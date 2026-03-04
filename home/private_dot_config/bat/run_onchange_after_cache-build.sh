#!/bin/bash

# tokyonight.nvim hash: {{ include "themes/tokyonight.nvim/tokyonight_day.tmTheme" | sha256sum }}
if type bat &>/dev/null; then
    bat cache --build
fi
