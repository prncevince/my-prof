.PHONY: test all symlinks constants

DOT = .Renviron .dir_colors .fzf.zsh .gitconfig .tmux.conf.local\
	.tmux.conf.local.light .vimrc .zlogout .zshrc
CONFIG = starship.toml
CONFIG_NVIM = init.vim coc-settings.json
CONFIG_YARN_GLOBAL = package.json yarn.lock
R_SHIMS = R.sh Rscript.sh rstudio.sh README.md
R_RSTUDIO_THEMES = night-owlish.rstheme
SSH = config
TMUX = .tmux.conf .tmux.conf.local README.md
VIM = coc-settings.json

DOT_FILES = $(addprefix ~/,$(DOT))
CONFIG_FILES = $(addprefix ~/.config/,$(CONFIG))
CONFIG_NVIM_FILES = $(addprefix ~/.config/nvim/,$(CONFIG_NVIM))
CONFIG_YARN_GLOBAL_FILES = $(addprefix ~/.config/yarn/global/,$(CONFIG_YARN_GLOBAL))
R_SHIMS_FILES = $(addprefix ~/.R/shims/,$(R_SHIMS))
R_RSTUDIO_THEMES_FILES = $(addprefix ~/.R/rstudio/themes/,$(R_RSTUDIO_THEMES))
SSH_FILES = $(addprefix ~/.ssh/,$(SSH)) 
TMUX_FILES = $(addprefix ~/.tmux/,$(TMUX))
VIM_FILES = $(addprefix ~/.vim/,$(VIM))

ALL = $(DOT_FILES) $(CONFIG_FILES) $(CONFIG_NVIM_FILES) $(CONFIG_YARN_GLOBAL_FILES) \
	$(R_SHIMS_FILES) $(R_RSTUDIO_THEMES_FILES) $(SSH_FILES) $(TMUX_FILES) $(VIM_FILES)

all: .all

# you are entering the GNU make recipe shell - there be dragons
.all: $(ALL)
	$(foreach i, $(shell for i in {1..$(words $?)}; do echo $$i; done),d=$(word $(i), $(subst $(HOME),.,$(?D))); if [ ! -d $$d ]; then mkdir -p $$d; fi;) 
	$(foreach i, $(shell for i in {1..$(words $?)}; do echo $$i; done),/usr/local/bin/gcp -pu $(word $(i), $?) $(word $(i), $(subst $(HOME),.,$(?D)));)
	git add .
	git diff-index --quiet HEAD || git commit -m "update $(addprefix ~/,$(shell git diff-index --name-only HEAD))"
	git push
	touch .all

symlinks: 
	ln -fs .tmux/.tmux.conf .tmux.conf
	ln -fs .R/shims/R.sh .R/shims/R
	ln -fs .R/shims/Rscript.sh .R/shims/Rscript
	ln -fs .R/shims/rstudio.sh .R/shims/rstudio

constants:
	cp ~/.condarc ./
