# My Profile

To be installed on a new MacOS ... or one restored from OS with all the installs already.

Can help you mirror between multiple MacOS machines.

## 'Manual' Installs

- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)
- [Anaconda](https://docs.anaconda.com/anaconda/install/mac-os/#using-the-command-line-install)
- [RStudio](https://www.rstudio.com/products/rstudio/download/#download)
- [R](https://cran.r-project.org/bin/macosx/)
  - [Configure for r-shims](https://github.com/prncevince/r-shims#mac-1)
  - Configure for [coc.nvim](https://github.com/neoclide/coc.nvim)'s [coc-r-lsp](https://github.com/neoclide/coc-r-lsp) plugin & as well as vim's ALE plugin. See `""" LANGUAGE """` in [.vimrc](.vimrc)
    - `install.packages(c('languageserver', 'styler', 'lintr'))`
  - Configure for RStudio in [{renv}](https://rstudio.github.io/renv/index.html) environments:
    - `install.packages('rstudioapi')`
- [zsh-nvm](https://github.com/lukechilds/zsh-nvm#as-an-oh-my-zsh-custom-plugin)
- [vim-plug](https://github.com/junegunn/vim-plug#vim)
- [Docker](https://docs.docker.com/desktop/mac/install/)
- [Homebrew](https://docs.brew.sh/Installation)

## 'Auto' Installs

```
git clone https://github.com/prncevince/my-prof.git && cd my-prof
make
brew bundle --global
```
