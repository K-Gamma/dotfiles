#!/usr/bin/env bash
# fzf-git.sh 代替 popup ピッカー (herdr プラグイン fzf-git のエントリポイント実体)
#
# 呼び出し元 (zshrc の __fzf_git_herdr_init、home/private_dot_config/zsh/dot_zshrc)
# が `herdr plugin pane open` で popup ペインを開く際、以下を --env で渡す:
#   FZF_GIT_CWD        - 呼び出し元シェルの $PWD (git リポジトリの探索起点)
#   HERDR_ORIGIN_PANE  - 選択結果を挿入する呼び出し元ペインの ID
#   FZF_GIT_SH         - fzf-git.sh の絶対パス (antidote キャッシュ配下)
#
# git 系 kind (files/branches/tags/remotes/hashes/stashes/lreflogs/worktrees/each_ref) は
# fzf-git.sh 本体の `--run <kind>` 非対話実行モードをそのまま利用する。
#
# prs/issues は home/private_dot_config/zsh/dot_zshrc の
# _fzf_git_prs / _fzf_git_issues (fzf-git.sh extensions ブロック) を
# `_fzf_git_fzf` に依存しない standalone 実装として移植したもの。
# border-label・CTRL-O (gh --web)・glow プレビューは元実装を踏襲している。

set -uo pipefail

kind="${1:-${HERDR_PLUGIN_ENTRYPOINT_ID:-}}"
[[ -z "$kind" ]] && exit 1

# herdr は --cwd でプロセスの作業ディレクトリを設定するが、
# 明示的に FZF_GIT_CWD が渡されていればそちらを優先する。
if [[ -n "${FZF_GIT_CWD:-}" ]]; then
  cd "$FZF_GIT_CWD" 2> /dev/null || true
fi

# antidote キャッシュ上の既知パス (フォールバック)。
# 引用元: home/private_dot_config/zsh/dot_zsh_plugins.txt の
# `junegunn/fzf-git.sh kind:defer` エントリが解決するパスと同一。
DEFAULT_FZF_GIT_SH="$HOME/.cache/antidote/github.com/junegunn/fzf-git.sh/fzf-git.sh"
fzf_git_sh="${FZF_GIT_SH:-$DEFAULT_FZF_GIT_SH}"

# fzf-git.sh 本体が使うデフォルトの fzf ラッパー（_fzf_git_fzf の初期実装を移植）。
# 引用元: fzf-git.sh (junegunn/fzf-git.sh) の _fzf_git_fzf 定義。
# herdr popup ペイン自体がフローティング表示 (width=90%/height=70%、
# herdr-plugin.toml の [[panes]] 宣言) を提供するため、本家が使う
# `--tmux 90%,70%` (tmux popup 委譲) は不要で除去した。
# `--height 100%` はユーザーの FZF_DEFAULT_OPTS が持つ `--height=~50%` を
# 上書きし、popup 専用端末の全面を fzf に使わせるために明示している
# (fzf は同名オプションの後勝ちマージのため、FZF_DEFAULT_OPTS より後に
# 展開されるこの引数が優先される)。手元の fzf 0.73.1 には `--no-height`
# が存在しないため `--height 100%` を採用した。
_picker_fzf() {
  fzf --height 100% \
    --layout reverse --multi --min-height 20+ --border \
    --no-separator --header-border horizontal \
    --border-label-pos 2 \
    --color 'label:blue' \
    --preview-window 'right,50%' --preview-border line \
    --bind 'ctrl-/:change-preview-window(down,50%|hidden|)' "$@"
}

# 選択結果 (改行区切り) を、各行 printf '%q' でクォートして 1 個のスペースで
# 連結し、呼び出し元ペインのコマンドラインへ末尾スペース付きで挿入する。
send_result() {
  local result="$1"
  [[ -z "$result" ]] && return 0
  [[ -z "${HERDR_ORIGIN_PANE:-}" ]] && return 0
  [[ -z "${HERDR_BIN_PATH:-}" ]] && return 0

  local quoted="" line q
  while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    printf -v q '%q' "$line"
    quoted+="$q "
  done <<< "$result"

  [[ -z "$quoted" ]] && return 0
  "$HERDR_BIN_PATH" pane send-text "$HERDR_ORIGIN_PANE" "$quoted"
}

case "$kind" in
  files | branches | tags | remotes | hashes | stashes | lreflogs | worktrees | each_ref)
    if [[ ! -f "$fzf_git_sh" ]]; then
      exit 1
    fi
    git rev-parse > /dev/null 2>&1 || exit 0
    # fzf-git.sh 本体は --run 実行時、環境変数 __fzf_git_fzf が設定されて
    # いればそれを eval して自身の _fzf_git_fzf (デフォルト実装は
    # --height 50% --tmux 90%,70%) を上書きするフックを持つ
    # (引用元: fzf-git.sh の `if [[ $__fzf_git_fzf ]]; then eval
    # "$__fzf_git_fzf"` 分岐)。files/branches/... 系エントリポイントは
    # このフックを経由するため、上の _picker_fzf と同じ全面表示設定を
    # ここでも適用する。
    __fzf_git_fzf_def="$(declare -f _picker_fzf)"
    export __fzf_git_fzf="${__fzf_git_fzf_def/_picker_fzf/_fzf_git_fzf}"
    selection="$(bash "$fzf_git_sh" --run "$kind" || true)"
    send_result "$selection"
    ;;

  prs)
    git rev-parse > /dev/null 2>&1 || exit 0
    command -v gh > /dev/null 2>&1 || exit 0
    selection="$(
      gh pr list --state open --limit 100 \
        --json number,title,author,headRefName,updatedAt \
        --template '{{range .}}{{tablerow .number .title .author.login .headRefName (timeago .updatedAt)}}{{end}}' |
        _picker_fzf --no-multi --ansi \
          --border-label '🔀 Pull Requests' \
          --header 'CTRL-O (open in browser)' \
          --bind "ctrl-o:execute-silent(gh pr view {1} --web)" \
          --preview 'gh pr view {1} | glow -s light -' |
        awk '{print $1}'
    )"
    send_result "$selection"
    ;;

  issues)
    git rev-parse > /dev/null 2>&1 || exit 0
    command -v gh > /dev/null 2>&1 || exit 0
    selection="$(
      gh issue list --state open --limit 100 \
        --json number,title,author,labels,updatedAt \
        --template '{{range .}}{{tablerow .number .title .author.login (pluck "name" .labels | join ",") (timeago .updatedAt)}}{{end}}' |
        _picker_fzf --no-multi --ansi \
          --border-label '🐛 Issues' \
          --header 'CTRL-O (open in browser)' \
          --bind "ctrl-o:execute-silent(gh issue view {1} --web)" \
          --preview 'gh issue view {1} | glow -s light -' |
        awk '{print $1}'
    )"
    send_result "$selection"
    ;;

  *)
    exit 1
    ;;
esac

exit 0
