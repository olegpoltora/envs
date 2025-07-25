DIR="$(dirname "$(readlink -f "$0")")"
echo $DIR

echo "ls -la $DIR/.priv"
ls -la $DIR/.priv

gocryptfs $DIR/.priv.sec $DIR/.priv

echo "ls -la $DIR/.priv"
ls -la $DIR/.priv


read -p "press any key to unmount..."

fusermount -u $DIR/.priv

