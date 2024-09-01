#!/bin/bash
# Fedora KDE configuration script.

# Installation directory structure
#   ./          Main installation directory
#   ./Repos     Formatted repository files
#   ./Grub      Grub themes


source ./colors.sh                  # Color codes used in this script

# [General options]
HOSTNAME="Raphtalia"                # Set hostname (obviously..)
DEFAULT_USER="dave"                 # Used to set your default shell since this script is
                                    #  run as sudo
# [Grub options]
INSTALL_GRUB_THEME="True"           # Make changes to /etc/default/grub to use themes and
                                    #  other options (see below)
GRUB_THEME="poly-dark"              # Theme inside ./GRUB
GRUB_GFXMODE="1920x1080"            # Set Grub theme video mode
GRUB_NAMING="True"                  # Copy the modified 10_Linux & 30_os-prober files to 
                                    #  /etc/grub.d to rename Fedora & Windows entries

# [Plymouth options]
INSTALL_PLYMOUTH_THEME="True"       # Install Plymouth theme
PLYMOUTH_THEME="spinner"            #  the theme.. Make sure it's installed

# [Applications]
REMOVEFILE="setup-remove-apps.cfg"  # Apps to remove
APPSFILE="setup-install-apps.cfg"   # Apps & software groups to install
USE_CONFIGURED_REPO_FILES="False"   # Copy formatted repo files to /etc/yum.repos.d -
                                    #  they're in ./Repos
INSTALL_SUPERPAPER="False"          # Install Superpaper for dual monitor support

# [Text colors]
HEADINGCOLOR=$YELLOW_F              # Some color aliases to make things easier (defined
INDENTEDCOLOR=$GREEN_F              #  in colors.sh)
SUBHEADINGCOLOR=$CYAN_F

# Convert True/False strings to uppercased first letter
string=$INSTALL_PLYMOUTH_THEME
INSTALL_PLYMOUTH_THEME="${string^}"

string=$USE_CONFIGURED_REPO_FILES
USE_CONFIGURED_REPO_FILES="${string^}"

string=$INSTALL_GRUB_THEME
INSTALL_GRUB_THEME="${string^}"

string=$GRUB_NAMING
GRUB_NAMING="${string^}"

string=$INSTALL_SUPERPAPER
INSTALL_SUPERPAPER="${string^}"

clear
echo
echo -e "${BOLD}${HEADINGCOLOR}Fedora Post-Install Setup ${BOLD}${NORM}"
echo
if (( $EUID != 0 )); then
  echo -e "${BOLD}${SUBHEADINGCOLOR}Please run as root${NORM}"
  exit
fi

echo -e "  ${BOLD}${SUBHEADINGCOLOR}Configuration${NORM}"
echo -e "  ${BOLD}${INDENTEDCOLOR}  Set Hostname to:                ${BOLD}$HOSTNAME${NORM}"
echo

echo -e "  ${BOLD}${SUBHEADINGCOLOR}Boot Options${NORM}"
echo -e "  ${BOLD}${INDENTEDCOLOR}  Install Grub Boot Theme?        ${BOLD}$INSTALL_GRUB_THEME${NORM}"

if [ $INSTALL_GRUB_THEME == "True" ];
then
echo -e "  ${BOLD}${INDENTEDCOLOR}    Theme                         ${BOLD}$GRUB_THEME${NORM}"
echo -e "  ${BOLD}${INDENTEDCOLOR}    GFXMODE                       ${BOLD}$GRUB_GFXMODE${NORM}"
echo -e "  ${BOLD}${INDENTEDCOLOR}    Rename Grub Entries?          ${BOLD}$GRUB_NAMING${NORM}"
fi

echo -e "  ${BOLD}${INDENTEDCOLOR}  Install Plymouth Theme?         ${BOLD}$INSTALL_PLYMOUTH_THEME${NORM}"
if [ $INSTALL_PLYMOUTH_THEME == "True" ]; then
echo -e "  ${BOLD}${INDENTEDCOLOR}    Theme                         ${BOLD}$PLYMOUTH_THEME${NORM}"
fi

echo
echo -e "  ${BOLD}${SUBHEADINGCOLOR}Software${NORM}"
echo -e "  ${BOLD}${INDENTEDCOLOR}  Use pre-configured repo files?  ${BOLD}$USE_CONFIGURED_REPO_FILES${NORM}"
echo -e "  ${BOLD}${INDENTEDCOLOR}  List of apps to remove:         ${BOLD}$REMOVEFILE${NORM}"
echo -e "  ${BOLD}${INDENTEDCOLOR}  List of apps to install:        ${BOLD}$APPSFILE${NORM}"
echo
echo -e "  ${BOLD}${INDENTEDCOLOR}  Install SuperPaper?             ${BOLD}$INSTALL_SUPERPAPER${NORM}"

echo
read -p "Options correct? Press any key to continue or CTRL-C to quit" answer

# [Basic system config]

echo -e "${BOLD}${HEADINGCOLOR}Setting Hostname to $HOSTNAME${NORM}"
hostnamectl set-hostname $HOSTNAME

echo -e "${BOLD}${HEADINGCOLOR}Setting DNF options${NORM}"
echo "fastestmirror=1" >> /etc/dnf/dnf.conf
echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
echo "deltarpm=true" >> /etc/dnf/dnf.conf

# Repositories

echo -e "${BOLD}${HEADINGCOLOR}Installing repositories${NORM}"

# Add or remove these as desired, but RPM Fusion is really needed. It contains
# software that isn't in the standard Fedora repos; those only contain FOSS
# apps while RPM Fusion adds a lot.

# If you selected 'USE_CONFIGURED_REPO_FILES' they'll be copied at the end. This way
# all of the keys get imported

echo -e "  ${BOLD}${INDENTEDCOLOR}  RPM Fusion${BOLD}${NORM}"
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo -e "  ${BOLD}${INDENTEDCOLOR}  Flathub${BOLD}${NORM}"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo -e "  ${BOLD}${INDENTEDCOLOR}  Updating repository list${BOLD}${NORM}"
dnf groupupdate core -y

# Add & Remove applications

echo -e "${BOLD}${HEADINGCOLOR}Removing unwanted apps${NORM}"
while IFS= read -r line
do
  filename="${line%%\#*}"
  echo -e "  ${BOLD}${INDENTEDCOLOR}$filename${NORM}"
  dnf -y -q remove "$filename"
done < $REMOVEFILE

echo -e "${BOLD}${HEADINGCOLOR}Installing Groups & Apps${NORM}"

while IFS= read -r line
do
  filename="${line%%\#*}"
  echo -e "  ${BOLD}${INDENTEDCOLOR}$filename${NORM}"
  dnf -y -q install $filename
done < $APPSFILE

# Remove duplicate Vivaldi repo
rm /etc/yum.repos.d/vivaldi-fedora.repo

# Install Superpaper
if [ $INSTALL_SUPERPAPER == "True" ];
then
  echo -e "${BOLD}${HEADINGCOLOR}Installing Superpaper${NORM}"
  python3 -m pip install --user --upgrade superpaper
fi

# [Install Microsoft fonts]

# These are the free/public Microsoft fonts. It makes life MUCH easier by not
# mapping the general Microsoft fonts to something strange with files created
# in Office.if [ $GRUB_NAMING == "True" ];

echo -e "${BOLD}${HEADINGCOLOR}Installing Microsoft Fonts${NORM}"
rpm -i --quiet https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# GRUB

# I use a theme called poly-dark I got from gnome-look.org and changed the
# background & fonts

# Also for Grub, if I have a multi-boot machine and Windows is one of the
# OSs installed, I copy my modified 30_os-prober to /etc/grub.d/ To change your
# own find the 'menuentry' immediately after searching for 'Windows' and change the
# first part to menuentry '$(echo "Windows")'. That way it just says 'Windows'
# and not all the stuff about what partition it's on.

# Or, you could change it to read 'Windoze, 'Help me God' or whatever you'd like :)

# It also copies a modified 10_Linux file, which modifies the 'Fedora' entry on
# the main Grub screen so it just says 'Fedora' instead of with all the kernel info.

if [ $GRUB_NAMING == "True" ];
then
  echo -e "${BOLD}${HEADINGCOLOR}Update Grub config files to rename entries${NORM}"
  cp 30_os-prober /etc/grub.d/
  cp 10_linux /etc/grub.d/
fi

if [ $INSTALL_GRUB_THEME == "True" ];
then
  echo -e "${BOLD}${HEADINGCOLOR}Setting up GRUB Theme & Config${NORM}"

  # Backup our grub config first
  cp -r /etc/default/grub /etc/default/grub.bak
  cp -r ./Grub/poly-dark/ /boot/grub2/themes/

  # Comment out the default settings
  sed -ie 's/GRUB_TERMINAL/#GRUB_TERMINAL/' /etc/default/grub
  #sed -ie 's/GRUB_ENABLE_BLSCFG/#GRUB_ENABLE_BLSCFG/' /etc/default/grub
  sed -ie 's/GRUB_DEFAULT/#GRUB_DEFAULT/' /etc/default/grub
  sed -ie 's/GRUB_DISABLE_SUBMENU/#GRUB_DISABLE_SUBMENU/' /etc/default/grub
  sed -ie 's/GRUB_DISABLE_RECOVERY/#GRUB_DISABLE_RECOVERY/' /etc/default/grub

  # Update with ours
  echo "#-- Added by setup script, remove duplicates --" >> /etc/default/grub
  echo "GRUB_THEME=/boot/grub2/themes/poly-dark/theme.txt" >> /etc/default/grub
  echo "GRUB_DISABLE_SUBMENU=False" >> /etc/default/grub
  echo "GRUB_DISABLE_RECOVERY=False" >> /etc/default/grub
  echo "GRUB_DEFAULT=0" >> /etc/default/grub
  #echo "GRUB_ENABLE_BLSCFG=False" >> /etc/default/grub
  echo "GRUB_GFXMODE=$GRUB_GFXMODE" >> /etc/default/grub

  # Removing empty lines at the end of GRUB config
  sed -i -e :a -e '/^\n*$/{$d;N;};/\n$/ba' /etc/default/grub

  # Adding new line to GRUB config just in case
  echo | tee -a /etc/default/grub
fi

# Update Grub if changes were made
if [ $GRUB_NAMING == "True" ] || [ $INSTALL_GRUB_THEME == "True" ];
then
# Important - for a UEFI machine this is how to rebuild grub.cfg.
# (For BIOS machines it needs to be: grub2-mkconfig -o /boot/grub2/grub.cfg)
  grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
fi

if [ $INSTALL_PLYMOUTH_THEME == "True" ];
  then
# Make sure the Plymouth theme you want is installed
  echo -e "${BOLD}${HEADINGCOLOR}Setting Plymouth Boot Theme to $PLYMOUTH_THEME${NORM}"
  plymouth-set-default-theme $PLYMOUTH_THEME -R
fi

# I edited a set of repo files to make them look better. See them in the Repos directory
if [ $USE_CONFIGURED_REPO_FILES == "True" ];
then
  echo -e "${BOLD}${HEADINGCOLOR}Copy modified repo files to /etc/yum.repos.d${NORM}"
  mkdir /etc/yum.repos.d/old
  mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/old/
  cp Repos/*.repo /etc/yum.repos.d/
  chmod 644 /etc/yum.repos.d/*.repo
  dnf update -y --refresh
fi

ENDTIME=$(date)
echo -e "${BOLD}${HEADINGCOLOR_F}Completed at $ENDTIME${NORM}"
