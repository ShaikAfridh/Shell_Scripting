#!/bin/bash

#This script demonstrates I/O redirection

#There are 3 types of I/O
# 1.Standard Input('<' or '0<') ----->keyboard {0}
# 2.Standard Output('>'or'1>')----->1
# 3.Standard Error('2>')--------->2

#Redirect STDOUT to a file
FILE="/tmp/data"
head -n1 /etc/passwd > ${FILE}

#Redirect STDIN to a program
read LINE < ${FILE}
echo "LINE contains: ${LINE}"

#Changing password for the user using I/O functions
# [vagrant@localhost ~]$ echo "secret" > password
# [vagrant@localhost ~]$ cat password
# secret
# [vagrant@localhost ~]$ sudo passwd --stdin afridi < password
# Changing password for user afridi.
# passwd: all authentication tokens updated successfully.

#Redirect STDOUT to a file, overwriting the file.
head -n3 /etc/passwd > ${FILE}
echo
echo "Contents of ${FILE}"
cat ${FILE}

#Redirect STDOUT to a file, appending to the file.
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}

echo
echo "Contents of  ${FILE}"
cat ${FILE}


# head - output the first part of files {with head command we can give multiple files}
# [vagrant@localhost ~]$ head -n1 /etc/passwd /etc/hosts
# ==> /etc/passwd <==
# root:x:0:0:root:/root:/bin/bash
#
# ==> /etc/hosts <==
# 127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4

#STDERR (2>)
# [vagrant@localhost ~]$ head /fakefile 2> head.err
# [vagrant@localhost ~]$ cat head.err
# head: cannot open ‘/fakefile’ for reading: No such file or directory

#Redirect stdout in 'head.out' and stderr in 'head.err'
# [vagrant@localhost ~]$ head -n1 /etc/passwd /etc/hosts /fakefile >head.out 2>> head.err
# [vagrant@localhost ~]$ cat head.out
# ==> /etc/passwd <==
# root:x:0:0:root:/root:/bin/bash
#
# ==> /etc/hosts <==
# 127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
# [vagrant@localhost ~]$ cat head.err
# head: cannot open ‘/fakefile’ for reading: No such file or directory

#Both output and std err in same file {'2>&' or '&>'}
# [vagrant@localhost ~]$ head -n1 /etc/passwd /etc/hosts /fakefile >head.both 2>&1
# [vagrant@localhost ~]$ cat head.both
# ==> /etc/passwd <==
# root:x:0:0:root:/root:/bin/bash
#
# ==> /etc/hosts <==
# 127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
# head: cannot open ‘/fakefile’ for reading: No such file or directory

# '&>>'------> append the both stdout and std Error


# cat - concatenate files and print on the standard output
# -n, --number------>number all output lines


#Redirect STDIN to a program ,using File descripter 0
read LINE 0< ${FILE}
echo
echo "LINE contains: ${LINE}"

#Redirect STDOUT to a file using File descripter 1,overwriting the file
head -n3 /etc/passwd 1> ${FILE}
echo
echo "contents of ${FILE}:"
cat ${FILE}

#Redirect STDERR to a file using FD 2.
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakefile 2> ${ERR_FILE}

#Redirect STDOUT and STERR to a file
head -n3 /etc/passwd /fakefile &> ${FILE}
echo
echo "Contents of ${FILE}"
cat ${FILE}

#Redirect STDOUT and STDERR through a pipe. {it will numbered}
echo
head -n3 /etc/passwd /fakefile |& cat -n
# Output:-
# 1	==> /etc/passwd <==
#     2	root:x:0:0:root:/root:/bin/bash
#     3	bin:x:1:1:bin:/bin:/sbin/nologin
#     4	daemon:x:2:2:daemon:/sbin:/sbin/nologin
#     5	head: cannot open ‘/fakefile’ for reading: No such file or directory

#send outpt to STDERR {>&--->stdout and stderr}
echo "this is STDERR!" >&2

#Discard STDOUT
echo
echo "Discarding STDOUT: "
head -n3 /etc/passwd /fakefile > /dev/null

#Discard STDERR
echo
echo "Discarding STDERR:"
head -n3 /etc/passwd /fakefile 2> /dev/null

#Discard Both STDOUT and STDERR
head -n3 /etc/passwd /fakefile &> /dev/null

#Clean up
rm ${FILE} ${ERR_FILE} &> /dev/null
