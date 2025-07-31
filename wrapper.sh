#!/bin/bash

projectDir=$(d=$(dirname "$(realpath "$0")"); while [[ "$d" != "/" && $(basename "$d") != "envs" ]]; do d=$(dirname "$d"); done; [[ $(basename "$d") == "envs" ]] && echo "$d" || echo "$(dirname "$(realpath "$0")")/envs")


gitInit(){
  sudo apt-get update
  sudo apt-get install -y git
}

repoInit(){
  local branch=$1
  local ssh=$2

  if [[ $ssh == true ]];then
    git clone git@github.com:olegpoltora/envs.git || {
        echo "Ошибка клонирования репозитория по ssh"
        exit 1
    }
  else
    git clone https://github.com/olegpoltora/envs.git || {
        echo "Ошибка клонирования репозитория по https"
        exit 1
    }
  fi

  if [ "$branch" != "" ]; then
    echo "Смена ветки на $branch"
    cd "$projectDir" || {
        echo "Ошибка при смене папки"
        exit 1
    }
    git checkout "$branch" || {
      echo "Ошибка при смене ветки"
      exit 1
    }
    cd ../
  else
    echo "Работаем с главной веткой"
  fi
}

# Функция для обработки ошибки при наличии несохранённых изменений
handleError() {
  echo "Сохранение локальных изменений в stash..."
  git stash
  if git pull --rebase; then
    echo "Rebase выполнен успешно после сохранения изменений"

    echo "Возвращаем сохранённые изменения обратно"
    git stash pop

    echo "Локальные изменения:"
    git diff

    read -p "Закомитить и пушнуть с комментарием? (y/N)" isPush
    if [[ $isPush == "y" ]];then
      read -p "Введите комментарий..." comment
      git add --update
      git commit -m "$comment"
      git push
    fi
  else
    echo "Не удалось выполнить rebase"
    exit 1
  fi
}

repoUpdate(){
  local branch=$1

  cd "$projectDir" || {
      echo "Ошибка при смене папки"
      exit 1
  }

  if [ "$branch" != "" ]; then
    echo "Смена ветки на $branch"
    git fetch
    git checkout "$branch" || {
      echo "Ошибка при смене ветки. Убедитесь, что ветка была запушена или репозиторий был склонирован (установлен upstream)"
      exit 1
    }
  else
    echo "Работаем с главной веткой"
    git fetch
    git checkout "main" || {
      echo "Ошибка при смене ветки. Убедитесь, что ветка была запушена или репозиторий был склонирован (установлен upstream)"
      exit 1
    }
  fi

  # Проверяем, есть ли несохранённые изменения (в рабочей директории или индексе)
  if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "Обнаружены несохранённые изменения"
    handleError
  else
    echo "Нет несохранённых изменений, забираем..."
    if ! git pull --rebase; then
        echo "Ошибка rebase, не связанная с несохранёнными изменениями"
        exit 1
    fi
    echo "Pull с rebase выполнен успешно"
  fi
  cd ../
}

configSsh(){
  source "$projectDir/utils/ssh-create.sh" || {
      echo "Ошибка выполнения $projectDir/utils/ssh-create.sh"
      exit 1
  }
  echo "После конфигурирования ssh с github, меняем репозиторий на ssh"
  cd "$projectDir" || {
      echo "Ошибка при смене папки"
      exit 1
  }

  git remote set-url origin git@github.com:olegpoltora/envs.git

  cd ../
}

function gitRepoProtocol() {
  # Проверяем, что мы вообще в git-репозитории
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      echo "Error: Not a git repository" >&2
      return 1
  fi

  # Получаем URL origin
  local repoUrl
  repoUrl=$(git config --get remote.origin.url 2>/dev/null)

  # Если нет remote origin
  if [[ -z "$repoUrl" ]]; then
      echo "No remote 'origin' configured" >&2
      return 2
  fi

  # Определяем тип протокола
  case "$repoUrl" in
      http://*|https://*)
          echo "https"
          return 0
          ;;
      git@*|ssh://*)
          echo "ssh"
          return 0
          ;;
      *)
          echo "unknown"
          return 3
          ;;
  esac
}

credential(){
  cd "$projectDir" || {
      echo "Ошибка при смене папки"
      exit 1
  }

  git config user.email "oleg.poltoratskii@gmail.com"
  git config user.name "Oleg Poltoratskii"

  cd ../
}

updateWrapper(){
  # Копируем новый wrapper.sh во временный файл
  # Атомарно заменяем старый wrapper.sh (mv безопасен даже при выполнении)
  cp --preserve=timestamps "$projectDir"/wrapper.sh "$projectDir"/../wrapper.sh.tmp
  mv "$projectDir"/../wrapper.sh.tmp "$projectDir"/../wrapper.sh
}

main(){
  local branch=$1

  if [ -d "$projectDir/.git" ]; then
    echo "git репозиторий существует"
    repoUpdate "$branch"

    # todo проверять на наличие записей в ~/.ssh/config о репозитории
    if ! grep -q "github.com" "$HOME/.ssh/config"; then
      echo "ssh не сконфигурирован с github, конфигурируем..."
      configSsh
    else
      echo "ssh сконфинурирован с github"
    fi

  else
    echo "git репозиторий НЕ существует, инициализируем"
    gitInit

    if ! grep -q "github.com" "$HOME/.ssh/config"; then
      echo "ssh не сконфигурирован с github..."
      echo "Сначала попытаемся забрать ./utils/ssh-create.sh по https..."

      repoInit "$branch" false
      configSsh
    else
      echo "ssh сконфинурирован с github"
      repoInit "$branch" true
    fi
  fi

#  if [[ $(gitRepoProtocol) == "https" ]]; then
#      echo "Переключаем на SSH..."
#      git remote set-url origin git@github.com:olegpoltora/envs.git
#  fi

  credential

  updateWrapper
}

run(){
    source "$projectDir/run/update.sh" || {
        echo "Ошибка выполнения update.sh"
        exit 1
    }
}

branch=$1
skipRun=${2:-false}
main "$branch"
if [[ $skipRun != "true" ]]; then
  run
else
  echo "Пропускаем run"
fi