function need () {
    setenforce 0
    systemctl stop firewalld.service 
   yum install gcc gcc-c++ wget make -y 
   chack $?
}
function display(){
echo "#############################"
echo "1.httpd静态网站构建"
echo "2.mysql数据库构建"
echo "3.mysql密码重置"
echo "4.php-fpm服务构建"
echo "5.LAMP平台构建,并安装WordPress"
echo "0.退出程序"
echo "#############################"
read -p "请输入你需要构建的项目" id
pass $id
}

function pass(){
   case "${1}" in
    1)
        httpd
    ;;
    2)
        mysql
    ;;
    3)
        mysql_uppass
    ;;
    4)
        php
    ;;
    5)
        lamp
    ;;
    0)
        echo '感谢使用，有问题可以联系2678857625@qq.com'
        exit
    ;;
    *)
        echo "输入错误请重新输入"
        display
    ;;
   esac
}

function chack(){
   if (( $1 != 0 )); then
    echo "请检查问题"
    exit 
   
   fi
}
