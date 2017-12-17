bindkey -v

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

PROMPT="[%n@%m] %# "
RPROMPT="[%~]"

setopt IGNORE_EOF
setopt NO_FLOW_CONTROL
setopt NO_BEEP

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

bindkey '^r' \
  history-incremental-pattern-search-backward
bindkey '^s' \
  history-incremental-pattern-search-forward

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end \
  history-search-end
bindkey "^o" history-beginning-search-backward-end

alias ls="exa"
alias ll="clear;ls -lha"
alias vi="vim"
alias c="clear"
alias d="docker"
alias mv="mv -i"
alias cp="cp -ir"
alias rm="rm -ir"
alias virc="vi ~/.zshrc"
alias sorc="source ~/.zshrc"
alias vimrc="vi ~/.vimrc"
alias diff="colordiff"
alias ...="cd ../.."
alias ....="cd ../../.."
