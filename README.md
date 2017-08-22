# dotfiles
My dotfiles

## Install

```sh
$ git clone https://github.com/K-Ganma/dotfiles.git
$ cd dotfiles
$ bash ./install.sh
# make dir
...

# make symbolic link
...

$ exec $SHELL -l
Cloning into '/home/ganma/.zsh/.zplug'...
remote: Counting objects: 5250, done.
remote: Total 5250 (delta 0), reused 0 (delta 0), pack-reused 5250
Receiving objects: 100% (5250/5250), 1.06 MiB | 459.00 KiB/s, done.
Resolving deltas: 100% (3263/3263), done.
Checking connectivity... done.
Install? [y/N]: y
[zplug] Start to install 7 plugins in parallel
...

[zplug] Elapsed time: 14.4635 sec.
 ==> Installation finished successfully!
```

## Uninstall

```sh
$ cd dotfiles
$ bash ./install.sh clean
Are you sure you want to clean those ? [y/N] > y

# rm dir
...

# rm symbolic link
...

```
