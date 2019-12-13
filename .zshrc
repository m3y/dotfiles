# This setting requires the following command.
#
#  - nvim
#  - docker
#  - xsel
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
alias d="docker"
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"
alias mkdir="mkdir -p"
alias cat="bat"
alias pbcopy="xsel --clipboard --input"
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
# powerlevel9k
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
##POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{101} >_ $ %F{014}"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir kubecontext vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv status)
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_USER_DEFAULT_FOREGROUND='101'
POWERLEVEL9K_USER_DEFAULT_BACKGROUND='grey'
POWERLEVEL9K_USER_ROOT_FOREGROUND='101'
POWERLEVEL9K_USER_ROOT_BACKGROUND='grey'
POWERLEVEL9K_USER_SUDO_FOREGROUND='101'
POWERLEVEL9K_USER_SUDO_BACKGROUND='grey'
POWERLEVEL9K_STATUS_OK_FOREGROUND='green'
POWERLEVEL9K_STATUS_OK_BACKGROUND='grey'
POWERLEVEL9K_STATUS_ERROR_FOREGROUND='red'
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='grey'
POWERLEVEL9K_DIR_HOME_FOREGROUND='blue'
POWERLEVEL9K_DIR_HOME_BACKGROUND='grey'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='blue'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='grey'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='blue'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='grey'
POWERLEVEL9K_DIR_ETC_FOREGROUND='blue'
POWERLEVEL9K_DIR_ETC_BACKGROUND='grey'
POWERLEVEL9K_KUBECONTEXT_FOREGROUND='yellow'
POWERLEVEL9K_KUBECONTEXT_BACKGROUND='grey'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='green'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='grey'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='grey'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='grey'
POWERLEVEL9K_PYTHON_ICON=$'\uE606'
POWERLEVEL9K_VIRTUALENV_FOREGROUND="green"
POWERLEVEL9K_VIRTUALENV_BACKGROUND="grey"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

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
