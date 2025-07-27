#!/bin/bash

backup(){
  local location="$1"
  local fileName="$2"

  local resultFile="${location}/${fileName}"
  local currentDate=$(date +"%Y-%m-%d %T")

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
  local profile=$1
  echo "Profile $profile"

  local profileScriptName="./profile/$profile.sh"

  source "./$profileScriptName" || {
    echo "Ошибка выполнения $profile"
    exit 1
  }
}

cleanApt(){
  sudo apt autoremove -y
}

commonProfile(){
  createFolderLinks "./utils" "/mnt/poltora/utils"
  createFolderLinks "./config" "/home/poltora/.config"

  runProfile "common"
}

profileList(){
  local path=$1
  local type=$2
  local negativeFilter=$3
  local joinStr=$4

  local result=$(find "$path/" -maxdepth 1 -type f -name "*.$type" | sed 's|.*/||; s/\.[^.]*$//' | grep -v "$negativeFilter" | paste -sd "$4")
  echo "$result"
}

main(){
#  local profilesString=$(profileList "../profile" "sh" "common" "/")
  local profilesString=$(profileList "./profile" "sh" "common" "/")
  read -p "Выберите профиль ($profilesString): " profile

  commonProfile

  runProfile "$profile"

  cleanApt
}

help(){
  echo ""
  echo "git команды:"
  echo "git status"
  echo "git diff"
  echo "git add ."
  echo "git commit -m \"Сообщение коммита\""
  echo "git push origin main"
  echo "git push origin \"feature/xyz\""
  echo "Config file must be changed either in repo with symlink to necessary destination, or by bash script!"
}


main
help
