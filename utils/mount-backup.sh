read -p "External drive name?" diskName


encfs /media/poltora/$diskName/.priv.sec /media/poltora/$diskName/.priv

read -p "press any key to unmount..."

fusermount -u /media/poltora/$diskName/.priv

