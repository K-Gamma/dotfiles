#!/bin/bash

if [[ ! -d $(brew --prefix)/opt/fzf/install ]]; then
    $(brew --prefix)/opt/fzf/install --xdg --key-bindings --completion --no-update-rc
fi
