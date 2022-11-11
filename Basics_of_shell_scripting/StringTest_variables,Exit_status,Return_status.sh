#!/bin/bash

#Display the UID and username of the user executing this script
#Display if the user is the vagrant user or not.
username=$(id -un)
if [[ "${username}" -eq 'vagrant']]; then
  echo "this is a ${username} user"
else
  echo "this is not a vagrant user"
fi
#Display the UID
Uid="${UID}"
echo "${Uid}"

#Only display if the UID doesnot match 1000.
if [[ "${Uid}" -ne '1000' ]]; then
  echo "your UID doesnot match with 1000"
  exit 1
fi


#Test if the command succeeded
if [[ "${?}" -nq '0' ]]; then
  echo "the id command did not execute successfully"
fi

#Display the username
echo "your username is ${username}"

#You can use a string test conditional
if [[ "${username}" = 'vagrant' ]]; then
  echo "your username matches vagrant"
fi

# Test for !=(not equal) for the string.
if [[ "${username}" != 'vagrant' ]]; then
  echo "your username doesnot match vagrant"
fi
