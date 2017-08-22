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

$ vim
[dein] ( 1/20) |vim-markdown        | ['git', 'clone', '--recursive', 'https://github.com/rcmdnk/vim-markdown.git', '/home/ganma/.vim/dein/repos/github.com/rcmdnk/vim-markdown']
[dein] ( 1/20) [=                   ] vim-markdown
[dein] ( 2/20) |iceberg.vim         | ['git', 'clone', '--recursive', 'https://github.com/cocopon/iceberg.vim.git', '/home/ganma/.vim/dein/repos/github.com/cocopon/iceberg.vim']
[dein] ( 2/20) [==                  ] iceberg.vim
[dein] ( 3/20) |context_filetype.vim| ['git', 'clone', '--recursive', 'https://github.com/Shougo/context_filetype.vim.git', '/home/ganma/.vim/dein/repos/github.com/Shougo/context_filetype.vim']
[dein] ( 3/20) [===                 ] context_filetype.vim
...

[dein]   vim-endwise(1 change)
[dein]   vim-toml(1 change)
[dein]   vimshell.vim(1 change)
[dein]   vim-quickrun(1 change)
[dein]   vim-precious(1 change)
[dein]   jedi-vim(1 change)
[dein]   vimproc.vim(1 change)
[dein]   vim-ft-help_fold(1 change)
[dein]   lightline.vim(1 change)                             0,0-1         全て続けるにはENTERを押すかコマンドを入力してください
vim .zsh/zshenv  9.15s user 4.01s system 6% cpu 3:36.09 total
```

## Uninstall

```sh
$ cd dotfiles
$ bash ./install.sh clean
Are you sure you want to clean those ? [y/N] > y

# rm symbolic link
...

# rm dir
...

```

