# dotfiles
My dotfiles managed by [chezmoi](https://github.com/twpayne/chezmoi).

## Requirements
You'll need to install the following software.
- git (Required)
  - [git-credential-manager](https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/install.md) (If you want to do it with 'https')
- [bitwarden-cli](https://bitwarden.com/ja-JP/help/cli/#download-and-install) (Required)

## Installation
After installing chezmoi in `.local/bin`, clone this repository to `.local/share` and do `chezmoi init && chezmoi apply`.

``` shell
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply "K-Gamma"
```
