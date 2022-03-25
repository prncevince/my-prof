.PHONY: all brew symlinks constants

BREWPREFIX = $(shell brew --prefix)
brew-old = /usr/local/bin/brew

DOT = .Brewfile .Brewfile.old .Renviron .dir_colors .fzf.zsh \
			.tmux.conf.local .tmux.conf.local.light .vimrc .zlogout .zshrc
ANACONDA3_ETC_JUPYTER_JUPYTERNOTEBOOKCONFIGD = jupyterlab.json nteract_on_jupyter.json
ANACONDA3_ETC_JUPYTER_NBCONFIG = notebook.json 
ANACONDA3_ETC_JUPYTER_NBCONFIG_NOTEBOOKD = ipyaggrid.json plotlywidget.json vega.json widgetsnbextension.json
ANACONDA3_SHARE_JUPYTER_LAB_SETTINGS = build_config.json page_config.json
CONFIG = starship.toml
CONFIG_NVIM = init.vim coc-settings.json
CONFIG_YARN_GLOBAL = package.json yarn.lock
JUPYTER_LAB_USER-SETTINGS_@JUPYTERLAB_SHORTCUTS-EXTENSION = shortcuts.jupyterlab-settings
JUPYTER_NBCONFIG = notebook.json
R = Makevars
R_SHIMS = R.sh Rscript.sh rstudio.sh README.md
R_RSTUDIO_THEMES = night-owlish.rstheme
TMUX = .tmux.conf .tmux.conf.local README.md
VIM = coc-settings.json

DOT_FILES = $(DOT)
ANACONDA3_ETC_JUPYTER_JUPYTERNOTEBOOKCONFIGD_FILES = $(addprefix anaconda3/etc/jupyter/jupyter_notebook_config.d/,$(ANACONDA3_ETC_JUPYTER_JUPYTERNOTEBOOKCONFIGD))
ANACONDA3_ETC_JUPYTER_NBCONFIG_FILES = $(addprefix anaconda3/etc/jupyter/nbconfig/,$(ANACONDA3_ETC_JUPYTER_NBCONFIG))
ANACONDA3_ETC_JUPYTER_NBCONFIG_NOTEBOOKD_FILES = $(addprefix anaconda3/etc/jupyter/nbconfig/notebook.d/,$(ANACONDA3_ETC_JUPYTER_NBCONFIG_NOTEBOOKD))
ANACONDA3_SHARE_JUPYTER_LAB_SETTINGS_FILES = $(addprefix anaconda3/share/jupyter/lab/settings/,$(ANACONDA3_SHARE_JUPYTER_LAB_SETTINGS))
CONFIG_FILES = $(addprefix .config/,$(CONFIG))
CONFIG_NVIM_FILES = $(addprefix .config/nvim/,$(CONFIG_NVIM))
CONFIG_YARN_GLOBAL_FILES = $(addprefix .config/yarn/global/,$(CONFIG_YARN_GLOBAL))
JUPYTER_LAB_USER-SETTINGS_@JUPYTERLAB_SHORTCUTS-EXTENSION_FILES = $(addprefix .jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/,$(JUPYTER_LAB_USER-SETTINGS_@JUPYTERLAB_SHORTCUTS-EXTENSION))
JUPYTER_NBCONFIG_FILES = $(addprefix .jupyter/nbconfig/,$(JUPYTER_NBCONFIG))
R_FILES = $(addprefix .R/,$(R))
R_SHIMS_FILES = $(addprefix .R/shims/,$(R_SHIMS))
R_RSTUDIO_THEMES_FILES = $(addprefix .R/rstudio/themes/,$(R_RSTUDIO_THEMES))
TMUX_FILES = $(addprefix .tmux/,$(TMUX))
VIM_FILES = $(addprefix .vim/,$(VIM))

ALL_REPO = $(DOT_FILES) \
	$(ANACONDA3_ETC_JUPYTER_JUPYTERNOTEBOOKCONFIGD_FILES) $(ANACONDA3_ETC_JUPYTER_NBCONFIG_FILES) \
	$(ANACONDA3_ETC_JUPYTER_NBCONFIG_NOTEBOOKD_FILES) $(ANACONDA3_SHARE_JUPYTER_LAB_SETTINGS_FILES) \
	$(CONFIG_FILES) $(CONFIG_NVIM_FILES) $(CONFIG_YARN_GLOBAL_FILES) \
	$(JUPYTER_LAB_USER-SETTINGS_@JUPYTERLAB_SHORTCUTS-EXTENSION_FILES) \
	$(JUPYTER_NBCONFIG_FILES) $(R_FILES) $(R_SHIMS_FILES) $(R_RSTUDIO_THEMES_FILES) $(SSH_FILES) \
	$(TMUX_FILES) $(VIM_FILES)

ALL_SERVER = $(addprefix ~/,$(ALL_REPO))

all: .all

# you are entering the GNU make recipe shell - there be dragons

# inception deployment - copy files in repo to server if they are newer than on server or don't exist on server
.all &:: $(ALL_REPO)
	$(foreach i, $(shell for i in {1..$(words $?)}; do echo $$i; done),d=$(word $(i), $(addprefix ~/,$(?D))); if [ ! -d $$d ]; then mkdir -p $$d; fi;) 
	$(foreach i, $(shell for i in {1..$(words $?)}; do echo $$i; done),$(BREWPREFIX)/bin/gcp -pu $(word $(i), $?) $(word $(i), $(addprefix ~/,$(?D)));)
	touch .all

# add to repo changes made on server
.all &:: $(ALL_SERVER)
	$(foreach i, $(shell for i in {1..$(words $?)}; do echo $$i; done),d=$(word $(i), $(subst $(HOME),.,$(?D))); if [ ! -d $$d ]; then mkdir -p $$d; fi;) 
	$(foreach i, $(shell for i in {1..$(words $?)}; do echo $$i; done),$(BREWPREFIX)/bin/gcp -pu $(word $(i), $?) $(word $(i), $(subst $(HOME),.,$(?D)));)
	git add .
	git diff-index --quiet HEAD || git diff-index --name-only HEAD | sed 's/.*/~\/&/' | tr '\n' ' ' | sed -r 's/.*/update &/;s/(.*) /\1/' | git commit -F -
	git push
	touch .all

# in the case that the files do not exist yet in repo - we can copy them from server
# this beats determining which .all is ran first - an extra copy
$(ALL_REPO):
	$(foreach i, $(shell for i in {1..$(words $@)}; do echo $$i; done),$(BREWPREFIX)/bin/gcp -pu $(word $(i), $(addprefix ~/,$@)) $(word $(i), $(@D));)

$(ALL_SERVER): ;

brew:
	brew bundle dump --file=~/.Brewfile --force
	$(brew-old) bundle dump --file=~/.Brewfile.old --force

symlinks: 
	ln -fs .tmux/.tmux.conf .tmux.conf
	ln -fs .R/shims/R.sh .R/shims/R
	ln -fs .R/shims/Rscript.sh .R/shims/Rscript
	ln -fs .R/shims/rstudio.sh .R/shims/rstudio

constants:
	cp ~/.condarc ./
