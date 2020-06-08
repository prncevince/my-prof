.PHONY: all deploy symlinks constants

PROFILE = .config/* .config/nvim/* .ssh/* .tmux/* .vim/* $(DOTFILES)
DOTFILES = .Renviron .dir_colors .fzf.zsh .tmux.conf.local\
					 .tmux.conf.local.light .vimrc .zlogout .zshrc
CONFIG = starship.toml
CONFIG_NVIM = nvim/init.vim 
TMUX = .tmux.conf .tmux.conf.local README.md
VIM = coc-settings.json

all: .deploy

.deploy: $(PROFILE)
	touch .deploy
	git add .
	git commit -m "update my profile"
	git push

$(addprefix .config/,$(CONFIG)): $(addprefix ~/.config/,$(CONFIG))
	cp $? .config/ 

$(addprefix .config/,$(CONFIG_NVIM)): $(addprefix ~/.config/,$(CONFIG_NVIM))
	cp $? .config/nvim/ 

.ssh/*: ~/.ssh/config
	cp $? .ssh/

.tmux/*: $(addprefix ~/.tmux/,$(TMUX))
	cp $? .tmux/

.vim/*: ~/.vim/coc-settings.json
	cp $? .vim/

$(DOTFILES) &: $(addprefix ~/,$(DOTFILES)) 
	cp $? ./

symlinks: 
	ln -fs .tmux/.tmux.conf .tmux.conf

constants:
	cp ~/.condarc ./
