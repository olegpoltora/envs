### Перезапуск light-locker при выходе из сна

echo '#!/bin/bash
case $1 in
    post)
        pkill light-locker
        sleep 2
        light-locker &
        ;;
esac
'| sudo tee /lib/systemd/system-sleep/light-locker-fix.sh > /dev/null

sudo chmod +x /lib/systemd/system-sleep/light-locker-fix.sh

