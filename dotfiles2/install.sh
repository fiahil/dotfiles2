#!/bin/bash

function install () {
    echo "> Installing dotfiles"
    curl -fsSL https://raw.githubusercontent.com/fiahil/dotfiles2/master/.zsh/functions/dotfiles | { cat ; echo "dotfiles init" } | zsh
    echo "> Installation completed !"
}

install
