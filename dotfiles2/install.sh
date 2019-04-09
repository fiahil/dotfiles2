#!/bin/zsh

set -euo pipefail

function install () {
    echo "> Installing dotfiles"
    curl -fsSL https://raw.githubusercontent.com/fiahil/dotfiles2/master/.zsh/functions/dotfiles \
        | { cat ; echo "dotfiles init" } \
        | zsh

    echo "> Installing vim plugins"
    if [ -e "$HOME"/.vim/autoload/plug.vim ]; then
        vim -E -s +PlugUpgrade +qa
    else
        curl -fsSLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    vim -u "$HOME"/.vimrc.bundles +PlugUpdate +PlugClean! +qa
    reset -Q

    echo "> Installing antigen"
    curl -fsSlo "$HOME/.antigen/antigen.zsh" --create-dirs \
        https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh

    echo "> Installation completed !"
}

install
