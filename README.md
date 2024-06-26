# My Profile

To be installed on a new MacOS ... or one restored from OS with all the installs already.

Can help you mirror between multiple MacOS machines.

## 'Manual' Installs

- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)
- [RStudio](https://www.rstudio.com/products/rstudio/download/#download)
- [R](https://cran.r-project.org/bin/macosx/)
  - One swing: `install.packages(c('languageserver', 'styler', 'lintr', 'rstudioapi', 'rprojroot'))` 
  - [Configure for r-shims](https://github.com/prncevince/r-shims#mac-1)
  - Configure for [coc.nvim](https://github.com/neoclide/coc.nvim)'s [coc-r-lsp](https://github.com/neoclide/coc-r-lsp) plugin & as well as vim's ALE plugin. See `""" LANGUAGE """` in [.vimrc](.vimrc)
    - `install.packages(c('languageserver', 'styler', 'lintr'))`
  - Configure for RStudio in [{renv}](https://rstudio.github.io/renv/index.html) environments:
    - `install.packages('rstudioapi')`
  - [Configure for quarto-shims](https://github.com/prncevince/quarto-shims)
    - `install.packages('rprojroot')`
- [zsh-nvm](https://github.com/lukechilds/zsh-nvm#as-an-oh-my-zsh-custom-plugin)
- [vim-plug](https://github.com/junegunn/vim-plug#vim)
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm#installation)
- [Homebrew](https://docs.brew.sh/Installation)
- [Firefox](https://www.mozilla.org/firefox/download/thanks/)
  - install [Tree Style Tab](https://addons.mozilla.org/en-US/firefox/addon/tree-style-tab/), [Bookmark Manager & Viewer](https://addons.mozilla.org/en-US/firefox/addon/bookmarks-manager-and-viewer/), [Adblock Plus - free ad blocker](https://addons.mozilla.org/en-US/firefox/addon/adblock-plus/), [Multi-touch Zoom](https://addons.mozilla.org/en-US/firefox/addon/multi-touch-zoom/)
  - copy [userChrome.css](userChrome.css) to `~/Library/Application Support/Firefox/Profiles/*.default/chrome/`
    - go to `about:config` in address bar, & make sure that `toolkit.legacyUserProfileCustomizations.stylesheets` is set to `true`

## 'Auto' Installs

```
export HOMEBREW_NO_AUTO_UPDATE=1
brew install coreutils make
```

```
git clone https://github.com/prncevince/my-prof.git && cd my-prof
make
brew bundle --global
```

### Vim Plugins

Run `:PlugInstall`

### Tmux Plugins

Run `prefix I`

### Miniconda (aka Miniforge w/ Mamba)

Instead of Anaconda / Conda, we can install a version of [Miniforge](https://github.com/conda-forge/miniforge) with Mamba. Mamba has faster dependency resolution. 

We can do this using a Homebrew cask, e.g. `brew install miniforge` or `brew install mambaforge`. There should be one in the `~/.Brewfile`. If `miniforge` is installed, then we also need to perform a `conda install -n base mamba`.

### Jupyter Lab

To be able to use virtual environments within Python. See [Using Jupyter Notebook Extensions](https://docs.continuum.io/anaconda/user-guide/tasks/use-jupyter-notebook-extensions/)

Note, Anaconda is monolithic, so it's probably best to create a new environment to manage your [JupyterLab installation](jupyter.org/install). 

Make sure to activate the environment that you install JupyterLab into when you use it to run other virtual environments. 

In addition, the JupyterLab plotly extension *must* be installed into the same environment as JupyterLab, so a plotly install can [take care of this](https://plotly.com/python/troubleshooting/#jupyterlab-problems). 
The same goes for the JupyterLab leaflet extension. However, this does not seem to cover all the dependency versions for say [geemap](https://book.geemap.org/chapters/01_introduction.html#installing-geemap), so it's better to install geemap with jupyter into it's own environment and use that version of `jupyter`. This can be done by installing [pygis](https://github.com/giswqs/pygis).

```
mamba install -n pygis pygis
```

If you'd like Math TeX docstring rendered, you can [install the `docrepr` package](https://blog.jupyter.org/inspector-jupyterlab-404cce3e1df6) within the activated environment & cofigure it for interactive sessions. Your mileage may vary, but `SHIFT+TAB` is typically more reliant than `⌘+I` & the Contextual Pane for parsing docstring.

```
# just don't install anything into the base environment 
# a smarter move - create a jupyterlab environment 
conda create -n juplab -c conda-forge nb_conda jupyterlab plotly ipyleaflet
# to use the python environment's kernel from myenv within your juplab environment
conda install -n myenv ipykernel
# to get html parsed docstring for myenv - downloads sphinx dependent utilites
conda install -n myenv docrepr 
```

Within interactive JupyterLab session:

```python
ip = get_ipython()
ip.sphinxify_docstring = True
ip.enable_html_pager = True
```

## Troubleshooting

### Hombrew Auto-Updates

Scenario: Hombrew runs `brew update --preinstall` and everything seems to break after ~15 minutes of installs.

If the `pipx` python utilities are dysfunctional due to a brew installation of python, reinstall them:

```
pipx reinstall-all
```

If your tmux session seems to be broken, kill the tmux server:

```
tksv 
# or 
tmux kill-server
```
