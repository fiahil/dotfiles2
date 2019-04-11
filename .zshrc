
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

# Powerlevel9k
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k

POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon user virtualenv dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs time)
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='\u2570\uf460 '
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
#POWERLEVEL9K_USER_ICON="\uF415" # 
POWERLEVEL9K_ROOT_ICON="\uF09C"
#POWERLEVEL9K_SUDO_ICON=$'\uF09C' # 
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_VCS_GIT_ICON='\uF408 '
POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uF408 '
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=2
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0

# antigen
[[ -f ~/.antigen/antigen.zsh ]] && source ~/.antigen/antigen.zsh
[[ -f ~/.antigenrc ]] && source ~/.antigenrc

# dircolors
[[ -f ~/.dircolors ]] && eval `dircolors ~/.dircolors`

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# iterm2
[[ -f ~/.iterm2_shell_integration.zsh ]] && source ~/.iterm2_shell_integration.zsh

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local