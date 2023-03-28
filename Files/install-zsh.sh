#!/usr/bin/zsh
# Install oh-my-zsh
source ./colors.sh   # Color codes

HEADINGCOLOR=$YELLOW_F                  # Some color aliases to make things easier
USER_FILES_DIR=/home/dave/Setup/User

echo -e "${BOLD}${HEADINGCOLOR}Install zsh & copy config${BOLD}${NORM}"

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp -v -p $USER_FILES_DIR/.zshrc $HOME
cp -v -p $USER_FILES_DIR/*.zsh-theme $HOME/.oh-my-zsh/themes
