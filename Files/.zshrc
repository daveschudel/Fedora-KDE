
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="nanotech-test"

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

CASE_SENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)

source $ZSH/oh-my-zsh.sh

export BROWSER="firefox '%s' &"
export TERM='xterm-256color'
export EDITOR=/usr/bin/nano
export CLICOLOR=1
export HISTCONTROL=ignoredups
export LSCOLORS=GxfxcxdxbxGxGxabagacad
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:/opt/homebrew/bin":$PATH
export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:${MANPATH}"

# Homebrew options
export HOMEBREW_COLOR=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_VERBOSE=0
alias bupgrade="~/Scripts/brew-upgrade"

# gls is the updated ls command installed by Homebrew
# gls options (a little different from MacOS's ls)
# -l : long format
# -a : all files; do not ignore entries starting with '.'
# -h : show hidden files 
# -L : dereference links; show what the link points to instead of the link itself
# alias ls='gls -lahL --color=auto  --group-directories-first --color-scale'

# Changed to use exa instead of ls

alias ls='exa -lah --group-directories-first -F --git --no-permissions --octal-permissions '

alias cloud='cd "/Users/dave/Library/Mobile Documents/com~apple~CloudDocs"'
alias home='cd $HOME'
alias space="defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'; killall Dock"
alias showhidden="defaults write com.apple.Finder AppleShowAllFiles true"
alias wx="ansiweather"
alias 100="cd $HOME/Source/100Days"

# Aliases for safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# aliases to add options
alias grep='grep --color=auto'
alias wget='wget -c'

#source /opt/homebrew/Cellar/zsh-syntax-highlighting/0.7.1/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
