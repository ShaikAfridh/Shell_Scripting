#!/bin/bash
#Demonstrate the use of shift and while loops

#Display the first three parameters
echo "paramerter 1: ${1}"
echo "paramerter 2: ${2}"
echo "paramerter 3: ${3}"
echo

# while: while COMMANDS; do COMMANDS; done
    # Execute commands as long as a test succeeds.
    # true - do nothing, successfully {gives exit status'0'}
# sleep - delay for a specified amount of time

# x=1
# while [[ "${x}" -eq 1 ]]
# do
#    echo "THis is the value of X = $x"
#    x=7
# done

#Creating infinite while loops
# while [[ true ]]
# do
#    echo "${RANDOM}"
#    sleep 1.5
# done

# Shift positional parameters.{like if we specify value on $2 it will goto $1 and $0 like that}

#Loop through all positional parameters
while [[ "${#}" -gt 0 ]]; do
  echo "number of parameters: ${#} "
  echo "Parameter 1: ${1}"
  echo "Parameter 2: ${2}"
  echo "Parameter 3: ${3}"
  echo
  shift
done


# Output:-
# [vagrant@localhost ~]$ ./while.sh  afridi shaik
# paramerter 1: afridi
# paramerter 2: shaik
# paramerter 3:
#
# number of parameters: 2
# Parameter 1: afridi
# Parameter 2: shaik
# Parameter 3:
#
# number of parameters: 1
# Parameter 1: shaik
# Parameter 2:
# Parameter 3:
