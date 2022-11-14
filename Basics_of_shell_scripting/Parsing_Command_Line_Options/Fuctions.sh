#!/bin/bash

# function is a group of command that we call using a single name in our script
# DRY-------->don't repeat yourself {function}
# WET---------> write everything twice
#1. write block of code once and repeat many time.
#2. breakup large tasks into series of smaller tasks it makes code easier to maintain

# function: function name { COMMANDS ; } or name () { COMMANDS ; }
# 1st Method:-
# log() {
  # echo "You called the log function!"
# }

# 2nd Method:-
# function log() {
#   echo "You called the log function!"
# }
#
# log

# local: local [option] name[=value] ...
# Create a local variable called NAME, and give it VALUE.  OPTION can be any option accepted by `declare'.
#local variable used inside function
#Tip:- Use local variable inside the function instead of global variable

# log(){
#   local MESSAGE="${@}"
#   echo "${MESSAGE}"
# }
#
# log 'Hello!'
# log 'This is fun!'

# log(){
#   local MESSAGE="${@}"
#   if [[ "${VERBOSE}" = 'true' ]]; then
#     echo "${MESSAGE}"
#   fi
# }
# in above funtion 'Hello' is not displayed in screen bcoz we haven't set the VERBOSE varibale value then after we declared the VERBOSE='true' variable the it print

# log 'Hello!'
# VERBOSE='true'
# log 'Shell scripting is fun!'


# log(){
#   local VERBOSE="${1}"
#   shift
#   local MESSAGE="${@}"
#   if [[ "${VERBOSE}" = 'true' ]]; then
#     echo "${MESSAGE}"
#   fi
# }
 # readonly ------->Mark shell variables as unchangeable.
# readonly VERBOSITY='true'
# log "${VERBOSITY}" 'Hello!'
# log "${VERBOSITY}"'Shell scripting is fun!'

# logger makes entries in the system log.  It provides a shell command interface to the syslog(3) system log module.

# -t, --tag tag
# Mark every line to be logged with the specified tag.
# Nov 13 10:09:20 localhost myscript: Tagging on.
                          # [tag]      [log value]

log(){
 #this function sends a message to syslog and to standard output if VERBOSE is true.
 local MESSAGE="${@}"
 if [[ "${VERBOSE}" = 'true' ]]; then
  echo "${MESSAGE}"
 fi
 logger -t function.sh "${MESSAGE}"
}


backup_file(){
  #This function creates a backup of a file. Returns non-zero status on error.
  local FILE="${1}"
  #Make sure the file exists.
  if [[ -f "${FILE}"  ]]; then
    #  %F     full date; same as %Y-%m-%d
    # %N     nanoseconds (000000000..999999999)
    #basename  Print NAME with any leading directory components removed.  If specified, also remove a trailing SUFFIX.
    #below backup_file variable store the destination of the file to be copied and with date
    local backup_file="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    #below is a function which stores the backing up file in '/var/log/messages'
    log "Backing up ${FILE} to ${backup_file}"
    #The exit status of the function will be the exit status of the cp command
    #below command gives copying the file from current path to destination
    cp -p ${FILE} ${backup_file} #here -p represents preserve mode which will gives the file original_timestamps
  else
    #The file does not exist, so return a non-zero exit status
    return 1
  fi
}

readonly VERBOSE='true'
log 'Hello!'
log 'This is fun!'

backup_file '/etc/passwd'


#Make a decision based on the exit status of the function
if [[ "${?}" -eq '0' ]]; then
  log 'File backup succeded!'
else
  log 'File backup is failed!'
  exit 1
fi
