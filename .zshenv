export SHELL=/bin/zsh
export TERM="xterm-256color"
export ARCHFLAGS="-arch x86_64"

# Use vim as the visual editor
export VISUAL=vim 
export EDITOR=$VISUAL

# Pager settings
export PAGER=less
export LESS="-iMRSex4 -FX"

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv

# Paths
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/git/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/anaconda3/bin/:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/10/bin:$PATH"

export GOPATH="$HOME/go"

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
