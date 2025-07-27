#read -p "Продолжить выполнение ${BASH_SOURCE[0]}? (y/n): " answer
#if ! [[ "$answer" =~ ^[YyДд] ]]; then
#    echo "Вы выбрали НЕТ. Выход..."
#    return
#fi
#echo "Вы выбрали ДА. Выполняем действие..."

# Media environment

#sudo add-apt-repository universe
#sudo apt-get update

## System

sudo apt-get install -y xubuntu-restricted-extras 

#exfat-fuse exfat-utils

### ftp

sudo apt-get install -y vsftpd

if [ -f /etc/vsftpd.conf ]; then
  sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.backup-$(date +"%Y-%m-%d-%H-%M-%S")
  sudo sed -i  's|#write_enable=YES|write_enable=YES|' /etc/vsftpd.conf
  if ! grep -q "mdtm_write=YES" "/etc/vsftpd.conf"; then
    printf 'mdtm_write=YES\n' | sudo tee -a /etc/vsftpd.conf
  fi
  grep --color=auto "mdtm" /etc/vsftpd.conf
  sudo service vsftpd restart
fi


sudo service vsftpd status

#how to restore original conf file? remove with --purge and install again

## Media soft

### Torrent

#sudo apt install -y qbittorrent
#sudo apt-get install -y qbittorrent

#sudo apt-get install -y deluge

### vlc

#sudo snap install vlc

sudo apt install -y vlc

### acestreamplayer

#sudo apt install -y acestreamplayer

sudo snap install acestreamplayer

# Media Environment settings

## transmission

#sed -i  's|"preallocation": 1|"preallocation": 2|' /home/poltora/.config/transmission/settings.json

#if [ -f /home/poltora/.config/transmission/settings.json ]; then
#    sed -i  's|"queue-stalled-minutes": 30|"queue-stalled-minutes": 3|' /home/poltora/.config/transmission/settings.json || {
#        echo "Ошибка при выполнении!"
#    }
#fi


