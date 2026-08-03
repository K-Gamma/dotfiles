#!/usr/bin/env bash
# herdr の keybind (config.toml alt+h) から呼ばれるラッパー。
# フォーカス中ペインの id と cwd を herdr pane list から解決し、
# claude-history プラグインの popup を開く。
#
# picker 側 (home/private_dot_config/herdr/plugins/claude-history/picker.sh) が
# 選択されたプロンプト本文を呼び出し元ペインに send-text する。

set -uo pipefail

if [[ "${HERDR_ENV:-}" != "1" ]]; then
  # keybind 経由の呼び出しでは HERDR_ENV が立たない可能性があるが、
  # 実行環境確認としては herdr バイナリの存在で十分なので警告のみ。
  :
fi

# NUL 区切りで pane_id と cwd を受け取り、`read -d ''` で安全に取り込む。
# cwd はユーザーがフォーカス中ペインで `cd` した任意のパスであり得るため、
# `eval` で展開すると任意コード実行になり得る点に注意 (このスキーマで回避)。
{
  IFS= read -r -d '' pane
  IFS= read -r -d '' cwd
} < <(herdr pane list | python3 -c '
import sys, json
ps = json.load(sys.stdin)["result"]["panes"]
p = next((x for x in ps if x.get("focused")), None)
if p:
    sys.stdout.write(p["pane_id"] + "\0")
    sys.stdout.write((p.get("foreground_cwd") or p.get("cwd") or "") + "\0")
') || true

[[ -z "${pane:-}" ]] && exit 0

herdr plugin pane open \
  --plugin claude-history \
  --entrypoint picker \
  --env "HERDR_ORIGIN_PANE=$pane" \
  --env "HERDR_ORIGIN_CWD=${cwd:-}" \
  > /dev/null 2>&1
