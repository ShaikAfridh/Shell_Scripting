#!/bin/bash

#Display the UID and username of the user executing this script.
#Display if the user is the root user or not.

#Display the UID
echo "Your UID is ${UID}"

#Display the username
username=$(id -un)
echo "your username is ${username}"

#Display if the user is the root user or not
if [[ "${UID}" -eq '0' ]]; then
  echo 'your are root.'
else
  echo 'Your are not root.'
fi
