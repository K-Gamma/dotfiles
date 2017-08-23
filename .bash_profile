# Add environment variables here:

# Language
export LANG=ja_JP.UTF-8
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
