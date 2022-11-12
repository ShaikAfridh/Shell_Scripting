#!/bin/bash
#     #----->sharp
#     !-----> Bang
#     #!----> shebang
#     #we can put another interpreter like
#     #!/bin/python -------> python interpreter
#     #!/bin/ruby   -------> ruby scripts

#Permissions
  # -rw-rw-r-- 1 docker docker    0 Nov 10 09:09 basics.sh
  # in above
  # '-' -----> indicates file
  # 'd' -----> indicates directory
  # 'r' -----> read -----> 4
  # 'w' -----> write ----> 2
  # 'x' -----> execute --> 1
  # 'rw-'-------> owner/admin
  # 'rw-'-------> group
  # 'r--'-------> other users
#
# 7(rwx) =4(r)+2(w)+1(x)
# 5(rx) =4(r)+1(x)
# 5(rx) =4(r)+1(x)

# Default:-
# chmod 755 [filename].sh
#This script display various information to the screen

#Display 'Hello'
echo 'Hello'

#Assign a value to a variable
WORD='script'

# ' ' -------> dosen't interpreter variable value
# " " -------> interpreter variable value
#Display that va;ue using the variable
echo "$WORD"

#Demonstrate that single quotes cause variable to NOT get expanded
echo '$WORD'

#combine the variable with hard-coded text
echo "This  is a shell $WORD"

#Display the contents of the variable using an alternative syntax.
echo "This is a shell ${WORD}"

#Append text to the variable
echo "${WORD}ing is fun!"

#Show how NOT to append text to a variable
#This doesn't work:
echo "$WORDing is fun!"

#Create a new variable
ENDING='ed'

# Combine the two variable
echo "This is ${WORD}${ENDING}"

#Change the value stored in the ENDING variable. (REASSIGNMENT)
ENDING='ing'
echo "${WORD}${ENDING} is fun!"

#Reassign value to ENDING
ENDING='s'
echo "you are going to write many ${WORD}${ENDING} in this class!"
