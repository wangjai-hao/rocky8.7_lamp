function lamp(){
    sed -i "s/daemon/www/g" /opt/httpd/conf/httpd.conf
    sed -i "s/index.html/index.php/g" /opt/httpd/conf/httpd.conf
    sed -ri "s/#(.*)mod_proxy_fcgi.so/\1mod_proxy_fcgi.so/g" /opt/httpd/conf/httpd.conf 
    sed -ri "s/#(.*)mod_proxy.so/\1mod_proxy.so/g" /opt/httpd/conf/httpd.conf 
    echo "Include conf/extra/httpd-fcgi.conf" >> /opt/httpd/conf/httpd.conf
    cat>>/opt/httpd/conf/extra/httpd-fcgi.conf<<EOF
<FilesMatch "\.php$">
SetHandler  "proxy:fcgi://127.0.0.1:9000"
</FilesMatch>
EOF
    wget https://cn.wordpress.org/latest-zh_CN.tar.gz
    tar -xvf latest-zh_CN.tar.gz
    mv wordpress/* /opt/httpd/htdocs/
    killall httpd
    sleep 2s
     chmod 777 /opt/httpd/htdocs
    /opt/httpd/bin/httpd
    rm -rf wordpress latest*
}
