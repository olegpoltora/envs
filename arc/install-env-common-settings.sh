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


# Settings

read -p "Used backup file path: $RUT... (Crtl-C or ENTER)"


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


shopt -u nocaseglob # Unsets nocaseglob
shopt -u nullglob # Unsets nullglob



