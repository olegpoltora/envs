# Docker at Development environment

#sudo add-apt-repository universe
sudo apt-get update

## Docker

### ~~Uninstall old versions~~

#sudo apt-get remove docker docker-engine docker.io containerd runc

### Update the `apt` package index and install packages to allow `apt` to use a repository over HTTPS:

sudo apt-get install -y ca-certificates curl gnupg 

#\lsb-release

### Add Docker’s official GPG key

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

#1

#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#2

#sudo mkdir -p /etc/apt/keyrings

#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

### set up the repository

#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

### Install Docker Engine

#sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

### Verify that the Docker Engine installation is successful by running the hello-world image:

sudo docker run hello-world

# Configuration

read -p "Now setting configuration…(Crtl-C or ENTER)"

## Docker

### Бакап конфигурации

#sudo systemctl disable --now docker.service docker.socket

#sudo service docker stop

sudo systemctl stop docker && sudo systemctl stop docker.socket

#sudo systemctl stop docker.service && sudo systemctl stop docker.socket && sudo systemctl stop containerd

sudo cp /lib/systemd/system/docker.service /lib/systemd/system/docker.service.back-$(date +"%Y-%m-%d-%H-%M-%S")

ls -l /lib/systemd/system/|grep docker

sudo cp /etc/docker/daemon.json /etc/docker/daemon.json.back-$(date +"%Y-%m-%d-%H-%M-%S")

ls -l /etc/docker/|grep json

### tcp + location + json + ==non TLS==

#sudo cp /lib/systemd/system/docker.service.back-1682522949 /lib/systemd/system/docker.service

sudo sed -i  's|ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock|ExecStart=/usr/bin/dockerd|' /lib/systemd/system/docker.service

cat /lib/systemd/system/docker.service | grep ExecStart

sudo mkdir -p /mnt/poltora/docker

sudo rsync -aqxP /var/lib/docker/ /mnt/poltora/docker

echo '{
  "hosts": ["unix:///var/run/docker.sock", "tcp://127.0.0.1:2376"],
  "data-root": "/mnt/poltora/docker"
}
' | sudo tee /etc/docker/daemon.json
cat /etc/docker/daemon.json

#sudo systemctl disable docker

#sudo service docker stop

### Проверка

sudo systemctl daemon-reload

sudo service docker start

service docker status

#systemctl is-active docker

#sudo systemctl restart docker.service

#sudo netstat -lntp | grep dockerd

ps aux | grep -i docker | grep -v grep

sudo docker info | grep "Docker Root Dir"

sudo docker info -f '{{ .DockerRootDir}}'

sudo du -hc --max-depth=0 /mnt/poltora/docker

sudo du -hc --max-depth=0 /var/lib/docker/

#docker -H tcp://0.0.0.0:2376 info -f '{{ .DockerRootDir}}'
