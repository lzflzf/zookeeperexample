

filename=$1

## 先检测文件是否上锁，如果上锁则说明前一个处理进程还没有退出
lock=`ls /opt/locks/ | grep ^${2}.lock.`

if [[ ${lock} ]]
then
   echo ${filename} is locked
   ####maybe there should be ruturn
   exit
fi

echo unlock continue,adding lock for ${filename}
lock=/opt/locks/${2}.lock.`date +%Y-%m-%d-%H-%M-%S`
echo ${lock}
touch ${lock}


if [[  ${2} =~ ^([0-9]{18})([0-9]{8})([a-z_]+)\.csv$   ]]
then
	#### 先对文件进行MD5校验，有可能文件是错误的，也有可能文件正在传输中
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
    	hivesql=load data local inpath '${filename}' into table ${table} PARTITION BY(indate='${indate}') ;
    	echo ${hivesql} >> `date +%Y%m%d`log.out
    	hive -e "${hivesql}"
    	mv ${filename}  /opt/backer/data/
    	###
    fi
else
    echo `date +%Y-%m-%d %H:%M:%S`------${filename} Not Match  >>  `date +%Y%m%d`error.out
fi

## 
echo end handle!!! deleting lock for ${filename}
rm -f ${lock}

