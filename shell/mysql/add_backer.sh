
ip=127.0.0.1 ;
database=* ;
table=* ;
root_passwd=11111111 ;
password=1234567 ;
dumper=dumper ;

mkdir -p /opt/backer/ ;
datapath=/opt/backer/data ;
mkdir -p $datapath ;

echo > create_backer_user.sql;

echo create user ${dumper}@'${ip}' identified by '${password}'; >> create_backer_user.sql;
echo "grant select on ${database}.${table} to ${dumper}@'${ip}';" >> create_backer_user.sql;
echo "grant show view on ${database}.${table} to ${dumper}@'${ip}';" >> create_backer_user.sql;
echo "grant lock tables on ${database}.${table} to ${dumper}@'${ip}';" >> create_backer_user.sql;
echo "grant trigger on ${database}.${table} to ${dumper}@'${ip}';" >> create_backer_user.sql;

/usr/local/mysql/bin/mysql -uroot -p${root_passwd} -e "source create_backer_user.sql";

echo  > /opt/backer/mysqldump.sh ;
echo /usr/local/mysql/bin/mysqldump -h127.0.0.1 -u${dumper} -p${password} --all-databases  > ${datapath}/\`date +%Y%m%d\`all.sql  >  /opt/backer/mysqldump.sh ;
echo /usr/bin/find ${datapath} -mtime +3 -delete; >> /opt/backer/mysqldump.sh ;
echo chmod 600 ${datapath}/\* >> /opt/backer/mysqldump.sh ;
echo 10 23 \* \* \* sh /opt/backer/mysqldump.sh >> /etc/crontab ;
service crond restart ;

#### 备份文件服务器把文件scp过去灾备
