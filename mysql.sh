function mysql(){
    need

yum install openssl-devel.x86_64 -y
sudo yum install -y glibc -y
sudo yum install -y libstdc++ -y
wget https://github.com/Kitware/CMake/releases/download/v3.25.2/cmake-3.25.2.tar.gz
tar -xvf cmake-3.25.2.tar.gz 
cd cmake-3.25.2/
./configure
make  && make install
cd ..
# wget https://udomain.dl.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.gz
# mv boost_1_59_0.tar.gz /opt/

# tar -xvf /opt/boost_1_59_0.tar.gz -C /opt/
# mv /opt/boost_1_59_0 boost

yum remove mariadb-libs.x86_64 -y
yum install ncurses-devel -y
yum install libtirpc-devel.x86_64 -y

wget https://github.com/thkukuk/rpcsvc-proto/releases/download/v1.4/rpcsvc-proto-1.4.tar.gz
tar xf rpcsvc-proto-1.4.tar.gz
cd rpcsvc-proto-1.4
./configure
make
make install
cd ..

useradd -s /sbin/nologin -r mysql
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.40.tar.gz
tar -xvf mysql-5.7.40.tar.gz 
cd mysql-5.7.40
cmake . -DCMAKE_INSTALL_PREFIX=/opt/mysql  -DMYSQL_DATADIR=/opt/mysql/data/ -DMYSQL_UNIX_ADDR=/opt/mysql/mysql.sock  -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MYISAM_STORAGE_ENGINE=1  -DENABLED_LOCAL_INFILE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DMYSQL_USER=mysql -DWITH_DEBUG=0 -DWITH_EMBEDDED_SERVER=1 -DDOWNLOAD_BOOST=1  -DENABLE_DOWNLOADS=1 -DWITH_BOOST=/opt/boost 
make
make install
cd ..
mkdir /opt/mysql/log
mkdir /opt/mysql/etc
mkdir /opt/mysql/data
touch /opt/mysql/log/mysql.error
cp my.cnf /opt/mysql/etc/
chown mysql.mysql /opt/mysql/ -R
/opt/mysql/bin/mysqld --initialize --user=mysql --basedir=/opt/mysql/ --datadir=/opt/mysql/data/ 
cp /opt/mysql/support-files/mysql.server /etc/init.d/mysql
echo PATH=$PATH:/opt/mysql/bin >> /etc/profile &&. /etc/profile
rm -rf cmake*
rm -rf mysql-*
rm -rf rpcsvc*
echo -e "\033[0;31;40m完成构建mysql服务\033[0m"
}