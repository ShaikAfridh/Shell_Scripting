#!/bin/bash
# $(()) ------>is called arithemetic expansion
# Addition
# [vagrant@localhost ~]$ NUM=$((1+2))
# [vagrant@localhost ~]$ echo ${NUM}
# 3
# Substraction
# [vagrant@localhost ~]$ NUM=$((10-1))
# [vagrant@localhost ~]$ echo ${NUM}
# 9
# Multiplication
# [vagrant@localhost ~]$ NUM=$((2*4))
# [vagrant@localhost ~]$ echo ${NUM}
# 8
# Division
# [vagrant@localhost ~]$ NUM=$((6/2))
# [vagrant@localhost ~]$ echo ${NUM}
# 3
# Remainder
# [vagrant@localhost ~]$ NUM=$((6%2))
# [vagrant@localhost ~]$ echo ${NUM}
# 0
# Below 6/4=1.50 but we got '1' below operator nothing do Rounding values it just remove decimal point give us values
# [vagrant@localhost ~]$ NUM=$((6/4))
# [vagrant@localhost ~]$ echo ${NUM}
# 1

# bc is a language that supports arbitrary precision numbers with interactive execution of statements.
# usage: bc [options] [file ...]
#   -h  --help         print this usage and exit
#   -i  --interactive  force interactive mode
#   -l  --mathlib      use the predefined math routines
#   -q  --quiet        don't print initial banner
#   -s  --standard     non-standard bc constructs are errors
#   -w  --warn         warn about non-standard bc constructs
#   -v  --version      print version information and exit

#using bc gives accurate decimal numbers
# [vagrant@localhost ~]$ echo '6/4' |bc -l
# 1.50000000000000000000
#For Quick calculator we can use 'bc -l' command
# [vagrant@localhost ~]$ bc -l
# bc 1.06.95
# Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006 Free Software Foundation, Inc.
# This is free software with ABSOLUTELY NO WARRANTY.
# For details type `warranty'.
# 6/4
# 1.50000000000000000000
# 1+1
# 2

# we can use awk operator also for precise decimal value
# [vagrant@localhost ~]$ awk 'BEGIN {print 6/4}'
# 1.5

# Two ways perform math operations
# 1. let  Evaluate arithmetic expressions.
# let: let arg [arg ...]
# [vagrant@localhost ~]$ let NUM='2+3'
# [vagrant@localhost ~]$ echo ${NUM}
# 5

# 2.  expr - evaluate expressions
# [vagrant@localhost ~]$ NUM=$(expr 2 + 3)
# [vagrant@localhost ~]$ echo $NUM
# 5
#!/bin/bash
# Getopts is used by shell procedures to parse positional parameters as options.

#This script generates a random password
# this user can ser the password length with -l and add a special chaacter with -s.
#Verbose mode can be enabled with -v.


usage(){
  echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
  echo 'Generate a random passsword.'
  echo ' -l LENGTH specify the password length'
  echo '-s append a special character to the password'
  echo '-v  Increase verbosity.'
  exit 1
}

log(){
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = "true" ]]; then
    echo "${MESSAGE}"
  fi
}
#Set a default password length
LENGTH=48

while  getopts vl:s OPTION  ; do
  case ${OPTION} in
    v)
    VERBOSE='true'
    log 'Verbose mode on.'
    ;;
    l)
    LENGTH="${OPTARG}" # OPTARG The value of the last option argument processed by the getopts builtin command
    ;;
    s)
    USE_SPECIAL_CHARACTER='true'
    ;;
    ?)
    usage
    ;;
  esac
done

# echo "Number of args: ${#}"
# echo "All args: ${@}"
# echo "First arg: ${1}"
# echo "Second arg: ${2}"
# echo "Third arg: ${3}"
#Inspect OPTIND
# OPTIND The  index  of  the next argument to be processed by the getopts builtin command (see SHELL BUILTIN COMMANDS below).
# echo "OPTIND: ${OPTIND}"

#Remove the options while leaving the remaining arguments
shift "$(( OPTIND - 1 ))"
# echo 'After the shift:'

# echo "Number of args: ${#}"
# echo "All args: ${@}"
# echo "First arg: ${1}"
# echo "Second arg: ${2}"
# echo "Third arg: ${3}"
# log 'Generating a password'

if [[ "${#}" -gt 0 ]]; then
  usage
fi

password=$(date +%s%N${RANDOM}${RANDOM} |sha256sum|head -c${LENGTH})

#Append a special character if requested to do so.
if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]; then
  log 'selecting a random special character '
  SPECIAL_CHARACTER=$(echo '!@#$%%^&*()_+=-~`~' |fold -w1|shuf|head -c1)
  password="${password}${SPECIAL_CHARACTER}"
fi

log 'Done.'
log "Here is the password: "
echo "${password}"

exit 0
