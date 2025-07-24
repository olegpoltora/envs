read -p "Продолжить выполнение ${BASH_SOURCE[0]}? (y/n): " answer

if ! [[ "$answer" =~ ^[YyДд] ]]; then
    echo "Вы выбрали НЕТ. Выход..."
    return
fi


echo "Вы выбрали ДА. Выполняем действие..."

# Media environment

#sudo add-apt-repository universe
sudo apt-get update

## System

sudo apt-get install -y xubuntu-restricted-extras 

#exfat-fuse exfat-utils

### ftp

sudo apt-get install -y vsftpd

## Media soft

### Torrent

sudo apt install -y qbittorrent
#sudo apt-get install -y qbittorrent

#sudo apt-get install -y deluge

### vlc

#sudo snap install vlc

sudo apt install -y vlc
