#!/bin/bash

repoInit(){
  local branch=$1

  sudo apt-get update
  sudo apt-get install -y git

  git clone https://github.com/olegpoltora/envs.git || {
      echo "Ошибка клонирования репозитория"
      exit 1
  }

  if [ "$branch" != "" ]; then
    echo "Смена ветки на $branch"
    cd ./envs || {
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

repoUpdate(){
  cd ./envs || {
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
  fi
  git pull --rebase
  cd ../
}

main(){
  local branch=$1

  if [ -d "./envs/.git" ]; then
    echo "git репозиторий существует"
    repoUpdate
  else
    echo "git репозиторий НЕ существует, инициализируем"
    repoInit "$branch"
  fi

  cd ./envs || {
      echo "Ошибка при смене папки"
      exit 1
  }

  source "./run/update.sh" || {
      echo "Ошибка выполнения update.sh"
      exit 1
  }
}

branch=$1
main "$branch"
