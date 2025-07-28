# Quasi ETF

sudo apt-get update

## JRE

sudo apt-get install -y openjdk-17-jre

java -version

#sudo update-alternatives --config java

##  Maven

sudo apt-get install -y maven 

## Git

sudo apt-get install -y git 

## postgresql

sudo apt-get install -y postgresql

sudo systemctl disable postgresql

## redis-server

sudo apt-get install -y redis-server

sudo systemctl disable redis-server

# Settings

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

##  Maven

### Перенос репозитория в /mnt

read -p "Maven repo in /mnt…(Crtl-C or ENTER)"

ls -la /usr/share/maven/

ls -la /etc/maven/

#cat /etc/maven/settings.xml 

cp ~/.m2/settings.xml ~/.m2/settings.xml.back-$(date +"%Y-%m-%d-%H-%M-%S")

cp /etc/maven/settings.xml ~/.m2/settings.xml

ls -l ~/.m2/ | grep settings

mkdir -p /mnt/poltora/.m2/repository

sed -i  's|<localRepository>/path/to/local/repo</localRepository>|--><localRepository>/mnt/poltora/.m2/repository</localRepository> <!--|' /home/poltora/.m2/settings.xml

cat /home/poltora/.m2/settings.xml | grep localRepository

du -hc --max-depth=0 /mnt/poltora/.m2/

du -hc --max-depth=0 /home/poltora/.m2/