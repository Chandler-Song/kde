#!/bin/bash

FILE=$1
OUTPUT=`echo $1 | sed 's/\//_/g'`
echo "" > ${OUTPUT}.h
cat ${FILE} | grep -n "^{" | awk -F ":" '{ print $1 }' > lines
while read line
do
i=`expr ${line} - 1`
cond=`sed -n "${i},${i}p" ${FILE} | grep "^$" | wc -l`
while [ "${cond}" -ne 1 ]
do
i=`expr ${i} - 1`
cond=`sed -n "${i},${i}p" ${FILE} | grep "^$" | wc -l`
done
sed -n "${i},${line}p" ${FILE} | grep -v "{" | grep -v "^$">> ${OUTPUT}
done < lines

# macos x
sh remove_comment.sh ${OUTPUT} | tr "\t" " " | tr "\n" " " | tr " " "#" | \
    sed 's/##//g' | sed 's/#/ /g' | sed 's/,/ /g' | \
    sed 's/  / /g' | sed -e 's/)/);\'$'\n/g' | sed 's/^ //g' > ${OUTPUT}.h

rm ${OUTPUT}

# linux: cat arch_x86_kvm_cpuid.c.h | tr "\n" " " | tr "\t" " " | tr " " "#" | sed 's/##//g'  |  sed 's/#/ /g' | sed 's/  //g' |sed 's/,/, /g'|sed 's/  / /g'|sed 's/)/);\n/g'
