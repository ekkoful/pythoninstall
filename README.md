### pythoninstall
#### 自动安装python并配置相关环境
1. 自动安装python2.7或者python3.6
2. 完成时间:2017-12-12
3. 此文档编辑时间:2017-12-12

#### 测试环境
1. CentOS6.5 64Bit
2. Python2.7.14
3. pip9.0.1
4. 测试机器配置2H1G

#### 相关文件路径
1. python2.7 安装路径：/usr/local/python27/
2. python3.6 安装路径：/usr/local/python3/
3. pip安装路径：/usr/local/$python/bin

#### 文件相关
1. /pythontar：下载的源码文件(可以删除)
2. /usr/src：解压后的源码文件配置

#### 注意事项
1. 保持网络畅通
2. 保持yum源可以使用

#### 使用方法
```bash
   cd
   git clone https://github.com/Beechoing/pythoninstall.git
   cd pythoninstall
   chmod +x pyinstall.sh
   ./pyinstall.sh
```
