#!/bin/bash

F=$1
FILE=$1.tmp
OUTPUT=`echo $1 | sed 's/\//_/g'`
echo "" > ${OUTPUT}.h
cat ${F} | grep "EXPORT_SYMBOL_GPL" >> ${OUTPUT}.h
echo "\n" >> ${OUTPUT}.h
cat ${F} | grep -v "#if" > ${FILE}
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
sed -n "${i},${line}p" ${FILE} | grep -v "{" | grep -v "^$" >> ${OUTPUT}
done < lines

# macos x
# echo "\n" >> ${OUTPUT}.h
# sh $HUB/kde/shells/remove_comment.sh ${OUTPUT} | tr "\t" " " | tr "\n" " " | tr " " "#" | \
#     sed 's/##//g' | sed 's/#/ /g' | sed 's/,/, /g' | \
#     sed 's/  / /g' | sed -e 's/)/)\'$'\n/g' | sed 's/^ //g' >> ${OUTPUT}.h

# linux
sh /root/kde/shells/remove_comment.sh ${OUTPUT} | tr "\t" " " | tr "\n" " " | tr " " "#" | \
    sed 's/##//g' | sed 's/#/ /g' | sed 's/,/, /g' | \
    sed 's/  / /g' | sed -e 's/)/)\n/g' | sed 's/^ //g' >> ${OUTPUT}.h

echo "\n" >> ${OUTPUT}.h
cat ${OUTPUT}.h | grep -o "(.*)" | tr "," "\n" | sed 's/(//g' | sed 's/)//g' | sed 's/^ //g' | sort | uniq -c| sort -nr >> ${OUTPUT}.h

rm ${OUTPUT}
rm lines
rm ${FILE}

# linux: cat arch_x86_kvm_cpuid.c.h | tr "\n" " " | tr "\t" " " | tr " " "#" | sed 's/##//g'  |  sed 's/#/ /g' | sed 's/  //g' |sed 's/,/, /g'|sed 's/  / /g'|sed 's/)/);\n/g'
