# Work environment - beelink

# Configuration

read -p "Now setting configuration…(Crtl-C or ENTER)"

## Lock

echo "dbus-send --session --dest=org.freedesktop.ScreenSaver --type=method_call --print-reply /ScreenSaver org.freedesktop.ScreenSaver.Lock"  | sudo tee /usr/local/bin/xfce-lock > /dev/null 

sudo chmod +x /usr/local/bin/xfce-lock

sudo mv /usr/bin/xflock4 /usr/bin/xflock4.bak
sudo ln -s /usr/local/bin/xfce-lock /usr/bin/xflock4

#Строго говороя, после каких-то шагов заработал xflock4 и какие-то шаги оказались не нужны. Не стал менять xflock4 на xfce-lock в шорткатах клавиш.

#И хотя я добавил dbus-send, но добавил в xfce-lock, который вроде и не используется? Или неявно используется. Вобщем заработало, нейросетка опенэйай помогла.

### Перезапуск light-locker при выходе из сна

echo '[Unit]
Description=Restart light-locker after suspend
After=suspend.target sleep.target hibernate.target hybrid-sleep.target

[Service]
Type=simple
ExecStart=/bin/bash -c "sleep 2 && pkill light-locker && light-locker &"
RemainAfterExit=yes

[Install]
WantedBy=suspend.target sleep.target hibernate.target hybrid-sleep.target
'| sudo tee /etc/systemd/system/unlock-fix.service > /dev/null


cat /etc/systemd/system/unlock-fix.service

sudo systemctl daemon-reload
sudo systemctl enable unlock-fix.service
sudo systemctl restart unlock-fix.service
