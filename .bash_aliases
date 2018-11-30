# This file is sourced by '.bashrc'.
# Please add commands to define aliases:

# Don't write to history
alias man=' man'

# Enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
    if [ -f ~/.dircolors ]; then
        eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    fi
    alias ls='ls -F --color=auto'
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
alias g='git'
alias v='vim'
alias relogin='exec $SHELL -l'
alias color256='for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo'
alias color256bg='for c in {000..255}; do echo -en " \e[48;5;${c}m$c\e[0m" ; [ $(($c%16)) -eq 15 ] && echo;done;echo'


# GoogleDrive aliases
alias gdrive_m='google-drive-ocamlfuse ~/google-drive'
alias gdrive_u='fusermount -u ~/google-drive'

# KeePass alias
alias keepass='gdrive_m | mono ~/KeePass/KeePass.exe &'

# cputmp alias
alias cputmp='cat /sys/class/thermal/thermal_zone0/temp | echo $(cat) / 1000  | bc | echo $(cat) °C'
# gputmp alias
alias gputmp='nvidia-settings -q "[gpu:0]/GPUCoreTemp" | grep Attribute  | awk "{print \$4}" | tr -d . | echo $(cat)°C'

# latexmk aliases
alias lmk='latexmk'
alias lmkp='latexmk -pv'
alias lmkc='latexmk -c'

# apt update & upgrade & autoremove alias
alias sudo_update='sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove'


# vim: fdm=marker fdc=3 fdl=0
