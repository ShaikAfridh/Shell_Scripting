#!/bin/bash
#Goals:-
#This script creates an account on the local system.
# You will be prompted for the account name and password.

#Ask for the username.
read -p "Enter your username: " username

#Ask for the realname
read -p "Enter your realname: " comment

#Ask for the password
read -p "Enter your password: " password

#Create the user.
useradd -c "${comment}" -m "${username}"

#Set the password for the user.
echo ${password} | passwd --stdin ${username}

#Force  password change on first login.
passwd -e ${username}
