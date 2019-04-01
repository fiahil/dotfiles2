#!/bin/bash

function install () {
    echo "> Installing dotfiles"

    export DOTDIR='$HOME/.dotfiles'
    export REMOTE='git@github.com:fiahil/dotfiles2.git'

    git init --bare "${DOTDIR}"

    alias dotfiles="git --git-dir=${DOTDIR} --work-tree=${HOME}"

    dotfiles config status.showUntrackedFiles no
    dotfiles remote add origin "${REMOTE}"
    dotfiles fetch
    dotfiles reset origin/master

    echo "> Installation completed !"
    echo "> Files existing before:"

    dotfiles status
}

install