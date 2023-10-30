# Author: Oleg Selivanov <oleg.a.selivanov@gmail.com>
# This config can be safely used on remove machine.

setopt appendhistory
setopt autopushd
setopt noautoremoveslash
setopt completealiases
setopt histignorealldups
setopt nomenucomplete

# Setup history.
HISTFILE=$HOME/.zsh_history
# History file limit.
SAVEHIST=99999
# Session history limit.
HISTSIZE=99999
setopt HIST_IGNORE_SPACE

# Unmap <c-s>.
stty stop undef

# Local zsh completions.
fpath=($HOME/.zsh/completions $fpath)

# Auto-completion initialization with middle of the word and
# any case completion.
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit promptinit
compinit

promptinit
zstyle ':completion:*' menu select
LISTMAX=9999
zmodload zsh/complist
ZLE_REMOVE_SUFFIX_CHARS=$'\t\n;&|'

# Bunch of handful aliases.
alias ls="ls -CF --block-size \"'1\" --color=auto --group-directories-first"
alias ll="ls -lF --block-size \"'1\" --color=auto --group-directories-first"
alias iotop='iotop -oP -d 1'
alias p='clear;ps axo pid,%cpu,user,group,start_time,rss,vsz,command'
alias less='less -M'

# Use PCRE for grep by default. Very useful with greplace utility.
# See homebin/greplace for details.
alias g='grep -iP --colour=auto'
alias grep='grep -P --colour=auto'

# Default colored prompt in red to warn about working on remote machine.
setopt promptsubst
autoload -U colors
colors
PROMPT=$'%{$fg[red]%}%n@%m %{$fg[yellow]%}%~ %{${reset_color}%}%# '

# Set default pager.
export PAGER=less

# Setup default editor.
export EDITOR=/usr/bin/vim

# Support for 256 colors.
export TERM=xterm-256color

# https://github.com/oselivanov/zsh-vi-done-right
zsh_vi_word_walking=1
if [ -f ~/.zsh_vi ]; then
  . ~/.zsh_vi
fi

if [ -f ~/.zsh_experiments ]; then
  . ~/.zsh_experiments
fi

if [ -f ~/.zsh_profile ]; then
  . ~/.zsh_profile
fi
