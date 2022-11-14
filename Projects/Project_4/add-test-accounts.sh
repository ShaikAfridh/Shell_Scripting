#!/bin/bash
#Add some accounts to the test with
if [[ "${UID}" -ne 0 ]]; then
  echo 'please run this script with sudo or as root.' >&2
  exit 1
fi

for U in afridi automation devops developer
do
  useradd ${U}
  echo 'pass123' |passwd --stdin ${U}
done
