#!/bin/bash
# if: if COMMANDS; then COMMANDS; [ elif COMMANDS; then COMMANDS; ]... [ else COMMANDS; ] fi
# Execute commands based on conditional.

# case: case WORD in [PATTERN [| PATTERN]...) COMMANDS ;;]... esac
# Execute commands based on pattern matching.
#This script demonstrates the case statement.
# if [[ "${1}" = 'start' ]]; then
#   echo 'Starting.'
# elif [[ "${1}" = 'stop' ]]; then
#   echo 'stopping.'
# elif [[ "${1}" = 'status' ]]; then
#   echo 'status:-'
# else
#   echo "supply a valid option." >&2
#   exit 1
# fi

# case "${1}" in #Word------>${!}
#   start) #pattern)-------->start
#   echo 'starting.' #statement
#     ;; #end the code block
#   stop)
#   echo 'stopping.'
#     ;;
#   status)
#   echo 'Status: '
# esac #finish case statement

# Pattern Matching
# Any  character  that  appears  in a pattern, other than the special pattern characters described below, matches itself.
# *      Matches any string, including the null string.
# ?      Matches any single character.
# [...]  Matches any one of the enclosed characters.

# case "${1}" in
#   start)
#   echo 'starting'
#     ;;
#   stop)
#   echo 'stopping'
#     ;;
#   status)
#   echo 'status'
#     ;;
#   *)
#   echo 'Supply a valid option.' >&2
#   exit 1
#     ;;
# esac

#We can use pipe(|) to match multiple patterns
# case "${1}" in
#   start)
#   echo 'starting'
#     ;;
#   stop)
#   echo 'stopping'
#     ;;
#   status|state|--status|--state)
#   echo 'status'
#     ;;
#   *)
#   echo 'Supply a valid option.' >&2
#   exit 1
#     ;;
# esac

# /etc/init.d/sshd start
# /etc/init.d/sshd status
# /etc/init.d/sshd stop

case "${1}" in
  start) echo 'starting' ;;
  stop) echo 'stopping' ;;
  status) echo 'status' ;;
  *)
  echo 'Supply a valid option.' >&2
  exit 1
    ;;
esac
