#!/bin/bash

#This script create a new user on the localsystem.
#You must supply a username as an argument to the script.
#Optionally, You can also provide a comment for the account as an argument
#A password will be automatically generated for the account
#The username, password, and host for the account will be displayed

if [[ "${UID}" -ne 0 ]]; then
  echo 'please run this script with sudo as a root' >&2
  exit 1
fi

#If they don't supply at least one argument then give them hel.

if [[ ${#} -lt 1 ]]; then
  echo 'Usage: ${0} USERNAME [COMMNT]....' >&2
  echo 'Create an account on the localsystem with the name of USER_NAME and a comment field of COMMENT...' >&2
  exit 1
fi
#The firstparameter is the user name
USERNAME="${1}"

#The rest of the parameters are for the account comments
shift
COMMENT="${@}"

#Generate a password
PASSWORD=$(date +%s%N |sha256sum| head -10)

#Create the user
useradd -c "${COMMENT}" -m "${USERNAME}" > /dev/null
#check to see if the useradd command is succeded.
#We don't want to tell the user that an account was created when it hasn't been

if [[ "${?}" -ne '0' ]]; then
  echo 'the user account is not created please check again!' >&2
  exit 1
fi
#Set the password
echo "${PASSWORD}" | passwd --stdin "${USERNAME}" > /dev/null

#Check to see if the password command succeded or not
if [[ "${?}" -ne '0' ]]; then
  echo "for user account $USERNAME password is unable to set please check again!'" >&2
  exit 1
fi

#Force password change on first login
passwd -e "${USERNAME}" &> /dev/null

#Display the username, password, and the host where the user was created.
echo "USERNAME = ${USERNAME}"
echo "PASSWORD = ${PASSWORD}"
echo "HOSTNAME = ${HOSTNAME}"
exit 0
