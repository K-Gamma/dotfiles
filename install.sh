#!/bin/bash
# @(#) This script make symbolic link of dotfiles.

if [ $# -gt 1 ]; then
    echo "Error: wrong number of arguments" 1>&2
    exit 1
fi

# working directory
WD=$(cd "${0%/*}" && pwd)

# delimiter
IFS_ORG=$IFS
IFS=$'\n'

# original file
ODIRS=($(find $WD/ -mindepth 1 -type d))
OFILES=($(find $WD/ -type f))

IFS=$IFS_ORG

# 関数の定義
# uninstall {{{
uninstall () {
    local odir dir
    # rm dir
    echo $'\n# rm dir'
    for odir in "${ODIRS[@]}"; do
        if [ ${odir##*/} = '.git' ]; then
            continue
        fi
        dir=${odir//\/dotfiles/}
        if [ -e "${dir}" ]; then
            echo "rm -rf ${dir}"
            rm -rf ${dir}
        fi
    done

    local ofile file
    # rm symbolic link of OFILE
    echo $'\n# rm symbolic link'
    for ofile in "${OFILES[@]}"; do
        if [ ${ofile##*/} = ${0##*/} ]; then
            continue
        fi
        file=${ofile//\/dotfiles/}
        if [ -e "${file}" ]; then
            echo "rm -rf ${file}"
            rm -rf ${file}
        fi
    done

    # ++++++++++++++++ other config ++++++++++++++++ #
    echo $'\n# +++++++ other config +++++++ #'

    # rm symbolic link of .zshenv into ~/
    if [ -L ~/.zshenv ]; then
        echo "rm -rf ~/.zshenv"
        rm -rf ~/.zshenv
    fi
}
# }}}

# install {{{
install() {
    local odir dir
    # make dir
    echo $'\n# make dir'
    for odir in "${ODIRS[@]}"; do
        if [ ${odir##*/} = '.git' ]; then
            continue
        fi
        dir=${odir//\/dotfiles/}
        if [ ! -e "${dir}" ]; then
            echo "mkdir $dir"
            mkdir "${dir}"
        elif [ ! -d "${dir}" ]; then
            echo "Cannot create : ${dir}"
        else
            echo "Already exist : ${dir}"
        fi
    done

    local ofile file
    # make symbolic link of OFILE
    echo $'\n# make symbolic link'
    for ofile in "${OFILES[@]}"; do
        if [ ${ofile##*/} = ${0##*/} ]; then
            continue
        fi
        file=${ofile//\/dotfiles/}
        if [ ! -e "${file}" ]; then
            echo "${ofile} --> ${file}"
            ln -s ${ofile} ${file}
        elif [ ! -f "${file}" ]; then
            echo "Cannot create : ${file}"
        else
            echo "Already exist : ${file}"
        fi
    done

    # ++++++++++++++++ other config ++++++++++++++++ #
    echo $'\n# +++++++ other config +++++++ #'

    # make symbolic link of .zshenv into ~/
    if [ -f ~/.zsh/.zshenv -a ! -f ~/.zshenv ]; then
        echo "~/.zsh/.zshenv --> ~/.zshenv"
        ln -sf ~/.zsh/.zshenv ~/.zshenv
    fi
}
# }}}


if [ $# -eq 1 ]; then
    if [ $1 = "clean" ]; then
        read -p 'Are you sure you want to clean those ? [y/N] > ' ANSWER
        case $ANSWER in
            "Y" | "y" | "yes" | "Yes" | "YES" ) uninstall;;
            * ) exit 1;;
        esac
    else
        echo "Error: wrong arguments" 1>&2
        exit 1
    fi
    exit 0
fi
install


# vim: foldmethod=marker
# vim: foldcolumn=3
# vim: foldlevel=0
