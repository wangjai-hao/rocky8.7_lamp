#!/bin/bash
function mysql_uppass(){
read -p "请输入mysql路径，如：/opt/mysql,默认为/opt/mysql" path
if [ -z ${path} ]; then
    path="/opt/mysql"
fi

                  
#定义mysql的路径

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "must root"
    exit 1
fi
 
echo "+-------------------------------------------------------------------+"
echo "|   重置 MySQL Root 密码                                            |"
echo "+-------------------------------------------------------------------+"
 
if [ -s ${path}/bin/mysql ]; then
    DB_Name="mysql"
    DB_Version=`${path}/bin/mysql_config --version`
else
    echo "没有mysql"
    exit 1
fi
 
while :;do
    DB_Root_Password=""
#定义mysqlroot的密码
    read -p "请输入新的 ${DB_Name} root 密码: " DB_Root_Password
    if [ "${DB_Root_Password}" = "" ]; then
        echo "错误：密码不能为空"
    else
        break
    fi
done
 
echo "Stoping ${DB_Name}..."
/etc/init.d/${DB_Name} stop
echo "Starting ${DB_Name} with skip grant tables"
${path}/bin/mysqld_safe --skip-grant-tables >/dev/null 2>&1 &
sleep 5
echo "update ${DB_Name} root password..."
if echo "${DB_Version}" | grep -Eqi '^8.0.|^5.7.|^10.[234].'; then
    ${path}/bin/mysql -u root << EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_Root_Password}';
EOF
else
    ${path}/bin/mysql -u root << EOF
update mysql.user set password = Password('${DB_Root_Password}') where User = 'root';
EOF
fi
 
if [ $? -eq 0 ]; then
    echo "Password reset succesfully. Now killing mysqld softly"
    if command -v killall >/dev/null 2>&1; then
        killall mysqld
    else
        kill `pidof mysqld`
    fi
    sleep 5
    echo "Restarting the actual ${DB_Name} service"
    /etc/init.d/${DB_Name} start
    echo "重置后的密码为 '${DB_Root_Password}'"
else
    echo "重置 ${DB_Name} root 密码失败"
fi

sleep 2s
 mysql="/opt/mysql/bin/mysql -uroot -p${DB_Root_Password}"
# #定义进入mysql的语句
# #sql="show tables from mysql"
sql="create database wordpress"
# #创建一条mysql语句
 $mysql -e "$sql"
# #进入到mysql数据库执行sql语句
}