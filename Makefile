.PHONY: all symlinks constants

PROFILE = .R/shims/ .R/rstudio/themes/ .config/ .config/nvim/ .config/yarn/global/ .ssh/ .tmux/ .vim/ .update
DOTFILES = .Renviron .dir_colors .fzf.zsh .gitconfig .tmux.conf.local\
	.tmux.conf.local.light .vimrc .zlogout .zshrc
CONFIG = starship.toml
CONFIG_NVIM = init.vim coc-settings.json
CONFIG_YARN_GLOBAL = package.json yarn.lock
R_SHIMS = R.sh Rscript.sh rstudio.sh README.md
R_RSTUDIO_THEMES = night-owlish.rstheme
SSH = config
TMUX = .tmux.conf .tmux.conf.local README.md
VIM = coc-settings.json

define copy
	if [ ! -d $@ ]; then mkdir -p $@; fi 
	cp $? $@
	touch $@
endef

all: .deploy

.deploy: $(PROFILE)
	git add .
	git commit -m "update my profile"
	git push
	touch .deploy

.R/shims/: $(addprefix ~/.R/shims/,$(R_SHIMS))
	$(copy)

.R/rstudio/themes/: $(addprefix ~/.R/rstudio/themes/,$(R_RSTUDIO_THEMES))
	$(copy)

.config/: $(addprefix ~/.config/,$(CONFIG))
	$(copy)

.config/nvim/: $(addprefix ~/.config/nvim/,$(CONFIG_NVIM))
	$(copy)

.config/yarn/global/: $(addprefix ~/.config/yarn/global/,$(CONFIG_YARN_GLOBAL))
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
	ln -fs .R/shims/R.sh .R/shims/R
	ln -fs .R/shims/Rscript.sh .R/shims/Rscript
	ln -fs .R/shims/rstudio.sh .R/shims/rstudio

constants:
	cp ~/.condarc ./
