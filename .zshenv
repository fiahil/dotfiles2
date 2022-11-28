export SHELL=/bin/zsh
export TERM="xterm-256color"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Use vim as the visual editor
export VISUAL=vim 
export EDITOR=$VISUAL

# Pager settings
export PAGER=less
export LESS="-iMRSex4 -FX"

# Paths
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/git/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.8/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.9/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.10/bin:$PATH"

# Mac-specific exports
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="/Applications/Postgres.app/Contents/Versions/13/bin:$PATH"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export GOPATH="$HOME/go"
export GOROOT="/usr/local/opt/go/libexec"

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
