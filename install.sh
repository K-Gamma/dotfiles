#!/bin/bash -u
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
ODIRS=($(find ${WD}/ -mindepth 1 -type d | grep -v ".git"))
OFILES=($(find ${WD}/ -type f | grep -E -v ".git/|README.md|${0##*/}"))

IFS=$IFS_ORG

# Install {{{
install() {
    local odir dir
    # Make dir
    echo $'\n# Make dir'
    for odir in "${ODIRS[@]}"; do
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
    # Make symbolic link
    echo $'\n# Make symbolic link'
    for ofile in "${OFILES[@]}"; do
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


    # ---------------- other config ---------------- #

    # Make symbolic link of .zshenv into ~/
    if [ -f ~/.zsh/.zshenv -a ! -f ~/.zshenv ]; then
        echo "~/.zsh/.zshenv --> ~/.zshenv"
        ln -sf ~/.zsh/.zshenv ~/.zshenv
    fi

    echo $'\n\n|++++++++++++++++ DOTFILES IS INSTALLED ! ++++++++++++++++|\n\n'

}
# }}}

# Uninstall {{{
uninstall () {
    local ofile file
    # Remove symbolic link
    echo $'\n# Remove symbolic link'
    for ofile in "${OFILES[@]}"; do
        file=${ofile//\/dotfiles/}
        if [ -e "${file}" ]; then
            echo "rm -rf ${file}"
            rm -rf ${file}
        fi
    done

    # Remove dir
    local odir dir
    echo $'\n# Remove dir'
    for odir in "${ODIRS[@]}"; do
        dir=${odir//\/dotfiles/}
        if [ -e "${dir}" ]; then
            echo "rm -rf ${dir}"
            rm -rf ${dir}
        fi
    done


    # ---------------- other config ---------------- #

    # Remove symbolic link of .zshenv into ~/
    if [ -L ~/.zshenv ]; then
        echo "rm -rf ~/.zshenv"
        rm -rf ~/.zshenv
    fi

    echo "\n\n|++++++++++++++++ DOTFILES IS DELETED ! ++++++++++++++++|\n\n"

}
# }}}

if [ $# -eq 1 ]; then
    if [ $1 = "uninstall" -o $1 = "u" ]; then
        read -p 'Are you sure to deleted dotfiles and some plugin ? [y/N] > ' ANSWER
        case $ANSWER in
            "Y" | "y" | "yes" | "Yes" | "YES" ) uninstall;;
            * ) exit 1;;
        esac
    else
        echo "Error: wrong arguments" 1>&2
        exit 1
    fi
fi
install


# vim: foldmethod=marker
# vim: foldcolumn=3
# vim: foldlevel=0
