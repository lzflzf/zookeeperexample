### 扫描csv文件

datapath=/opt/data1

for dir in `ls ${datapath}`
do
   echo ${dir}
   for filename in `ls ${datapath}/${dir}/ | grep csv$`
   do
    #### mysql -hxxxxx -pxxxx -uxxxxx -pxxxxx -e "insert into lizhifeng.logs(aaa,bbb) values('aaaa','bbbb');"
   	sh import_csv_to_hive.sh ${datapath}/${dir}/${filename} ${filename}
   done
done



