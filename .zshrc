# Author: Oleg Selivanov <oleg.a.selivanov@gmail.com>

# Vi mode by default and basic settings setup.
bindkey -v 
bindkey "^r" history-incremental-search-backward
bindkey -M viins '^p' up-history 
bindkey -M viins '^n' down-history 
bindkey -M vicmd "^r" history-incremental-search-backward
vi-esc-fix() {
  zle vi-cmd-mode
  zle forward-char
}
zle -N vi-esc-fix
bindkey -r "\e" 
bindkey -M viins "\e" vi-esc-fix

setopt autopushd
setopt appendhistory
setopt completealiases
setopt histignorealldups
setopt promptsubst
setopt autoremoveslash
setopt nomenucomplete

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
alias g='git st'
alias gl='git lg'
alias gd='git diff'
alias iotop='iotop -oP -d 1'
alias p='clear;ps axo pid,%cpu,user,group,start_time,rss,vsz,command'

# Extra handful aliases.
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# Use PCRE for grep by defaul. Very useful with greplace oneline utility.
# See homebin/greplace for details.
alias grep='grep -P --colour=auto'

# Auto-completion initialization.
autoload -U compinit promptinit
compinit
promptinit
zstyle ':completion:*' menu select

LISTMAX=9999

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# I want to delete char with Backspace key in command mode as well
bindkey -M vicmd "^?" vi-backward-delete-char

# Don't use vi mode in backward delete word/char
# because it cannot delete charcters before the position entering insert mode
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

# Initialization of colors shortcuts.
autoload -U colors
colors

# Default colored prompt in red to warn about working with remote machine.
PROMPT=$'%{$fg[red]%}%n@%m %{$fg[yellow]%}%~ %{${reset_color}%}%# '

# Setup user bin.
export PATH="$HOME/bin:$PATH"

# Set default pager.
export PAGER=less

if [ -f ~/.zsh_profile ]; then
    . ~/.zsh_profile
fi
