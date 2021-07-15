
# load our own completion functions
fpath=(~/.zsh/completion /usr/local/share/zsh/site-functions $fpath)

# completion; use cache if updated within 24h
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit -d $HOME/.zcompdump
else
  compinit -C
fi

# disable zsh bundled function mtools command mcd
# which causes a conflict.
compdef -d mcd

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

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

# antibody
source <(antibody init)
antibody bundle < ~/.zshplugins

# dircolors
[[ -f ~/.dircolors ]] && eval `dircolors ~/.dircolors`

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# iterm2
[[ -f ~/.iterm2_shell_integration.zsh ]] && source ~/.iterm2_shell_integration.zsh

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Plugin keybindings
bindkey '\eOA' history-substring-search-up
bindkey '\eOB' history-substring-search-down
bindkey '^[^[' autosuggest-accept
bindkey '^[^M' autosuggest-execute
