# This file is sourced on all invocations of the shell.
# If the -f flag is present or if the NO_RCS option is
# set within this file, all other initialization files
# are skipped.
#
# This file should contain commands to set the command
# search path, plus other important environment variables.
# This file should not contain commands that produce
# output or assume the shell is attached to a tty.
#
# ~ ($HOME)/
# ├── .zshenv --> $HOME/.zsh/.zshenv
# ├── .zsh/ ($ZDOTDIR)
# │   ├── (zsh's dotfiles) --> $HOME/dotfiles/.zsh/(zsh's dotfiles)
# │   └── ...
# └── ...

# Setting for zprof restart zsh
#zmodload zsh/zprof && zprof

# Global initialization files aren't sourced.
unsetopt global_rcs

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

# + Zsh Setting {{{
# Zsh's home
export ZDOTDIR=$HOME/.zsh

# zplug's home
export ZPLUG_HOME=$ZDOTDIR/.zplug

# Specify a set of characters to be treated as part of a word.
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# In the line editor, the number of matches to list without
# asking first. If set to zero, the shell asks only if the top
# of the listing would scroll off the screen.
export LISTMAX=0

# + History Setting {{{
# Set history file destination
export HISTFILE=$ZDOTDIR/.zsh_history

# Number of items stored in memory
export HISTSIZE=1000

# Number of items stored in history file
export SAVEHIST=100000
# + }}}
# + }}}

# + 'GCC' Setting {{{
# Colored GCC warnings and errors
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


# vim: foldmethod=marker
# vim: foldcolumn=3
# vim: foldlevel=0
