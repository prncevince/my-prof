.PHONY: all symlinks constants

PROFILE = .R/rstudio/themes/ .config/ .config/nvim/ .ssh/ .tmux/ .vim/ .update
DOTFILES = .Renviron .dir_colors .fzf.zsh .gitconfig .tmux.conf.local\
					 .tmux.conf.local.light .vimrc .zlogout .zshrc
CONFIG = starship.toml
CONFIG_NVIM = nvim/init.vim
RSTUDIO_THEMES = night-owlish.rstheme
SSH = config
TMUX = .tmux.conf .tmux.conf.local README.md
VIM = coc-settings.json

define copy
	cp $? $@
	touch $@
endef

all: .deploy

.deploy: $(PROFILE)
	touch .deploy
	git add .
	git commit -m "update my profile"
	git push

.R/rstudio/themes/: $(addprefix ~/.R/rstudio/themes/,$(RSTUDIO_THEMES))
	$(copy)

.config/: $(addprefix ~/.config/,$(CONFIG))
	$(copy)

.config/nvim/: $(addprefix ~/.config/,$(CONFIG_NVIM))
	$(copy)

.ssh/: $(addprefix ~/.ssh/,$(SSH))
	$(copy)

.tmux/: $(addprefix ~/.tmux/,$(TMUX))
	$(copy)

.vim/: $(addprefix ~/.vim/,$(VIM))
	$(copy)

.update: $(addprefix ~/,$(DOTFILES)) 
	cp $? ./
	touch .update

symlinks: 
	ln -fs .tmux/.tmux.conf .tmux.conf

constants:
	cp ~/.condarc ./
