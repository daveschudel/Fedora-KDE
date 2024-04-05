- [Internet](#internet)
- [Utilities](#utilities)
- [Multimedia](#multimedia)
- [Miscellaneous](#miscellaneous)


## Internet
[Slack](https://slack.com/) (easiest to use a Flatpak)
```
flatpak install flathub com.slack.Slack
```

[Vivaldi Browser](https://vivaldi.com/)
```
dnf config-manager --add-repo https://repo.vivaldi.com/stable/vivaldi-fedora.repo
```


[Neochat](https://apps.kde.org/neochat/) (Matrix Client)
```
sudo dnf install neochat
```

[Discord](https://discord.com/) (easiest to use a Flatpak)
```
flatpak install flathub com.discordapp.Discord
```

## Utilities
[KeePassXC](https://keepassxc.org/)
```
sudo dnf install keepassxc
```
  
[NordVPN](https://nordvpn.com/)
  You need to purchase a subscription, then download the installer

[GTKHash](https://gtkhash.org/)
```
sudo dnf install gtkhash
```

[Blueman](https://github.com/blueman-project/blueman) (I use this for Serial over Bluetooth; I couldn't get the KDE Bluetooth utility to work)
```
sudo dnf install blueman
```

[Visual Studio Code](https://code.visualstudio.com/)
```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
```

## Multimedia
[VLC](https://www.videolan.org/vlc/) handles just about every kind of video format I've come across.
```
sudo dnf install vlc
```
  
[Spotify](www.spotify.com) (easiest to use a Flatpak)
```
flatpak install flathub com.spotify.Client
```

## Miscellaneous
[BOINC](https://boinc.berkeley.edu/) is a utility that lets you use spare cpu cycles to do scientific analysis for various projects. I'm a member of [Einstein @ Home](https://einsteinathome.org/) so my machines work on pulsar and gravity wave analysis. The BOINC site has a list of all of the projects.
```
sudo dnf install boinc-client boinc-manager
```
The installer just installs the app, so go [here](https://boinc.berkeley.edu/wiki/Installing_BOINC_on_Fedora) to get it set up.
