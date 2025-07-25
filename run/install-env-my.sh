# My environment

#sudo add-apt-repository universe
#sudo apt-get update

## ~~JRE~~

#sudo apt install -y default-jre

#java -version

## ~~Lightread~~

#sudo add-apt-repository ppa:cooperjona/lightread

#sudo apt-get update && sudo apt-get install lightread

## ~~aws~~

#sudo apt-get install -y s3cmd


# Settings

read -p "Now setting configuration…(Crtl-C or ENTER)"

## backup

sudo mkdir /mnt/backup/
sudo chown poltora:poltora /mnt/backup/
mkdir /mnt/backup/test
echo "ls -la /mnt/backup"
ls -la /mnt/backup
#read -p "…"

## backup-priv

mkdir /mnt/backup/.priv
mkdir /mnt/backup/.priv-go.sec
gocryptfs /mnt/backup/.priv-go.sec /backup/.priv

echo "ls -la /mnt/backup/.priv"
ls -la /mnt/backup/.priv
#read -p "..."
