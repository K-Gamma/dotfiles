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

# + History Setting {{{
# Number of items stored in memory.
export HISTSIZE=1000
# Number of items stored in history file.
export HISTFILESIZE=100000

# Don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth

# Time add to history.
HISTTIMEFORMAT='%Y/%m/%d(%a) %T %z  '
# + }}}

# + 'GCC' Setting {{{
# Colored GCC warnings and errors.
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# + }}}

# + 'CUDA' and 'cuDNN' Setting {{{
export PATH=/usr/local/cuda-8.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:/lib:$LD_LIBRARY_PATH
export CUDA_HOME=/usr/local/cuda
export C_INCLUDE_PATH=$C_INCLUDE_PATH:'/usr/local/cuda/samples/common/inc':'/usr/local/cuda-8.0/include'
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:'/usr/local/cuda/samples/common/inc':'/usr/local/cuda-8.0/include'
# + }}}

# + 'pyenv' Setting {{{
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# + }}}

# + 'Anaconda' Setting {{{
export PATH="$PYENV_ROOT/versions/anaconda3-4.3.0/bin/:$PATH"
# + }}}

# + My command Setting {{{
export PATH="/opt/:$PATH"
# + }}}
# }}}

# Get the aliases and functions.
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi


# vim: foldmethod=marker
# vim: foldcolumn=3
# vim: foldlevel=0
