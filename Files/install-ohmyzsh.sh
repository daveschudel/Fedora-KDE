#!/bin/bash
source ./colors.sh                  # Color codes used in this script
echo -e "${BOLD}${HEADINGCOLOR}Install Oh-My-Zsh${BOLD}${NORM}"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
