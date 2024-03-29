# This setting requires the following command.
#
#  - bat
#  - eza
#  - delta
#  - fzf
#  - ghq
#  - gojq
#  - kctx(https://github.com/m3y/kctx)
#  - starship
#  - vim
#  - xsel
#  - xdg-open

# vim mode
bindkey -v

# aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ls="eza --icons=auto"
alias ll="clear;ls -lha"
alias diff="delta"
alias vi="vim"
alias c="clear"
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"
alias mkdir="mkdir -p"
alias cat="bat"
alias pbcopy="xsel --clipboard --input"
alias open="xdg-open"
alias jq="gojq"
alias kctx="source ~/.ghq/src/github.com/m3y/kctx/kctx"

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

function fzf-src() {
  local selected_dir=$(ghq list --full-path | fzf -1 +m)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src
bindkey '^g' fzf-src

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
  BUFFER=$(history -n -r 1 | awk '!a[$0]++' | fzf)
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N select_history
bindkey '^r' select_history

# ===== zplug =====
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

# zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

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

# ===== /zplug =====

# acrivate mise
eval "$(~/.local/bin/mise activate zsh)"

# completion
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# tmux control
if [ -z "${TMUX}" ]; then
  /usr/bin/tmux
fi

# start starship
eval "$(starship init zsh)"
