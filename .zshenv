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

# Keep PATH/FPATH/MANPATH free of duplicates (nested shells re-run rc files
# and would re-prepend). Both scalar and tied array need the flag: -U only
# takes effect on assignment to the flagged name.
typeset -U PATH path FPATH fpath MANPATH manpath
# PATH entries themselves: ~/.zprofile (after macOS path_helper) and ~/.zshrc.

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
