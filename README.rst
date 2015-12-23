設定ファイル
============

概要
----
開発環境を整えるための設定ファイル達

反映方法
--------
git から clone

    $ git clone git@github.com:m3y/dotfiles.git

反映 - localhost

    $ cd ansible
    $ ansible-playbook -i inventory/localhost -vv dotfiles_for_local.yml

反映 - dev server

    $ cd ansible
    $ ansible-playbook -i inventory/dev_hosts -vv dotfiles.yml
