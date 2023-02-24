#!/bin/bash

# Fedora KDE configuration script.
# See install.md for more information

source ./colors.sh   # Color codes

# [General options]
HOSTNAME="Lucy"                         # Set hostname (obviously..)

# [ Boot options]
INSTALL_GRUB_THEME="True"               # Make changes to /etc/default/grub to use themes, and other options (see below)
GRUB_LAPTOP="True"                      # Sets the Grub theme font size; Laptop or PC
GRUB_THEME="poly-dark"                  # Theme inside ./GRUB
GRUB_GFXMODE="1920x1080"                # Set Grub theme video mode
GRUB_WINDOWS="True"                     # Copy a modified 30_os-prober file to /etc/grub.d so the menu entry for Windows
INSTALL_PLYMOUTH_THEME="False"          # Install Plymouth theme
PLYMOUTH_THEME="spinfinity"             #     the theme.. Make sure this theme will be installed. Add it to
                                        #     APPSFILE if needed
# [Repos & Applications]
USE_CONFIGURED_REPO_FILES="True"        # Use pre-configured .repo files that look nicer
REMOVEFILE="setup-remove-apps.txt"      # Apps to remove
APPSFILE="setup-install-apps.txt"       # Individual apps to install (not in groups)
GROUPSFILE="setup-install-groups.txt"   # Software groups to install

# [Config]
NORDUSER="dave"                         # To add user to NordVPN groupd

# [Text colors]
HEADINGCOLOR=$YELLOW_F                  # Some color aliases to make things easier
SUBHEADINGCOLOR=$CYAN_F                 #   see colors.sh
INDENTEDCOLOR=$GREEN_F

# -----------------------------------------------------------------------------
clear

# Convert True/False strings to uppercase
string=$SETUP_AS_VM
SETUP_AS_VM="${string^}"

string=$GRUB_LAPTOP
GRUB_LAPTOP="${string^}"

string=$USE_CONFIGURED_REPO_FILES
USE_CONFIGURED_REPO_FILES="${string^}"

string=$USE_CONFIGURED_REPO_FILES
USE_CONFIGURED_REPO_FILES="${string^}"

string=$INSTALL_PLYMOUTH_THEME
INSTALL_PLYMOUTH_THEME="${string^}"

string=$INSTALL_GRUB_THEME
INSTALL_GRUB_THEME="${string^}"

string=$GRUB_WINDOWS
GRUB_WINDOWS="${string^}"

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
echo -e "  ${BOLD}${INDENTEDCOLOR}    Setup for Laptop?             ${BOLD}$GRUB_LAPTOP${NORM}"
echo -e "  ${BOLD}${INDENTEDCOLOR}    Theme                         ${BOLD}$GRUB_THEME${NORM}"
echo -e "  ${BOLD}${INDENTEDCOLOR}    GFXMODE                       ${BOLD}$GRUB_GFXMODE${NORM}"
fi

echo -e "  ${BOLD}${INDENTEDCOLOR}  Install Plymouth Theme?         ${BOLD}$INSTALL_PLYMOUTH_THEME${NORM}"
if [ $INSTALL_PLYMOUTH_THEME == "True" ]; then
echo -e "  ${BOLD}${INDENTEDCOLOR}    Theme                         ${BOLD}$PLYMOUTH_THEME${NORM}"
fi

echo
echo -e "  ${BOLD}${SUBHEADINGCOLOR}Software${NORM}"
echo -e "  ${BOLD}${INDENTEDCOLOR}  Use pre-configured repo files?  ${BOLD}$USE_CONFIGURED_REPO_FILES${NORM}"
echo -e "  ${BOLD}${INDENTEDCOLOR}  List of apps to remove          ${BOLD}$REMOVEFILE${NORM}"
echo -e "  ${BOLD}${INDENTEDCOLOR}  List of groups to install       ${BOLD}$GROUPSFILE${NORM}"
echo -e "  ${BOLD}${INDENTEDCOLOR}  List of apps to install         ${BOLD}$APPSFILE${NORM}"
echo


### Not working yet
if [ -z "$NORDUSER" ]; then
echo -e "  ${BOLD}${HEADINGCOLOR}  No user specified to add to NordVPN group${NORM}"
else
echo -e "  ${BOLD}${INDENTEDCOLOR}  Username for NordVPN            ${BOLD}$NORDUSER${NORM}"
fi

echo

echo
read -p "Options correct? Press any key to continue or CTRL-C to quit" answer

# -----------------------------------------------------------------------------

echo -e "${BOLD}${HEADINGCOLOR}Setting Hostname to $HOSTNAME${NORM}"
hostnamectl set-hostname $HOSTNAME

echo -e "${BOLD}${HEADINGCOLOR}Configuring DNF${NORM}"
echo "fastestmirror=1" >> /etc/dnf/dnf.conf
echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
echo "deltarpm=true" >> /etc/dnf/dnf.conf

#------------------------------------------------------------------------------
echo -e "${BOLD}${HEADINGCOLOR}Installing repositories${NORM}"

if [ $USE_CONFIGURED_REPO_FILES == "True" ];
then
  echo -e "${BOLD}${INDENTEDCOLOR}  Installing pre-configured repositories${NORM}"
  mkdir /etc/yum.repos.d/old
  mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/old/
  cp Repos/*.repo /etc/yum.repos.d/
  chmod 644 /etc/yum.repos.d/*.repo

else

  echo -e "  ${BOLD}${INDENTEDCOLOR}RPM Fusion Free${BOLD}${NORM}"
  dnf install -y -q https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

  echo -e "  ${BOLD}${INDENTEDCOLOR}RPM Fusion Non-Free${BOLD}${NORM}"
  dnf install -y -q https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

  # Add any other repos needed here
  echo -e "  ${BOLD}${INDENTEDCOLOR}Vivaldi${BOLD}${NORM}"
  dnf config-manager --add-repo https://repo.vivaldi.com/archive/vivaldi-fedora.repo

  echo -e "  ${BOLD}${INDENTEDCOLOR}Visual Studio Code${BOLD}${NORM}"
  rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

fi

echo -e "  ${BOLD}${INDENTEDCOLOR}  Flathub${BOLD}${NORM}"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

dnf update --refresh
read -p "Options correct? Press any key to continue or CTRL-C to quit" answer


# a kluge to fix the vivaldi repo being recreated
rm /etc/yum.repos.d/viv*.repo
#------------------------------------------------------------------------------

echo -e "${BOLD}${HEADINGCOLOR}Removing unwanted apps${NORM}"
while IFS= read -r line
do
  filename="${line%%\#*}"
  echo -e "  ${BOLD}${INDENTEDCOLOR}$filename${NORM}"
  dnf -y -q remove "$filename"
done < $REMOVEFILE

echo -e "${BOLD}${HEADINGCOLOR}Installing Software Groups${NORM}"

while IFS= read -r line
do
  filename="${line%%\#*}"
  echo -e "  ${BOLD}${INDENTEDCOLOR}$filename${NORM}"
  dnf groupinstall -y -q "$filename"
done < $GROUPSFILE

echo -e "${BOLD}${HEADINGCOLOR}Installing Individual Apps${NORM}"

while IFS= read -r line
do
  filename="${line%%\#*}"
  echo -e "  ${BOLD}${INDENTEDCOLOR}$filename${NORM}"
  dnf -y -q install $filename
done < $APPSFILE

#------------------------------------------------------------------------------
# These are the free/public Microsoft fonts. It makes life MUCH easier by not
# mapping the general Microsoft fonts to something strange with files created
# in Office.

echo -e "${BOLD}${HEADINGCOLOR}Installing Microsoft Fonts${NORM}"
rpm -i --quiet https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

#------------------------------------------------------------------------------
if [ "$SETUP_AS_VM" == "False" ];
then
  echo -e "${BOLD}${HEADINGCOLOR}Enabling Laptop Power Management${NORM}"
  systemctl enable tlp
  cpupower frequency-set --governor conservative
fi

#------------------------------------------------------------------------------
# GRUB

# We need to determine which font to use in Grub. The smaller font looks better
# on the laptop while the larger works on the desktop. Grub/theme-*.txt have the
# desired fonts for that system. I put two theme files in the poly-dark directory:
# theme-laptop.txt and theme-desktop.txt. Just copy the one you want to theme.txt

# I use a theme called poly-dark I got from gnome-look.org and changed the
# background & fonts

# Also for Grub, if I have a multi-boot machine and Windows is one of the
# OSs installed, I go into /etc/grub.d/30_os-prober as root and find the 
# 'menuentry' immediately after searching for 'Windows' and change the 
# first part to menuentry '$(echo "Windows")'. That way it just says 'Windows'
# and not all the stuff about what partition it's on.

# Or, you could change it to read 'Windoze, 'Help me God' or whatever you'd like :)

if [ $INSTALL_GRUB_THEME == "True" ];
then
  echo -e "${BOLD}${HEADINGCOLOR}Setting up GRUB2, Theme & Config${NORM}"

  # Backup our grub config first
  cp -r /etc/default/grub /etc/default/grub.bak

  # Copy the correct theme file to the default. I have two versions of the theme,
  # one for a laptop & one for a desktop. I have different font sizes so they
  # render at a readable size on each

  if [ $GRUB_LAPTOP == "True" ];
  then
    cp Grub/poly-dark/theme-laptop.txt Grub/poly-dark/theme.txt
  else
    cp Grub/poly-dark/theme-desktop.txt Grub/poly-dark/theme.txt
  fi

  cp -r Grub/poly-dark/ /boot/grub2/themes/

  echo "Making changes to /etc/default/grub"
  # Comment out the default settings
  sed -ie 's/GRUB_TERMINAL/#GRUB_TERMINAL/' /etc/default/grub
  sed -ie 's/GRUB_ENABLE_BLSCFG/#GRUB_ENABLE_BLSCFG/' /etc/default/grub
  sed -ie 's/GRUB_DEFAULT/#GRUB_DEFAULT/' /etc/default/grub
  sed -ie 's/GRUB_DISABLE_SUBMENU/#GRUB_DISABLE_SUBMENU/' /etc/default/grub
  sed -ie 's/GRUB_DISABLE_RECOVERY/#GRUB_DISABLE_RECOVERY/' /etc/default/grub

  # Update with mine
  echo "#-- Added by setup script, remove duplicates --" >> /etc/default/grub
  echo "GRUB_THEME=/boot/grub2/themes/poly-dark/theme.txt" >> /etc/default/grub
  echo "GRUB_DISABLE_SUBMENU=False" >> /etc/default/grub
  echo "GRUB_DISABLE_RECOVERY=False" >> /etc/default/grub
  echo "GRUB_DEFAULT=0" >> /etc/default/grub
  echo "GRUB_ENABLE_BLSCFG=False" >> /etc/default/grub
  echo "GRUB_GFXMODE=1920x1080" >> /etc/default/grub

  # Removing empty lines at the end of GRUB config
  sed -i -e :a -e '/^\n*$/{$d;N;};/\n$/ba' /etc/default/grub

  # Adding new line to GRUB config just in case
  echo | tee -a /etc/default/grub

  # Copy the modified 30_os-prober file. See the file, it has the Grub
  # menu entry set for "Windows" instead of "bootloader on /dev/sdb or whatever"
  cp 30_os-prober /etc/grub.d/

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

echo -e "${BOLD}${HEADINGCOLOR}Adding user to NordVPN group${NORM}"
usermod -aG nordvpn $USERNAME


ENDTIME=$(date)
echo -e "${BOLD}${HEADINGCOLOR_F}Completed at $ENDTIME${NORM}"
