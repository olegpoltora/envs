ps -aux|grep backintime | grep backup-job 
kill $(ps aux | grep '[b]ackintime' | awk '{print $2}')
ps -aux|grep backintime | grep backup-job 

ps -aux|grep rsync
#sudo killall rsync
#killall rsync

ps -aux|grep python3
#sudo killall  python3
#killall  python3

ps -aux|grep rsync
#sudo killall -9 rsync
#killall -9 rsync

#sudo killall -9 python3
#killall -9 python3

