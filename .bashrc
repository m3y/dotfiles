#===================================
# common settings.
#===================================
# Vi mode
set -o vi

# Path
if [[ ${TERM} != screen && ${TERM} != screen-256color ]]; then
  export PATH=${HOME}/.bin:${PATH}:
fi

# history設定
export HISTSIZE=10000
export HISTIGNORE="ls:ll:history*:cd:cd ..*"
export HISTCONTROL=ignoredeps
export HISTTIMEFORMAT='%Y-%m-%d %T '

# Alias
alias grep="grep --color=auto"
alias ll="clear;ls -lhA"
alias vi="vim"
alias c="clear"
alias mv="mv -i"
alias cp="cp -ir"
alias rm="rm -ir"
alias virc="vi ~/.bashrc"
alias sorc="source ~/.bashrc"
alias vimrc="vi ~/.vimrc"
alias cd="clear;cd"

#===================================
# local settings.
#===================================
# Alias
alias ls="clear;pwd;ls -GF"
alias vertical="grep -o ."
alias ....="cd ../../"
alias ......="cd ../../../"

# nodejs
if [[ ${TERM} != screen && -f ~/.nodebrew/nodebrew ]]; then
  export PATH=${HOME}/.nodebrew/current/bin:${PATH}
fi

# loop
function loop() {
    INTERVAL=3
    COMMAND="$*"
    ( while :; do clear; echo ${COMMAND}; ${COMMAND}; sleep ${INTERVAL}; done )
}

PROMPT_COMMAND="[[ -f ~/.bash_ps ]] && source ~/.bash_ps"
