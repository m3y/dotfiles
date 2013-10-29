設定ファイル
============

概要
----
開発環境を整えるための設定ファイル達、以下の設定ファイルを含む。
- .bash_profile
- .bashrc
- .bash_ps
- .vimrc
- .gitconfig
- .tmux.conf
- .screenrc

反映方法
--------
git から clone

    $ git clone git://github.com/m3y/dotfiles.git

設定ファイルの設置＆初期設定

    $ cd dotfiles
    $ ./bootstrap.sh

Vim環境の初期化について
-----------------------
以下の初期化処理を実施
- neobundleの導入
- php用テンプレートファイルの設置
- phpマニュアルの設置
- quickrun用syntaxファイルの設置

依存パッケージ
--------------
- vim
- tmux
- ctags
- w3m
