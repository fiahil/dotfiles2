## Installation

```sh
function install () {
    mkdir -p "$HOME/bin/"
    echo "> Installing antidote"
    git clone --depth=1 https://github.com/mattmc3/antidote.git "$HOME/bin/antidote"

    echo "> Installing dotfiles"
    eval "$(curl -fsSL https://raw.githubusercontent.com/fiahil/dotfiles2/master/.zsh/functions/dotfiles)"

    dotfiles init

    echo "> Installation completed, relaunch your shell" 
}

install
```
