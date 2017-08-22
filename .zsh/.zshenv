# Add environment variables here:
setopt no_global_rcs
export ZDOTDIR=$HOME/.zsh

source $ZDOTDIR/.zprofile

#$HOME/.
#├── .zshenv -> $HOME/.zsh/.zshenv
#├── .zsh
#│   ├──.zprofile -> $HOME/dotfiles/.zsh/.zprofile
#│   ├──.zshenv -> $HOME/dotfiles/.zsh/.zshenv
#│   └──.zshrc -> $HOME/dotfiles/.zsh/.zshrc
#└── …

# zdotdir (export in ~/.zshenv)
# export ZDOTDIR=$HOME/.zsh.d
# Language
export LANG=ja_JP.UTF-8
# zplug's home
export ZPLUG_HOME=$ZDOTDIR/.zplug
# default dircolors
export LSCOLORS=gxfxcxdxbxegedabagacad
# XDG
export XDG_CONFIG_HOME=~/.config
# pager
export PAGER="less -cm"
# Editor
export EDITOR=vim
# less
export LESSCHARSET=utf-8
export JLESSCHARSET=utf-8
# less で行番号をつける
export LESS='-r'
# w3mのホーム
export HTTP_HOME="http://www.google.co.jp/"

# PATH の設定
PATH=$PATH:/usr/local/bin

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

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# anaconda
export PATH="$PYENV_ROOT/versions/anaconda3-4.3.0/bin/:$PATH"

# gpufan
export PATH="/opt/:$PATH"
