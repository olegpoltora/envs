# My environment

sudo add-apt-repository universe
sudo apt-get update

## Common soft
### encfs (asks license)
sudo apt-get install -y encfs 

## ~~aws~~

#sudo apt-get install -y s3cmd

# Settings


## encfs

mkdir /mnt/poltora/.priv
mkdir /mnt/poltora/.priv.sec
encfs /mnt/poltora/.priv.sec /mnt/poltora/.priv



