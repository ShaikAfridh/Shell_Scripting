#!/bin/bash

#This scrpt disables,deletes, and/or archives users on the local system

ARCHIVE_DIR='/archive'
usage(){
  echo "USAGE: ${0} [-dra] USER [USERN]....." >&2
  echo "Disable a local linux account." >&2
  echo "   -d Deletes account instead of disabling them"
  echo "   -r removes the home directory associated with the accounts"
  echo "   -a creates an archive of the home directory associated with the accounts and stores the archives in the /archives directory"
  exit 1
}

#Make sure the script is being executed with super user previleges
if [[ "${UID}" -ne 0 ]]; then
  echo "Please run this script with sudo as root" >&2
  exit 1
fi



#Parse the options
while getopts dra OPTION
do
  case ${OPTION} in
    d) DELETE_USER='true' ;;
    r) REMOVE_OPTION='-r' ;;
    a) ARCHIVE='true';;
    ?) usage ;;
  esac
done

#Remove the options while leaving the remaining arguments
shift "$(( OPTIND - 1 ))"

# If the user doesn't supply at least one argument, give them help.
if [[ "${#}" -lt 1 ]]; then
  usage
fi

#Loop through  all the usernames supplied as arguments.
for USERNAME in "${@}"
do
  echo "Processing User: ${USERNAME}"

  #Make sure the UID of the account is at least 1000
  USERID=$(id -u "${USERNAME}")

  if [[ "${USERID}" -lt 1000  ]]; then
    echo "Refusing to remove the ${USERNAME} account with UID ${USERID}" >&2
    exit 1
  fi
  #Creating an archive if requested to do so.
  if [[ "${ARCHIVE}" = 'true' ]]; then
    #Make sure the  ARCHIVE_DIR directory exists
    if [[  ! -d "${ARCHIVE_DIR}" ]]; then #this conditions tells if not exists ARCHIVE_DIR variable
      # '$help test' ----> show s different operators
      # ! EXPR         True if expr is false.
      echo "Creating ${ARCHIVE_DIR} directory."
      mkdir -p ${ARCHIVE_DIR} # '-p' ----> parent directory
      if [[ "${?}" -ne 0 ]]; then
        echo "The archive directory ${ARCHIVE_DIR} could not be created" >&2
        exit 1
      fi
    fi
    # Archive the user's home directory and move it into the ARCHIVE_DIR
    HOME_DIR="/home/${USERNAME}"
    ARCHIVE_FILE="${ARCHIVE_FILE}/${USERNAME}.tgz"
    if [[ -d "${HOME_DIR}" ]]; then
        echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
        tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
        if [[ "${?}" -ne 0 ]]; then
          echo "Could not create ${ARCHIVE_DIR}." >&2
          exit 1
        fi
    else
      echo "${HOME_DIR} does not exist or is not a directory." >&2
      exit 1
    fi
  fi

  #Delete the user
  if [[ "${DELETE_USER}" = 'true' ]]; then
    #Delete the user
    userdel ${REMOVE_OPTION} ${USERNAME}
    #Check to see if the userdel command succeeded.
    #We don't want to tell the user that an account was deleted when it hasn't been,
    if [[ "${?}" -ne 0 ]]; then
      echo "the account ${USERNAME} was not deleted" >&2
      exit 1
    fi
    echo "The account ${USERNAME} was deleted."
  else
    chage  -E 0 ${USERNAME}
    #Check to see if the chage command succeeded.
    #We don't want to tell the user that an account was diabled when it hasn't been,

    if [[ "${?}" -ne 0 ]]; then
      echo "The account ${USERNAME} was Not deleted." >&2
      exit 1
    fi
    echo "The account ${USERNAME} was disbaled."
  fi
done

exit 0
