dbus-send --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement/Inhibit org.freedesktop.PowerManagement.Inhibit.GetInhibitors

cat /sys/power/wake_lock

lsof /dev/snd/* /dev/input/* /dev/video* /dev/bus/usb/* | grep -E 'COMMAND|/dev/'
