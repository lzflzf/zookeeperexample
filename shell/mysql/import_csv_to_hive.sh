

filename=$1

lock=/opt/locks/${2}.lock.`date +%Y-%m-%d-%H-%M-%S`
echo ${lock}

## 先检测文件是否上锁，如果上锁则说明前一个处理进程还没有退出

if [[ -e ${lock} ]]
then
   echo ${filename} is locked
   exit
fi

echo unlock continue,adding lock for $filename
touch ${lock}


if [[  ${filename} =~ ^([0-9]{18})([0-9]{8})([a-z_]+)\.csv$   ]]
then
    MD5=`md5sum ${filename} | awk '{print $1}'`
    expectMD5=`cat ${filename}.md5`
    echo ${MD5}
    echo ${expectMD5}
    if [[ ${MD5} != ${expectMD5} ]]
    then
	echo md5 is error ,exit
    else
    	echo continue
    	indate=${BASH_REMATCH[2]}
    	table=${BASH_REMATCH[3]}
    	echo `date +%Y-%m-%d %H:%M:%S`------load file ${filename}  >> `date +%Y%m%d`log.out    	
    	hivesql=load data inpath '${filename}' into table ${table} PARTTEN BY(indate='${indate}')
    	echo ${hivesql} >> `date +%Y%m%d`log.out
    	hive -e "${hivesql}"
    	mv ${filename} >> /opt/backer/data/
    	###
    fi
else
    echo `date +%Y-%m-%d %H:%M:%S`------${filename} Not Match\n  >>  `date +%Y%m%d`error.out
fi

## 
echo end handle!!! deleting lock for ${filename}
rm -rf ${lock}

