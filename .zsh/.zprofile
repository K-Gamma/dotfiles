# Add alias you want to use only in the login shell here:

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
alias -s {html,htm}=firefox
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
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract

# ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -F --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias la="ls -a"
alias ll="ls -la"
alias lh="ls -lh"

# rm
alias rm='rm -i -v'
alias del="rm -rf"

# other
alias df='df -h'
alias ps='ps --sort=start_time'
alias apv="appletviewer"
alias x="exit"
alias color256='for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo'

# GoogleDrive
alias gdrive_m='google-drive-ocamlfuse ~/googledrive'
alias gdrive_u='fusermount -u ~/googledrive'

# KeePass
alias keepass='gdrive_m | mono ~/KeePass/KeePass.exe &'

# cputmp
alias cputmp="cat /sys/class/thermal/thermal_zone0/temp | echo \`cat\`  / 1000  | bc | echo \`cat\` °C"
# gputmp
alias gputmp="nvidia-settings -q '[gpu:0]/GPUCoreTemp' | grep Attribute  | awk '{print \$4}' | tr -d . | echo \`cat\` °C"

# latexmk
alias lmk='latexmk'
alias lmkp='latexmk -pv'
alias lmkc='latexmk -c'

# update upgrade autoremove
alias sudo_update='sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove'

# git
alias gc='git commit -v'    # option -v : show change point
alias gco='git checkout'
alias gba='git branch -a'
alias ga='git add'
alias gm='git merge'
alias gf='git fetch'
alias gup='git fetch && git rebase'
alias ggpush='git push origin $(current_branch)'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gl='git log --graph'
alias gd='git diff'
alias gdc='git diff --cached'
alias gr='git rebase'
alias gst='git status --status --branch'
alias gsd='gst && gd'
alias gsa='gst && ga'
alias gsco='gst && gco'
alias gsrh='gst + grh'

