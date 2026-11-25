# load our own completion functions, then Homebrew's. Apple's /bin/zsh doesn't
# search the Apple Silicon prefix on its own; (N) drops dirs absent on this host.
fpath=(
  ~/.zsh/completion
  ${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh/site-functions(N)
  /usr/local/share/zsh/site-functions(N)
  $fpath
)

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

# give us access to ^Q (only when stdin is a terminal)
[[ -t 0 ]] && stty -ixon

# emacs keybindings (ohmyzsh lib/key-bindings.zsh also sets this and adds its
# own defaults; custom bindings must go after `antidote load` to stick)
bindkey -e

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
else
  print -u2 "starship not installed: brew install starship"
fi

# Plugins may call compdef while loading, before compinit runs further down:
# queue those calls; they are replayed right after compinit.
typeset -ga _compdef_queue
compdef() { _compdef_queue+=("${(j: :)${(@q)@}}") }

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

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# uv/cargo installer env script (absent on hosts without those installs)
[[ -f ~/.local/bin/env ]] && . ~/.local/bin/env

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

# replay compdef calls queued before compinit defined the real compdef
for _c in $_compdef_queue; do eval "compdef $_c"; done
unset _compdef_queue _c

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
