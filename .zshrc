# load our own completion functions
fpath=(~/.zsh/completion /usr/local/share/zsh/site-functions $fpath)

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=65536
SAVEHIST=65536

# taste options
DISABLE_AUTO_TITLE="true"
HYPHEN_INSENSITIVE="false"
COMPLETION_WAITING_DOTS="true"
ZSH_CACHE_DIR=/tmp/zshcache

mkdir -p /tmp/zshcache

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# give us access to ^Q
stty -ixon

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}

install_starship() {
  sh -c "$(curl -fsSL https://starship.rs/install.sh)"
  eval "$(starship init zsh)"
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

type starship > /dev/null && eval "$(starship init zsh)" || install_starship

# antidote
source "$HOME/bin/antidote/antidote.zsh"

# initialize plugins statically with ~/.zsh_plugins.txt
antidote load

# Plugin keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down
bindkey '^[^[' autosuggest-accept
bindkey '^[^M' autosuggest-execute

# dircolors
[[ -f ~/.dircolors ]] && eval `dircolors ~/.dircolors`

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# iterm2
[[ -f ~/.iterm2_shell_integration.zsh ]] && source ~/.iterm2_shell_integration.zsh

. "$HOME/.local/bin/env"

# completion: single compinit, after every fpath mutation (antidote plugins,
# ~/.zfunc). Full rebuild only if the dump is older than 24h, else use cache.
# NB: zsh does not glob inside [[ ]] — collect matches in an array instead.
fpath+=~/.zfunc
autoload -Uz compinit
_stale_dump=(~/.zcompdump(N.mh+24))
if (( $#_stale_dump )); then
  compinit -d ~/.zcompdump
else
  compinit -C -d ~/.zcompdump
fi
unset _stale_dump

# disable zsh bundled function mtools command mcd
# which causes a conflict.
compdef -d mcd

# load custom executable functions (g, jcurl call compdef)
for function in ~/.zsh/functions/*; do
  source $function
done

# Local config: machine-specific tool paths (deno, bun, pnpm, …).
# Sourced last so it can register completions via compdef.
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
