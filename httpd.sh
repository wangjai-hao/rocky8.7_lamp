#/bin/bash
function httpd(){
need

yum install libxml2-devel pcre2-devel.x86_64 expat-devel.x86_64 bzip2 -y
wget https://downloads.apache.org/apr/apr-util-1.6.3.tar.gz
wget https://archive.apache.org/dist/apr/apr-1.7.2.tar.gz
wget http://archive.apache.org/dist/httpd/httpd-2.4.54.tar.gz
tar xvf apr-1.7.2.tar.gz
cd apr-1.7.2
./configure --prefix=/opt/apr
make -j  && make install
cd ..
tar xvf apr-util-1.6.3.tar.gz
cd apr-util-1.6.3/
./configure --prefix=/opt/apr-uilt --with-apr=/opt/apr
make -j  && make install
cd ..
tar -xvf httpd-2.4.54.tar.gz
cd httpd-2.4.54/
./configure --prefix=/opt/httpd --with-apr=/opt/apr --with-apr-util=/opt/apr-uilt
make -j  && make install
cd ..
echo PATH=$PATH:/opt/httpd/bin >> /etc/profile && . /etc/profile

rm -rf apr*
rm -rf httpd-*
echo -e "\033[0;31;40m完成构建httpd服务\033[0m"

}

