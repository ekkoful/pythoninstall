#! /bin/bash
#
# This is a script for auto install python2.7+
#
# CentOS 6 + Python2.7+ or Python3+
#
# SystemVersion: CentOS 6.5
#
# Author : beechoing@126.com
#
# GitHub : https://github.com/Beechoing/pythoninstall.git
#

read -p  "请输入你想要安装的python2.7或者3.6(输入2或者3即可): " m
until [ $m -eq 2 -o $m -eq 3 ];do 
	read -p  "请输入你想要安装的python2.7或者3.6(输入2或者3即可): " m
done 

echo "日志文件为~/.pyinstall.log" 
touch ~/.pyinstall.log
log=~/.pyinstall.log

echo "创建目录/pythontar存放安装包..."
mkdir /pythontar 

echo "安装开发环境" | tee -a $log
yum groupinstall "Development tools" -y &>> $log
yum groupinstall "Server Platform Development" -y &>> $log
yum install openssl-devel -y &>> $log


if [ $m -eq 2 ];then 
	echo "正在下载python2.7.14..."
	wget -q https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tgz -P /pythontar/
	tar xf /pythontar/Python-2.7.14.tgz -C /usr/src/ 
	cd /usr/src/Python-2.7.14
	./configure --prefix=/usr/local/python27/ --enable-shared
	make && make install
	cd 
	mv /usr/bin/python{,2.6.6}
	ln -s /usr/local/python27/bin/python2.7 /usr/bin/python 
	sed -i '1 s/python/python2.6/g' /usr/bin/yum 
	echo "export PATH=$PATH:/usr/local/python27/bin" > /etc/profile.d/py.sh
	source /etc/profile.d/py.sh
	echo '/usr/local/python27/lib' > /etc/ld.so.conf.d/libpython2.3.conf
	ldconfig
else
	echo "正在下载python3.6.3..."
	wget -q https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz -P /pythontar/
	tar xf /pythontar/Python-3.6.3.taz -C /usr/src/
	cd /usr/src/Python-3.6.3
	./configure --prefix=/usr/local/python3/ --enable-shared 
	make && make install
	cd 
	mv /usr/bin/python{,2.6.6}
	ln -s /usr/local/python3/bin/python /usr/bin/python 
	sed -i '1 s/python/python2.6/g' /usr/bin/yum 
	echo "export PATH=$PATH:/usr/local/python3/bin" > /etc/profile.d/py.sh
	source /etc/profile.d/py.sh
	echo '/usr/local/python3/lib' > /etc/ld.so.conf.d/libpython3.conf
	ldconfig
fi 

if `python --version`;then 
	echo "新版本python已经安装完成"
	read -p "请问是否安装pip...(y|n): " s 
	until [ $s == 'y' -o $s == 'n' ];do 
		read -p "请问是否安装pip...(y|n): " s 
	done

	if [ $s == 'y' ];then
		echo "正在下载pip..."
		wget -q https://bootstrap.pypa.io/get-pip.py -P /pythontar/
		cd /pythontar/
		python get-pip.py
		source /etc/profile.d/py.sh
		echo "脚本执行结束^-^"
	else 
		echo "脚本执行结束^-^"
	fi
else 
	echo "新版本python安装失败,请查找错误原因" 
	echo "脚本执行结束^-^"
fi




