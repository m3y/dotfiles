export EDITOR=vim
export LANG=ja_JP.UTF-8

# for Japanese input
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx

# for passstore
export PASSWORD_STORE_DIR=/Volumes/GoogleDrive/My\ Drive/pass

# for Docker
export DOCKER_BUILDKIT=1

# for Golang
export GOPATH="${HOME}/.go"
export GO111MODULE=on
export PATH="${PATH}:${GOPATH}/bin"

# for krew
export PATH="${KREW_ROOT:-${HOME}/.krew}/bin:${PATH}"

# for pipenv
export PIPENV_VENV_IN_PROJECT=1
export PIPENV_IGNORE_VIRTUALENVS=1

# for Rust
export PATH="${HOME}/.cargo/bin:${PATH}"

# for local
export PATH="${PATH}:${HOME}/.bin:${HOME}/.local/bin"

# for homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:${PATH}"

# for aqua
export AQUA_ROOT_DIR=${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua
export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-}:${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua/aqua.yaml
export PATH="${AQUA_ROOT_DIR}/bin:${PATH}"

# for pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
