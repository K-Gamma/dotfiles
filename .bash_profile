# This file is sourced only for login shells.
# Please add commands to set the command search path,
# plus other important environment variables:

# Set up the environment variables. {{{
# Language
export LANG=ja_JP.UTF-8

# Default dircolors
export LSCOLORS=gxfxcxdxbxegedabagacad

# XDG Base Directory Specification
export XDG_CONFIG_HOME=~/.config

# Pager
export PAGER="less -cm"

# Editor
export EDITOR=vim

# Less
export LESS='-r'
export LESSCHARSET=utf-8
export JLESSCHARSET=utf-8
# Make less more friendly for non-text input files, see lesspipe(1)
if [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi

# + History {{{
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# Number of items stored in memory.
export HISTSIZE=1000
# Number of items stored in history file.
export HISTFILESIZE=100000

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

# Time add to history.
HISTTIMEFORMAT='%Y/%m/%d(%a) %T %z  '
# + }}}

# + for GCC {{{
# Add include path and library path.
export CPATH=/usr/local/include:${CPATH}
export LIBRARY_PATH=/usr/local/lib:${LIBRARY_PATH}

# Colored GCC warnings and errors.
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# + }}}

# + for Java {{{
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
# }}}

# + for Go {{{
export GOROOT=/usr/local
export PATH=${GOROOT}/bin:${PATH}
# + }}}

# + for TeX Live {{{
export PATH=/usr/local/texlive/2018/bin/x86_64-linux:${PATH}
export INFOPATH=/usr/local/texlive/2018/texmf-dist/doc/info:${INFOPATH}
export MANPATH=/usr/local/texlive/2018/texmf-dist/doc/man${MANPATH}
# + }}}

# + for virtualenvwrapper {{{
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=${HOME}/.virtualenvs
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    source /usr/local/bin/virtualenvwrapper.sh
fi
# + }}}

# + for CUDA and cuDNN {{{
export CUDA_HOME=/usr/local/cuda
export PATH=${CUDA_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}
export CPATH=${CUDA_HOME}/samples/common/inc:${CUDA_HOME}/include:${CPATH}
# + }}}

## + for Caffe {{{
#export CAFFE_ROOT=${HOME}/caffe
#export PYTHONPATH=${CAFFE_ROOT}/python:${PYTHONPATH}
#export CPATH=${PYENV_ROOT}/versions/2.7.14/include/python2.7:${CPATH}
## + }}}

# + for Ruby {{{
# for rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# for ruby-build
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
# + }}}

# + for ssh0/dot {{{
if [ -f ${HOME}/.config/dot ]; then
    export DOT_REPO="https://github.com/K-Ganma/dotfiles.git"
    export DOT_DIR="${HOME}/.dotfiles"
    fpath=(${HOME}/.config/dot $fpath)
    source ${HOME}/.config/dot/dot.sh
# + }}}

# + for My command {{{
export PATH="/opt/:$PATH"
# + }}}
# }}}

# Set up the shopt. {{{
# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# }}}

# Gain the aliases etc. {{{
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
# }}}

# vim: fdm=marker fdc=3 fdl=0
