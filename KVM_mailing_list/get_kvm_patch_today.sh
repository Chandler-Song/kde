#!/bin/bash $1
set -e
# demo: sh get_kvm_patch_today.sh -d 2018-10-09

while getopts "d:" arg #选项后面的冒号表示该选项需要参数
do
    case $arg in
        d)
        echo "a's arg:$OPTARG" #参数存在$OPTARG中
        if  [ ! -n "$1" ] ;then
            DATE=`date +"%Y-%m-%d"`
        else
            DATE=$OPTARG
        fi
        echo "check kvm-mailing-list on ${DATE}"
        mkdir ${DATE}
        cd ${DATE}
        wget "https://patchwork.kernel.org/api/covers/?project=8&format=json&before=${DATE}T23%3A59%3A59&since=${DATE}T00%3A00%3A00" -O ${DATE}.json
        
        num=`cat ${DATE}.json | jq '. | length'`
        if [ ${num} -eq 0 ]
        then
            echo "${DATE} is NULL"
            cd .. 
            rm -rf ${DATE}
            exit
        fi
        
        cat ${DATE}.json | jq '.[]' | jq '.id' | while read var
        do
        if [ ! -f "${var}.patch" ]; then 
        wget "https://patchwork.kernel.org/cover/${var}/mbox/" -O ${var}.patch
        fi
        done

        FILE="overview_${DATE}.md"
        if [ -f "${FILE}" ]; then 
        rm ${FILE}
        fi
        touch ${FILE}
        echo "\n" >> ${FILE}
        # i=1
        for var in `ls -1 *.patch`
        do 
        LINE=`cat ${var} | grep -n "X-Virus-Scanned" | awk -F ':' '{ print $1 }'`
        NAME=`cat ${var} | grep "From: "`
        SUBJECT=`cat ${var} | grep "Subject: " | sed 's/Subject: //g'`
        echo "#### ${SUBJECT}" >> ${FILE}
        echo "##### ${NAME}\n" >> ${FILE}
        echo "\`\`\`c" >> ${FILE}
	    k=`expr ${LINE} + 1`
        tail -n +${k} ${var} >> ${FILE}
        echo "\`\`\`" >> ${FILE}
        # i=`expr $i + 1`
        done
        cd ..
        ;;
        ?)  #当有不认识的选项的时候arg为?
        echo "unkonw argument"
    exit 1
    ;;
    esac
done


# cat *.patch | grep "Subject: " > patches.list
# sed 's/Subject: /* /g' patches.list | sort -k 3 -r >> ${FILE}
# cat */*.json | jq '.[] | { Patch: .name, From: .submitter.name, Email: .submitter.email}'

# for i in `seq 1 1 20`
# do
# echo "sh get_kvm_patch_today.sh -d 2018-09-`printf "%02d\n" $i`"
# done


# for i in `seq 1 1 6`
# do
#     for j in `seq 1 1 31`
#     do
#     echo "sh get_kvm_patch_today.sh -d 2018-`printf "%02d\n" $i`-`printf "%02d\n" $j`"
#     done
# done
