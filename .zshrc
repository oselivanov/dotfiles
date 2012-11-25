# Author: Oleg Selivanov <oleg.a.selivanov@gmail.com>

HISTFILE=$HOME/.zsh_history
# History file limit.
SAVEHIST=9999
# Session history limit.
HISTSIZE=9999

# Vi mode by default and basic settings setup.
bindkey -v 
setopt list_rows_first
setopt autopushd
setopt appendhistory
setopt completealiases
setopt histignorealldups
setopt promptsubst
setopt autoremoveslash
setopt noautomenu 
setopt nomenucomplete

# Auto-completion initialization.
autoload -U compinit promptinit
compinit
promptinit
zstyle ':completion:*' menu select

# Initialization of colors shortcuts.
autoload -U colors
colors

# Bunch of handful aliases.
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias ls='ls -CF --color=auto --group-directories-first'
alias ll='ls -AlF --color=auto --group-directories-first'
alias iotop='iotop -oP -d 1'
alias p='clear;ps axo pid,%cpu,user,group,start_time,rss,vsz,command'
# Use PCRE for grep by defaul. Very useful with greplace oneline utility.
# See homebin/greplace for details.
alias grep='grep -Pn --colour=auto'

# Default colored prompt in red to warn about working with remote machine.
PROMPT=$'%{$fg[red]%}%n@%m %{$fg[yellow]%}%~ %{${reset_color}%}%# '

# Setup user bin.
export PATH="$PATH:$HOME/bin"

if [ -f ~/.zsh_profile ]; then
    . ~/.zsh_profile
fi
