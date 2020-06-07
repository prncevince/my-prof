.PHONY: all deploy

PROFILE = .ssh/% .tmux/% .vim/% $(DOTFILES)
DOTFILES = .Renviron .condarc .dir_colors .fzf.zsh .tmux.conf .tmux.conf.local\
					 .tmux.conf.local.light .vimrc .zlogout .zshrc

all: deploy

deploy: $(PROFILE)
	git add .
	git commit -am "update my profile"
	git push -u origin master

.ssh/%: ~/.ssh/config
	cp $? .ssh/

.tmux/%: ~/.tmux/.tmux.conf 
	cp $? .tmux/

.vim/%: ~/.vim/coc-settings.json
	cp $? .vim/

$(DOTFILES) &: $(addprefix ~/,$(DOTFILES)) 
	cp $? ./
