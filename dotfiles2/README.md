## Installation

```sh
function install () {
    echo "> Installing dotfiles"

    apt update && apt install -y curl vim zsh git
    eval "$(curl -fsSL https://raw.githubusercontent.com/fiahil/dotfiles2/master/.zsh/functions/dotfiles)"

    dotfiles init
    dotfiles reload
}

install
```
