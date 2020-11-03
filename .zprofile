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

# for Golang
export GOPATH="${HOME}/.go"
export GO111MODULE=on
export PATH="${PATH}:${GOPATH}/bin"

# for krew
export PATH="${PATH}:${HOME}/.krew/bin"

# for pipenv
export PIPENV_VENV_IN_PROJECT=1
export PIPENV_IGNORE_VIRTUALENVS=1

# for Rust
export PATH="$HOME/.cargo/bin:$PATH"

# for poetry
export PATH="$HOME/.poetry/bin:$PATH"
