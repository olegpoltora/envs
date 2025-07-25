# Development environment

#sudo add-apt-repository universe
#sudo apt-get update

##  Maven

sudo apt-get install -y maven 

## Gradle

sudo apt-get install -y gradle

## ~~ftp client~~

#sudo apt-get install -y filezilla

## Git

sudo apt-get install -y git 

##  Java

ls -la /usr/lib/jvm/ 

#sudo apt-get install -y openjdk-11-jdk openjdk-11-source 

sudo apt-get install -y openjdk-17-jdk openjdk-17-source 

#sudo update-alternatives --config java

java -version

## Servers

### postgresql

sudo apt-get install -y postgresql

### redis-server

sudo apt-get install -y redis-server 

### ~~apache kafka~~

#wget --directory-prefix=/mnt/poltora/Soft/ https://dlcdn.apache.org/kafka/3.6.0/kafka_2.13-3.6.0.tgz

#tar -xzf /mnt/poltora/Soft/kafka_2.13-3.6.0.tgz --directory=/mnt/poltora/Soft/

#cp /mnt/poltora/Soft/kafka_2.13-3.6.0/config/server.properties /mnt/poltora/Soft/kafka_2.13-3.6.0/config/server.properties.back-$(date +"%Y-%m-%d-%H-%M-%S")

#cp /mnt/poltora/Soft/kafka_2.13-3.6.0/config/zookeeper.properties /mnt/poltora/Soft/kafka_2.13-3.6.0/config/zookeeper.properties.back-$(date +"%Y-%m-%d-%H-%M-%S")

#echo "delete.topic.enable = true" >> /mnt/poltora/Soft/kafka_2.13-3.6.0/config/server.properties

#mkdir --parents /mnt/poltora/kafka

#sed -i  's|dataDir=/tmp/zookeeper|dataDir=/mnt/poltora/kafka|' /mnt/poltora/Soft/kafka_2.13-3.6.0/config/zookeeper.properties

#cat /mnt/poltora/Soft/kafka_2.13-3.6.0/config/zookeeper.properties | grep dataDir

#echo "/mnt/poltora/Soft/kafka_2.13-3.6.0/bin/zookeeper-server-start.sh /mnt/poltora/Soft/kafka_2.13-3.6.0/config/zookeeper.properties" > /mnt/poltora/Documents/utils/zookeeper-start.sh

#chmod +x /mnt/poltora/Documents/utils/zookeeper-start.sh

#echo "/mnt/poltora/Soft/kafka_2.13-3.6.0/bin/kafka-server-start.sh /mnt/poltora/Soft/kafka_2.13-3.6.0/config/server.properties" > /mnt/poltora/Documents/utils/kafka-start.sh

#chmod +x /mnt/poltora/Documents/utils/kafka-start.sh

### Confluent Kafka

wget -qO - https://packages.confluent.io/deb/7.5/archive.key | sudo apt-key add -

sudo add-apt-repository -y "deb [arch=amd64] https://packages.confluent.io/deb/7.5 stable main"
sudo add-apt-repository -y "deb https://packages.confluent.io/clients/deb $(lsb_release -cs) main"

sudo apt-get update

sudo apt-get install -y confluent-platform



#sudo cp /etc/kafka/server.properties /etc/kafka/server.properties.back-$(date +"%Y-%m-%d-%H-%M-%S")

#echo "delete.topic.enable = true" >> /etc/kafka/server.properties

#sudo sed -i  's|#listeners=PLAINTEXT://:9092|listeners=http://0.0.0.0:9092|' /etc/kafka/server.properties

#sudo cat /etc/kafka/server.properties | grep 9092



sudo cp /etc/kafka/zookeeper.properties /etc/kafka/zookeeper.properties.back-$(date +"%Y-%m-%d-%H-%M-%S")

sudo sed -i  's|#dataDir=/var/lib/zookeeper|dataDir=/mnt/poltora/zookeeper|' /etc/kafka/zookeeper.properties

sudo sed -i  's|dataDir=/mnt/poltora/kafka|dataDir=/mnt/poltora/zookeeper|' /etc/kafka/zookeeper.properties

sudo cat /etc/kafka/zookeeper.properties | grep -i dir

sudo cp -r -p /var/lib/zookeeper /mnt/poltora/zookeeper



#cp /etc/schema-registry/schema-registry.properties /etc/schema-registry/schema-registry.properties.back-$(date +"%Y-%m-%d-%H-%M-%S")

#sudo cat /etc/schema-registry/schema-registry.properties



sudo systemctl restart confluent-zookeeper

sudo systemctl status confluent-zookeeper

#journalctl -u confluent-zookeeper.service



sudo systemctl restart confluent-server

sudo systemctl status confluent-server

#journalctl -u confluent-server.service



sudo systemctl restart confluent-schema-registry

sudo systemctl status confluent-schema-registry

#journalctl -u confluent-schema-registry.service

## ~~postman~~

#sudo snap install postman

## ~~VPN~~

#sudo apt install -y openconnect

### ~~globalprotect-openconnect ==!==~~

#http://system-administrator.pages.cs.sun.ac.za/globalprotect-openconnect/#globalprotect-openconnect-ubuntu-2004-and-2204

#sudo add-apt-repository -y ppa:yuezk/globalprotect-openconnect
#sudo apt-get update
#sudo apt install -y globalprotect-openconnect

## Intellij IDEA

sudo snap install intellij-idea-ultimate --classic

#sudo snap revert intellij-idea-ultimate

sudo snap refresh intellij-idea-ultimate --channel=2024.1/stable

sudo snap refresh --hold=forever intellij-idea-ultimate

## Common soft

### encfs (asks license)

sudo apt-get install -y encfs 

# Configuration

read -p "Now setting configuration…(Crtl-C or ENTER)"

## postgres location

#sudo -u postgres psql
#SHOW data_directory;

sudo systemctl stop postgresql

sudo systemctl status postgresql

sudo cp -r -p /var/lib/postgresql /mnt/poltora/postgresql

sudo cp /etc/postgresql/14/main/postgresql.conf /etc/postgresql/14/main/postgresql.conf.back-$(date +"%Y-%m-%d-%H-%M-%S")

cat /etc/postgresql/14/main/postgresql.conf | grep directory

sudo sed -i  "s|data_directory = '/var/lib/postgresql/14/main'|data_directory = '/mnt/poltora/postgresql/14/main'|" /etc/postgresql/14/main/postgresql.conf

cat /etc/postgresql/14/main/postgresql.conf | grep directory

sudo systemctl start postgresql

sudo systemctl status postgresql

## Dev util

#read -p "Dev utils…(Crtl-C or ENTER)"

grep -qxF 'export PATH=$PATH:/mnt/poltora/Documents/utils/' ~/.bashrc || echo 'export PATH=$PATH:/mnt/poltora/Documents/utils/' >> ~/.bashrc
grep -qxF 'export PATH=$PATH:/mnt/poltora/Documents/utils/' ~/.bashrc || echo 'export PATH=$PATH:/mnt/poltora/Documents/utils/' >> ~/.bashrc

#tail -3 ~/.bashrc

## inotify for idea

read -p "Inotify for Idea…(Crtl-C or ENTER)"

echo "fs.inotify.max_user_watches = 524288" | sudo tee /etc/sysctl.d/idea.conf

sudo sysctl -p --system

## encfs

mkdir /mnt/poltora/.priv
mkdir /mnt/poltora/.priv.sec
encfs /mnt/poltora/.priv.sec /mnt/poltora/.priv

mkdir /media/poltora/dev-backup/.priv
mkdir /media/poltora/dev-backup/.priv.sec
encfs /media/poltora/dev-backup/.priv.sec /media/poltora/dev-backup/.priv

### create mount util

tee /mnt/poltora/mount-development.sh <<mountdevelopment

ls -la /mnt/poltora/.priv
read -p "Mount main?…(y/N)" mount_main
if [[ $mount_main == "y" ]]
then
	encfs /mnt/poltora/.priv.sec /mnt/poltora/.priv
	ls -la /mnt/poltora/.priv
fi

echo ""
ls -la /media/poltora/dev-backup/.priv
read -p "Mount backup?…(y/N)" mount_backup
if [[ $mount_backup == "y" ]]
then
	encfs /media/poltora/dev-backup/.priv.sec /media/poltora/dev-backup/.priv
	ls -la /media/poltora/dev-backup/.priv
fi

mountdevelopment

##  Maven

### Перенос репозитория в /mnt

read -p "Maven repo in /mnt…(Crtl-C or ENTER)"

ls -la /usr/share/maven/

ls -la /etc/maven/

cat /etc/maven/settings.xml 

cp ~/.m2/settings.xml ~/.m2/settings.xml.back-$(date +"%Y-%m-%d-%H-%M-%S")

cp /etc/maven/settings.xml ~/.m2/settings.xml

ls -l ~/.m2/ | grep settings

mkdir -p /mnt/poltora/.m2/repository

sed -i  's|<localRepository>/path/to/local/repo</localRepository>|--><localRepository>/mnt/poltora/.m2/repository</localRepository> <!--|' /home/poltora/.m2/settings.xml

du -hc --max-depth=0 /mnt/poltora/.m2/

du -hc --max-depth=0 /home/poltora/.m2/

