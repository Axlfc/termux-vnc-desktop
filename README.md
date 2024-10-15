# termux-vnc-desktop
**Set up Ubuntu desktop with no root in our Android devices (Termux) and see GUI Desktop via VNC connection.**

Termux : https://f-droid.org/en/packages/com.termux

Termux:API : https://f-droid.org/en/packages/com.termux.api

_I suggest setting static IP linked to your phone's MAC address in the router options._

```termux-change-repo```

```pkg update -y && pkg upgrade -y && pkg install git -y```

```mkdir Documents```

```mkdir Documents/git```

```cd Documents/git```

```git clone https://github.com/Axlfc/termux-vnc-desktop/```


```cd termux-vnc-desktop```

```chmod +x *```

```bash install_ubuntu.sh```

```pd login ubuntu```

```cd /data/data/com.termux/files/home/Documents/git/termux-vnc-desktop```

```chmod +x *```

```bash ubuntu_termux_desktop.sh```

_Go and grab a coffee or your favorite drink as the system installs... (It may show nice red errors :D)_

- Select Geographic Area.
- Select the city or region.

_Keep going with your favorite drink, or get some snack, or... Get some other work DONE!!_

_If you show your mom the phone at this point she will 100% think you're a hacker._

_This may take a while..._  🥱

- Enter Keyboard distribution

_More wait_

- Enter User password (twice) and user information

_A bit more waiting..._

```bash new_install.sh```

```exit```

_A bit of a bit of more waiting..._

- Customize Desktop (optional, but recommended):

```cd /data/data/com.termux/files/home/Documents/git/termux-vnc-desktop```
```bash customize_desktop.sh```

## Final steps, start your VNC Server

```vncserver :1 -geometry 1280x1024```

- Set your password for VNC

(You can kill the vnc session with the command ```vncserver -kill :1``` 

Access your desktop via a VNC viewer app (Example: Remote Ripple in Windows) to the IP of your device::5901

In your own phone you can use the app AVNC and go to the localhost::5901

Put your VNC password and you should be able to see the desktop.
