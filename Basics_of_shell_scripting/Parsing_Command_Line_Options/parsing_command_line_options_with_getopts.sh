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

log 'Generating a password'


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
