#!/bin/bash
#Finding files/commands in os
# Some Commands doesn't show using 'which' command in that case we can use the 'locate' command it will seach the path of this Command
# 1.which
# 2.locate
# 3.find ------>search for files in a directory hierarchy
#Deleting Users
#userdel - delete a user account and related files
# -f, --force This option forces the removal of the user account, even if the user is still logged in. It also forces userdel to remove the user's home directory
# -r, --remove This will remove Users home directory
#Archives with tar{tape archive}
# GNU  `tar'  saves many files together into a single tape or disk archive, and can restore individual files from the archive.
# EXAMPLES
#        tar -cf archive.tar foo bar
#               # Create archive.tar from files foo and bar.
#
#        tar -tvf archive.tar
#               # List all files in archive.tar verbosely.
#
#        tar -xf archive.tar
#               # Extract all files from archive.tar.


#Compressed archive files ends with .tar.gz
# Gzip  reduces  the  size  of  the  named files using Lempel-Ziv coding (LZ77).  Whenever possible, each file isreplaced by one with the extension .gz

#Disabling Accounts
# chage - change user password expiry information
# -E, --expiredate EXPIRE_DATE
# Set the date or number of days since January 1, 1970 on which the user's account will no longer be accessible. The date may also be expressed in the format YYYY-MM-DD
# Passing the number -1 as the EXPIRE_DATE will remove an account expiration date.


#This script deletes a user.

#Run as root
if [[ "${UID}" -ne 0 ]]; then
  echo 'Please run with sudo or as root.' >&2
  exit 1
fi

#Assume the first argument is the user to delete

USER="${1}"

if [[ "${#}" -lt 1 ]]; then
  echo "Please Specify Username to delete the account"
  exit 1
fi
#Deletes the user
userdel ${USER}

#make sure the user got deleted
if [[ "${?}" -ne 0 ]]; then
  echo "The account ${USER} was NOT deleted" >&2
  exit 1
fi

#Tell the user the account was deleted.
echo "THe account ${USER} was deleted"

exit 0
