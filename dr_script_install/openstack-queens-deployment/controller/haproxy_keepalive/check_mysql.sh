#!/bin/sh

ERROR_MSG=`/usr/bin/mysql  -e "show databases;" 2>/dev/null`

#
# Check the output. If it is not empty then everything is fine and we return
# something. Else, we just do not return anything.
#
if [ "$ERROR_MSG" != "" ]
then
        exit 0

else
        exit 1
fi


#checkmysql
