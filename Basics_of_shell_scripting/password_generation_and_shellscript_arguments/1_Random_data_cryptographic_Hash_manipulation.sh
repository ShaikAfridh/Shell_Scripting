#!/bin/bash
#This script generates a list of random passwords.

#RANDOM Each time this parameter is referenced, a random integer between 0 and 32767 is generated.  The sequence of random numbers may be initialized by assigning a value to RANDOM.  If RANDOM is unset, it loses its special properties, even if it is subsequently reset.

#A random number as a password
PASSWORD="${RANDOM}"
echo "${RANDOM}"

#!v------->edit recent file

#Three random numbers together
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

# date +%s     seconds since 1970-01-01 00:00:00 UTC {it will increase 1 second each time}
#Use the current date/time as the basics for the password.

PASSWORD=$(date +%s)
echo "${PASSWORD}"

#86048 seconds in a day its around 86048 password
#Epic time is easy to guess
# %N     nanoseconds (000000000..999999999) {hard to guess}

#Use nanoseconds to act as randomization
PASSWORD=$(date +%s%N)
echo "${PASSWORD}"

#Checksum ---->it is a digit represent the stored data transmitted from one end to another end and to detect errors in the data
#checksum is a hexadecimal number that contains 0-9 a-f {10-16}digits
#Centos has few Checksum
#sha1sum
#sha256sum
# ls -l /usr/bin/*sum ------> list the all Checksum
# head
# -c, --bytes=[-]K print the first K bytes of each file; with the leading '-', print all but the last K bytes of each file

# -n, --lines=[-]K print the first K lines instead of the first 10; with the leading '-', print all but the last K lines of each file

#A better password
PASSWORD=$(date +%s%N |sha256sum |head -c32)
echo "${PASSWORD}"


#an even better password
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} |sha256sum |head -c48)
echo "${PASSWORD}"

 # shuf - generate random permutations {print random lines}
# fold - wrap each input line to fit in specified width
# -w, --width=WIDTH         use WIDTH columns instead of 80


#Append special character to the password
SPECIAL_CHARACTER=$(echo '!@#$%^&*()_+' | fold -w1|shuf|head -c1)
echo "${PASSWORD}${SPECIAL_CHARACTER}"
