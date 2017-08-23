# Add aliases you want to use only in the login shell here:

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias lh='ls -lh'
alias l='ls -CF'

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# rm aliases
alias rm='rm -i -v'
alias del='rm -rf'

# other aliases
alias df='df -h'
alias ps='ps --sort=start_time'
alias apv='appletviewer'
alias x='exit'
alias relogin='exec $SHELL -l'
alias color256='for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# GoogleDrive aliases
alias gdrive_m='google-drive-ocamlfuse ~/googledrive'
alias gdrive_u='fusermount -u ~/googledrive'

# KeePass alias
alias keepass='gdrive_m | mono ~/KeePass/KeePass.exe &'

# cputmp alias
alias cputmp='cat /sys/class/thermal/thermal_zone0/temp | echo \`cat\`  / 1000  | bc | echo \`cat\` °C'
# gputmp alias
alias gputmp='nvidia-settings -q "[gpu:0]/GPUCoreTemp" | grep Attribute  | awk '{print \$4}' | tr -d . | echo \`cat\` °C'

# latexmk aliases
alias lmk='latexmk'
alias lmkp='latexmk -pv'
alias lmkc='latexmk -c'

# apt update & upgrade & autoremove alias
alias sudo_update='sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove'

# git aliases
alias gc='git commit -v'    # option -v : show change point
alias gco='git checkout'
alias gba='git branch -a'
alias ga='git add'
alias gm='git merge'
alias gf='git fetch'
alias gup='git fetch && git rebase'
alias gpush='git push origin $(current_branch)'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gl='git lg'
alias gla='git lga'
alias gd='git diff'
alias gdc='git diff --cached'
alias gr='git rebase'
alias gst='git status --status --branch'
alias gsd='gst && gd'
alias gsa='gst && ga'
alias gsco='gst && gco'
alias gsrh='gst + grh'
