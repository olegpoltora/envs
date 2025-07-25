# Work environment

#sudo add-apt-repository universe
#sudo apt-get update

## rename

sudo apt install -y rename

### ~~Command-line JSON processor (gitlab api)~~

#sudo apt-get install -y jq

## postman

sudo snap install postman

## curl

sudo apt install -y curl

## FTP

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

#sudo service vsftpd status

#how to restore original conf file? remove with --purge and install again

## ~~VPN~~

#sudo apt install -y openconnect

### ~~globalprotect-openconnect~~

#http://system-administrator.pages.cs.sun.ac.za/globalprotect-openconnect/#globalprotect-openconnect-ubuntu-2004-and-2204

#sudo add-apt-repository -y ppa:yuezk/globalprotect-openconnect
#sudo apt-get update
#sudo apt install -y globalprotect-openconnect

## ~~RDP~~

### ~~remmina~~

#sudo apt install -y remmina remmina-plugin-vnc

##sudo snap install remmina

# Configuration

#read -p "Now setting configuration…(Crtl-C or ENTER)"

## Dev util

# shellcheck disable=SC2016
grep -qxF 'export PATH=$PATH:/mnt/poltora/Documents/utils/' ~/.bashrc || echo 'export PATH=$PATH:/mnt/poltora/Documents/utils/' >> ~/.bashrc
grep -qxF 'export PATH=$PATH:/mnt/poltora/Documents/utils/' ~/.profile || echo 'export PATH=$PATH:/mnt/poltora/Documents/utils/' >> ~/.profile

## backup

sudo mkdir -p /media/poltora/work-backup/
sudo chown poltora:poltora /media/poltora/work-backup/
echo "ls -la /media/poltora/work-backup/"
ls -la /media/poltora/work-backup/
#read -p "…"


## backup-priv

mkdir -p /media/poltora/work-backup/.priv
mkdir -p /media/poltora/work-backup/.priv.sec
gocryptfs -init /media/poltora/work-backup/.priv.sec
gocryptfs /media/poltora/work-backup/.priv.sec /media/poltora/work-backup/.priv

echo "ls -la /media/poltora/work-backup/.priv"
ls -la /media/poltora/work-backup/.priv
#read -p "..."

