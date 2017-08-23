#!/bin/bash -u
# @(#) This script build an environment.

if [ $# -gt 0 ]; then
    echo "Error: wrong number of arguments" 1>&2
    exit 1
fi

has() {
    which $1 > /dev/null 2>&1
    return $?
}

readonly DOTPATH=~/.dotfiles
readonly GITHUB_URL=https://github.com/K-Ganma/dotfiles.git

# if git is installed, use git.
if has "git"; then
    git clone --recursive "$GITHUB_URL" "$DOTPATH"
    # if git isn't installed, use curl or wget.
elif has "curl" || has "wget"; then
    readonly TAR_URL=https://github.com/K-Ganma/dotfiles/archive/master.tar.gz
    if has "curl"; then
        curl -fL "$TAR_URL" 
    elif has "wget"; then
        wget -O - "$TAR_URL"
    fi | tar xzvf -
    mv -f dotfiles-master "$DOTPATH"
elif
    echo "Error : 'curl' or 'wget' required." 1>&2
fi

cd ~/.dotfiles
if [$? -ne 0]; then
    echo "Error : $DOTPATH can't found." 1>&2
fi

# delimiter
IFS_ORG=$IFS
IFS=$'\n'

# original file
ODIRS=($(find ${DOTPATH}/ -mindepth 1 -type d | grep -v ".git"))
OFILES=($(find ${DOTPATH}/ -type f | grep -E -v ".git/|README.md|${0##*/}"))

IFS=$IFS_ORG

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


# vim: foldmethod=marker
# vim: foldcolumn=3
# vim: foldlevel=0
