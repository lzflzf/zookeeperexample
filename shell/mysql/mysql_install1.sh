/usr/local/mysql/support-files/mysql.server stop

rootpasswd=lizhifeng ;
datadir=/opt/mysql/data63 ;


# tar zxvf $1 -C /usr/local ;

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

