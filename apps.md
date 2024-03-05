- [Internet](#internet)
- [Utilities](#utilities)
- [Multimedia](#multimedia)
- [Miscellaneous](#miscellaneous)


## Internet
[Slack](https://slack.com/)< (easiest to use a Flatpak<br>
<code>flatpak install flathub com.slack.Slack</code>

  
[Brave Browser](https://brave.com/)<br>
  <code>sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc<br>
  sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/<br>
  sudo dnf install brave-browser  </code>

[Vivaldi Browser](https://vivaldi.com/)<br>
  <code>dnf config-manager --add-repo https://repo.vivaldi.com/stable/vivaldi-fedora.repo
  </code>


[Neochat](https://apps.kde.org/neochat/) (Matrix Client)<br>
<code>sudo dnf install neochat</code>

[Discord](https://discord.com/) (easiest to use a Flatpak)<br>
  <code>flatpak install flathub com.discordapp.Discord</code>


## Utilities
[KeePassXC](https://keepassxc.org/)<br><code>sudo dnf install keepassxc</code><br>
  
[NordVPN](https://nordvpn.com/)<br>
  You need to purchase a subscription, then download the installer

[GTKHash](https://gtkhash.org/)<br>
  <code>sudo dnf install gtkhash</code>

[Blueman](https://github.com/blueman-project/blueman) (I use this for Serial over Bluetooth; I couldn't get the KDE Bluetooth utility to work)<br><code>sudo dnf install blueman</code>

[Visual Studio Code](https://code.visualstudio.com/)<br>
  <code>
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'</code>


## Multimedia
[VLC](https://www.videolan.org/vlc/) handles just about every kind of video format I've come across.<br>
<code>sudo dnf install vlc</code>
  
[Spotify](www.spotify.com) (easiest to use a Flatpak)<br>
<code>flatpak install flathub com.spotify.Client</code>

## Miscellaneous
[BOINC](https://boinc.berkeley.edu/) is a utility that lets us use 'spare' cpu cycles to do scientific analysis for various projects. I'm a member of [Einstein @ Home](https://einsteinathome.org/) so my machines work on pulsar and gravity wave analysis. The BOINC site has a list of all of the projects.<br><br>
<code>sudo dnf install boinc-client boinc-manager</code><br><br>
The installer just installs the app, so go [here](https://boinc.berkeley.edu/wiki/Installing_BOINC_on_Fedora) to get it set up.