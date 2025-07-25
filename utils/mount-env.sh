df -h

if [ -f /mnt/poltora/.priv.sec/.encfs6.xml ]; then
  encryptProvider=encfs
else
  encryptProvider=gocrypt
fi

echo "ls -la /mnt/poltora/.priv"
ls -la /mnt/poltora/.priv

read -p "Mount?…(y/N)" is_mount
if [[ $is_mount == "y" ]]
then
	echo encfs /mnt/poltora/.priv.sec /mnt/poltora/.priv
  if [[ $encryptProvider == "encfs" ]]
  then
  	encfs /mnt/poltora/.priv.sec /mnt/poltora/.priv
  elif [[ $encryptProvider == "gocrypt" ]]
  	gocrypt /mnt/poltora/.priv.sec /mnt/poltora/.priv
  fi
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
read -p "Mount?…(y/N)" is_mount
if [[ $is_mount == "y" ]]
then
	echo encfs $LOCATION/.priv.sec $LOCATION/.priv
  if [[ $encryptProvider == "encfs" ]]
  then
  	encfs $LOCATION/.priv.sec $LOCATION/.priv
  elif [[ $encryptProvider == "gocrypt" ]]
  	gocrypt $LOCATION/.priv.sec $LOCATION/.priv
  fi

	echo "ls -la $LOCATION/.priv"
	ls -la $LOCATION/.priv
	read -p "..."
fi


echo ""
df -h
