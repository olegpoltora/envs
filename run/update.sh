#!/bin/bash

backup(){
  local location="$1"
  local fileName="$2"
  local resultFile="${location}/${fileName}"

  currentDate=$(date +"%Y-%m-%d %T")

  if [[ -e "$resultFile" && ! -L "$resultFile" && ! -d "$resultFile" ]]; then
    echo "Бекап $resultFile..."
    cp -rf "$resultFile" "${resultFile}".backup-"${currentDate}" || {
      echo "Ошибка бекапа $resultFile"
      exit 1
    }
  fi
}

createFileLink(){
  local from=$1
  local to=$2
  local fileName=$3

  local expectedTarget="$from/$fileName"
  local targetSymlink="$to/$fileName"

  if [[ -L "$targetSymlink" ]]; then
    currentTarget=$(readlink -f "$targetSymlink")

    if [[ "$currentTarget" != "$expectedTarget" ]]; then
      echo "Симлинк ведёт на '$currentTarget', ожидалось '$expectedTarget' — пересоздаём."
      rm -f "$targetSymlink"
      ln -sf "$expectedTarget" "$targetSymlink" || {
        echo "Ошибка при создании симлинка!"
        exit 1
      }
    else
      echo "Симлинк уже правильный: $targetSymlink → $expectedTarget"
    fi
  else
    mkdir -p "$(dirname "$targetSymlink")"
    ln -sf "$expectedTarget" "$targetSymlink" || {
      echo "Ошибка при создании симлинка!"
      exit 1
    }
    echo "Симлинк создан: $targetSymlink → $expectedTarget"
  fi
}

createFolderLinks(){
  local from=$1
  local to=$2

  mapfile -t files < <(find "$from" -type f)
  for file in "${files[@]}"; do
    if [ -f "$file" ]; then
      local filename=$(basename "$file")
      local dirname=$(realpath "$(dirname "$file")")

      local suffix=$(realpath --relative-to="$from" "$dirname")

      if [ "$suffix" != "." ]; then
        toSuffix=$to/$suffix
      else
        toSuffix=$to
      fi

      backup "$toSuffix" "$filename"
      createFileLink "$dirname" "$toSuffix" "$filename"
    fi
  done
}

runProfile(){
  local profileScriptName=$1

  source "./$profileScriptName" || {
    echo "Ошибка выполнения $profileScriptName"
    exit 1
  }
}

main(){
read -p "Выберите профиль (my/media/dev/work): " action

createFolderLinks "./utils" "/mnt/poltora/utils"
createFolderLinks "./config" "/home/poltora/.config"

runProfile "./run/install-env-common.sh"

#  getIfAbsentAndRun "$repoUrl" $profileLocation "install-env-common.sh"
#  getIfAbsentAndRun "$repoUrl" $runConfigLocation "imagemagick.sh"

case "$action" in
my)
  echo "My ENV..."
  runProfile "./run/install-env-my.sh"
;;
media)
  echo "Media ENV..."
  runProfile "./run/install-env-media.sh"
;;
dev)
  echo "Dev ENV..."
  runProfile "./run/install-env-dev.sh"
;;
work)
  echo "Work ENV..."
  runProfile "./run/install-env-work.sh"
;;
*)
  echo "Неизвестная команда: $action"
  exit 1
;;
esac

}

main

echo "git команды:"
echo "git status"
echo "git diff"
echo "git add ."
echo "git commit -m \"Сообщение коммита\""
echo "git push origin main"
echo "git push origin \"feature/xyz\""
