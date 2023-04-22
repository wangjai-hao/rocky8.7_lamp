 #!/bin/bash
function php(){
    need
yum -y install epel-release
yum -y install net-snmp-devel sqlite-devel bzip2-devel.x86_64 libcurl-devel.x86_64 libcurl-devel net-snmp-devel.x86_64 libxml2 libxml2-devel sqlite-devel bzip2-devel sqlite 
yum install -y http://mirror.centos.org/centos/8-stream/PowerTools/x86_64/os/Packages/oniguruma-devel-6.8.2-2.el8.x86_64.rpm
wget https://www.php.net/distributions/php-7.4.33.tar.gz
tar xvf php-7.4.33.tar.gz
cd php-7.4.33/
./configure --prefix=/opt/php --with-config-file-path=/opt/php/etc --with-mysqli=mysqlnd --enable-embedded-mysqli --with-mysql-sock=/opt/mysql/ --enable-pdo --with-pdo-mysql=mysqlnd --with-iconv-dir=/opt/ --with-pcre-regex --with-zlib --with-bz2  --with-zlib-dir  --enable-zip --enable-calendar --disable-phar --with-curl  --enable-dba --with-libxml-dir --enable-ftp --with-gd --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-gd-jis-conv --with-mhash --enable-mbstring --enable-opcache=yes --enable-pcntl --enable-xml --disable-rpath --enable-sockets --enable-shmop --enable-bcmath --with-snmp  --disable-ipv6 --with-gettext --disable-debug  --enable-fpm --with-fpm-user=www --with-fpm-group=www
make -j
make install 
cp -a php.ini-production /opt/php/etc/php.ini
cp /opt/php/etc/php-fpm.conf.default /opt/php/etc/php-fpm.conf
cp /opt/php/etc/php-fpm.d/www.conf.default /opt/php/etc/php-fpm.d/www.conf
cd ..
useradd -s /bin/nologin www
cp -a ./php-7.4.33/sapi/fpm/php-fpm.service /usr/lib/systemd/system/php-fpm.service
systemctl daemon-reload 
systemctl start php-fpm.service 
echo PATH=$PATH:/opt/php/bin >> /etc/profile
source /etc/profile
rm -rf php-*
echo -e "\033[0;31;40m完成构建php-fpm服务\033[0m"
}