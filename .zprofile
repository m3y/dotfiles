export EDITOR=vim
export LANG=ja_JP.UTF-8

# for Japanese input
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx

# for passstore
export PASSWORD_STORE_DIR=/home/m3y/Documents/Dropbox/data

# for Docker
export DOCKER_BUILDKIT=1

# for GOLANG
export GOPATH="${HOME}/.go"
export GO111MODULE=on

# path
export PATH="${PATH}:${GOPATH}/bin"
