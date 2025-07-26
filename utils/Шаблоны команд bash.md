# Шаблоны команд bash

## Добавить строку в существующий файл

echo "export PATH=\$PATH:/mnt/poltora/Documents/utils/" >> ~/.bashrc

## Добавить строку в новый файл под рут

echo "one string"  | sudo tee /path/to/file > /dev/null 

## Добавить строку в существующий файл под рут

echo 'mdtm_write=YES' | sudo tee -a /etc/vsftpd.conf

## Добавить несколько строк в существующий файл под рут

echo 'mdtm_write=YES
' | sudo tee -a /etc/vsftpd.conf

## Заменить строку

sudo sed -i  's|#write_enable=YES|write_enable=YES|' /etc/vsftpd.conf

## Бакап файла

sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.back-$(date +"%Y-%m-%d-%H-%M-%S")

# Шаблоны в backintime

.[Tt]rash*