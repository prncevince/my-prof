# R Shims

- [Supported Platforms / Setups](#supported-platforms--setups)
  - [Mac](#mac)
  - [Windows](#windows)
- [Download / Install](#download--install)
  - [Mac](#mac-1)
  - [Windows](#windows-1)
- [Usage](#usage)
- [Problems](#problems)
  - [Mac](#mac-2)
- [Why Shims?](#why-shims)

Inspired by a need to synchronize minor versions of R (`x.y`, e.g. `4.0` in `4.0.3`) across projects. Puts shims for `R`, `Rscript`, and `rstudio` utilities on the `PATH` after manual edition to dot-profile.

Does **not** handle installing R.

Some conversation for handling the use of different versions of R stemmed from below issue:

- https://github.com/rstudio/renv/issues/254

Some other projects that handle this:

- [rig - The R Installation Manager](https://github.com/r-lib/rig)
- [rcli](https://rcli.pat-s.me/)
- [renv / renv-installer](https://github.com/jcrodriguez1989/renv-installer) utility (not R package), which stems from [pyenv](https://github.com/pyenv/pyenv)
- [RSwitch](https://rud.is/rswitch/) for macOS - GUI and CLI utility

# Supported Platforms / Setups

## Mac

Regular [Mac binary CRAN `.pkg` installs](https://cran.r-project.org/bin/macosx/). Simple and effective. Not as complex as aforementioned projects.

When running the macOS `.pkg` installer, always run this first to keep the old install:

```bash
sudo pkgutil --forget org.R-project.arm64.R.fw.pkg
```

## Windows 

Windows Unix Terminal emulators setups with R & RStudio installs to the `%localappdata%` directory. This achieves a nice per user setup. 

[R installations](https://cran.r-project.org/bin/windows/base/) must be installed to the below directory using the convention, with `x.y.z` being your `major.minor.patch` version of R. This allows for multiple installations of R to exist within your `%userprofile%` on the system.

- `%localappdata%/R/R-x.y.z`

[RStudio installations](https://rstudio.com/products/rstudio/download/) must be installed to the below directory

- `%localappdata%/RStudio`

# Download / Install

## Mac

`git clone --single-branch --branch mac https://github.com/prncevince/r-shims $HOME/.R/shims`

Use `git pull` in your `$HOME/.R/shims` directory to update as needed.

Add to your Bash/Zsh dot profile:

```bash
export PATH="$HOME/.R/shims:$PATH"
```

For each version of R that you have installed, edit the `/Library/Frameworks/R.framework/Versions/x.y/Resources/bin/R` shell file. Comment out lines 31 and add a line below it setting `R_HOME_DIR` to the value of `R_HOME`. It should look like so:

```sh
if test -n "${R_HOME}" && \
  test "${R_HOME}" != "${R_HOME_DIR}"; then
  #echo "WARNING: ignoring environment value of R_HOME"
  R_HOME_DIR="${R_HOME}"
fi
R_HOME="${R_HOME_DIR}"
```

## Windows

As advertised, this is developed for Unix terminal emulators, e.g. [Git for Windows](https://gitforwindows.org/).


`git clone --single-branch --branch windows https://github.com/prncevince/r-shims $HOME/.R/shims`

Use `git pull` in your `$HOME/.R/shims` directory to update as needed.

Add to your Bash/Zsh dot profile:

```bash
export PATH="$HOME/.R/shims:$PATH"
```

Make sure that [Rtools](https://cran.r-project.org/bin/windows/Rtools/) is **on top** of the `PATH` that is accessed by R. When R is invoked by a shell, it inherits the `PATH` environment variable, which can mess up which `sh` is invoked by RStudio when creating a new RStudio Project if Rtools is added to the end of the `PATH` versus being put on top. This seems to create a nasty perpetual loop invoking `make`. 

You can do this by adding to your `%localappdata%/R/R-x.y.z/etc/Renviron.site` something like so for your version of Rtools:

```sh
PATH="${LOCALAPPDATA}\Rtools\rtools40\usr\bin;${PATH}"
```


# Usage

Create a `.Rversion` file containing the minor version of R (`x.y`) in the root of your repo. 

- e.g. `echo 4.0 > .Rversion`

`cd` to the repo's root directory. 

To open RStudio with the specified version of R, and inside a `*.Rproj` if also in the repo, simply run:

`rstudio`

To just run the specified version of R, use `R` or `Rscript` in the usual way.

# Problems

Here, we layout know system problems that are unavoidable, unless changes to the source code of RStudio or R are made.

## Mac

Restarting the R session in RStudio will always startup the system version of R, i.e. the symbolic link `/Library/Frameworks/R.framework/Versions/Current`. 

# Why Shims?

Programs that utilize R (e.g. [GNU Make](https://www.gnu.org/software/make/)), access the current shells `PATH` environment variable, but not aliases/functions. Thus, shims are necessary for programs like GNU Make to use the updated `R`/`Rscript` utilities.

In addition, they don't plague your dot-profile with functions/aliases. There are many other reasons as well. 
