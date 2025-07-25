du -hc --max-depth=0 /media/poltora/Terra/.backup/backintime/my/poltora/1/*

du -hc --max-depth=0 /media/poltora/Terra/.backup/backintime/soft/poltora/1/*

du -hc --max-depth=0 /media/poltora/Terra/.backup/backintime/install/poltora/1/*

du -hc --max-depth=0 /media/poltora/Terra/.backup/backintime/temp/poltora/1/*


echo ""

encfs /media/poltora/Terra/.i7-com-priv /media/poltora/Terra/.i7-com

du -hc --max-depth=0 /media/poltora/Terra/.i7-com/backintime/poltora-i7-com/poltora/5/*

fusermount -u /media/poltora/Terra/.i7-com


