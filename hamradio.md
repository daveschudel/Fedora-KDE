- [1) Introduction](#1-introduction)
- [2) Winlink](#2-winlink)
    - [Pairing the D74](#pairing-the-d74)
  - [Setup Wine for WinLink](#setup-wine-for-winlink)
  - [Serial-over-Bluetooth](#serial-over-bluetooth)
  - [Wine Fonts \& App Resolution](#wine-fonts--app-resolution)
  - [SELinux warnings](#selinux-warnings)
  - [Using the D74 for Winlink](#using-the-d74-for-winlink)
- [3) TQSL](#3-tqsl)
- [4) WSJT-X](#4-wsjt-x)
  - [Sound Card Configuration](#sound-card-configuration)
  - [GridTracker](#gridtracker)
- [5) Logging](#5-logging)
    - [N3FJP](#n3fjp)
    - [Other logging apps](#other-logging-apps)
- [6) KDE Menu Entries](#6-kde-menu-entries)
- [7) External References](#7-external-references)


<br>

# 1) Introduction

Here are some tips on using Fedora for ham radio. I use the KDE spin but most of this will apply to all spins.<br>
<br>


# 2) Winlink

K6ETA has a very good writeup on getting [Winlink running on Wine](http://k6eta.com/linux/installing-rms-express-on-linux-with-wine) but it's for connecting to your radio over a USB-to-Serial cable. I set mine up to use the TNC in the Kenwood D74 wirelessly. However, the built-in TNC will not support VERA-FM. I personally have a problem with using a closed proprietary system but I have to admit the speeds & error handling are superior to standard Winlink.


### Pairing the D74

The Bluetooth manager that somes with the Fedora KDE Spin wouldn't pair with the D74. So I disabled it and install the GTK blueman app.<br>

```
sudo dnf install blueman
```

It paired with the D74 with no problems on my Asus Zenbook (Ryzen 5, 8GB), but wouldn't pair on an older desktop with one of those Bluetooth USB adapters. When it pairs it shows up as a cell phone. If you right-click on the D74 in Blueman's dialog there's an option to connect serial. Do that and you'll get the message on the D74 that it's established a Bluetooth connection.

## Setup Wine for WinLink

I followed K6ETA's instructions with a few changes.
```
sudo usermod -aG audio (userid)
sudo usermod -aG tty (userid)
sudo usermod -aG dialout (userid)
```

You'll need winetricks along with Wine itself<br>
```
sudo dnf install wine winetricks
```
Then
```
export WINEARCH=win32
```

Like K6ETA says, this part is very important. If you close the terminal you're working in you'll have to reenter it in the new session or things will get VERY messed up. Then<br>

```
winetricks winxp
winetricks sound=alsa
winetricks -q dotnet472
winetricks vb6run
winetricks vcrun2015
```
You may run into a problem installing ```vb6run``` and ```vcrun2015```. The version of winetricks in the repos is out of date for some reason. Just update winetricks by ```sudo winetricks --self-updating``` and that should fix it.

FYI: the .NET install takes a long time.<br><br>
I got SELinux warnings all over the place when installing .NET so I made the appropriate adjustments. Install
<code>setroubleshoot</code> and it will give you instructions on how to fix them.
```
sudo dnf install setroubleshoot
```

If you are using a USB-to-Serial cable follow K6ETA's instructions. Otherwise continue.

## Serial-over-Bluetooth

The serial over Bluetooth connection shows up as <code>/dev/rfcomm0</code>. So make the following changes.
```
ln -s /dev/rfcomm0 ~/.wine/dosdevices/com1
```

This maps rfcomm0 to COM1 in Wine. Then open <code>~/.wine/system.reg</code> and add these lines after #arch-win32
```
[hardware\Devicemap\Serialcomm] 1131331688
“COM1″=”COM1”
```
Then download & install Winlink and configure it to use COM1.<br>

## Wine Fonts & App Resolution

Sometimes the fonts on Wine apps are sized differently than in native apps. To fix this, go into winecfg, select 'Display' and you'll see a slider for Screen Resolution. It was set to 96 dpi originally so I set it to 144 so it matched everything else on my machine.

## SELinux warnings

After I connected to the D74 Bluetooth SELinux displayed an access violation: <br><br>
*SELinux is preventing ps from sys_ptrace access on the cap_userns labeled blueman_t* <br><br>I followed the instructions and created a policy file, then installed it. Make sure you have <code>setroubleshoot</code> installed.
```
sudo dnf install setroubleshoot
```
When SELinux throws up a security violation it will tell you how to fix the problem.<br>
```
sudo ausearch -c 'ps' --raw | audit2allow -M my-ps 
sudo semodule -i my-ps.pp
```

I don't know why it threw warnings. I feel *reasonably* confident that adding that policy isn't going to open my machine to some exploit but I'll investigate it further. Of course there's always the option of setting SELinux to 'Permissive' but I recommend you don't do that. SELinux is there for a reason. :)


## Using the D74 for Winlink

You need to put the D74 into TNC mode by pressing (F) then 5, twice. The first set puts the D74 into APRS mode, the second will put the TNC into KISS mode. Then open a Packet Winlink session and connect to the remote message server. If you close the connection window it will kick the D74 out of KISS mode. I'm not sure why. Just keep an eye on it.<br>

I've also seen it drop the Bluetooth connection. I'll check the logs and see if I can find anything. For now, I just keep an eye on it as well.<br><br>

# 3) TQSL
If you want to use TQSL for automatic uploading of logs it's in the Fedora repositories too.
```
sudo dnf install trustedqsl
```
Once it's installed go into the app and request a certificate.

For some reason the version in the repository is 2.65 while the release version is 2.71. Not sure why. You could download the source & build it if you want.
<br>
<br>


# 4) WSJT-X

WSJT-X is in the Fedora repositories so you can just install it.<br>
```
sudo dnf install wsjtx
```
## Sound Card Configuration
If you're using a SignaLink the sound card will show up as an 'alsa' device so configure WSJT-X using that. I don't know how radios with built-in sound cards will show up but I'd assume it would be something similar.<br>

## GridTracker
GridTracker isn't in the Fedora or RPMFusion repositories. Download it from https://gridtracker.org/index.php/downloads/gridtracker-downloads

# 5) Logging

### N3FJP
[N3FJP](https://www.n3fjp.com/) is probably the closest you can get to a standard for a logging app. It can be run under Wine under a 32-bit prefix. He has a nice [writeup](https://www.n3fjp.com/N3FJPLinuxWA7NCL.pdf) on how to do it under Wine, but if you've already installed Winlink you just need to add a few libraries.

```
winetricks mdac28
winetricks jet40
```

I had to reboot for it to work.


### Other logging apps
  - [CQRLog](https://www.cqrlog.com/)
  - [Jlog](https://www.jlog.org/) - not in the Fedora repositories
  - [KLog](https://www.klog.xyz/)
  - [QLog](https://github.com/foldynl/QLog) - not in the Fedora repositories
  - [XLog](https://savannah.nongnu.org/projects/Xlog)

There are apps for PSK31, AX25, DXCC and many others. Chirp is there as well. Use<br>

```
dnf search ham radio
```
to see a list.<br><br>

# 6) KDE Menu Entries
I created a submenu in the KDE menu for Ham Radio and put everything in there. For apps running under Wine, you'll have to go into the Menu Editor and create a new entry. <br>

For Wine apps, enter the program as "wine" and put the path to the app in the Arguments field.<br><br>I use [Icon Archive](https://www.iconarchive.com/) to find icons for apps if there aren't any in the program's directory.<br><br>

# 7) External References

The [ArchLinux Amateur Radio Wiki](https://wiki.archlinux.org/title/Amateur_radio) has some great information. 




