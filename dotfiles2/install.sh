#!/bin/bash

function install () {
    echo "> Installing dotfiles"
    curl -fsSL https://raw.githubusercontent.com/fiahil/dotfiles2/master/.zsh/functions/dotfiles | xargs -I CMD bash -c "CMD ; dotfiles init"
    echo "> Installation completed !"
}

install
