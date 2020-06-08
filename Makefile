.PHONY: all deploy symlinks constants

PROFILE = .ssh/% .tmux/% .vim/% $(DOTFILES)
DOTFILES = .Renviron .dir_colors .fzf.zsh .tmux.conf.local\
					 .tmux.conf.local.light .vimrc .zlogout .zshrc

all: deploy

deploy: $(PROFILE)
	git add .
	git commit -m "update my profile"
	git push

.ssh/%: ~/.ssh/config
	cp $? .ssh/

.tmux/%: ~/.tmux/.tmux.conf 
	cp $? .tmux/

.vim/%: ~/.vim/coc-settings.json
	cp $? .vim/

$(DOTFILES) &: $(addprefix ~/,$(DOTFILES)) 
	cp $? ./

symlinks: 
	ln -fs .tmux/.tmux.conf .tmux.conf

constants:
	cp ~/.condarc ./
