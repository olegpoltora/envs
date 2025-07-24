read -p "Продолжить выполнение ${BASH_SOURCE[0]}? (y/n): " answer

if ! [[ "$answer" =~ ^[YyДд] ]]; then
    echo "Вы выбрали НЕТ. Выход..."
    return
fi


echo "Вы выбрали ДА. Выполняем действие..."

# Common environment

#sudo add-apt-repository universe
sudo apt-get update

## ~~encfs (notification)~~

#sudo apt-get install -y encfs 

## gocryptfs

sudo apt install -y gocryptfs

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

## Typora

#sudo dpkg -i ./typora_1.2.4_amd64.deb
#sudo dpkg -i /media/poltora/Terra/backintime/soft/poltora/1/last_snapshot/backup/mnt/poltora/Soft/install/typora_1.2.4_amd64.deb

#typora + docker installation (apt-key is deprecated)
#wget https://typora.io/linux/public-key.asc | sudo gpg --dearmor > /usr/share/keyrings/typora.gpg
#echo "deb [arch=amd64 signed-by=/usr/share/keyrings/typora.gpg] https://typora.io/linux ./" | sudo tee /etc/apt/sources.list.d/typora.list > /dev/null

#wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
#sudo add-apt-repository 'deb https://typora.io/linux ./'

#sudo apt-get update
#sudo apt-get install typora -y

sudo snap install typora

## Office

#sudo apt-get install libreoffice-impress -y

sudo apt install -y gedit

## Pdf search

sudo apt install -y pdfgrep

## ~~freemind~~

#freemind через снеп - гавно. Запускаю .sh

#sudo apt-get install -y freemind

## ~~aws~~

#sudo apt-get install -y s3cmd

## image-magic for convert

sudo apt install -y graphicsmagick-imagemagick-compat

## ~~curlftpfs (монтирование ftp)~~

#sudo apt install -y curlftpfs

#mkdir -p ~/ftp_mount

## ~~grsync~~

#sudo apt install -y grsync

## ~~Self performance~~

#pomodorro

#sudo snap install pomatez

#sudo apt install -y xfce4-time-out-plugin

## ~~Imagemagick~~

#sudo apt install imagemagick -y 

# Configuration

#read -p "Now setting configuration…(Crtl-C or ENTER)"

## Common utils

#read -p "Common utils…(Crtl-C or ENTER)"

echo "export PATH=\$PATH:/mnt/poltora/utils/" >> ~/.bashrc
echo "export PATH=\$PATH:/mnt/poltora/utils/" >> ~/.profile

## ~~Zoom desktop~~

#xfconf-query --set false --channel xfwm4 --property /general/zoom_desktop

## mnt

sudo mkdir /mnt/poltora/
sudo chown poltora:poltora /mnt/poltora/
mkdir /mnt/poltora/test
echo "ls -la /mnt/poltora"
ls -la /mnt/poltora
read -p "…"

## backup (waiting for devices for all pc…)

#sudo mkdir /mnt/backup/
#sudo chown poltora:poltora /mnt/backup/
#mkdir /mnt/backup/test
#echo "ls -la /mnt/backup"
#ls -la /mnt/backup
#read -p "…"

## priv

mkdir /mnt/poltora/.priv
mkdir /mnt/poltora/.priv.sec
gocryptfs -init /mnt/poltora/.priv.sec
gocryptfs /mnt/poltora/.priv.sec /mnt/poltora/.priv
#encfs /mnt/poltora/.priv.sec /mnt/poltora/.priv

echo "ls -la /mnt/poltora/.priv"
ls -la /mnt/poltora/.priv
read -p "..."


