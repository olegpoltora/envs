df -h

echo "ls -la /mnt/poltora/.priv"
ls -la /mnt/poltora/.priv

read -p "Unmount?…(y/N)" is_mount
if [[ $is_mount == "y" ]]
then
	echo fusermount -u /mnt/poltora/.priv
	fusermount -u /mnt/poltora/.priv

	echo "ls -la /mnt/poltora/.priv"
	ls -la /mnt/poltora/.priv

	read -p "..."
fi


# backup

internalLocation="/mnt/backup"
externalLocation="/media/poltora/dev-backup"
#externalLocation="/media/poltora/backup/" TODO

echo ""
echo "Possible backup locations:"
# 1)
echo ""
echo "Internal)"
echo "ls -la $internalLocation"
ls -la $internalLocation

# 2)
echo ""
echo "External)"
echo "ls -la $externalLocation"
ls -la $externalLocation

echo ""
read -p "Backup location? (I)nternal/(e)xternal..." LOCATION

if [[ $LOCATION == '' || $LOCATION == 'I' ]]; then
	echo "use Internal backup location"
	LOCATION=$internalLocation
elif [[ $LOCATION == 'e' ]]; then
	echo "use External backup location"
	LOCATION=$externalLocation
fi

echo "ls -la $LOCATION/.priv"
ls -la $LOCATION/.priv
read -p "Unmount?…(y/N)" is_mount
if [[ $is_mount == "y" ]]
then
	echo fusermount -u $LOCATION/.priv
	fusermount -u $LOCATION/.priv

	echo "ls -la $LOCATION/.priv"
	ls -la $LOCATION/.priv

	read -p "..."
fi


echo ""
df -h
