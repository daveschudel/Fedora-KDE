# -----------------------------------------------------------------------------
# Dave's .bashrc
#
# A lot of the stuff in here was taken from examples of other .bashrc files
# -----------------------------------------------------------------------------

export BROWSER="firefox '%s' &"
export TERM='xterm-256color'
export EDITOR=/usr/bin/nano
export CLICOLOR=1
export HISTCONTROL=ignoredups
export LC_ALL="C"

# (l) long format; (a) print all including .; (h) human-readable; (N) literal; print names without quotes
alias ls="ls -lahN --color=auto --group-directories-first" 

# Shortcut to connect to Phoenix
alias vpn="nordvpn connect united_states phoenix"

# Makes sure when creating a directory the parents are also created
alias mkdir="mkdir -pv"

# Lists the mounted drives in a viewable format
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"

# Colorized diff
alias diff='colordiff'

# Set ls colors in the terminal
eval "$(dircolors ~/.dircolors)"

# Generated 2016-02-27 by http://www.gilesorr.com/Code/bpb/ ,
# The Bash Prompt Builder written by Giles Orr.
# Modified by me

# Definitions for the color variant bar in the prompt
BAR1="\[\e[48;5;117m\] "
BAR2="\[\e[48;5;73m\] "
BAR3="\[\e[48;5;33m\] "
BAR4="\[\e[48;5;26m\] "
BAR5="\[\e[48;5;21m\] "
BAR6="\[\e[48;5;20m\] "
BAR7="\[\e[48;5;19m\] "
BAR8="\[\e[48;5;18m\] "
BAR9="\[\e[48;5;17m\] "
BAR10="\[\e[48;5;16m\] "
CLEAR="\[\e[0m\]"
GREEN="\[\e[1;32m\]"
YELLOW="\[\e[1;33m\]"
PURPLE="\[\e[1;35m\]"

# I removed the code to set the titlebar.  I'm good w/it just saying 'Konsole' or whatever
PS1="${BAR1}${BAR2}${BAR3}${BAR4}${BAR5}${BAR6}${BAR7}${BAR8}${BAR9}${BAR10}${CLEAR}${YELLOW}\${PWD} ${GREEN}\$ ${CLEAR}"

