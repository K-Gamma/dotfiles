#!/bin/bash -u
# @(#) This script make symbolic link of dotfiles.

if [ $# -ne 1 ]; then
    echo "Error: Wrong the number of the arguments" 1>&2
    exit 1
fi

## Define the Variables {{{
# Working Directory
WD=$(cd "${0%/*}" && pwd)


# Change the IFS (Internal Filed Separator)
IFS_ORG=$IFS
IFS=$'\n'

# Original Directorys and Files
ODIRS=($(find ${WD}/ -mindepth 1 -type d | grep -v ".git"))
OFILES=($(find ${WD}/ -type f | grep -E -v ".git/|README.md|${0##*/}"))

# Reset the IFS
IFS=$IFS_ORG

## }}}

## Define the Functions {{{
### Install {{{
install() {
    local odir dir
    # Make dir
    echo $'\n# Make dir'
    for odir in "${ODIRS[@]}"; do
        dir=${odir//\/.dotfiles/}
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
        file=${ofile//\/.dotfiles/}
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
### }}}

### Uninstall {{{
uninstall () {
    local ofile file
    # Remove symbolic link
    echo $'\n# Remove symbolic link'
    for ofile in "${OFILES[@]}"; do
        file=${ofile//\/.dotfiles/}
        if [ -e "${file}" ]; then
            echo "rm -rf ${file}"
            rm -rf ${file}
        fi
    done

    # Remove dir
    local odir dir
    echo $'\n# Remove dir'
    for odir in "${ODIRS[@]}"; do
        dir=${odir//\/.dotfiles/}
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
### }}}
## }}}

if [ $1 = "install" -o $1 = "i" ]; then
    read -p 'Are you sure to install dotfiles and some plugin ? [Y/n] > ' ANSWER
    case $ANSWER in
        "Y" | "y" | "yes" | "Yes" | "YES" ) install;;
        * ) exit 1;;
    esac
elif [ $1 = "uninstall" -o $1 = "u" ]; then
    read -p 'Are you sure to deleted dotfiles and some plugin ? [y/N] > ' ANSWER
    case $ANSWER in
        "Y" | "y" | "yes" | "Yes" | "YES" ) uninstall;;
        * ) exit 1;;
    esac
else
    echo "Error: Wrong the arguments" 1>&2
    exit 1
fi
exit 0

# vim: fdm=marker fdc=3 fdl=0
