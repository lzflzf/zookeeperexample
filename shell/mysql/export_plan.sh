#!/bin/bash

start=`date +%s`

cat ${1} | awk -F'\001' '{ printf "%s\001%s\001%s\001%s\n" , $1,$3,$5,$35 }'  > ${1}.plantmp

./awk.sh FS="interest" ${1}.plantmp > ${1}.plan

end=`date +%s`

echo ${end}-${start}
