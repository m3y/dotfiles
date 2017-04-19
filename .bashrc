#===================================
# common settings.
#===================================
# Vi mode
set -o vi

# Alias
alias ls="exa"
alias ll="clear;ls -lha"
alias vi="vim"
alias c="clear"
alias d="docker"
alias mv="mv -i"
alias cp="cp -ir"
alias rm="rm -ir"
alias virc="vi ~/.bashrc"
alias sorc="source ~/.bashrc"
alias vimrc="vi ~/.vimrc"
alias diff="colordiff"

# git補完
source ~/.bash_git_completion

#===================================
# local settings.
#===================================
# Alias
alias vertical="grep -o ."
if [[ `uname` == 'Darwin' ]]; then
    alias sed="gsed"
    alias cat="lolcat"
    alias mcat="memo list --fullpath | peco | xargs lolcat"
else
    alias ls="ls --color"
fi

if which gsed > /dev/null 2>&1; then
    alias sed="gsed"
fi

# 言語などの追加設定の読込関数
function loadConfig() {
    FILES=$(ls ~/.etc/*.conf 2> /dev/null);
    for FILE in ${FILES}; do
        source ${FILE};
    done
}

function colorlist() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}mcolour${i}    ";
        echo "\x1b[38;5;${i}mcolour${i}    ";
    done
}

function solarized() {
    echo -e "\x1b[38;5;255m base03: \t\x1b[38;5;234m colour234"
    echo -e "\x1b[38;5;255m base02: \t\x1b[38;5;235m colour235"
    echo -e "\x1b[38;5;255m base01: \t\x1b[38;5;240m colour240"
    echo -e "\x1b[38;5;255m base00: \t\x1b[38;5;241m colour241"
    echo -e "\x1b[38;5;255m base0:  \t\x1b[38;5;244m colour244"
    echo -e "\x1b[38;5;255m base1:  \t\x1b[38;5;245m colour245"
    echo -e "\x1b[38;5;255m base2:  \t\x1b[38;5;254m colour254"
    echo -e "\x1b[38;5;255m base3:  \t\x1b[38;5;230m colour230"
    echo -e "\x1b[38;5;255m yellow: \t\x1b[38;5;136m colour136"
    echo -e "\x1b[38;5;255m orange: \t\x1b[38;5;166m colour166"
    echo -e "\x1b[38;5;255m red:    \t\x1b[38;5;160m colour160"
    echo -e "\x1b[38;5;255m magenta:\t\x1b[38;5;125m colour125"
    echo -e "\x1b[38;5;255m violet: \t\x1b[38;5;61m colour61"
    echo -e "\x1b[38;5;255m blue:   \t\x1b[38;5;33m colour33"
    echo -e "\x1b[38;5;255m cyan:   \t\x1b[38;5;37m colour37"
    echo -e "\x1b[38;5;255m green:  \t\x1b[38;5;64m colour64"
}

# loop
function loop() {
    local INTERVAL=3
    local COMMAND="$*"
    ( while :; do clear; echo ${COMMAND}; ${COMMAND}; sleep ${INTERVAL}; done )
}

function move_repository () {
    local l="cd "$(ghq list --full-path | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
bind -x '"\C-g": move_repository'

# settings for peco
function replace_by_history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi

    local l=$(HISTTIMEFORMAT= history | eval $tac | sed -e 's/^\s*[0-9]*\+\s\+//' | peco)
    READLINE_LINE="$l"
    READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-r": replace_by_history'

PROMPT_COMMAND="[[ -f ~/.bash_prompt ]] && source ~/.bash_prompt; ${PROMPT_COMMAND}"
