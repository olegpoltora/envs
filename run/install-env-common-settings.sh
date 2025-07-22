# Common environment

#DIR="$(cd "$(dirname "$0")" && pwd)"
DIRS="$(dirname "$(readlink -f "$0")")"
RUT="$(echo $DIRS | sed 's/\(\/backup\).*/\1/g')"

#echo $DIR
#echo $DIRS
#echo $RUT

shopt -s nullglob # Sets nullglob
shopt -s nocaseglob # Sets nocaseglob

CURRENTDATE=`date +"%Y-%m-%d %T"`

## Common utils

echo "export PATH=\$PATH:/mnt/poltora/utils/" >> ~/.bashrc
echo "export PATH=\$PATH:/mnt/poltora/utils/" >> ~/.profile

# Settings

read -p "Used backup file path: $RUT... (Crtl-C or ENTER)"

## back in time

mkdir -p ~/.config/backintime/
cp -rf ~/.config/backintime ~/.config/backintime.backup-"${CURRENTDATE}"
cp -rf $RUT/../config ~/.config/backintime/config

## xubuntu

mkdir -p ~/.config/xfce4/
cp -rf ~/.config/xfce4 ~/.config/xfce4.backup-"${CURRENTDATE}"
cp -rf $RUT/home/poltora/.config/xfce4/* ~/.config/xfce4/

## ftp client (gigolo)

mkdir -p ~/.config/gigolo/
cp -rf ~/.config/gigolo ~/.config/gigolo.backup-"${CURRENTDATE}"
cp -rf $RUT/home/poltora/.config/gigolo/bookmarks ~/.config/gigolo/

## midnight commander

mkdir -p ~/.config/mc/
cp -rf ~/.config/mc ~/.config/mc.backup-"${CURRENTDATE}"
cp -rf $RUT/home/poltora/.config/mc/hotlist ~/.config/mc/

echo export HISTCONTROL=ignoreboth:erasedups >> ~/.bashrc

## typora

mkdir -p ~/.config/Typora/conf
cp -rf ~/.config/Typora/conf ~/.config/Typora/conf.backup-"${CURRENTDATE}"
cp -rf $RUT/home/poltora/.config/Typora/conf ~/.config/Typora/
cp -rf ~/.config/Typora/profile.data ~/.config/Typora/profile.data.backup-"${CURRENTDATE}"
cp -rf $RUT/home/poltora/.config/Typora/profile.data ~/.config/Typora/

## libre office

mkdir -p ~/.config/libreoffice/4/user
cp -rf ~/.config/libreoffice/4/user ~/.config/libreoffice/4/user.backup-"${CURRENTDATE}"
cp -rf $RUT/home/poltora/.config/libreoffice/4/user/registrymodifications.xcu ~/.config/libreoffice/4/user/registrymodifications.xcu 

## convert jpg to pdf

sudo sed -i  's|<policy domain="coder" rights="none" pattern="PDF" />|<!-- <policy domain="coder" rights="none" pattern="PDF"/> -->|' /etc/ImageMagick-6/policy.xml


shopt -u nocaseglob # Unsets nocaseglob
shopt -u nullglob # Unsets nullglob



