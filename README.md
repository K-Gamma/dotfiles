# dotfiles
These are my dotfiles.

## Install
You can get my dotfiles by the following procedure.

```sh
$ git clone https://github.com/K-Ganma/dotfiles.git
$ cd dotfiles
$ bash ./install.sh
# Make dir and symbolic link
$ exec $SHELL -l
# Install zplug and zsh's plugins
$ vim
# Install dein.vim and vim's plugins
```

## Uninstall
You can delete my dotfiles by following procedure.
But, Please note that all installed plugins will also be deleted.

```sh
$ cd dotfiles
$ bash ./install.sh clean
Are you sure to deleted dotfiles and some plugin ? [y/N] > y
# Remove symbolic link and dir
```

## Requirements
You'll need to install the following software.
- Git
- Zsh
- Vim

