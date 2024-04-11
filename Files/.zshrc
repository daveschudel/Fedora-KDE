
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="dave"

case `uname` in
  Darwin)
    # MacOS
      export PATH="/home/dave/Scripts:/opt/homebrew/opt/zip/bin:/opt/homebrew/opt/coreutils/libexec/gnubin:/opt/homebrew/bin":$PATH
      export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:${MANPATH}"
      export HOMEBREW_COLOR=1
      export HOMEBREW_NO_ENV_HINTS=1
      export HOMEBREW_VERBOSE=0
      source ./.linuxify

      if type brew &>/dev/null
      then
        FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
        autoload -Uz compinit
        compinit
      fi

      alias icloud='cd "/Users/dave/Library/Mobile Documents/com~apple~CloudDocs"'
      alias space="defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'; killall Dock"
      alias showhidden="defaults write com.apple.Finder AppleShowAllFiles true"

      source /opt/homebrew/Cellar/zsh-syntax-highlighting/0.7.1/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ;;
  Linux)
    export PATH="/home/dave/Scripts:$PATH"
  ;;
  FreeBSD)
    # commands for FreeBSD go here
  ;;
esac

CASE_SENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

export BROWSER="firefox '%s' &"
export TERM='xterm-256color'
export EDITOR=/usr/bin/nano
export CLICOLOR=1
export HISTCONTROL=ignoredups

alias ls='exa -lah --group-directories-first -F --git --no-permissions --octal-permissions '

# Aliases for safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# aliases to add options
alias grep='grep --color=auto'
alias wget='wget -c'
