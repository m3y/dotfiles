# Term
export TERM=xterm-256color

# Editor
export EDITOR=vim

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

# Java
#export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# go
export GOPATH=${HOME}/.go
export GOROOT=$( go env GOROOT )

# Path
export PATH=${PATH}:${HOME}/.bin:${HOME}/local/bin:${HOME}/.bin/`uname`:/usr/local/bin:${GOPATH}/bin:${HOME}/.cargo/bin

# .bashrc 読み込み
if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi
