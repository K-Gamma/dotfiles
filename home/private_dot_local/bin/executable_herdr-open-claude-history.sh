#!/usr/bin/env bash
# herdr の keybind (config.toml alt+shift+h) から呼ばれるラッパー。
# キーを押したペインの id（HERDR_ACTIVE_PANE_ID。手動実行時は HERDR_PANE_ID）と、
# その foreground_cwd を herdr pane get から解決し、
# claude-history プラグインの popup を開く。
#
# picker 側 (home/private_dot_config/herdr/plugins/claude-history/picker.sh) が
# 選択されたプロンプト本文を呼び出し元ペインに send-text する。

set -uo pipefail

pane="${HERDR_ACTIVE_PANE_ID:-${HERDR_PANE_ID:-}}"
[[ -z "$pane" ]] && exit 0

# NUL 区切りで cwd を受け取り、`read -d ''` で安全に取り込む。
# cwd はユーザーがペインで `cd` した任意のパスであり得るため、
# `eval` で展開すると任意コード実行になり得る点に注意 (このスキーマで回避)。
# HERDR_ACTIVE_PANE_CWD はシェルの cwd でフォアグラウンドプロセスの cwd と意味が違うため使わない。
{
  IFS= read -r -d '' cwd || exit 0
} < <(herdr pane get "$pane" 2>/dev/null | python3 -c '
import sys, json
p = json.load(sys.stdin)["result"]["pane"]
sys.stdout.write((p.get("foreground_cwd") or p.get("cwd") or "") + "\0")
' 2>/dev/null)

herdr plugin pane open \
  --plugin claude-history \
  --entrypoint picker \
  --env "HERDR_ORIGIN_PANE=$pane" \
  --env "HERDR_ORIGIN_CWD=${cwd:-}" \
  > /dev/null 2>&1
