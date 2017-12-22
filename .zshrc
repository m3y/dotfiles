bindkey -v # vim mode

# aliases
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
alias fzf="fzf --reverse --select-1 --exit-0"

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

setopt IGNORE_EOF
setopt NO_FLOW_CONTROL
setopt NO_BEEP

# completion
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end \
  history-search-end
bindkey "^o" history-beginning-search-backward-end

function select_history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select_history
bindkey '^r' select_history

# prompt
PROMPT="[%n@%m] %# "
RPROMPT="[%~]"

# ===== zplug =====
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

# Make sure to use double quotes to prevent shell expansion
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "b4b4r07/enhancd", use:init.sh
export ENHANCD_FILTER=fzf
export ENHANCD_HOOK_AFTER_CD=ls
function ghq_search() {
  __enhancd::cd -G
}
zle -N ghq_search
bindkey '^G' ghq_search
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

# Install packages that have not been installed yet
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  else
    echo
  fi
fi

zplug load
