#!/bin/bash

projectDir=$(d=$(dirname "$(realpath "$0")"); while [[ "$d" != "/" && $(basename "$d") != "envs" ]]; do d=$(dirname "$d"); done; [[ $(basename "$d") == "envs" ]] && echo "$d" || echo "$(dirname "$(realpath "$0")")/envs")


compareFiles(){
  local file1="$1"
  local file2="$2"

  diff -q "$file1" "$file2" > /dev/null

#  diff -q "$1" "$2" > /dev/null
#  echo $?  # явно выводим код возврата (0 или 1)

#  if diff -q "$file1" "$file2" > /dev/null; then
#      return 0
#  else
#      return 1
#  fi
}

fileList(){
  local path=$1
  local type=$2
  local positiveFilter=$3
  local negativeFilter=$4
  local reverseSorted=$5
  local maxDepth=${6:-1}  # По умолчанию 1 (без рекурсии)

  [[ ! -d "$path" ]] && { echo "Error: Directory '$path' not found" >&2; return 1; }

 local pattern="*${positiveFilter}*.${type}"
  [[ -z "$positiveFilter" ]] && pattern="*.${type}"

  if [[ -n "$negativeFilter" ]]; then
    find "$path" -maxdepth "$maxDepth" -type f -name "$pattern" | grep -v "$negativeFilter" | sort $( [[ "$reverseSorted" == "true" ]] && echo "-r" )
  else
    find "$path" -maxdepth "$maxDepth" -type f -name "$pattern" | sort $( [[ "$reverseSorted" == "true" ]] && echo "-r" )
  fi
}

newestFile(){
  local path=$1
  local type=$2
  local fileName=$3

  local files
  mapfile -t files < <(fileList "$path" "$type" "$fileName" "" "true" 1)

  if [[ ${#files[@]} -gt 0 ]]; then
    echo "${files[0]}"
  else
    echo "Error: No files found" >&2
    return 1
  fi
}

backup(){
  local location="$1"
  local fileName="$2"

  local resultFile="${location}/${fileName}"
  local currentDate=$(date +"%Y-%m-%d %T")

  if [[ -e "$resultFile" && ! -L "$resultFile" && ! -d "$resultFile" ]]; then
    file=$(newestFile "$location" "*" "$fileName")
    if [[ -n "$file" ]]; then
      echo "Новейший backup: $file"
#      needForBackup=$(compareFiles "$resultFile" "$file")
#      if [[ $needForBackup == 1 ]]; then
      if ! compareFiles "$resultFile" "$file"; then
        echo "Файлы $resultFile и $file разные, делаем бекап"
        echo "Бекап $resultFile..."
        cp -rf "$resultFile" "${resultFile}".backup-"${currentDate}" || {
          echo "Ошибка бекапа $resultFile"
          exit 1
        }
      else
        echo "Файлы $resultFile и $file одинаковые, бекап не нужен"
      fi
    else
      echo "Бекапы не найдены"
      echo "Бекап $resultFile..."
      cp -rf "$resultFile" "${resultFile}".backup-"${currentDate}" || {
        echo "Ошибка бекапа $resultFile"
        exit 1
      }
    fi
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

  local profileScriptName="$projectDir/profile/$profile.sh"

  source "$profileScriptName" || {
    echo "Ошибка выполнения $profile, file: $profileScriptName"
    exit 1
  }
}

cleanApt(){
  sudo apt autoremove -y
}

commonProfile(){
  createFolderLinks "$projectDir/utils" "/mnt/poltora/utils"
  createFolderLinks "$projectDir/config" "/home/poltora/.config"

  runProfile "common"
}

profileList(){
  local path=$1
  local type=$2
  local negativeFilter=$3
  local joinStr=$4

#  local result=$(find "$path/" -maxdepth 1 -type f -name "*.$type" | sed 's|.*/||; s/\.[^.]*$//' | grep -v "$negativeFilter" | paste -sd "$joinStr")
#  echo "$result"
  find "$path/" -maxdepth 1 -type f -name "*.$type" | sed 's|.*/||; s/\.[^.]*$//' | grep -v "$negativeFilter" | paste -sd "$joinStr"
}

main(){
  pc=$(hostname)
  local profilesString=$(profileList "$projectDir/profile" "sh" "common" "/")
  read -p "Продолжить с профилем $pc из существующих ($profilesString)? " profile

  commonProfile

  runProfile "${profile:-$pc}"

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
