# Work environment

#sudo add-apt-repository universe
sudo apt-get update

## curl

sudo apt install -y curl

## FTP

sudo apt-get install -y vsftpd

sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.back-$(date +"%Y-%m-%d-%H-%M-%S")

sudo sed -i  's|#write_enable=YES|write_enable=YES|' /etc/vsftpd.conf

echo 'mdtm_write=YES
' | sudo tee -a /etc/vsftpd.conf

cat /etc/vsftpd.conf | grep mdtm

sudo service vsftpd restart

sudo service vsftpd status

#how to restore original conf file? remove with --purge and install again

## VPN

sudo apt install -y openconnect

### globalprotect-openconnect ==!==

#http://system-administrator.pages.cs.sun.ac.za/globalprotect-openconnect/#globalprotect-openconnect-ubuntu-2004-and-2204

sudo add-apt-repository -y ppa:yuezk/globalprotect-openconnect
sudo apt-get update
sudo apt install -y globalprotect-openconnect

## ~~RDP~~

### ~~remmina~~

#sudo apt install -y remmina remmina-plugin-vnc

##sudo snap install remmina

# Configuration

read -p "Now setting configuration…(Crtl-C or ENTER)"

## Dev util

echo "export PATH=\$PATH:/mnt/poltora/Documents/utils/" >> ~/.bashrc
echo "export PATH=\$PATH:/mnt/poltora/Documents/utils/" >> ~/.profile
