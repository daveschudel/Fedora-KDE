
### Problems with kernels 6.7.3 & 6.7.4 - February 28, 2024

I had problems with kernels 6.7.3 and 6.7.4. 6.7.5 seems to be fine. I'm not sure what was going on but there are posts on the internet about them doing strange things. On my machine, it sometimes froze before getting to the SDDM screen; other times it hung and logged in a minute or two later. I could go back to 6.5.6 and it worked fine. I'm currently running on an Asus Zenbook with a Ryzen 5. I don't know if that has anything to do with it or not.

If you're having problems too it might be a good idea to keep more than the three default kernels. Open <code>/etc/dnf/dnf.conf</code> and add <code>installonly_limit=5</code> or however many kernels you want to keep.<br><br>
Also, you can delete kernels you don't want. Run <code>rpm -qa | grep "kernel-core"</code> and get a list of the kernels installed. Then use <code>sudo dnf remove [kernel name]</code>

I also ran into a problem with the KDE Spin and VirtualBox. If I try to create a VM with the KDE spin the video goes haywire. It doesn't do that with the standard Workstation release. It is using kernel 6.5.6.
