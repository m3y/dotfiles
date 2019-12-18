# This setting requires the following command.
#
#  - nvim
#  - xsel
#  - xdg-open
#  - peco
#  - ghq
#  - bat
#  - https://github.com/m3y/password-store-utility

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
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"
alias mkdir="mkdir -p"
alias cat="bat"
alias pbcopy="xsel --clipboard --input"
alias open="xdg-open"
alias pc="p -c"

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

function peco-src() {
  local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^g' peco-src

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
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

# zsh-syntax-highlighting
zplug "zsh-users/zsh-syntax-highlighting"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=cyan,bold'
# zsh-autosuggestions
zplug "zsh-users/zsh-autosuggestions"
# powerlevel10k
zplug romkatv/powerlevel10k, as:theme, depth:1
[ -f ${HOME}/.p10k.zsh ] && source ${HOME}/.p10k.zsh

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

if [ -z "${TMUX}" ]; then
  /usr/bin/tmux
fi
