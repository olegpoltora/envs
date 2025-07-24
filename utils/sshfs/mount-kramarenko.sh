#sshfs -o allow_other,default_permissions,IdentityFile=~/.ssh/id_rsa oleg@vps.k-max.name:/sshfs/oleg/ /mnt/kramarenko -p 2512
#fusermount: option allow_other only allowed if 'user_allow_other' is set in /etc/fuse.conf


sudo sshfs -o allow_other,default_permissions,IdentityFile=~/.ssh/id_rsa oleg@vps.k-max.name:/sshfs/oleg/ /mnt/kramarenko -p 2512
