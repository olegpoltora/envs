### Перезапуск light-locker при выходе из сна

echo '[Unit]
Description=Force screen lock after suspend
After=suspend.target sleep.target hibernate.target hybrid-sleep.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c "sleep 5 && su poltora -c 'DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus xflock4'"
RemainAfterExit=yes

[Install]
WantedBy=suspend.target sleep.target hibernate.target hybrid-sleep.target
'| sudo tee /etc/systemd/system/unlock-fix.service > /dev/null


cat /etc/systemd/system/unlock-fix.service

sudo systemctl daemon-reload
sudo systemctl enable unlock-fix.service
sudo systemctl restart unlock-fix.service
