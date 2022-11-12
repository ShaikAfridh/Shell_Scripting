#!/bin/bash

if [[ "${UID}" != '0' ]]; then
  echo 'please run script sudo as a root'
  exit 1
fi

read -p 'Enter the username: ' username
read -p 'Enter your name: ' comment
read -p 'Enter the password: ' password

useradd -c ${comment} -m ${username}

if [[ "${?}" -ne 0 ]]; then
  echo 'Something went wrong account is not able to create.'
  exit 1
fi

echo ${password} |passwd --stdin ${username}

passwd -e ${username}


echo "USERNAME : ${username}"
echo "PASSWORD : ${password}"
echo "HOSTNAME : ${HOSTNAME}"
