#!/bin/zsh

# Personal Setup

source colors.sh

USER_FILES_DIR=/home/dave/Setup/User

INSTALL_ZSH_FILES="True"            # Update zsh with user files
INSTALL_BASH_FILES="True"           # Update bash with user files

# [Text colors]
HEADINGCOLOR=$YELLOW_F              # Some color aliases to make things easier (defined in colors.sh)
SUBHEADINGCOLOR=$CYAN_F
INDENTEDCOLOR=$GREEN_F

# Convert True/False strings to uppercase
string=$INSTALL_ZSH_FILES
INSTALL_ZSH_FILES="${string^}"

string=$INSTALL_BASH_FILES
INSTALL_ZSH_FILES="${string^}"

echo -e "${BOLD}${HEADINGCOLOR}Personal Config${NORM}"

if [ $INSTALL_ZSH_FILES == "True" ];
then
  echo -e "${BOLD}${INDENTEDCOLOR}  Zsh${NORM}"

# Copy my .zshrc & theme
  cp $USER_FILES_DIR/.zshrc $HOME
  cp $USER_FILES_DIR/*.zsh-theme $HOME/.oh-my-zsh/themes

# This one has the zcompdir set to ./cache instead of dumping zcompdir files
# all over your home directory
  cp -p $USER_FILES_DIR/oh-my-zsh.sh $HOME/.oh-my-zsh
  source $HOME/.zshrc
fi

if [ $INSTALL_BASH_FILES == "True" ];
then
  echo -e "${BOLD}${INDENTEDCOLOR}  Bash${NORM}"
  cp -p $USER_FILES_DIR/.dircolors $HOME
  cp -p $USER_FILES_DIR/.bashrc $HOME/
fi

cp $USER_FILES_DIR/.hushlogin $HOME

echo -e "${BOLD}${INDENTEDCOLOR}  ssh${NORM}"
# My ssh files in ..Fedora/User already have the attributes set needed for ssh
# if yours don't, set them to:
#   ./ssh directory 700
#   private key     600
#   public key      640

cp -r --preserve=all $USER_FILES_DIR/.ssh/ $HOME

# Don't use these so get rid of them
rm -rf $HOME/Public
rm -rf $HOME/Videos
rm -rf $HOME/Templates

echo -e "${BOLD}${INDENTEDCOLOR}  Git${NORM}"
cp $USER_FILES_DIR/.gitconfig $HOME

# If I've edited these files on my Mac those .DS_Store files will pop up everywhere.
# The Icon? files are the Mac's icon information (as opposed to .directory)

echo -e "${BOLD}${HEADINGCOLOR}Removing MacOS files from Setup directory${NORM}"
find $HOME/Setup -name '*.DS_STORE' -print0 | xargs -0 rm -f
find $HOME/Setup -name 'Icon?' -print0 | xargs -0 rm -rf

