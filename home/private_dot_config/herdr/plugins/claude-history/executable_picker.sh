#!/usr/bin/env bash
# Claude Code のプロンプト履歴を fzf popup で選び、
# 選択されたプロンプト本文を呼び出し元ペインへ挿入する。
#
# 呼び出し元は herdr の keybind (config.toml [[keys.command]] key = "alt+shift+h") が
# `herdr plugin pane open --plugin claude-history --entrypoint picker` を叩き、
# --env HERDR_ORIGIN_PANE=<focused pane id> を渡してくる想定。
#
# 履歴選択本体は `claude-history` コマンド (~/.local/bin/claude-history) に委譲する。
# Enter でプロンプト全文が stdout に出るので、それをそのまま send-text する。

set -uo pipefail

if [[ -z "${HERDR_ORIGIN_PANE:-}" || -z "${HERDR_BIN_PATH:-}" ]]; then
  exit 1
fi

if ! command -v claude-history >/dev/null 2>&1; then
  echo "Error: claude-history が PATH に見つかりません" >&2
  # popup がすぐ閉じるとメッセージが読めないので少し待つ
  sleep 2
  exit 1
fi

# herdr popup がフローティング表示を提供するため、claude-history 側の
# fzf --tmux popup は無効化して全画面で描画させる。
selection="$(CLAUDE_HISTORY_TUI_TMUX="" claude-history)" || exit 0
[[ -z "$selection" ]] && exit 0

"$HERDR_BIN_PATH" pane send-text "$HERDR_ORIGIN_PANE" "$selection"
