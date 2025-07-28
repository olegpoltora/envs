# Migration encfs to gocryptfs

sudo apt install -y gocryptfs


## poltora
#location="/mnt/poltora"
location="/mnt/backup"

### encfs

echo encfs ${location}/.priv.sec ${location}/.priv
encfs ${location}/.priv.sec ${location}/.priv

echo "ls -la ${location}/.priv"
ls -la ${location}/.priv
read -p "..."

### gocryptfs

mkdir ${location}/.priv-go
mkdir ${location}/.priv-go.sec
gocryptfs -init ${location}/.priv-go.sec
gocryptfs ${location}/.priv-go.sec ${location}/.priv-go

echo "ls -la ${location}/.priv-go"
ls -la ${location}/.priv-go
read -p "..."

### copy

echo cp -a ${location}/.priv/ ${location}/.priv-go/
read -p "..."
cp -a ${location}/.priv/* ${location}/.priv-go/

echo "ls -la ${location}/.priv-go"
ls -la ${location}/.priv-go
read -p "..."

echo fusermount -u ${location}/.priv
fusermount -u ${location}/.priv
echo fusermount -u ${location}/.priv-go
fusermount -u ${location}/.priv-go

echo mv ${location}/.priv.sec ${location}/.priv-encfs.sec
mv ${location}/.priv.sec ${location}/.priv-encfs.sec

echo mv ${location}/.priv-go.sec ${location}/.priv.sec
mv ${location}/.priv-go.sec ${location}/.priv.sec

df -h

#sudo apt-get remove -y encfs 