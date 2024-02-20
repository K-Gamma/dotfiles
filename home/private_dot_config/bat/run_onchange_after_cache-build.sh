#!/bin/bash

# tokyonight.nvim hash: {{ include "themes/tokyonight.nvim" | sha256sum }}
if type bat &>/dev/null; then
    bat cache --build
fi
