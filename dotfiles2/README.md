## Installation

```sh
function install () {
    echo "> Installing antibody"
    curl -fsSL git.io/antibody | sh -s - -b /usr/local/bin
    source <(antibody init)

    echo "> Installing dotfiles"
    eval "$(curl -fsSL https://raw.githubusercontent.com/fiahil/dotfiles2/master/.zsh/functions/dotfiles)"

    dotfiles init

    echo "> Installation completed, relaunch your shell" 
}

install
```
