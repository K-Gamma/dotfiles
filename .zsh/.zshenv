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

# global initialization files are skipped.
unsetopt global_rcs
# Zsh's home setting
export ZDOTDIR=$HOME/.zsh
# zplug's home setting
export ZPLUG_HOME=$ZDOTDIR/.zplug
# path
if [[ -z "$PATH" || "$PATH" == "/bin:/usr/bin" ]]
then
    export PATH="/usr/local/bin:/usr/bin:/bin:/usr/games"
fi
# Language
export LANG=ja_JP.UTF-8
# default dircolors
export LSCOLORS=gxfxcxdxbxegedabagacad
# XDG Base Directory Specification
export XDG_CONFIG_HOME=~/.config
# pager
export PAGER="less -cm"
# Editor
export EDITOR=vim
# less
export LESS='-r'
export LESSCHARSET=utf-8
export JLESSCHARSET=utf-8
# 履歴ファイルの保存先
export HISTFILE=$ZDOTDIR/.zsh_history
# メモリに保存される履歴の件数
export HISTSIZE=1000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

## CUDA and cuDNN paths
export PATH=/usr/local/cuda-8.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:/lib:$LD_LIBRARY_PATH
export CUDA_HOME=/usr/local/cuda
export C_INCLUDE_PATH=$C_INCLUDE_PATH:'/usr/local/cuda/samples/common/inc':'/usr/local/cuda-8.0/include'
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:'/usr/local/cuda/samples/common/inc':'/usr/local/cuda-8.0/include'

# pyenv paths
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# anaconda path
export PATH="$PYENV_ROOT/versions/anaconda3-4.3.0/bin/:$PATH"

# gpufan control script's path
export PATH="/opt/:$PATH"
