#!/bin/bash

#This script create a new user on the localsystem.
#You must supply a username as an argument to the script.
#Optionally, You can also provide a comment for the account as an argument
#A password will be automatically generated for the account
#The username, password, and host for the account will be displayed

if [[ "${UID}" -ne 0 ]]; then
  echo "Please run this script sudo as a root"
  exit 1
fi

#If they don't supply at least one argument then give them hel.
if [[ ${#} -lt 1 ]]; then
  echo "Usage: ${0} USERNAME [COMMNT]...."
  echo "Create an account on the localsystem with the name of USER_NAME and a comment field of COMMENT..."
  exit 1
fi
#The firstparameter is the user name
USER_NAME="${1}"

#The rest of the parameters are for the account comments
shift #this will chop off $1 parameters
COMMENT="${@}" #so rest of all parameters are considered to be as comment

#Generate a password
SPECIAL_CHARACTERS=$(echo '!@#$%^&*()_+' | fold -w1|shuf|head -c1)
RANDOM_PASS=$(date +%s%N |sha256sum| head -16)
PASSWORD="${RANDOM_PASS}${SPECIAL_CHARACTERS}"

#Create the user with password
useradd -c "${COMMENT}" -m "${USER_NAME}"

#check to see if the useradd command is succeded.
#We don't want to tell the user that an account was created when it hasn't been
if [[ "${?}" -ne 0 ]]; then
  echo "the account could not be created."
  exit 1
fi

#Set the password
echo ${PASSWORD} | passwd --stdin "${USER_NAME}"

#Check to see if the password command succeded or not
if [[ "${?}" -ne 0 ]]; then
  echo "the password for the account could not be set."
  exit 1
fi


#Force password change on first login
passwd -e ${USER_NAME}

#Display the username, password, and the host where the user was created.
echo
echo "USERNAME = ${USER_NAME}"
echo "PASSWORD = ${PASSWORD}"
echo "HOSTNAME = ${HOSTNAME}"

exit 0
