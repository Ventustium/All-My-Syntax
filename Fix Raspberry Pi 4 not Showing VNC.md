# Fix Raspberry Pi 4 VNC Not Showing
```bash
sudo raspi-config
```
And then do

Advanced options -> Wayland -> W1 X11 -> OK -> Finish

Reboot


other than that, you need to apply
```bash
vim /boot/config.txt
hdmi_force_hotplug=1
hdmi_group=2
hdmi_mode=9
```
 
