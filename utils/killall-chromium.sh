#killall /usr/lib/chromium-browser/chromium-browser

ps -aux|grep chromium

kill -9 $(ps -aux|grep chromium-browser | awk '{print $2}')

ps -aux|grep chromium
