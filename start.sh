#! /bin/bash

UMASK=$(umask)
umask go-rx
mkdir -p ~/.ssh

HOST_KEYS=''
for ALG in rsa dsa ecdsa ed25519
do
[ -e ~/.ssh/ssh_host_${ALG}_key ] || ssh-keygen -N '' -t ${ALG} -f ~/.ssh/ssh_host_${ALG}_key
HOST_KEYS="${HOST_KEYS} -h ~/.ssh/ssh_host_${ALG}_key"
done

umask $UMASK

[ -e projects.list ] || gitolite setup -pk "$PK_PATH"

exec /usr/sbin/sshd -eD -p 2222 -o PasswordAuthentication=no -o UsePrivilegeSeparation=no -o PidFile=none $HOST_KEYS
