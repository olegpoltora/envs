#sudo dmidecode | less

#echo "==============================System Information=============================="
#uname -v
#uname -n
uname -a
lsb_release -a
#echo "System serial number"
#sudo dmidecode -s system-serial-number
#echo "bios-vendor"
#sudo dmidecode -s bios-vendor
#echo "bios-version"
#sudo dmidecode -s bios-version

#sudo dmidecode |grep -E "system-serial-number|bios-vendor|bios-version"
#sudo dmidecode |grep system-serial-number

#read -p "==============================CPU=============================="
#lscpu

#read -p "==============================Hardware=============================="
#lshw

#read -p "==============================Block Device Information=============================="
#lsblk

#read -p "==============================USB Controller=============================="
#lsusb

#read -p "==============================PCI Devices=============================="
#lspci -v