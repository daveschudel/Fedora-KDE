#!/usr/bin/zsh
# Personal Setup - install zsh and ohmyzsh first

source colors.sh

USER_FILES_DIR=/home/dave/Setup/User
HEADINGCOLOR=$CYAN_F              # Colors defined in color.sh
INDENTEDCOLOR=$GREEN_F            #

# Copy my .zshrc & theme
echo -e "${BOLD}${INDENTEDCOLOR}Shells${NORM}"
cp -v -p $USER_FILES_DIR/.zshrc $HOME
cp -v -p $USER_FILES_DIR/*.zsh-theme $HOME/.oh-my-zsh/themes
source $HOME/.zshrc

# Copy Bash setup
cp -v -p $USER_FILES_DIR/.dircolors $HOME
cp -v -p $USER_FILES_DIR/.bashrc $HOME/

echo -e "${BOLD}${INDENTEDCOLOR}ssh${NORM}"
# My ssh files in ..Fedora/User already have the attributes set neecded for ssh
# if yours don't, set them to:
#   /./ssh      700
#   private key 600
#   public key  640

cp -r --preserve=all $USER_FILES_DIR/.ssh/ $HOME

# Don't use these so get rid of them
rm -rf $HOME/Public
rm -rf $HOME/Videos
rm -rf $HOME/Templates

echo -e "${BOLD}${HEADINGCOLOR}Git config${NORM}"
cp $USER_FILES_DIR/.gitconfig $HOME

echo -e "${BOLD}${HEADINGCOLOR}Removing MacOS files from Setup directory${NORM}"
find $HOME/Setup -name '*.DS_STORE' -print0 | xargs -0 rm -f
find $HOME/Setup -name 'Icon?' -print0 | xargs -0 rm -rf


