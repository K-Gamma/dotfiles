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
# ~ (${HOME})/
# ├── .zshenv --> ${HOME}/.zsh/.zshenv
# ├── .zsh/ (${ZDOTDIR})
# │   ├── (zsh's dotfiles) --> ${HOME}/dotfiles/.zsh/(zsh's dotfiles)
# │   └── ...
# └── ...

## Profiling zsh shell scripts
#zmodload zsh/zprof && zprof

# Global initialization files aren't sourced.
unsetopt global_rcs

# Set up the environment variables. {{{
# Language
export LANG=ja_JP.UTF-8

# Default dircolors
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# Road the dircolors file.
if [ -f ${HOME}/.dircolors ]; then
    if type dircolors > /dev/null 2>&1; then
        eval $(dircolors ${HOME}/.dircolors)
    elif type gdircolors > /dev/null 2>&1; then
        eval $(gdircolors ${HOME}/.dircolors)
    fi
fi

# XDG Base Directory Specification
export XDG_CONFIG_HOME=${HOME}/.config

# Pager
export PAGER="less -cm"

# Editor
export EDITOR=vim

# Less
export LESS='-r'
export LESSCHARSET=utf-8
export JLESSCHARSET=utf-8

# + Zsh {{{
# Specify the directory to put the Zsh files.
export ZDOTDIR=${HOME}/.zsh

# Set of characters to be treated as a pattern during spelling correction.
export CORRECT_IGNORE='_*'
export CORRECT_IGNORE_FILE='.*'

# Set of characters to be treated as part of a word.
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# In the line editor, the number of matches to list without
# asking first. If set to zero, the shell asks only if the top
# of the listing would scroll off the screen.
export LISTMAX=0

# ++ History {{{
# Specify the file to save history.
export HISTFILE=${ZDOTDIR}/.zsh_history

# Set the number of history stored in memory.
export HISTSIZE=1000

# Set the number of history stored in history file.
export SAVEHIST=100000
# Do not add in root
if [[ $UID == 0 ]]; then
    unset HISTFILE
    export SAVEHIST=0
fi
# ++ }}}

# ++ zplug/zplug {{{
# zplug will store/load packages in this directory.
# Defaults to ~/.zplug.
export ZPLUG_HOME=${ZDOTDIR}/.zplug

# zplug will used the firest element in this list as 
# the interactive filter.
# Defaults to fzf-tmux:fzf:peco:percol:zaw
#export ZPLUG_FILTER=fzf-tmux:fzf:peco:percol:zaw

# You can set sudo password for zplug's hook-build tag.
# However, this variable should not be managed in dotfiles and so on.
# Defaults to ''.
#export ZPLUG_SUDO_PASSWORD=''
# ++ }}}
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
# + }}}

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
    export VIRTUAL_ENV_DISABLE_PROMPT=1
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

# + for My command {{{
export PATH=/opt/:${PATH}
# + }}}
# }}}

# vim: fdm=marker fdc=3 fdl=0
