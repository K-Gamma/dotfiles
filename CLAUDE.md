# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Chezmoi で管理された dotfiles リポジトリ。ソースルートは `home/`。
Chezmoi テンプレート (.tmpl) を編集する際は `.chezmoiversion` を確認し、そのバージョンの公式ドキュメントを参照すること。

## 対象環境

macOS と Ubuntu (Debian 系) の両方で使用する。変更・提案時は両環境への影響を考慮すること。

## コミット規約

conventional commits 形式。日本語で記述。

```
type(scope): 説明
```

type: feat, fix, chore, refactor, docs など

## 外部ソースの引用

他人の GitHub リポジトリや公式ドキュメントを参考にした設定は、引用元をコメントで明示し、自分の設定と混ぜない。

## コード品質

### Lua (Neovim)

stylua でフォーマット。設定は `home/private_dot_config/nvim/.stylua.toml` を参照。

### Pre-commit (Lefthook)

設定は `.lefthook.yml` を参照。
