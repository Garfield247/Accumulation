# CentOS7爬虫环境搭建

1. python安装（Master,Slave）

   ```shell
   1.安装依赖
   yum -y install openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel 
   yum -y install wget
   yum -y install gcc
   2.下载python3.6.4
   wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz
   3.解压tgz包
   tar -zxvf Python-3.6.4.tgz
   4.将解压后的python移到/usr/local下面
   mv Python-3.6.4 /usr/local
   5.进入python目录
   cd /usr/local/Python-3.6.4/
   6.配置
   ./configure
   7.编译 make
   make
   8.编译，安装
   make install
   9.创建新的软链接到最新的python
   ln -s /usr/local/bin/python3.6 /usr/bin/python3
   11.查看python版本
   python3 -V
   ```

2. redis安装（Master）

   ```shell
   1.关闭防火墙：
   systemctl stop firewalld.service #停止firewall
   systemctl disable firewalld.service #禁止firewall开机启动
   firewall-cmd --state #查看默认防火墙状态（关闭后显示notrunning，开启后显示running）
   2.配置编译环境：
   sudo yum -y install gcc-c++
   3.下载源码：
   wget http://download.redis.io/releases/redis-3.2.8.tar.gz
   4.解压源码：
   tar -zxvf redis-3.2.8.tar.gz
   5.复制解压后的文件夹到/usr/local
   cp -r ./redis-3.2.8 /usr/local/redis
   cd /usr/local/redis
   6.编译安装
   make install
   如果有错，输入这个指令make MALLOC=libc
   7.启动测试是否安装成功
   cd src
   ./redis-server     //redis端口号默认为6379
   8设置开机启动及远程连接
   cd /usr/local/redis
   cp redis.conf redis_6379.conf
   vi redis_6379.conf
   第61行 bind 0.0.0.0
   第80行  protected-mode no
   第128行    daemonize yes
   cd utils/
   cp redis_init_script redis_init_script_6379
   vi redis_init_script_6379
   EXEC=/usr/local/redis/src/redis-server
   CLIEXEC=/usr/local/redis/src/redis-cli
   CONF="/usr/local/redis/redis_6379.conf"
   启动   ./redis_init_script_6379 start
   查看是否启动   ps -ef | grep redis
   添加到开机启动中
   vi /etc/rc.local
   添加一行
   /usr/local/redis/utils/redis_init_script_6379 start
   给/etc/rc.d/rc.local加执行权限
   chmod +x /etc/rc.d/rc.local

   Redis服务查看、开启、关闭:
   a.通过ps -ef|grep redis命令查看Redis进程
   b.开启Redis服务操作通过/etc/init.d/redis_6379 start命令，也可通过（service redis_6379 start）
   c.关闭Redis服务操作通过/etc/init.d/redis_6379 stop命令，也可通过（service redis_6379 stop）
   redis.conf 的配置信息
   1、daemonize 如果需要在后台运行，把该项改为yes
   2、pidfile 配置多个pid的地址 默认在/var/run/redis.pid
   3、bind 绑定ip，设置后只接受来自该ip的请求
   4、port 监听端口，默认是6379
   5、loglevel 分为4个等级：debug verbose notice warning
   6、logfile 用于配置log文件地址
   7、databases 设置数据库个数，默认使用的数据库为0
   8、save 设置redis进行数据库镜像的频率。
   9、rdbcompression 在进行镜像备份时，是否进行压缩
   10、dbfilename 镜像备份文件的文件名
   11、Dir 数据库镜像备份的文件放置路径
   12、Slaveof 设置数据库为其他数据库的从数据库
   13、Masterauth 主数据库连接需要的密码验证
   14、Requriepass 设置 登陆时需要使用密码
   15、Maxclients 限制同时使用的客户数量
   16、Maxmemory 设置redis能够使用的最大内存
   17、Appendonly 开启append only模式
   18、Appendfsync 设置对appendonly.aof文件同步的频率（对数据进行备份的第二种方式）
   19、vm-enabled 是否开启虚拟内存支持 （vm开头的参数都是配置虚拟内存的）
   20、vm-swap-file 设置虚拟内存的交换文件路径
   21、vm-max-memory 设置redis使用的最大物理内存大小
   22、vm-page-size 设置虚拟内存的页大小
   23、vm-pages 设置交换文件的总的page数量
   24、vm-max-threads 设置VM IO同时使用的线程数量
   25、Glueoutputbuf 把小的输出缓存存放在一起
   26、hash-max-zipmap-entries 设置hash的临界值
   27、Activerehashing 重新hash
   ```

3. mysql（Master,Slave）

   ```shell
   1、先检查系统是否装有mysql
   rpm -qa | grep mysql
   这里执行安装命令是无效的，因为centos-7默认是Mariadb，所以执行以下命令只是更新Mariadb数据库
   yum -y install mysql
   删除可用
   yum -y remove mysql
   2、下载mysql的repo源
   wget http://repo.mysql.com/mysql57-community-release-el7-10.noarch.rpm
   	安装rpm包
   sudo rpm -Uvh mysql57-community-release-el7-10.noarch.rpm
   3、安装mysql
   yum install  -y  mysql-community-server
   4、启动mysql
   service mysqld start
   5、重置密码
   	获取临时密码
   	grep 'temporary password' /var/log/mysqld.log
   	复制root@localhost:后面的密码
   	登录
   	mysql -u root -p
   	粘贴刚才的密码
   	登陆成功，修改密码
   	ALTER USER 'root'@'localhost' IDENTIFIED BY 'root123';
   	若报错1819，进行如下操作,	再进行修改：
       mysql> set global validate_password_policy=0;
       mysql> set global validate_password_length=1;
       允许远程登录
   	GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'yourpassword' WITH GRANT OPTION;

   6、查询数据库编码格式，确保是 UTF-8
   	mysql> show variables like "%char%";
   	修改mysql的/etc/my.cnf 文件中的字符集键值
   	在[mysqld]字段里加入character_set_server=utf8，如下：  
   	[mysqld]  
   	port = 3306  
   	socket = /var/lib/mysql/mysql.sock  
    	character_set_server=utf8
    7、重启mysql
   service mysqld restart
   ```

   ​

   ​
