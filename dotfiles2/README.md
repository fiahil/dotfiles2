## Installation

```sh
function install () {
    echo "> Installing antigen"
    curl -fsSL git.io/antigen | sh -s - -b /usr/local/bin
    source <(antibody init)

    echo "> Installing dotfiles"
    eval "$(curl -fsSL https://raw.githubusercontent.com/fiahil/dotfiles2/master/.zsh/functions/dotfiles)"

    dotfiles init

    echo "> Installation completed, relaunch your shell" 
}

install
```
