# Common environment

#sudo add-apt-repository universe
sudo apt-get update

## file navigator

sudo apt-get install -y mc  

## backup

sudo apt-get install -y backintime-qt4 meld 

### ==check media==

#sudo fsck -f /dev/sda1

## soft manipulate

sudo apt-get install -y synaptic 

#sudo apt-get install -y hardinfo

#sudo apt-get install -y exfat-fuse exfat-utils 

## disk manipulate

sudo apt-get install -y gparted

## Startup disk creator

sudo apt-get install -y usb-creator-gtk

## Folder info

sudo apt-get install -y baobab

## Typora (markdown editor)

#sudo dpkg -i ./typora_1.2.4_amd64.deb
#sudo dpkg -i /media/poltora/Terra/backintime/soft/poltora/1/last_snapshot/backup/mnt/poltora/Soft/install/typora_1.2.4_amd64.deb

wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository -y 'deb https://typora.io/linux ./'
sudo apt-get update
sudo apt-get install typora -y

## Office

#sudo apt-get install libreoffice-impress -y

sudo apt install -y gedit

## ~~freemind~~

#freemind через снеп - гавно. Запускаю .sh

#sudo apt-get install -y freemind

## ~~grsync~~

#sudo apt install -y grsync

## ~~Self performance~~

#pomodorro

#sudo snap install pomatez

#sudo apt install -y xfce4-time-out-plugin

## Imagemagick

sudo apt install imagemagick -y 

# Configuration

read -p "Now setting configuration…(Crtl-C or ENTER)"

## Common utils

read -p "Common utils…(Crtl-C or ENTER)"

echo "export PATH=\$PATH:/mnt/poltora/utils/" >> ~/.bashrc
echo "export PATH=\$PATH:/mnt/poltora/utils/" >> ~/.profile

## Zoom desktop

xfconf-query --set false --channel xfwm4 --property /general/zoom_desktop

