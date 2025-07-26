df -h

read -p "Press any key..."

echo "This option removes libs and packages that were installed automatically to satisfy the dependencies of an installed package. If that package is removed, these automatically installed packages are useless in the system. It also removes old Linux kernels that were installed from automatically in the system upgrade."
sudo apt-get autoremove -y

echo ""
echo "Either remove only the outdated packages, like those superseded by a recent update, making them completely unnecessary."
sudo apt-get autoclean

echo ""
echo "Or delete apt cache in its entirety (frees more disk space):"
sudo apt-get clean

echo ""
echo "Every Linux distribution has a logging mechanism that help you investigate what’s going on your system. You’ll have kernel logging data, system log messages, standard output and errors for various services in Ubuntu. The problem is that over the time, these logs take a considerable amount of disk space. You can check the log size with this command"
journalctl --disk-usage

echo ""
echo "Now, there are ways to clean systemd journal logs. The easiest for you is to clear the logs that are older than a certain days."
du -hc --max-depth=0 /var/log/journal
sudo journalctl --vacuum-time=3d

echo ""
#-f, --force     Ignore nonexistant files, and never prompt before removing.
#-r, -R, --recursive     Remove directories and their contents recursively.
du -hc --max-depth=0 ~/.local/share/Trash/
rm -rf ~/.local/share/Trash/*

echo ""
du -hc --max-depth=0 /mnt/.Trash-1000/
rm -rf /mnt/.Trash-1000/*

#echo ""
#rm -rf ~/.config/chromium/Default/Preferences
#rm -rf ~/.config/chromium/Local State

#du -hc --max-depth=0 ~/.cache/
echo ""
du -hc --max-depth=1 ~/.cache/

#echo rm -rfvi ~/.cache/!(JetBrains)
#rm -rf ~/.cache/!(JetBrains)
#rm -rf ~/.cache/!\(JetBrains\)
#rm -rf ~/.cache/!\\(JetBrains\\)
#rm -rf ~/.cache/\!\(JetBrains\)
#rm -rf '~/.cache/!(JetBrains)'
#rm -rf "~/.cache/!(JetBrains)"
#rm -rf ~/.cache/'!(JetBrains)'
#rm -rf ~/.cache/!(JetBrains)
#rm -rf ~/.cache/!("JetBrains")
#rm -rf "~/.cache/"!(JetBrains)
#rmdir -rf ~/.cache/!(JetBrains)

read -p "Clean system cache? (y/n)" cleanCache
if [ $cleanCache =  "y" ]
then
	echo "Yes, clean system cache"

	read -p "Keep JetBrains? (y/n)" keepJetbrainCache
	if [ $keepJetbrainCache =  "y" ]
	then
		echo "keep JetBrains"
		###find ~/.cache/ -not -path "*JetBrains*" -type d -delete
		find ~/.cache/* -not -path "*JetBrains*" -type d -exec rm -rf {} + 
	else
		echo "clean all system cache"
		rm -rf ~/.cache/*
	fi

else
	echo "No, keep system cache"
fi

echo ""
echo "Gradle cache"
du -hc --max-depth=1 ~/.gradle/caches/
read -p "Remove GRADLE cache? (y/n) " cleanGradleCache
if [ $cleanGradleCache =  "y" ]
then
	echo "Yes, clean gradle"
	rm -rf ~/.gradle/caches/*
else
	echo "No, skip gradle cache cleaning"
fi

echo ""
echo "Maven cache"
du -hc --max-depth=1 ~/.m2/
read -p "Remove Maven cache? (y/n) " cleanMavenCache
if [ $cleanMavenCache =  "y" ]
then
	echo "Yes, clean maven"
	rm -rf ~/.m2/*
else
	echo "No, skip maven cache cleaning"
fi



#echo ""
#echo "chromium"
#du -hc --max-depth=0 ~/.cache/chromium/
#rm -rf ~/.cache/chromium

#echo ""
#echo "chromium snap"
#du -hc --max-depth=0 ~/snap/chromium/common/.cache/chromium/
#rm -rf ~/snap/chromium/common/.cache/chromium

echo ""
echo ".thumbnails"
du -hc --max-depth=0 ~/.thumbnails/
rm -rf ~/.thumbnails

echo ""
echo "TelegramDesktop cache"
du -hc --max-depth=0 ~/.local/share/TelegramDesktop/tdata/user_data/cache/
rm -rf ~/.local/share/TelegramDesktop/tdata/user_data/cache

echo ""
echo "TelegramDesktop media cache"
du -hc --max-depth=0 ~/.local/share/TelegramDesktop/tdata/user_data/media_cache/
rm -rf ~/.local/share/TelegramDesktop/tdata/user_data/media_cache

echo ""
df -h
