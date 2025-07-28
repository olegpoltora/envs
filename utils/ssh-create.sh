deleteFile(){
  local filename=$1

  if [ -f "$filename" ]; then
    rm "$filename"
  fi
}

writeToFile(){
  local filename=$1
  local content=$2

  if [[ -f $filename ]]; then
    echo "Content of $filename"
    cat "$filename"

    read -p "Add or rewrite file '$filename'? (a/r)" prompt

    if [[ $prompt == "a" ]]; then
      echo "Add to file '$filename'..."
      echo "$content" >> ~/.ssh/config
    elif [[ $prompt == "r" ]]; then
      echo "Rewrite file '$filename'..."
      echo "$content" > ~/.ssh/config
    else
        echo "Wrong options. Exit"
        exit 1
    fi
  else
    echo "Write to new file '$filename'..."
    echo "$content" > ~/.ssh/config
  fi
}

clean(){
  local filename=$1

  deleteFile "$filename"
  deleteFile "${filename}.pub"
}

generate(){
  local filename=$1
  local user=$2
  local server=$3

  ssh-keygen -t ed25519 -a 100 -f "$filename"

  chmod 600 "$filename"
  chmod 600 "${filename}.pub"

  read -r -d '' content << EOF
Host $server
  HostName $server
  User $user
  IdentityFile $filename
EOF

  writeToFile ~/.ssh/config "$content"
  chmod 600 ~/.ssh/config

  ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts
}

log(){
  local filename=$1

  echo ls -la ~/.ssh
  ls -la ~/.ssh

  echo cat ~/.ssh/config
  cat ~/.ssh/config

  echo cat "${filename}.pub"
  cat "${filename}.pub"

  read -p "Copy to server, for example github - https://github.com/settings/ssh/new"
}

check(){
  local user=$1

  echo "Test connection to server '$server' for user '$user'..."

  echo ssh -T "$user@$server"
  if ssh -T "$user@$server" 2>&1 | grep -q "successfully authenticated"; then
      echo "SSH auth to GitHub successful."
      return 0
  else
      echo "SSH auth failed."
      return 1
  fi
}

main(){
  local filename=$1
  local user=$2
  local server=$3

  clean "$filename"
  generate "$filename" "$user" "$server"
  log "$filename"
  check "$user" "$server"
}


#git config core.sshCommand "ssh -i $filename


#ssh-keygen -y -f $filename
#cat $filename

#git fetch --all
#git remote -v
#git remote -vv
#git config --global url."git@github.com:".insteadOf "https://github.com/"

#git remote set-url origin git@github.com:user/repo.git
#git remote set-url origin https://github.com/username/repo.git


#git remote set-url origin git@github-project:user/repo.git


# Если ssh-agent уже запущен, просто подключиться:
#if [ -z "$SSH_AUTH_SOCK" ]; then
#  eval "$(ssh-agent -s)"
#  ssh-add -t 1h $filename  # Ключ удалится из памяти через 1 час
#fi

pc=$(hostname)
currentMonth=$(date +"%Y-%m")

  #_${project}   #-C "$email"
filename="$HOME/.ssh/${pc}_${currentMonth}_ed25519"

read -p "Server?" server
read -p "User (for github.com - git)?" user

main "$filename" "$user" "$server"
