- [1) Introduction](#1-introduction)
  - [Fedora 39](#fedora-39)
  - [Other Fedora options](#other-fedora-options)
  - [Fedora Magazine](#fedora-magazine)
  - [Fedora Laptops](#fedora-laptops)
- [2) Installation](#2-installation)
  - [X11 vs Wayland](#x11-vs-wayland)
- [3) Shells](#3-shells)
    - [Eza Colors](#eza-colors)
  - [Zsh](#zsh)
    - [Zsh Tweaks](#zsh-tweaks)
    - [Themes](#themes)
  - [Bash](#bash)
- [4) DNF](#4-dnf)
  - [RPM Fusion](#rpm-fusion)
- [5) My Fedora KDE settings \& tweaks](#5-my-fedora-kde-settings--tweaks)
  - [Backup \& Restore](#backup--restore)
  - [Changing The Volume Name](#changing-the-volume-name)
  - [Konsole](#konsole)
  - [Dolphin](#dolphin)
  - [KDE System Settings](#kde-system-settings)
    - [Startup/SDDM](#startupsddm)
    - [Appearance](#appearance)
    - [KDE Taskbar](#kde-taskbar)
    - [KDE Desktop Effects](#kde-desktop-effects)
    - [KDE Splash Screen](#kde-splash-screen)
  - [Laptop Power Management](#laptop-power-management)
  - [Multiple Desktops](#multiple-desktops)
- [6) Apps \& Packages I'd Recommend](#6-apps--packages-id-recommend)
  - [Yakuake](#yakuake)
  - [Visual Studio Code](#visual-studio-code)
    - [Using the Microsoft repository](#using-the-microsoft-repository)
    - [Using a Flatpak](#using-a-flatpak)
  - [Microsoft Open Fonts](#microsoft-open-fonts)
  - [OneDrive](#onedrive)
- [7) General Linux Information](#7-general-linux-information)
  - [SSH](#ssh)
  - [Backups](#backups)
  - [VPN](#vpn)
- [8) SELinux](#8-selinux)
- [9) Advanced Topics](#9-advanced-topics)
  - [Grub](#grub)
    - [Grub Configuration Files](#grub-configuration-files)
    - [Themes](#themes-1)
  - [Plymouth Splash](#plymouth-splash)
  - [Customizing the DNF repository list](#customizing-the-dnf-repository-list)
    - [Structure of a .repo file.](#structure-of-a-repo-file)
- [10 Upgrades and Beta versions](#10-upgrades-and-beta-versions)
  - [Upgrading Fedora](#upgrading-fedora)
- [11) KDE Development](#11-kde-development)
- [12) Ham Radio](#12-ham-radio)
  - [Winlink](#winlink)
  - [WSJT-X](#wsjt-x)
  - [TQSL](#tqsl)
  - [Serial over Bluetooth](#serial-over-bluetooth)
  - [Logging Apps](#logging-apps)
    - [N3FJP](#n3fjp)


<br>

<a name="intro"></a>

# 1) Introduction

I've run Fedora since Fedora 9. It's my choice for a Linux OS for a number of reasons. When I first started with Linux my college used Scientific Linux, based on CentOS which itself is based on RedHat. Other students used Ubuntu, but I found it difficult to use since the development tools & other things don't match. Think Ubuntu's Build Essentials vs Fedora's Development Tools group. Everything I did on my machine matched what was used on the servers.  

Also, I just like the way Fedora does things. It may seem more complicated that Ubuntu but it gave me the opportunity to learn much more about what's happening inside. Linus Torvalis uses Fedora. The prosecution rests. :)

I've spent a lot of time just playing with Fedora and KDE, learning how it works. KDE is very configurable. You can pretty much set it up however you want. 

Chapters 5 & 10 are the only one that here specific to the KDE spin so users of the base Fedora distro and other spins can get information that could help them too.

As I find more I'll add it. I hope it helps you. 
<br><br>

## Fedora 39

Fedora 39 was released November 7. There are a number of changes to Gnome but the big one for all the spins & labs was eliminating the Modular repository. 

I decided to use the upgrade option this time instead of wiping the machine & starting from scratch. 

I only ran into one problem. The most recent kernel wouldn't start. Not sure why, but I had VirtualBox installed and it has a kernel mod, and I've played around with Grub so it was probably something I did. I just booted into the previous kernel, removed the most recent, reinstalled it and it works fine. See [Upgrading Fedora](#upgrading-fedora) for more information.
<br><br>

## Other Fedora options

The primary Fedora release comes with the GNOME desktop environment. Fedora also releases 'spins' and 'labs'. Spins are distros focused on a desktop environment; e.g. KDE, LXDE, i3. Spins can be found [here](https://spins.fedoraproject.org/). Fedora Labs are distros designed for a specific purpose. These include

* [Astronomy](https://labs.fedoraproject.org/en/astronomy/)
* [Comp Neuro](https://labs.fedoraproject.org/en/comp-neuro/) for computational modelling tools for neuroscience
* [Design Suite](https://labs.fedoraproject.org/en/design-suite/) for multimedia production & design
* [Games](https://labs.fedoraproject.org/en/games/)
* [Jam](https://labs.fedoraproject.org/en/games/) for music production
* [Python Classroom](https://labs.fedoraproject.org/en/python-classroom/)
* [Security Lab](https://labs.fedoraproject.org/en/security/)
* [Robotics Suite](https://labs.fedoraproject.org/en/robotics/)
* [Scientific](https://labs.fedoraproject.org/en/scientific/)
<br><br>

## Fedora Magazine
[Fedora Magazine](https://fedoramagazine.org/) has a lot of good information. They'll post articles on how-tos and new apps to try.
<br><br>
## Fedora Laptops
Fedora Magazine had an article https://fedoramagazine.org/fedora-slimbook-available-now/ about a company called Slimbook that released a series of laptops with Fedora pre-installed. I went to their site and configured one. I don't need a portable workstation anymore but it was fun to see what I could get.

16" Display, 64Gb RAM, Two 1TB Samsung SSDs setup for RAID 0, 2 USB 3 ports, 2 USB-C ports. It would *only* run me € 2593. :)
<br><br>

<a name="install"></a>

# 2) Installation

* Download the Fedora KDE Spin [https://spins.fedoraproject.org/en/kde/](https://spins.fedoraproject.org/en/kde/)
<br>


* Import Fedora's GPG key(s) <br>
```
curl https://getfedora.org/static/fedora.gpg | gpg --import
```

* Verify the checksum is valid <br>
```
gpg --verify-files CHECKSUM_FILENAME
```

* Verify the download's checksum matches <br>
```
sha256sum -c CHECKSUM_FILE
```

Unless I'm installing Fedora in a VM I ***always*** encrypt the drive. I use the standard install options and leave the root user disabled. Obviously if you need a specific partition layout set it up here. I'd be wary of playing with it for the sake of playing with it. The Fedora engineers have done a great job of optimizing everything for the desktop and it would be very easy to *optimize* your system so it runs worse. I used to make the swap partition larger but there was no need for it. Enlarge it if you want to be able to hibernate. 

Fedora switched to the Btvfs file system from Ext4. I'd leave it alone. There are discussions and/or arguments all over the web about the problems & benefits of Btvfs but like for partitioning, you're best just to leave it alone.

The Fedora installer looks different depending on what Spin you're installing. For example, the KDE Spin has you setup the user account before installing while the standard Fedora installation (Gnome) has you creating the user after installing. I'm not sure why.

After installing Fedora you'll want to update everything before adding to your system. See the [DNF](#dnf) section for more information. 

```
sudo dnf update -y
```

The '-y' parameter suppresses the 'yes/no' prompts.
<br><br>

<a name="shells"></a>
## X11 vs Wayland

Wayland is the default display manager for the Fedora KDE spin. Here are the Fedora [Wayland](https://docs.fedoraproject.org/en-US/fedora/latest/system-administrators-guide/Wayland/) docs. 

Fedora has decided to drop X11 support for Fedora 40 KDE. [Linuxiac](https://linuxiac.com/fedora-40-to-offer-plasma-6-drops-x11-entirely/) has a nice writeup on it with a link to the offical Fedora Wiki.
<br><br>

  
# 3) Shells

I switched to **<code>eza</code>** to replace **<code>ls</code>**. See [https://github.com/eza-community/eza](https://github.com/eza-community/eza) for more information. It formats things really well.

```
alias ls='eza -lao --group-directories-first --no-permissions --time-style "+%m/%d/%y %H:%M" --git'
```
Many of the switches are straight from **<code>ls</code>** but there are a few new ones.

-l : Long directory format<br>
-a : All files & directories, including . and ..<br>
-o : Octal permissions<br>
--group-directories-first<br>
--no-permissions : This one removes the standard wide permissions column<br>
--time-style : Allows you to format the time & date column<br>
--git : Adds the git status for each file
<br>

### Eza Colors
There's a very good man page on ArchLinux [https://man.archlinux.org/man/eza_colors.5.en](https://man.archlinux.org/man/eza_colors.5.en) that documents how to set various colors. I changed two<br>
```
export EZA_COLORS="di=33:da=36"
```

*di* sets the directory color<br>
*da* sets the date color

<br>
<img src="Images/eza.png"/>
<br><br>
<a name="zsh"></a>

## Zsh
I use Zsh but still have Bash configured on my system. Zsh gives you a LOT of features over what Bash has. Read more at [https://zsh.sourceforge.io/Intro/intro_toc.html](https://zsh.sourceforge.io/Intro/intro_toc.html)

I also recommend Oh-My-Zsh. It adds lots of features that will make your life easier, along with themes. Check it out at [https://github.com/ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)

To install Oh-My-Zsh
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

It will create <code>~/.oh-my-zsh/</code> in your home directory. Themes are in <code>~/.oh-my-zsh/themes</code>.
<br><br>

<a name="zsh-themes"></a>
### Zsh Tweaks

OhMyZsh left those ```zcompdump``` files all over my home directory. Open ```./oh-my-zsh/oh-my-zsh.sh``` and look 
for the line

```ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"```

and change it to something like this. (I put mine in .config)

```ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.config/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"```
<br><br>

### Themes

Oh-My-Zsh has many themes you can try out. I took a theme and modified it to. Other than using an installed theme that's probably the easiest route. Theme building can get complicated.

[This page has a lot of information on zsh themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)

My theme is based on the nanotech.zshtheme found in <code>~/.oh-my.zsh/themes</code>.

```
  bar1() {    
      BAR_FG="048"    
      BAR1_BG="117  "  
      echo "%{$FG[$BAR_FG]%}%{$BG[$BAR1_BG]%} "    
  }    
  bar2() {    
      BAR_FG="048"    
      BAR1_BG="073"    
      echo "%{$FG[$BAR_FG]%}%{$BG[$BAR1_BG]%} "    
  }    
  bar3() {    
      BAR_FG="048"    
      BAR1_BG="033"    
      echo "%{$FG[$BAR_FG]%}%{$BG[$BAR1_BG]%} "    
  }    
  bar4() {    
      BAR_FG="048"    
      BAR1_BG="026"    
      echo "%{$FG[$BAR_FG]%}%{$BG[$BAR1_BG]%} "    
  }    
  bar5() {    
      BAR_FG="048"    
      BAR1_BG="021"    
      echo "%{$FG[$BAR_FG]%}%{$BG[$BAR1_BG]%} "    
  }    
  bar6() {    
      BAR_FG="048"    
      BAR1_BG="020"    
      echo "%{$FG[$BAR_FG]%}%{$BG[$BAR1_BG]%} "
  } 
  bar7() {    
      BAR_FG="048"    
      BAR1_BG="019"    
      echo "%{$FG[$BAR_FG]%}%{$BG[$BAR1_BG]%} "    
  }    
  bar8() {    
      BAR_FG="048"    
      BAR1_BG="018"    
      echo "%{$FG[$BAR_FG]%}%{$BG[$BAR1_BG]%} "    
  }    
  bar9() {    
      BAR_FG="048"    
      BAR1_BG="017"    
      echo "%{$FG[$BAR_FG]%}%{$BG[$BAR1_BG]%} "    
  }    
  bar10() {    
      BAR_FG="048"    
      BAR1_BG="016"    
      echo "%{$FG[$BAR_FG]%}%{$BG[$BAR1_BG]%} "    
  }    

  COLOR_BAR="$(bar1)$(bar2)$(bar3)$(bar4)$(bar5)$(bar6)$(bar7)$(bar8)$(bar9)$(bar10)"**  

  PROMPT='${COLOR_BAR}%d %F{green}%F{yellow}%f**'  
  RPROMPT='$(git_prompt_info) %F{green}%D{%L:%M}** '  
  
  ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{green}"     
  ZSH_THEME_GIT_PROMPT_SUFFIX="%f"    
  ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"    
  ZSH_THEME_GIT_PROMPT_CLEAN=""    

```
And looks like this on a black background.

![title](Images/zsh-theme.png)

<a name="bash"></a>

## Bash

Here's the prompt for my colored bar in Bash

```
# Definitions for the color variant bar in the prompt. Doesn't have anything for Git.

  BAR1="\\[\e[48;5;117m\] "  
  BAR2="\\[\e[48;5;73m\] "  
  BAR3="\\[\e[48;5;33m\] "  
  BAR4="\\[\e[48;5;26m\] "  
  BAR5="\\[\e[48;5;21m\] "  
  BAR6="\\[\e[48;5;20m\] "  
  BAR7="\\[\e[48;5;19m\] "  
  BAR8="\\[\e[48;5;18m\] "  
  BAR9="\\[\e[48;5;17m\] "  
  BAR10="\\[\e[48;5;16m\] " 
  CLEAR="\\[\e[0m\]" 
  GREEN="\\[\e[1;32m\]" 
  YELLOW="\\[\e[1;33m\]" 
  PURPLE="\\[\e[1;35m\]" 

  # I removed the code to set the titlebar.  I'm good w/it just saying 'Konsole' or whatever  
  PS1="${BAR1}${BAR2}${BAR3}${BAR4}${BAR5}${BAR6}${BAR7}${BAR8}${BAR9}${BAR10}${CLEAR}${YELLOW}\${PWD} ${GREEN}\$ ${CLEAR}"  

```
and looks like this. 

![title](Images/bash.png)

<br>

<a name="dnf"></a>

# 4) DNF
<a name="dnf-config"></a>

There are many options for DNF from getting through proxies, security settings, and more. Look at the official [Fedora DNF Reference](https://docs.fedoraproject.org/en-US/fedora/latest/system-administrators-guide/package-management/DNF/), the [Fedora DNF Quickdocs](https://docs.fedoraproject.org/en-US/quick-docs/dnf/) and the [DNF GitHub page](https://github.com/rpm-software-management/dnf) for more information.

I use one option for dnf, set in <code>/etc/dnf/dnf.conf</code>.

```
fastestmirror=1  # The default setting is off. If you have problems after setting this revert back.
```

I also use the -y parameter to suppress the 'Are you sure' messages.<br>

```
sudo dnf -y update
```
You can set this in <code>/etc/dnf/dnf.conf</code> by using <code>assumeyes=1</code> but I'd advise against it. I use -y for running updates but not to install individual packages so I can see what's actually getting installed.


DNF can take a long to update itself because it downloads the repository data often. A [discussion](https://ask.fedoraproject.org/t/why-is-dnf-so-slow/6316) on the Fedora Project site suggested setting <code>metadata_expire=2d</code> in <code>/etc/dnf/dnf.conf</code>. If you use the -q parameter (quiet) like in my install scripts it will look like the process hangs. 

I noticed that not all repositories I installed had the <code>metadata_expire</code> set. I went through all my .repo files and set them all to 1d. That seems to have fixed it.

It appears that if you run dnf with the ```--refresh``` option it updates the repository data much faster than if you let Fedora handle it. I'm not sure why, it just seems that way. 

There are a lot of dnf groups to choose from. See a list of groups by running 
```
dnf group list
```
You can get the short names for each group - useful if you're using batch files to install them - by running dnf with the -v (verbose) option. It will also tell you the metadata date/time for each repo.

```
dnf -v group list
...
repo: using cache for: fedora
fedora: using metadata from Sat 05 Nov 2022 03:04:38 AM CDT.
repo: using cache for: updates
updates: using metadata from Fri 17 Mar 2023 11:49:31 PM CDT.
repo: using cache for: fedora-modular
...

...
Network Servers (network-server)
Neuron Modelling Simulators (neuron-modelling-simulators)
Office/Productivity (office)
Python Classroom (python-classroom)
Python Science (python-science)
Robotics (robotics-suite)
...
```

You can see what's in each group by running <code>dnf group info GROUP_NAME</code>. I generally install *Development Tools* and *X Software Development* but take a look at the ones that sound like they might fit your needs. 

Groups are by far the easiest way to install the big desktop environments. For example, if for some unknown reason you wanted to install Gnome 😎 you'd use
```
sudo dnf -y group install @gnome-desktop
```

(IMHO Gnome looks like what you'd get if Crayola wrote a window manager) 😎

Smaller DE's are just installed as packages; e.g. 
```
sudo dnf install fluxbox
```
<br>
<a name="rpmfusion"></a>

## RPM Fusion
You'll probably want to enable RPM Fusion. RPM Fusion is a repository that contains software that doesn't meet the Fedora licensing. The base Fedora distro is FOSS-Only.

[https://rpmfusion.org](https://rpmfusion.org)

You can install it from your browser but I think it's easier to do it from the command line.

```
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

Installing the appstream packages with dnf will enable showing apps from those repos in Discover.
```
appstream
appstream-qt
rpmfusion-free-appstream-data
rpmfusion-nonfree-appstream-data
```

Many of the options in dnf are actually plugins. You can install additional plugins, like the one you'll need for updating Fedora itself. See the plugins section at [https://docs.fedoraproject.org/en-US/quick-docs/dnf/](https://docs.fedoraproject.org/en-US/quick-docs/dnf/)

If you want something other than what's in the Fedora & RPM Fusion repos, check out Fedora's COPR repositories. They're user-created repos with their projects. There are nightly builds of software as well. Some of them are personal repos and say 'do not use'. Don't use them. :)

[https://copr.fedorainfracloud.org/coprs/](https://copr.fedorainfracloud.org/coprs/)
<br><br>


<a name="various-kde-settings"></a>

# 5) My Fedora KDE settings & tweaks

## Backup & Restore

I haven't found a reliable way to restore all of my KDE settings when installing a new Fedora build. If you back up
./local & ./config that will take care of your personal settings but it will miss anything installed as the superuser. 
All of that lives down in /usr. I'll keep trying until I get it right.
<br><br>

<a name="change-volume-name"></a>

## Changing The Volume Name

Launch KDE Disk Editor from the Live CD. Rename your home volume to whatever you want. You can't change the name of a volume when booting from it. If your disk is encrypted you'll have to unlock it first. I just reboot back into the USB drive right after installing Fedora & do it then.
<br><br>

<a name="konsole"></a>

## Konsole

* General - Uncheck 'Remember window size'
* Profiles - You can't edit the Default profile so create a new one. I use a 90x24 window size. Under Command change it to /bin/zsh. Konsole will use the shell specified here and *not* the default shell for your account
* Under Appearance, I use White on Black, then press Edit and change Background transparency to 10%. I also bump the font up a bit.
* Scrolling to Unlimited


Set your new profile to the default profile. Then I disable all of toolbars under the Konsole Settings menu and hide the Menubar. Make sure you exit the Konsole session or it may not save your profile properly.
<br><br>

<a name="dolphin"></a>

## Dolphin
I remove all of the 'search for' categories on the left. I also hide the boot partition. Then I add what I need to 'Places'.

I setup Dolphin like this: In Settings<br>
* General/Behavior - Remember display style for each folder. This is handy for making the icons larger in folders with images, etc.
* General/Previews - Select the types you want displayed. I generally turn off everything but images & ebooks
* Context Menu - take everything out I don't need or want. There are additional services you can download. 

To change the icons for file types, go into System Settings/Applications and create a file type for what you want. For example, I created a type Text/x-shell, set the icon, and added .bashrc, .zshrc, etc. as filename patterns.

<img src="Images/dolphin.png"/>
<br><br>
<a name="system-settings"></a>

## KDE System Settings
<a name="sddm"></a>

### Startup/SDDM
I set it to automatically log in. Yes, I know this is bad security but if you set the machine up with an encrypted drive you have to login with that before continuing. I don't worry about it on a VM either. Obviously if this machine might be at risk don't do this. I use mine for playing around and learning about Fedora. 
<br><br>
<a name="appearance"></a>

### Appearance

* Icons - Gradient Light
* Colors - Nord Light 
* Fonts - Comfortaa
* Plasma Style - Breeze AlphaBlack. It gives you the ability to have a transparent panel.
* Window Decorations - Breeze, but I change the window title so it's on the right.
* [Plasma Splash Screen](#kde-splash-screen)

The KDE Store [https://store.kde.org](https://store.kde.org) has a complete list of Plasma widgets, fonts, colors, themes and other addons. They can also be found in Discover under Plasma Addons.
<br><br>
<a name="taskbar"></a>

### KDE Taskbar
* Change menu to Application Menu. Right-click on any widget and it will give you a list of alternatives.<br>
* Application Menu Settings, check 'Flatten submenus' and uncheck Recent categories<br>
* Install Latte Seperator<br>
* Install Latte Spacer
* Add another digital clock & set it to UTC<br>
* Use QuickLaunches to group applications<br>
* Use Latte Seperator to put nice seperators between the QuickLaunches, clocks, etc., and a Latte Spacer to put a little space between the last QuickLaunch and the Task Manager. It's available from "Get New Widgets" in the Add Widgets window.
<br><br>

Once it's done it looks like this
<img src="Images/taskbar.png"/>
<br><br>
### KDE Desktop Effects

I started using a Desktop Effect called Energize B [Burn-My-Windows] available on the KDE Store [https://www.pling.com/p/1884311It]. It makes opening & closing windows look like they're beaming in and out with a transporter. But I miss the spinning cube. I hope the KDE developers bring it back. I had an image of an open Stargate at the top & bottom.

KDE is great if you want to show off :)
<br><br>

### KDE Splash Screen
I modified [this](https://store.kde.org/p/2072224) theme and put my standard Stargate wallpaper in it so it matches my Grub, Plymouth, Login & Lock screens. 

When you install a new splash screen from the Settings app it will put it in ~/.local/share/plasma/look-and-feel. I just went in and changed the wallpaper in contents/splash/images.

<a name="power"></a>

## Laptop Power Management

It's easiest to do it in the settings app, but if you want to do it
from the command line install tlp, then you can set power management this way<br>

```
cpupower frequency-set --governor conservative
```
Read the man page for cpupower for more options
<br><br>
<a name="desktops"></a>
## Multiple Desktops

KDE, like most desktop environments will use multiple desktops. Set them up in Settings/Workspace Behavior/Virtual desktops.

There are some great transitions available where your desktops can slide over one another and that sort of thing. Those are in Desktop Effects.

If you wanted the spinning cube, however, they removed it. The code wasn't compatible with the way the KDE team is setting up the rest of the system. Hopefully it will come back. 
<br><br>

<a name="other-apps"></a>

# 6) Apps & Packages I'd Recommend

A list of other applications can be found at [https://apps.kde.org](https://apps.kde.org) but these are the ones I use the most.

<a name="yakuake"></a>

## Yakuake
Yakuake is a great drop-down terminal. You hit a hotkey and a terminal drops down from the top of the screen. It's themeable and new themes can be downloaded. I use the Breeze Transparent theme.


<img src="Images/yakuake.png"/>
<br>

See at [https://apps.kde.org/yakuake/](https://apps.kde.org/yakuake/) or install with dnf.
```
sudo dnf install yakuake
```

<br>
<a name="vscode"></a>

## Visual Studio Code

<a name="vscode-repo"></a>

### Using the Microsoft repository

At this point (Fedora 39) VSCode isn't in the Fedora or RPM Fusion repositories. You can download it but I like having it installed from a repo so it stays up to date without having to run a seperate update
command like <code>flatpak update</code>

This will install the repo and key

```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
```

Then<br>

```
sudo dnf check-update
sudo dnf install code
```

<a name="vscode-flatpak"></a>

### Using a Flatpak
If you prefer Flatpaks<br>
```
flatpak install https://flathub.org/repo/appstream/com.visualstudio.code.flatpakref
```

See [https://code.visualstudio.com/docs/setup/linux](https://code.visualstudio.com/docs/setup/linux) or [Microsoft's Visual Studio Code GitHub page](https://github.com/Microsoft/vscode) for more information.
<br><br>


<a name="microsoft-open-fonts"></a>

## Microsoft Open Fonts

If you get documents created in Microsoft Word and open them in LibreOffice sometimes you'll get strange font conversions. The program will use the font listed in the
document unless it doesn't have it installed. Then it will *try* to find something compatible.

You can install the Microsoft open fonts that will take care of most of this. They're on SourceForge

```
rpm -i --quiet https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm 
```

You'll need <code>cabextract</code> and <code>xorg-x11-font-utils</code> to install the fonts.
<br>

<a name="onedrive"></a>
## OneDrive

I still do a lot over in Microsoft 365 and the OneDrive client for Linux is way, way better than it used to be. I use it with a 365 Business account but it should work the same for the personal version. It doesn't default to files-on-demand like the Windows & Mac clients do so it just syncs everything the way you'd expect.

After adding the RPM Fusion repos,

```
dnf install onedrive 
```

I would still keep an eye on it just to make sure it doesn't do strange things. 
<br>
<br>

# 7) General Linux Information

## SSH
I've created my private and public keys but the correct permissions are easy to forget. Just use <code>chmod permissions filename/directory</code>

```
SSH directory 700
Private key   600
Public key    644

ex: chmod 600 id_rsa
```
<br>

## Backups
This is probably obvious but have more than one if possible. It can be as simple and copying everything to an external USB drive to using a tool like rsync. Here's a good list of suggestions. 

[https://linuxhint.com/11_best_backup_tools_linux/](https://linuxhint.com/11_best_backup_tools_linux/)
<br><br>

## VPN
I use NordVPN on Windows, MacOS and Linux. For info, see [https://support.nordvpn.com/Connectivity/Linux/1325529112/Installing-and-using-NordVPN-on-Fedora-and-QubesOS-Linux.htm/](https://support.nordvpn.com/Connectivity/Linux/1325529112/Installing-and-using-NordVPN-on-Fedora-and-QubesOS-Linux.htm/). <br>

Then install it using their script

```
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
```

I ran into some strange problems using their NordLynx protocol so I switched to OpenVPN. That fixed everything.

There's a nice NordVPN Plasma Widget in Discover that puts a icon in the tray for controlling it.
<br><br>

<a name="selinux"></a>

# 8) SELinux
There are people out there who recommend disabling SELinux when alerts start popping up. SELinux is a powerful security tool. It runs in three modes: *disabled*, *permissive* & *enforcing*. Fedora defaults to *enforcing*.

Disable it at your own risk.

I've never seen anything installed from the Fedora or RPMFusion repositories that caused an SELinux exception. For me it's always been something where I downloaded a binary or compiled from source.

 If you install <code>setroubleshoot</code> (I recommend it) it will give you a detailed description of what the problem is. If you get an SELinux alert something is trying to write where it doesn't have permission. If the app should be able to write there you can tell SELinux to allow that app to access that file.

Here is a good overview of SELinux for Fedora.
[https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-selinux/](https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-selinux/)

<br>

<a name = "advanced"></a>
# 9) Advanced Topics

## Grub
<a name="grub-config"></a>
The main config file is <code>/etc/default/grub.</code> I set mine up with these differences.<br>

I add/change these lines to the grub config file
```
GRUB_THEME=/boot/grub2/themes/poly-dark/theme.txt 

# The wording is a bit strange, but disabling this will enable the
# submenu on the Grub menu. It puts the other kernels into the submenu
# cleaning up your menu.
GRUB_DISABLE_SUBMENU=false 

# I recommend disabling this. The Recovery options are always
# a good idea to have. Plus if you enable the submenu Grub puts
# them all there.   
GRUB_DISABLE_RECOVERY=false  

# The default menu item when Grub starts
GRUB_DEFAULT=0   

# Sets the resolution of the Grub screen if you're using graphics
GRUB_GFXMODE=auto  
```

This will set your grub options. To save changes and write the Grub menu to disk. If you're running on a UEFI system run
```
sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
```
For legacy systems run
```
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```
You can edit grub.cfg directly for testing, but it will work until grub2-mkconfig overwrites it.
<br><br>

<a name="custom-grub"></a>

### Grub Configuration Files

The Grub menu is built from config files in <code>/etc/grub.d</code>. You'll need root privileges.

<code>30_os-prober</code> handles menu entries for other OSs. Open it and find the <code>menuentry</code> immediately after searching for 'Windows' and change the first part to <code>menuentry '$(echo "Windows")'</code>Make sure you get that last single quote. This way it just says 'Windows' and not all of the other stuff.

Or, you could change it to read 'Windoze, 'Help me God' or whatever you'd like :)
<br><br>
<a name="grub-themes"></a>

### Themes
You can download Grub themes from gnome-look.org or the KDE store. Depending on your monitor and/or resolution you may want to change the font sizes. 

[Here's a good article explaining how to do it](https://www.bleepingcomputer.com/forums/t/743402/how-to-change-font-size-in-grub-menu/)<br>
[There are some nice Grub themes here](https://www.gnome-look.org/browse?cat=109)
<br><br>

<a name="plymouth-splash"></a>
## Plymouth Splash
Plymouth splash screens are found in /usr/share/plymouth/themes. I went into the **spinner** theme and replaced background-tile.png with my standard splash wallpaper.
<br><br>

<a name="custom-repo-list"></a>
## Customizing the DNF repository list

### Structure of a .repo file.
Fedora's repository files are located in <code>/etc/yum.repos.d</code>. This is a section of a .repo. There can be other sections, like for debug or source packages. These are usually disabled.

```
[fedora]
name=Fedora $releasever - $basearch
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch
enabled=1
countme=1
metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
```

Fedora's Repository Docs are here - [https://docs.fedoraproject.org/en-US/quick-docs/repositories/](https://docs.fedoraproject.org/en-US/quick-docs/repositories/)


To change what the repo looks like when running dnf change the 2nd line of the .repo file.

The entries will look like this

```
name=Fedora $releasever - $basearch
```
<br>
You can change them to something like this so the repo names and architecture are in columns.  

```
Fedora $releasever              - $basearch
name=Fedora $releasever Updates - $basearch
```
<br>
Or remove the architecture altogether

```
Fedora $releasever
name=Fedora $releasever
```

If you want them in order, rename each repo file; e.g.

```
01-Fedora.repo 
02-Fedora-updates.repo
```
to make it look like this
<img src="Images/dnf.png"/>
<br>

<a name="parallels"></a>

# 10 Upgrades and Beta versions

The only problem I've had running betas are with the RPM Fusion repos not being set up yet. If you feel adventurous go for it. You'll have to update to the release version when it comes out. 
<br><br>

## Upgrading Fedora

I've been leery about doing a full update of an OS since the Windows 3.1 days. Fedora is ***way*** more stable than Windows ever was but my phobia remains. 😎 I always back everything up and do a fresh install.

Here's Fedora's instructions on how to do it. [Upgrading to a new release of Fedora](https://docs.fedoraproject.org/en-US/quick-docs/upgrading/)

<br>

<a name="kdedev"></a>

# 11) KDE Development

I usually install the groups <code>"Development Tools"</code> <code>"Development Libraries"</code>**, and <code>"X Software Development"</code> by default since it seems like I'm always running into things I need. 

Check out https://develop.kde.org/develop for a good introduction to KDE/Qt development.

If you're interested in working on KDE itself check out the Fedora KDE SIG
at [https://fedoraproject.org/wiki/SIGs/KDE](https://fedoraproject.org/wiki/SIGs/KDE)<br><br>

# 12) Ham Radio

I created a document with information about setting up Fedora to use with Ham Radio apps. (I'll seperate it out later) Several apps need Wine set up in a very specific way. Follow the instructions for Winlink and you should be good.
<br><br>
## Winlink
[K6ETA](http://k6eta.com/linux/installing-rms-express-on-linux-with-wine) has a very good writeup on installing Winlink in Linux under Wine. 
<br>

## WSJT-X
WSJT-X is in the Fedora repositories, so just install it.
```
sudo dnf install wsjtx
```

Depending on the sound card you're using it could be just about anything. It will probably show up as 'alsa..'

You'll probably have a serial connection for rig control. It will probably be something like /dev/ttyUSB something.
<br><br>
The sound card selection is pretty stable but those USB to Serial converters can move COM ports depending on which USB port they're plugged in to. 
<br>

## TQSL
TQSL is installed with
```
sudo dnf install tqsllib
```
Once it's installed go into the app and request a certificate.
<br>

## Serial over Bluetooth
I use my Kenwood TH-D74 for Winlink and connect over Bluetooth. I couldn't get the KDE Bluetooth app to pair it properly so I installed Blueman and disabled the KDE Bluetooth app in the taskbar. Once you pair the D74 - it will show up as a mobile phone - you can right-click it's entry in Blueman and connect via Serial.



## Logging Apps

### N3FJP
N3FJP is probably the closest you can get to a standard for a logging app. It can be run under Wine.


