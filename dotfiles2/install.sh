#!/bin/bash

function install () {
    echo "> Installing dotfiles"

    export DOTDIR="${HOME}/.dotfiles"
    export REMOTE="git@github.com:fiahil/dotfiles2.git"

    dotfiles="git --git-dir=${DOTDIR} --work-tree=${HOME}"

    git init --bare "${DOTDIR}"

    $dotfiles config status.showUntrackedFiles no
    $dotfiles remote add origin "${REMOTE}"
    $dotfiles fetch
    $dotfiles reset origin/master
    $dotfiles stash

    echo "> Installation completed !"
}

install
