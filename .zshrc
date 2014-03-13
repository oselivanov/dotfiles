# Author: Oleg Selivanov <oleg.a.selivanov@gmail.com>
# This config could be safely copied to remove machine.

bindkey -v 

vi-go-back() {
  cd ..
  zle vi-insert
  zle -I
  echo
  echo
  FIRST_LINE=1
  precmd
  FIRST_LINE=0
}
zle -N vi-go-back
bindkey -M viins "^h" vi-go-back
bindkey -M vicmd "^h" vi-go-back

# Word walking by default.
bindkey -M vicmd h vi-backward-word 
bindkey -M vicmd l vi-forward-word

setopt appendhistory
setopt autopushd
setopt autoremoveslash
setopt completealiases
setopt histignorealldups
setopt nomenucomplete

# Setup history.
HISTFILE=$HOME/.zsh_history
# History file limit.
SAVEHIST=9999
# Session history limit.
HISTSIZE=9999

# Unmap <c-s>.
stty stop undef

# Bunch of handful aliases.
alias ls='ls -CF --color=auto --group-directories-first'
alias ll='ls -lF --color=auto --group-directories-first'
alias iotop='iotop -oP -d 1'
alias p='clear;ps axo pid,%cpu,user,group,start_time,rss,vsz,command'

# Use PCRE for grep by default. Very useful with greplace utility.
# See homebin/greplace for details.
alias grep='grep -P --colour=auto'

# Auto-completion initialization.
autoload -U compinit promptinit
compinit
promptinit
zstyle ':completion:*' menu select
LISTMAX=9999
zmodload zsh/complist

# Default colored prompt in red to warn about working on remote machine.
PROMPT=$'%{$fg[red]%}%n@%m %{$fg[yellow]%}%~ %{${reset_color}%}%# '

# Always prefer scripts from my ~/bin
export PATH=$HOME/bin:$PATH

# Set default pager.
export PAGER=less

# Setup default editor.
export EDITOR=/usr/bin/vim

# https://github.com/oselivanov/zsh-vi-done-right
if [ -f ~/.zsh_vi ]; then
  . ~/.zsh_vi
fi

if [ -f ~/.zsh_profile ]; then
  . ~/.zsh_profile
fi
