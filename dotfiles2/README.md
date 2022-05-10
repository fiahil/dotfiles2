## Installation

```sh
function install () {
    mkdir -p "$HOME/bin/"
    echo "> Installing antigen"
    curl -L git.io/antigen > "$HOME/bin/antigen.zsh"

    echo "> Installing dotfiles"
    eval "$(curl -fsSL https://raw.githubusercontent.com/fiahil/dotfiles2/master/.zsh/functions/dotfiles)"

    dotfiles init

    echo "> Installation completed, relaunch your shell" 
}

install
```
