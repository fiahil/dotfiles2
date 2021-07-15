## Installation

```sh
set -euxo pipefail

function install () {
    echo "> Installing dotfiles"

    src=$(curl -fsSL https://raw.githubusercontent.com/fiahil/dotfiles2/master/.zsh/functions/dotfiles)
    eval $src

    echo "> Installation completed"
    dotfiles reload
}

install
```
