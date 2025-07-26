# turn off internal camera

dmesg | grep vide
#[   16.762570] uvcvideo: Found UVC 1.00 device Lenovo EasyCamera (5986:0295)



# in console
for device in $(ls /sys/bus/usb/devices/*/product); do 
  echo $device; cat $device; 
done

#/sys/bus/usb/devices/3-5/product
#Lenovo EasyCamera


lsusb
#Bus 003 Device 005: ID 1bcf:05ca Sunplus Innovation Technology Inc. 


lsusb -t
#/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
#    |__ Port 5: Dev 4, If 0, Class=Video, Driver=uvcvideo, 480M
#    |__ Port 5: Dev 4, If 1, Class=Video, Driver=uvcvideo, 480M


#We can send a command to the USB driver to unbind a port,
echo '3-5' | sudo tee /sys/bus/usb/drivers/usb/unbind

#To turn it back on,
echo '3-5' | sudo tee /sys/bus/usb/drivers/usb/bind




# logitech

lsusb
#Bus 003 Device 030: ID 046d:0825 Logitech, Inc. Webcam C270



lsusb -t
#/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
#    |__ Port 3: Dev 23, If 0, Class=Video, Driver=uvcvideo, 480M
#    |__ Port 3: Dev 23, If 3, Class=Audio, Driver=snd-usb-audio, 480M
#    |__ Port 3: Dev 23, If 1, Class=Video, Driver=uvcvideo, 480M
#    |__ Port 3: Dev 23, If 2, Class=Audio, Driver=snd-usb-audio, 480M


echo '3-30' | sudo tee /sys/bus/usb/drivers/usb/bind