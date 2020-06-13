.PHONY: all symlinks constants

PROFILE = .config/ .config/nvim/ .ssh/ .tmux/ .vim/ .update
DOTFILES = .Renviron .dir_colors .fzf.zsh .tmux.conf.local\
					 .tmux.conf.local.light .vimrc .zlogout .zshrc
CONFIG = starship.toml
CONFIG_NVIM = nvim/init.vim
SSH = config
TMUX = .tmux.conf .tmux.conf.local README.md
VIM = coc-settings.json

all: .deploy

.deploy: $(PROFILE)
	touch .deploy
	git add .
	git commit -m "update my profile"
	git push

.config/: $(addprefix ~/.config/,$(CONFIG))
	cp $? .config/ 
	touch .config/

.config/nvim/: $(addprefix ~/.config/,$(CONFIG_NVIM))
	cp $? .config/nvim/ 
	touch .config/nvim/

.ssh/: $(addprefix ~/.ssh/,$(SSH))
	cp $? .ssh/
	touch .ssh/

.tmux/: $(addprefix ~/.tmux/,$(TMUX))
	cp $? .tmux/
	touch .tmux/

.vim/: $(addprefix ~/.vim/,$(VIM))
	cp $? .vim/
	touch .vim/

.update: $(addprefix ~/,$(DOTFILES)) 
	cp $? ./
	touch .update

symlinks: 
	ln -fs .tmux/.tmux.conf .tmux.conf

constants:
	cp ~/.condarc ./
