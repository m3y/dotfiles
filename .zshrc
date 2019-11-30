# This setting requires the following command.
#
#  - nvim
#  - docker
#  - xsel
#  - peco

# vim mode
bindkey -v

# aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ll="clear;ls -lha"
alias vi="nvim"
alias vim="nvim"
alias c="clear"
alias d="docker"
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"
alias pbcopy="xsel --clipboard --input"

# common
setopt IGNORE_EOF
setopt NO_FLOW_CONTROL
setopt NO_BEEP
setopt INTERACTIVE_COMMENTS

# extend cd
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

cdpath=(.. ~)

# completion
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# history
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

function select_history() {
  BUFFER=$(history -n -r 1 | awk '!a[$0]++' | peco)
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N select_history
bindkey '^r' select_history

# prompt
PROMPT="[%n@%m] %# "
RPROMPT="[%~]"

# ===== zplug =====
