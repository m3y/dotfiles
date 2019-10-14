bindkey -v # vim mode

# aliases
alias ll="clear;ls -lha"
alias vi="nvim"
alias vim="nvim"
alias c="clear"
alias d="docker"
alias mv="mv -i"
alias cp="cp -ir"
alias rm="rm -ir"
alias virc="vi ~/.zshrc"
alias sorc="source ~/.zshrc"
alias vimrc="vi ~/.vimrc"
alias ...="cd ../.."
alias ....="cd ../../.."
alias pc="p -c"
alias pbcopy="xsel --clipboard --input"

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
## Pipenv
#eval "$(pipenv --completion)"

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end \
  history-search-end
bindkey "^o" history-beginning-search-backward-end

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
# zsh-autosuggestions
zplug "zsh-users/zsh-autosuggestions"
# zsh-completions
zplug "zsh-users/zsh-completions"
# enhancd
zplug "b4b4r07/enhancd", use:init.sh
export ENHANCD_FILTER=peco
export ENHANCD_HOOK_AFTER_CD="echo \=\=\= ls \=\=\=;ls"
function ghq_search() {
  __enhancd::cd -G
}
zle -N ghq_search
bindkey '^G' ghq_search
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
# zsh-colors
zplug "Tarrasch/zsh-colors"

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

if [[ "${TMUX}" = "" ]]; then
  tmux
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
