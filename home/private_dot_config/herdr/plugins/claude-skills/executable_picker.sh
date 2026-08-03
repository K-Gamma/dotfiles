#!/usr/bin/env bash
# Claude Code のスキルを fzf popup で選び、/<name> を呼び出し元ペインへ挿入する。
#
# 呼び出し元は herdr の keybind (config.toml [[keys.command]] key = "ctrl+f") が
# `herdr plugin pane open --plugin claude-skills --entrypoint picker` を叩き、
# --env HERDR_ORIGIN_PANE=<focused pane id> を渡してくる想定。
#
# スキル列挙元:
#   ~/.claude/skills/*/SKILL.md               (ユーザーグローバル)
#   $HERDR_ORIGIN_CWD/.claude/skills/*/SKILL.md (プロジェクトローカル)
#
# 各 SKILL.md の YAML frontmatter から `name:` と `description:` を取り出す。
# プラグインスキル (~/.claude/plugins 以下、`plugin:skill` 名前空間) は
# インストール状況の解決が複雑なので v1 では対象外。

set -uo pipefail

if [[ -z "${HERDR_ORIGIN_PANE:-}" || -z "${HERDR_BIN_PATH:-}" ]]; then
  exit 1
fi

# SKILL.md 群を 1 個の python3 プロセスで一括パースする。
# ファイル毎に python3 を spawn するとインタプリタ起動コストが線形に効いて
# popup が「空表示 → 数百ミリ秒後にスキル出現」となるため。
skills="$(
  python3 - "$HOME/.claude/skills" "${HERDR_ORIGIN_CWD:-$PWD}/.claude/skills" << 'PY' | sort -u
import re, sys, pathlib

for root in sys.argv[1:]:
    d = pathlib.Path(root)
    if not d.is_dir():
        continue
    for f in sorted(d.glob("*/SKILL.md")):
        try:
            text = f.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue
        m = re.match(r"---\s*\n(.*?)\n---\s*\n", text, re.DOTALL)
        if not m:
            continue
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
                desc_lines.append(m3.group(1).strip().strip('"').strip("'"))
                in_desc = True
                continue
        if not name:
            continue
        desc = " ".join(x for x in desc_lines if x)
        print(f"{name}\t{desc}")
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
