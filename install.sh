#!/bin/bash

getIfAbsentAndRun() {
  local repoUrl="$1"
  local remotePrefix=$2
  local fileName=$3

  local resultFile="./$remotePrefix/$fileName"
  local remoteFile="$repoUrl/$remotePrefix/$fileName"

  #if [ ! -f "$resultFile" ]; then
  safeDownload "./$remotePrefix" "$remotePrefix" "$fileName"
  
  chmod +x "./$resultFile" || {
      echo "Ошибка изменения прав доступа!"
      exit 1
  }
  #fi
  source "./$resultFile" || {
      echo "Ошибка выполнения $resultFile!"
      exit 1
  }
}

backupAndSafeDownload() {
  local savePath=$1
  local remotePrefix=$2
  local fileName=$3

  backup "$savePath" "$fileName"
  safeDownload "$savePath" "$remotePrefix" "$fileName"
}

backup(){
  local fileLocation="$1"
  local fileName="$2"
  local resultFile="${fileLocation}/${fileName}"

  currentDate=$(date +"%Y-%m-%d %T")

  if [ -f "$resultFile" ]; then
    echo "Бекап $resultFile..."
    cp -rf "$resultFile" "${resultFile}".backup-"${currentDate}" || {
      echo "Ошибка бекапа $fileName!"
      exit 1
    }
  fi
}

safeDownload(){
  local savePath=$1
  local remotePrefix=$2
  local fileName=$3

  local resultFile="$savePath/$fileName"
  local remoteFile="$repoUrl/$remotePrefix/$fileName"

  echo "Загрузка $remoteFile..."
  tempFile="${resultFile}.tmp"

  # Загружаем во временный файл
  dirPath=$(dirname "$tempFile")
#  echo mkdir -p $dirPath
  mkdir -p "$dirPath"
  wget -q "$remoteFile" -O "$tempFile" || {
      echo "Ошибка загрузки $remoteFile как $tempFile !"
      rm -f "$tempFile"
      exit 1
  }

  # Проверяем, что файл действительно загрузился
  if [ ! -s "$tempFile" ]; then
      echo "Ошибка: загружен пустой файл!"
      rm -f "$tempFile"
      exit 1
  fi

  # Проверяем содержимое на ошибки (например, HTML страницу 404)
  if grep -q "Error 404" "$tempFile"; then
      echo "Ошибка: файл не найден на сервере!"
      rm -f "$tempFile"
      exit 1
  fi

  # Если все проверки пройдены - перемещаем на постоянное место
  mv "$tempFile" "$resultFile" || {
    echo "Ошибка перемещения файла $tempFile в $resultFile!"
    rm -f "$tempFile"
    exit 1
  }

}

repoUrl="https://raw.githubusercontent.com/olegpoltora/envs/refs/heads/${1:-main}"
localConfig="/home/poltora/.config"

runConfigLocation="run-config"
remoteConfig="config"
profileLocation="run"

read -p "Выберите действие (common/my/media/dev/work): " action

case "$action" in
common)
  echo "Common ENV..."
  getIfAbsentAndRun "$repoUrl" $profileLocation "install-env-common.sh"

  getIfAbsentAndRun "$repoUrl" $runConfigLocation "imagemagick.sh"

  backupAndSafeDownload $localConfig $remoteConfig "backintime/config"

  backupAndSafeDownload $localConfig $remoteConfig "xfce4/panel/whiskermenu-1.rc"
  backupAndSafeDownload $localConfig $remoteConfig "xfce4/panel/screenshooter-13.rc"

  backupAndSafeDownload $localConfig $remoteConfig "xfce4/xfconf/xfce-perchannel-xml/keyboard-layout.xml"
  backupAndSafeDownload $localConfig $remoteConfig "xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml"
  backupAndSafeDownload $localConfig $remoteConfig "xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml"
  backupAndSafeDownload $localConfig $remoteConfig "xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml"
  backupAndSafeDownload $localConfig $remoteConfig "xfce4/xfconf/xfce-perchannel-xml/xfce4-taskmanager.xml"
  backupAndSafeDownload $localConfig $remoteConfig "xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml"
  backupAndSafeDownload $localConfig $remoteConfig "xfce4/xfconf/xfce-perchannel-xml/xsettings.xml"

  backupAndSafeDownload $localConfig $remoteConfig "xfce4/terminal/terminalrc"

  backupAndSafeDownload $localConfig $remoteConfig "gigolo/bookmarks"

  backupAndSafeDownload $localConfig $remoteConfig "mc/hotlist"
;;
my)
  echo "My ENV..."
  getIfAbsentAndRun "$repoUrl" $profileLocation "install-env-my.sh"
;;
media)
  echo "Media ENV..."
  getIfAbsentAndRun "$repoUrl" $profileLocation "install-env-media.sh"
  backupAndSafeDownload $localConfig $remoteConfig "transmission/settings.json"
;;
dev)
  echo "Dev ENV..."
  getIfAbsentAndRun "$repoUrl" $profileLocation "install-env-dev.sh"
;;
work)
  echo "Work ENV..."
  getIfAbsentAndRun "$repoUrl" $profileLocation "install-env-work.sh"
;;
*)
  echo "Неизвестная команда: $action"
  exit 1
;;
esac

