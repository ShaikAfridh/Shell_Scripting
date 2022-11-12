#!/bin/bash

#this script generates a rando, password for each user specified on the command line

#Display what the user typed on the command line.

echo "You executed this command ${0}"

# parameter------>it is variable is being used inside the shell script
# argument------->it is data passed to the shell script
#
# first positional argument contains $0 -----> it contains the name of the script
# $1------> first argument
# $2------> second argument
# $3------> third argument..............

#PATH----->The search path for commands.  It is a colon-separated list of directories in which the shell looks for commands
#basename - strip directory and suffix from filenames
#dirname - strip last component from file name

#Display the path and file name of the script

echo "you used $(dirname ${0}) as the path to the $(basename ${0} script.)"

#    !------>Expands to the process ID of the most recently executed background (asynchronous) command.
#    #------->Expands to the number of positional parameters in decimal.
#  ?--------->Expands to the exit status of the most recently executed foreground pipeline.
# !---------->Expands to the process ID of the most recently executed background (asynchronous) command.
#Tell the user how many arguments they passed in.
#(Inside the script they are parameters , outside they are arguments)
NUMBER_OF_PARAMETERS="${#}"
echo "You supplied ${NUMBER_OF_PARAMETERS} arguments on the command line"


# make sure they at least supply one argument
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]; then
  echo "Usage : [${0}] [USERNAME] [COMPANY_NAME] [PASSWORD]"
  exit 1
fi

# @-------->Expands to the positional parameters, starting from one.  When the expansion occurs within double quotes, each parameter expands to  a separate  word.   That  is, "$@" is equivalent to "$1" "$2" ...
# *------>Expands  to the positional parameters, starting from one.  When the expansion occurs within double quotes, it expands to a single word
#generate and display a password for each parameter.

for USERNAME in "${@}"
do
  PASSWORD=$(date +%s%N | sha256sum|head -c48)
  echo "${USERNAME}: ${PASSWORD}"
done
