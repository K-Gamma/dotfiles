# This file is sourced only for interactive shells.
# It should contain commands to set up aliases, fun
# -ctions, options, key bindings, etc:
# See /usr/share/zsh/help

# Compile '.zshrc' to speed up loading. {{{
if [[ ! -f $ZDOTDIR/.zshrc.zwc ]] || [[ $(readlink $ZDOTDIR/.zshrc) -nt $ZDOTDIR/.zshrc.zwc ]]; then
    zcompile $ZDOTDIR/.zshrc.zwc $ZDOTDIR/.zshrc
fi
#}}}

# Build-in Function Settings {{{
# TODO: adjustment
# + Autoload {{{
autoload -Uz colors && colors
autoload -Uz is-at-least
if is-at-least 4.3.10; then
    autoload -Uz vcs_info
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
fi

# completion
autoload -U compinit; compinit -C

# Can execute man with the Esc-h
if (( ${+aliases[run-help]} )); then
    unalias run-help
fi
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-svn
# + }}}

# + Options {{{
# ++ Changing Directories {{{
# Omit cd.
setopt auto_cd

# Add cd directory to directories stack.
# For example, 'cd - [tab]' allows you to jump to a directories in the past.
setopt auto_pushd

# Omit '~'.
setopt cdable_vars

# Don't puhf the same directory onto the directories stack.
setopt pushd_ignore_dups
# ++ }}}

# ++ Completion {{{
# Don't change the position of prompt when completing.
setopt always_last_prompt

# Move the cursor to the end after complete completion.
setopt always_to_end

# Automatically list choices on an ambiguous completion.
setopt auto_list

# Toggle completion candidate by tab.
setopt auto_menu

# Complement variable name and correspondence of parentheses.
setopt auto_param_keys

# If a parameter is completed whose content is the name of a directory, then add a trailing slash instead of a space.
setopt auto_param_slash

# Remove slash added a trailing by auto_param_slash.
setopt auto_remove_slash

# Expand aliases and complement it.
setopt complete_aliases

# Complement even if the cursor is in the middle of word.
unsetopt complete_in_word

# Don't beep on an ambiguous completion.
unsetopt list_beep

# Try to make the completion list smaller.
setopt list_packed

# Show the type of each file with a trailing identifying mark.
setopt list_types

# If can completion the continuation of a word, it isn't accepted yet.
unsetopt rec_exact
# ++ }}}

# ++ Expansion and Globbing {{{
# For example, Can make folders 1, 2, 3 by 'mkdir {1-3}'.
setopt brace_ccl

# Use additional characters for globs.
setopt extended_glob

# Don't require a leading '.' in a filename to be matched explicit.
setopt glob_dots

# Substitutions using the :s and :& history modifiers are performed with pattern matching instead of string matching.
setopt hist_subst_pattern

# Allows the completion after '=' in the option.
setopt magic_equal_subst

# If directory matches by expanding file name, appends / to the end.
setopt mark_dirs

# Suppress glob warning.
unsetopt nomatch

# Expand arrays included in expansion separately.
setopt rc_expand_param
# ++ }}}

# ++ History {{{
# Save each command’s beginning timestamp and the duration to the history file
setopt extended_history

# if conflict occurred, delete the old one.
setopt hist_ignore_all_dups

# Erase extra blanks.
setopt hist_ignore_dups

# If there is a space at the beginning, don't record history.
setopt hist_ignore_space

# Remove the history command from the history list when invoked.
setopt hist_no_store

# Stuff the extra spaces and record.
setopt hist_reduce_blanks

# Share the history among zsh's started at the same time.
setopt share_history
# ++ }}}

# ++ Input/Output {{{
# Expand aliases.
setopt aliases

# Don't overwrite with redirect.
setopt clobber

# Try to correct the spelling of commands.
setopt correct

# Try to correct the spelling of all arguments in a line.
setopt correct_all

# Don't use 'C-q' and 'C-s'.
setopt no_flow_control

# Do not exit on end-of-file.
setopt ignore_eof

# Print a warning message if a mail file has been accessed since the shell last checked.
setopt mail_warning

# Perform a path search even on command names with slashes in them.
setopt path_dirs

# Japanese file name can be displayed.
setopt print_eight_bit

# If querying the user before executing 'rm *' or 'rm path/*', first wait ten seconds and ignore anything typed in that time.
setopt RM_STAR_WAIT
# ++ }}}

# ++ Job Control {{{
# If you enter a command with the same name as the suspended process, execute it.
setopt auto_resume

# List jobs in the long format by default.
setopt long_list_jobs
# ++ }}}

# ++ Prompting {{{
# Even if there isn't line feed code at the end of the output string, it is displayed.
unsetopt prompt_cr

# Evaluate PROMPT variable expansion, command substitution, arithmetic operation etc for each display.
setopt prompt_subst

# Delete the right prompt after executing the command.
setopt transient_rprompt
# ++ }}}

# ++ Scripts and Functions {{{
# Handle to multiple redirects and pipes.
setopt multios
# ++ }}}

# ++ Zsh Line Editor {{{
# Don't sound a beep.
unsetopt beep

# Emacs like key bind.
setopt emacs
#setopt vi

# Use ZLE.
setopt zle
# ++ }}}
# + }}}

# TODO: adjustment
# + Typeset {{{
# An array to note missing features to ease diagnosis in case of problems
typeset -ga debian_missing_features

# Avoid duplication of $PATH
typeset -U path PATH
# + }}}

# TODO: adjustment
# + Zstyle (The zsh/zutil Module Settings) {{{
# ++ Prompt Settings {{{
# +++ PROMPT Setting {{{
function triangle-mark {
    echo '\ue0b0 '
    return 0
}
#function env-name {
#    local PYTHON_ENV_NAME=" "
#    if [[ -z "${VIRTUAL_ENV}" ]]; then
#        PYTHON_ENV_NAME=${VIRTUAL_ENV}
#        PYTHON_ENV_NAME=${PYTHON_ENV_NAME##*/}
#    fi
#    echo ${PYTHON_ENV_NAME}
#}
#PROMPT="%K{025}%F{254}$(env-name)%K{254}%F{025}$(triangle-mark)%K{254}%F{025} %n@%m %K{238}%F{254}$(triangle-mark)%K{238}%F{007} %c %k%F{238}$(triangle-mark)%f"
PROMPT="%K{254}%F{025} %n@%m %K{238}%F{254}$(triangle-mark)%K{238}%F{007} %c %k%F{238}$(triangle-mark)%f"
# +++ }}}

PROMPT2="%F{green}%_> %f"
SPROMPT="%F{red}correct: %R -> %r [nyae]? %f"

# +++ RPROMPT Setting {{{
function branch-mark {
    echo '\ue0a0 '
    return 0
}
if is-at-least 4.3.10; then
    # ++++ Use vcs_info {{{
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' formats "%F{green}%c%u$(branch-mark)[%b]%f"
    if is-at-least 4.3.10; then
        zstyle ':vcs_info:git:*' check-for-changes true
        zstyle ':vcs_info:git:*' stagedstr "%F{yellow}"
        zstyle ':vcs_info:git:*' unstagedstr "%F{red}"
        zstyle ':vcs_info:git:*' actionformats '%F{magenta}[%b|%a]%f'
    fi
    precmd() { vcs_info }
    RPROMPT='${vcs_info_msg_0_}'
    # ++++ }}}
else
    # ++++ Don't use vcs_info {{{
    function get-branch-status {
        local res color
        output=$(git status --short 2> /dev/null)
        if [[ -z "$output" ]]; then
            res=':' # status Clean
            color='%F{green}'
        elif [[ $output =~ "[\n]?\?\? " ]]; then
            res='?:' # Untracked
            color='%F{yellow}'
        elif [[ $output =~ "[\n]? M " ]]; then
            res='M:' # Modified
            color='%F{red}'
        else
            res='A:' # Added to commit
            color='%F{cyan}'
        fi
        echo ${color}
        return 0
    }
    function get-branch-name {
        echo $(git rev-parse --abbrev-ref HEAD 2> /dev/null)
        return 0
    }
    function branch-status-check {
        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
            return 0
        fi
        local branchname=$(get-branch-name)
        if [[ -z $branchname ]]; then
            return 0
        fi
        echo "$(get-branch-status)$(branch-mark)[${branchname}]%f"
        return 0
    }
    RPROMPT='$(branch-status-check)'
    # ++++ }}}
fi
# +++ }}}
# ++ }}}

# ++ 'cdr' settings (Required before 'zplug load') {{{
if [[ ! -d ${XDG_CACHE_HOME:-$HOME/.cache}/shell ]]; then
    mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/shell"
fi
if is-at-least 4.3.10; then
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':chpwd:*' recent-dirs-max 500
    zstyle ":chpwd:*" recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-file "${XDG_CACHE_HOME:-$HOME/.cache}/shell/chpwd-recent-dirs"
    zstyle ':chpwd:*' recent-dirs-pushd true
fi
# ++ }}}

# TODO: English commentary
# ++ Completion Settings {{{
# 補完侯補をメニューから選択
# select=2: 補完候補を一覧から選択, 補完候補が2つ以上なければすぐに補完
zstyle ':completion:*' menu select=2

# 補完時に, 文字の大小を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ~/f を /home/usr/foo ではなく ~/foo に補完
zstyle ':completion:*' keep-prefix

#zstyle ':completion:*' recent-dirs-insert ???

### 補完候補
### _oldlist 前回の補完結果を再利用する。
### _complete: 補完する。
### _match: globを展開しないで候補の一覧から補完する。
### _history: ヒストリのコマンドも補完候補とする。
### _ignored: 補完候補にださないと指定したものも補完候補とする。
### _approximate: 似ている補完候補も補完候補とする。
### _prefix: カーソル以降を無視してカーソル位置までで補完する。
zstyle ':completion:*' completer _complete _ignored _prefix

# 補完候補に着色
if [[ -n "$LS_COLORS" ]]; then
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

# カレントディレクトリを非表示
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# オブジェクトファイルとか中間ファイルとか非表示
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

# sudo でも補完の対象
zstyle ':completion:*:sudo:*' command-path \
    /usr/local/sbin \
    /usr/local/bin  \
    /usr/sbin       \
    /usr/bin        \
    /sbin           \
    /bin            \
    /usr/X11R6/bin

# 補完候補をキャッシュ
zstyle ':completion:*' use-cache true #yes?
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/shell/completion-cache-dirs"

# 詳細情報を非表示
zstyle ':completion:*' verbose no

# 補完フォーマット
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'
zstyle ':completion:*' group-name ''

# セパレータ
zstyle ':completion:*' list-separator '-->'
# ++ }}}
# + }}}

# TODO: addition
# + Aliases {{{
alias less='less -MN'

# global
alias -g ...='cd ../..'
alias -g ....='cd ../../..'
alias -g .....='cd ../../../..'
alias -g @g='| grep'
alias -g @l='| less'
alias -g @h='| head'
alias -g @t='| tail'
alias -g @s='| sed'
alias -g @c='| cat'

# suffix
alias -s py=python
alias -s hs=runhaskell
alias -s {png,jpg,bmp,PNG,JPG,BMP}=eog
alias -s {mp3,frac}=audacious
alias -s {html,htm,md}=firefox
function extract() {
    case $1 in
        *.tar.gz|*.tgz) tar xzvf $1;;
        *.tar.xz) tar Jxvf $1;;
        *.zip) unzip $1;;
        *.lzh) lha e $1;;
        *.tar.bz2|*.tbz) tar xjvf $1;;
        *.tar.Z) tar zxvf $1;;
        *.gz) gzip -d $1;;
        *.bz2) bzip2 -dc $1;;
        *.Z) uncompress $1;;
        *.tar) tar xvf $1;;
        *.arj) unarj $1;;
    esac
    return 0
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract

# Don't write to history
alias run-help=' run-help'
alias man=' man'

# Enable aliases when 'sudo'
alias sudo='sudo '

# Enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
    case "${OSTYPE}" in
        darwin*)
            alias ls='ls -GF'
            ;;
        linux*)
            if [[ -f ~/.dircolors ]]; then
                eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
            fi
            alias ls='ls -F --color=auto'
            alias dir='dir --color=auto'
            alias vdir='vdir --color=auto'
            alias grep='grep --color=auto'
            alias fgrep='fgrep --color=auto'
            alias egrep='egrep --color=auto'
            ;;
    esac
fi

# some more ls aliases
alias l='ls -CF'
alias ll='ls -alF'
alias la='ls -A'
alias lh='ls -lh'
alias t='tree'
alias ta='tree -a'
alias td='tree -d'
alias tl='tree -l'
alias tf='tree -f'

# rm aliases
alias rm='rm -i -v'
alias del='rm -rf'

# other aliases
alias df='df -h'
alias ps='ps --sort=start_time'
alias apv='appletviewer'
alias x='exit'
alias g='git'
alias v='vim'
alias clip='xsel --clipboard --input'
alias relogin='exec $SHELL -l'
alias color256='for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo'
alias color256bg='for c in {000..255}; do echo -en " \e[48;5;${c}m$c\e[0m" ; [ $(($c%16)) -eq 15 ] && echo;done;echo'

# GoogleDrive aliases
alias gdrive_m='google-drive-ocamlfuse ~/google-drive'
alias gdrive_u='fusermount -u ~/google-drive'
alias gdrive_r='rm -rf ${HOME}/.gdfuse/default/cache'

# cputmp alias
alias cputmp='echo $(echo $(cat /sys/class/thermal/thermal_zone0/temp) / 1000 | bc) °C'

# gputmp alias
alias gputmp='echo $(nvidia-settings -tq "[gpu:0]/GPUCoreTemp") °C'

# latexmk aliases
alias lmk='latexmk'
alias lmkp='latexmk -pv'
alias lmkc='latexmk -c'

# apt update & upgrade & autoremove alias
alias update='sh -c "apt update && sudo apt -y upgrade && apt -y autoremove"'
# + }}}

# + Named Directories {{{
function name_dir()
{
    local dir=$1
    local name=$2

    if [[ -d $dir ]]; then
        hash -d $name=$dir
        return 0
    else
        return 1
    fi
    return 0
}

name_dir ~/.dotfiles/ dotfiles
name_dir ~/workspace/ workspace
name_dir ~/.zsh/ .zsh
name_dir ~/.vim/ .vim
# + }}}

# TODO: addition
# + Keybind {{{
# Emacs like keybind
bindkey -e

# History search
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
if is-at-least 4.3.10; then
    bindkey '^R' history-incremental-pattern-search-backward
    bindkey '^S' history-incremental-pattern-search-forward
fi
# + }}}

# TODO: addition
# + Functions {{{

# + }}}
# }}}

# Plugin Settings {{{
# + Plugin Install {{{
# Install zplug/zplug
if [[ ! -f $ZPLUG_HOME/init.zsh ]]; then
    mkdir -p $ZPLUG_HOME
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
source $ZPLUG_HOME/init.zsh

# Install zsh"s other plugin
zplug "zplug/zplug", hook-build:"zplug --self-manage"

zplug "b4b4r07/enhancd"
zplug "joel-porquet/zsh-dircolors-solarized"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux # for tmux
zplug "mollifier/anyframe"
zplug "mrowa44/emojify", as:command
zplug "ssh0/dot", use:"*.sh"
zplug "supercrabtree/k"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "Tarrasch/zsh-autoenv"


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    echo "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Source plugins and add commands to $PATH
zplug load
# + }}}

# TODO: addition
# + Plugin Settings {{{

# ++ zplug/zplug

# ++ b4b4r07/enhancd {{{
#if zplug check b4b4r07/enhancd; then
#    # setting if enhancd is available
#    export ENHANCD_FILTER=fzf-tmux
#    export ENHANCD_DOT_SHOW_FULLPATH=1
#fi
# ++ }}}

# ++ joel-porquet/zsh-dircolors-solarized {{{
if zplug check 'joel-porquet/zsh-dircolors-solarized';then
    setupsolarized dircolors.ansi-light
fi
# ++ }}}

# ++ junegunn/fzf-bin {{{
if zplug check 'junegunn/fzf-bin';then
    export FZF_DEFAULT_COMMAND=''
    export FZF_DEFAULT_OPTS='--height 50% --ansi --border --exact --extended --exit-0 --inline-info --multi --reverse --select-1'
fi
# +++ fv - fuzzy open with vim from anywhere {{{
fv() {
    local file
    
    file="$(fzf)"
    if [[ -n ${file} ]]; then
        vim ${file}
    fi
}
# +++ }}}

# +++ vg - fuzzy grep open via ag {{{
vg() {
    local file

    file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"

    if [[ -n ${file} ]]; then
        vim ${file}
    fi
}
# +++ }}}

# +++ fd - cd to selected directory {{{
fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) &&
        cd "$dir"
    }
# +++ }}}

# +++ Git {{{
# ++++ fbr - checkout git branch {{{
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
# ++++ }}}

# ++++ fbrm - checkout git branch (including remote branches) {{{
fbrm() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
# ++++ }}}

# ++++ flog - git commit browser {{{
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
# ++++ }}}
# +++ }}}
# ++ }}}

# ++ junegunn/fzf

# ++ mollifier/anyframe

# ++ mrowa44/emojify

# ++ ssh0/dot {{{
if zplug check 'ssh0/dot';then
    export DOT_REPO="https://github.com/K-Ganma/dotfiles.git"
    export DOT_DIR="${HOME}/.dotfiles"
fi
# ++ }}}

# ++ supercrabtree/k {{{
if zplug check 'supercrabtree/k';then
    source $ZPLUG_REPOS/supercrabtree/k/k.sh
fi
# ++ }}}

# ++ zsh-users/zsh-autosuggestions {{{
if zplug check 'zsh-users/zsh-autosuggestions';then
    source $ZPLUG_REPOS/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
# }}}

# ++ zsh-users/zsh-completions {{{
if [[ -d ${ZPLUG_REPOS}/zsh-users/zsh-completions/src/ ]] ; then
    export fpath=(${ZPLUG_REPOS}/zsh-users/zsh-completions/src/ ${fpath})
fi
# ++ }}}

# ++ zsh-users/zsh-syntax-highlighting

# + }}}
# }}}

## Profiling zsh shell scripts
#if (which zprof > /dev/null 2>&1) ;then
#  zprof
#fi

# vim: fdm=marker fdc=3 fdl=0
