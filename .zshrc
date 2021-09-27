# zsh Options
# removes error on pattern match globs that don't match
# unsetopt nomatch

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
### PATH addons ###
PATH=""
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi
# Go
export PATH=$PATH:${GOPATH//://bin:}/bin
# Python - Homebrew
export PATH="$(brew --prefix)/opt/python@3/libexec/bin:$PATH"
# pipx for python utilities
export PATH="$PATH:$HOME/.local/bin"
# pyenv - handles configuring pyenv - from the plugin magic :)
# export ZSH_PYENV_QUIET=true
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"
eval "$(pyenv init -)"
# R / RStudio
export PATH="$HOME/.R/shims:$PATH"
# Anaconda - see ZSH_THEME below
# NVM - Node/NPM
# local binaries can be called directly - if not on PATH, uses npx
# source <(npx --shell-auto-fallback zsh)
# SLOW! call `nvm use` automatically in directory with .nvmrc
# source ~/.nvm.use
# export NVM_AUTO_USE=true
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="spaceship"
eval "$(starship init zsh)"

# conda script & default Conda prompt
. $HOME/anaconda3/etc/profile.d/conda.sh
if [[ "$ZSH_THEME" = "spaceship" ]]; then
  conda config --set changeps1 False
else 
  conda config --set changeps1 True
fi

SPACESHIP_PROMPT_ADD_NEWLINE=false

SPACESHIP_PROMPT_ORDER=(
  time          # Time stampts section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
#  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
#  ruby          # Ruby section
#  elm           # Elm section
#  elixir        # Elixir section
#  xcode         # Xcode section
#  swift         # Swift section
  golang        # Go section
#  php           # PHP section
#  rust          # Rust section
#  haskell       # Haskell Stack section
#  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
#  dotnet        # .NET section
#  ember         # Ember.js section
  kubectl       # Kubectl context section
#  terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  brew
  docker #completion 
  docker-compose #aliases & completion
  docker-machine #aliases & completion
  git
	golang
	npm
	zsh-nvm
  #pyenv # not working as intended with all the incorrect config messages - handled in PATH section
  pipenv
  poetry
  #nvm
  tmux
  vi-mode
	zsh-autosuggestions
)

# To make Homebrew’s completions available in zsh, 
# you must get the Homebrew-managed zsh site-functions on your 
# FPATH before initialising zsh’s completion facility. 
# Add the following to your ~/.zshrc file:
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  autoload -Uz compinit
  compinit
fi

# Oh My Zsh
source $ZSH/oh-my-zsh.sh

### User configuration ###
#
# Bash completion for non-zsh compatible completion
#if [ -f $(brew --prefix)/etc/bash_completion ]; then
#    . $(brew --prefix)/etc/bash_completion
#fi
#autoload -U +X compinit && compinit
[[ -r $NVM_DIR/bash_completion  ]] && \. $NVM_DIR/bash_completion
# below is in $NVM_DIR/bash_completion
autoload -U +X bashcompinit && bashcompinit
source /usr/local/etc/bash_completion.d/hugo_fix.sh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

### USER SETTINGS ###
#
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

## PRIVATE VARIABLES ##
# No one needs to see these 
source ~/.private

##  ALIASES ##
alias cocconf="$EDITOR ~/.config/nvim/coc-settings.json"
alias du="/usr/bin/du -sh -- *"
alias duh="/usr/bin/du -sh -- * .*"
alias glt="git log --tags --simplify-by-decoration --pretty=\"format:%ci %d\""
alias gltd="git log --tags --simplify-by-decoration --pretty=\"format:%cD %d\""
alias gz="git-cz"
alias ls="gls --color=tty --group-directories-first"
alias make="gmake"
alias n="nvim"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias perm="gstat -c '%a %n'"
alias reload=". ~/.zshrc"
alias restart="exec zsh -l"
alias spaceship="$EDITOR $ZSH_CUSTOM/themes/spaceship.zsh-theme"
alias starshipconf="$EDITOR ~/.config/starship.toml"
alias ta="tmux attach"
alias tmuxconf="$EDITOR ~/.tmux.conf.local"
alias tn="tmux -L s2 -f /dev/null new-session -s test"
alias tk="tmux -L s2 kill-server"
alias tree="tree --dirsfirst -hCD"
alias nvimconf="$EDITOR ~/.config/nvim/init.vim"
alias vimconf="$EDITOR ~/.vimrc"
alias v="$EDITOR ."
alias wh="npx webpack -h"
alias whl="npx webpack -h | less"
alias zshconf="$EDITOR ~/.zshrc"
alias zshvars="( setopt POSIX_BUILTINS; set;  ) | less"

## COLORING ##
# color themes
# sets tmux theme the same as the iterm2 theme
export DARKS="Nord"
export LIGHTS="Outside"
function theme() {
  echo -e "\033]50;SetProfile=$1\a"
  export ITERM_PROFILE=$1
  darks=($(echo ${DARKS}))
  lights=($(echo ${LIGHTS}))
  if (($darks[(Ie)$1])); then
    # dark-mode on 2> /dev/null # Prevent error message if dark-mode is not installed
    if tmux info &> /dev/null; then
        tmux source-file ~/.tmux.conf
        #tmux source-file ~/.tmux/plugins/tmux-colors-solarized/tmuxcolors-dark.conf
    fi
  fi
  if (($lights[(Ie)$1])); then
    # dark-mode off 2> /dev/null
    if tmux info &> /dev/null; then
        tmux source-file ~/.tmux.conf.local.light 
        #tmux source-file ~/.tmux/plugins/tmux-colors-solarized/tmuxcolors-light.conf
    fi
  fi
}
# dircolors for colors for better colors for ls, tree & fd 
# doesn't seem to work:
#test -r "~/.dir_colors" && eval $(gdircolors ~/.dir_colors)
# seems to work:
test -r ~/.dir_colors && eval `gdircolors -b ~/.dir_colors`

## ENVIRONMENT VARIABLES ##
# zsh history
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
# zshrc config file
export ZSHRC=~/.zshrc
# tmux config file
export TMUXCONF=~/.tmux.conf.local
# Go Workspace
export GOPATH=$HOME/go
# macOS SDK
export MAC_SDK=$(xcode-select -p)/SDKs/MacOSX.sdk
# Auto load node version for local repo
NVM_AUTO_USE=true
# Vim config files
export VIMRC=$HOME/.vimrc
export NVIMINIT=$HOME/.config/nvim/init.vim

## FUNCTIONS ##
# fzf functions - fuzzy finder 
# fuzzy finder shortcut is '^ + R'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
    -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}
# fh - search in your command history and execute selected command
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
# ff - search through files recursively in the current directory
ff() {
  grep --line-buffered --color=never -r "" * | fzf
}
# alternative using ripgrep-all (rga) combined with fzf-tmux preview
# allows to search in PDFs, E-Books, Office documents, zip, tar.gz, etc. (see https://github.com/phiresky/ripgrep-all)
# find-in-file - usage: fif <searchTerm> or fif "string with spaces" or fif "regex"
# works within vim / nvim terminal sessions
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  local file
  file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$@" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$1"' {}")" || return 0
  if [ -n $VIM ]; then
    if [ -n $NVIM_LISTEN_ADDRESS ]; then
      nvr --remote-send "<C-\><C-N>:vsp $file<CR>"
    else
      "$EDITOR" --remote-send "<C-\><C-N>:vsp $file<CR>"
    fi
  else 
    "$EDITOR" "$file"
  fi
}
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() (
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
)

## KEY BINDINGS ##
# --> can't get working in tmux :( bindkey \C-k kill-line
bindkey \^u backward-kill-line
bindkey \^z kill-whole-line
bindkey \^k kill-line
#bindkey -e
# for iterm2
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word
# for tmux
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

## SCRIPTS ##

## SERVERS ##
# SSH Agent #
#
# This is NOT currently needed on MacOS b/c it launches ssh-agent with launchd each time
# see https://www.packetmischief.ca/2016/09/06/ssh-agent-on-os-x/
# In addition, tmux inherits & continually resets the SSH_AUTH_SOCK from the parent environment value
# Thus, the PID may only be set correctly in the parent process, so closing out of iTerm shuts down the ssh-agent 
if [ -z "$SSH_AUTH_SOCK" ] ; then
	eval `/usr/bin/ssh-agent -s`
  export SSH_AUTH_SOCK=$(launchctl getenv SSH_AUTH_SOCK)
  /usr/bin/ssh-add -l > /dev/null 2>&1
  export SSH_AGENT_PID=$(launchctl list | grep com.openssh.ssh-agent | awk '{print $1;}')
fi
# This IS needed on MacOS b/c it does not set SSH_AGENT_PID
if [ -z "$SSH_AGENT_PID" ] ; then
  /usr/bin/ssh-add -l > /dev/null 2>&1
  export SSH_AGENT_PID=$(launchctl list | grep com.openssh.ssh-agent | awk '{print $1;}')
fi

