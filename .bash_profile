# Term
export TERM=xterm-256color

# Editor
export EDITOR=vim

# Path
export PATH=${PATH}:${HOME}/.bin:${HOME}/local/bin:${HOME}/.bin/`uname`:/usr/local/bin

# history 設定
export HISTSIZE=10000
export HISTIGNORE="ls:ll:history*:cd:cd ..*"
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT='%Y-%m-%d %T '

# ls 設定
export LS_COLORS="di=34:ln=35:ex=36"

# grep 設定
export GREP_OPTIONS='--color=auto'

# less 設定
export LESS="-R"

# homebrew-cask 設定
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# .bashrc 読み込み
if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi
