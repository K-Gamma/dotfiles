#!/usr/bin/env bash
# Claude Code のスキルを fzf popup で選び、/<name> を呼び出し元ペインへ挿入する。
#
# 呼び出し元は herdr の keybind (config.toml [[keys.command]] key = "alt+f") が
# `herdr plugin pane open --plugin claude-skills --entrypoint picker` を叩き、
# --env HERDR_ORIGIN_PANE=<focused pane id> を渡してくる想定。
#
# スキル列挙元:
#   ~/.claude/skills/*/SKILL.md                 (ユーザーグローバル)
#   $HERDR_ORIGIN_CWD/.claude/skills/*/SKILL.md (プロジェクトローカル)
#   有効なプラグインの skills/*/SKILL.md と commands/*.md (`plugin:name` 表記)
#     - marketplace 経由: ~/.claude/plugins/installed_plugins.json のうち
#       settings.json (user / project / project local) の enabledPlugins が true のもの
#     - claude.ai 同期 (組織配布): ~/.claude/plugins/synced/*/manifest.json
#
# Claude Code 本体が組み込みで持つスキル (/code-review など) はディスク上に
# SKILL.md が無いので列挙できない。

set -uo pipefail

if [[ -z "${HERDR_ORIGIN_PANE:-}" || -z "${HERDR_BIN_PATH:-}" ]]; then
  exit 1
fi

# SKILL.md 群を 1 個の python3 プロセスで一括パースする。
# ファイル毎に python3 を spawn するとインタプリタ起動コストが線形に効いて
# popup が「空表示 → 数百ミリ秒後にスキル出現」となるため。
skills="$(
  python3 - "${HERDR_ORIGIN_CWD:-$PWD}" << 'PY'
import json, re, sys, pathlib

cwd = pathlib.Path(sys.argv[1])
claude_dir = pathlib.Path.home() / ".claude"
plugins_dir = claude_dir / "plugins"


def read_json(path):
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return None


def frontmatter(path):
    """YAML frontmatter から name と description を取り出す (無ければ None)。"""
    try:
        text = path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return None, None
    m = re.match(r"---\s*\n(.*?)\n---\s*\n", text, re.DOTALL)
    if not m:
        return None, None
    name = None
    desc_lines = []
    in_desc = False
    for line in m.group(1).splitlines():
        if in_desc:
            if re.match(r"^[A-Za-z_-]+\s*:", line):
                in_desc = False
            else:
                desc_lines.append(line.strip())
                continue
        m2 = re.match(r"^name\s*:\s*(.+?)\s*$", line)
        if m2:
            name = m2.group(1).strip().strip('"').strip("'")
            continue
        m3 = re.match(r"^description\s*:\s*(.*)$", line)
        if m3:
            head = m3.group(1).strip().strip('"').strip("'")
            # `description: >` / `|` のブロックスカラー記号は本文ではない
            if head not in (">", "|", ">-", "|-"):
                desc_lines.append(head)
            in_desc = True
            continue
    return name, " ".join(x for x in desc_lines if x)


def enabled_plugins():
    """settings.json の enabledPlugins を user → project → project local の順で重ねる。"""
    merged = {}
    for path in (
        claude_dir / "settings.json",
        cwd / ".claude" / "settings.json",
        cwd / ".claude" / "settings.local.json",
    ):
        data = read_json(path)
        if isinstance(data, dict) and isinstance(data.get("enabledPlugins"), dict):
            merged.update(data["enabledPlugins"])
    return merged


def plugin_roots(enabled):
    """有効なプラグインの (表示名, インストール先) を列挙する。"""
    roots = []
    installed = read_json(plugins_dir / "installed_plugins.json")
    entries = installed.get("plugins", {}) if isinstance(installed, dict) else {}
    for key, on in enabled.items():
        if on is not True:
            continue
        cands = entries.get(key, [])
        path = next((e.get("installPath") for e in cands if e.get("scope") == "user"), None)
        if not path:
            path = next(
                (
                    e.get("installPath")
                    for e in cands
                    if e.get("scope") == "project" and e.get("projectPath") == str(cwd)
                ),
                None,
            )
        if path:
            roots.append((key.rsplit("@", 1)[0], pathlib.Path(path)))

    for manifest in sorted((plugins_dir / "synced").glob("*/manifest.json")):
        data = read_json(manifest)
        for p in (data or {}).get("plugins", []):
            name = p.get("name")
            if not name or enabled.get(f"{name}@synced") is False:
                continue
            gen = p.get("generation")
            d = manifest.parent / (f"{name}~g{gen}" if gen else name)
            if d.is_dir():
                roots.append((name, d))

    out = []
    for fallback, root in roots:
        meta = read_json(root / ".claude-plugin" / "plugin.json")
        name = meta.get("name") if isinstance(meta, dict) else None
        out.append((name or fallback, root))
    return out


found = {}


def add(name, desc):
    if name and name not in found:
        found[name] = desc or ""


for root in (claude_dir / "skills", cwd / ".claude" / "skills"):
    if not root.is_dir():
        continue
    for f in sorted(root.glob("*/SKILL.md")):
        name, desc = frontmatter(f)
        add(name or f.parent.name, desc)

# プラグインのスキル名は frontmatter の name ではなくディレクトリ名 (command は
# ファイル名) で呼び出される。
for plugin, root in plugin_roots(enabled_plugins()):
    for f in sorted(root.glob("skills/*/SKILL.md")):
        add(f"{plugin}:{f.parent.name}", frontmatter(f)[1])
    for f in sorted(root.glob("commands/*.md")):
        add(f"{plugin}:{f.stem}", frontmatter(f)[1])

for name in sorted(found):
    print(f"{name}\t{found[name]}")
PY
)"
[[ -z "$skills" ]] && exit 0

selection="$(
  printf '%s\n' "$skills" |
    fzf --height 100% --layout reverse --border --no-separator \
      --header-border horizontal \
      --border-label '⚡ Claude skills' --border-label-pos 2 \
      --color 'label:blue' \
      --delimiter=$'\t' --with-nth=1 --nth=1,2 \
      --preview-window 'right,60%,wrap' --preview-border line \
      --preview 'printf "%s\n\n%s\n" {1} {2}' \
      --bind 'ctrl-/:change-preview-window(down,50%|hidden|)'
)" || exit 0

name="${selection%%$'\t'*}"
[[ -z "$name" ]] && exit 0

"$HERDR_BIN_PATH" pane send-text "$HERDR_ORIGIN_PANE" "/$name "
