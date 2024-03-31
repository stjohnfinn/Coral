#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias exa='exa --long --tree --level=2'

alias clea='clear'
alias lcear='clear'

PS1='\[\e[0m\]\d \[\e[0;38;5;69m\]\h \[\e[0m\]/ \[\e[0;1;3;38;5;69m\]\u \[\e[0m\][\[\e[0;2m\]\w\[\e[0m\]] \n \[\e[0;1m\]>\[\e[0;1m\]> \[\e[0m\]'

export HISTFILESIZE=10000
export HISTSIZE=500
shopt -s checkwinsize
shopt -s histappend
PROMPT_COMMAND='history -a'
export EDITOR=vim

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/go/bin
