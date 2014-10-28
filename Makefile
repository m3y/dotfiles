DOT_FILES = .bin .bashrc .bash_prompt .bash_profile .bash_git_completion .vimrc .vim .tmux.conf .gitconfig .peco
CURRENTDIR = $(shell pwd)
BACKUPDIR = $(HOME)/.dotfiles.back

all: usage
install: gitsubmodule backup clean bin bash tmux git vim peco

usage:
	@echo ""
	@echo "   % make [install|bin|bash|tmux|git|vim|peco|clean]"
	@echo ""
	@echo "      install:    bin/bash/tmux/git/vim/peco のインストール"
	@echo "      bin:        ユーティリティコマンドのインストール"
	@echo "      bash:       bash 関連設定ファイルのインストール"
	@echo "      tmux:       tmux 関連設定ファイルのインストール"
	@echo "      git:        git 関連設定ファイルのインストール"
	@echo "      vim:        vim 関連設定ファイルのインストール"
	@echo "      peco:       peco 関連設定ファイルのインストール"
	@echo "      clean:      設定ファイルのクリア"
	@echo ""

backup: make-backup-dir $(foreach f, $(DOT_FILES), backup-dot-files-$(f))
remove-backup:
	@rm -rf ${BACKUPDIR}

clean: $(foreach f, $(filter-out .ssh%, $(DOT_FILES)), unlink-dot-file-$(f))

gitsubmodule:
	git submodule update --init

bin: $(foreach f, $(filter .bin%, $(DOT_FILES)), link-dot-file-$(f))
bash: $(foreach f, $(filter .bash%, $(DOT_FILES)), link-dot-file-$(f))
tmux: $(foreach f, $(filter .tmux%, $(DOT_FILES)), link-dot-file-$(f))
git: $(foreach f, $(filter .git%, $(DOT_FILES)), link-dot-file-$(f))
vim: $(foreach f, $(filter .vim%, $(DOT_FILES)), link-dot-file-$(f))
peco: $(foreach f, $(filter .peco%, $(DOT_FILES)), link-dot-file-$(f))

vim-addon: vim-dependency vim-ref vim-nerdtree-plugin

vim-dependency:
	vim +NeoBundleInstall +qall

vim-nerdtree-plugin:
	@cp ${CURRENTDIR}/grep_menuitem.vim ${HOME}/.vim/bundle/nerdtree/nerdtree_plugin/grep_menuitem.vim
	@echo "Create nerdtree plugin."

vim-ref:
	@[ -d ${HOME}/.vim/dict ] || mkdir -p ${HOME}/.vim/dict
	@wget -O ${CURRENTDIR}/php_manual_ja.tar.gz http://jp1.php.net/get/php_manual_ja.tar.gz/from/this/mirror
	@tar zxvf ${CURRENTDIR}/php_manual_ja.tar.gz
	@mv ${CURRENTDIR}/php-chunked-xhtml ${HOME}/.vim/dict/phpmanual
	@rm ${CURRENTDIR}/php_manual_ja.tar.gz

make-backup-dir:
	mkdir -p $(BACKUPDIR)

backup-dot-files-%: %
	@if [ \( -f $(HOME)/$< -o -d $(HOME)/$< \) -a ! -L $(HOME)/$< ]; then \
    echo "Create Backup $(HOME)/$< => $(BACKUPDIR)/$<";\
    cp -rp $(HOME)/$< $(BACKUPDIR)/;\
  fi

unlink-dot-file-%: %
	@echo "Remove Symlink $(HOME)/$<"
	@$(RM) $(HOME)/$<

link-dot-file-%: %
	@echo "Create Symlink $(shell echo $<) => $(HOME)/$<"
	@ln -snf $(CURRENTDIR)/$(shell echo $<) $(HOME)/$<
