# This file is loaded in the login shells and interactive shells.

case ${OSTYPE} in
    darwin*) # Mac
        source $ZDOTDIR/.zshrc.darwin
        ;;
    linux*)
        source $ZDOTDIR/.zshrc.linux
        ;;
esac
