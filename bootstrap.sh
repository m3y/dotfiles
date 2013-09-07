#!/bin/bash
DIR=`pwd`

# 各設定ファイルの設置
# --------------------
[[ -f ~/.bash_profile ]] || ln -s ${DIR}/.bash_profile ~/.bash_profile
[[ -f ~/.bashrc ]]       || ln -s ${DIR}/.bashrc       ~/.bashrc
[[ -f ~/.bash_ps ]]      || ln -s ${DIR}/.bash_ps      ~/.bash_ps
[[ -f ~/.vimrc ]]        || ln -s ${DIR}/.vimrc        ~/.vimrc
[[ -f ~/.screenrc ]]     || ln -s ${DIR}/.screenrc     ~/.screenrc
[[ -f ~/.gitconfig ]]    || ln -s ${DIR}/.gitconfig    ~/.gitconfig

# neobundleの導入
# ---------------
which git > /dev/null
if [ $? -eq 0 -a ! -d ~/.vim/bundle/neobundle.vim ]; then
    echo git clone git://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
    git clone git://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
fi

# テンプレートファイルの設置 for vim
# ----------------------------------
[[ -d ~/.vim/template ]] || mkdir ~/.vim/template
[[ -f ~/.vim/template/php.txt ]] || ln -s ${DIR}/php_template.txt ~/.vim/template/php_template.txt

# phpマニュアルの設置 for vim
# ---------------------------
[[ -d ~/.vim/dict ]] || mkdir ~/.vim/dict
if [ ! -d ~/.vim/dict/phpmanual ]; then
    wget -O ./php_manual_ja.tar.gz http://jp1.php.net/get/php_manual_ja.tar.gz/from/this/mirror
    tar zxvf ./php_manual_ja.tar.gz
    mv ./php-chunked-xhtml ~/.vim/dict/phpmanual
    rm ./php_manual_ja.tar.gz
fi

# syntaxファイルの設置 for vim quickrun
# -------------------------------------
[[ -d ~/.vim/syntax ]] || mkdir ~/.vim/syntax
[[ -f ~/.vim/syntax/quickrun.vim ]] || ln -s ${DIR}/quickrun.vim.syntax ~/.vim/syntax/quickrun.vim


# 設定の読み込み
# --------------
source ~/.bash_profile
