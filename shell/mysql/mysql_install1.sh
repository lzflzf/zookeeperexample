/usr/local/mysql/support-files/mysql.server stop

rootpasswd=`echo \`date\` | md5sum | awk '{ print $1 }'` ;
echo ${rootpasswd} > /root/.ssh/mysql_root_passwd
chmod 600 /root/.ssh/mysql_root_passwd
datadir=/opt/mysql/data63 ;

# tar zxvf $1 -C /usr/local ;
echo "PATH=\${PATH}:/usr/local/mysql/bin" >> /etc/profile
source /etc/profile
/usr/local/mysql/bin/mysql_install_db --datadir=${datadir} ;
useradd -r -s /bin/false -M mysql ;
chown mysql:mysql -R ${datadir} ;

echo "[mysqld]" > /etc/my.cnf ;
echo "datadir=${datadir}" >> /etc/my.cnf ;
echo "socket=${datadir}/mysql.sock" >> /etc/my.cnf ;
echo "skip-grant-tables" >> /etc/my.cnf ;

echo "[mysqld_safe]" >> /etc/my.cnf ;
echo "log-error=${datadir}/mariadb.log" >> /etc/my.cnf ;
echo "pid-file=${datadir}/mariadb.pid" >> /etc/my.cnf ;

echo "[mysql]" >> /etc/my.cnf
echo "socket=${datadir}/mysql.sock" >> /etc/my.cnf ;

/usr/local/mysql/support-files/mysql.server start 1>mysql.out 2>mysql.out;

/usr/local/mysql/bin/mysql -e "flush privileges;update mysql.user set authentication_string=password(\"${rootpasswd}\") where user=\"root\" ; flush privileges;" ;

##/usr/local/mysql/bin/mysqladmin -uroot -S ${datadir}/mysql.sock  shutdown ;

sed -i "s/skip-grant-tables//g" /etc/my.cnf ;

/usr/local/mysql/support-files/mysql.server restart 1>mysql.out 2>mysql.out;

