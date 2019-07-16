# CentOS7爬虫环境搭建redis安装（Master）

##  准备工作

1. 关闭防火墙：

   - 停止firewall

     ```
     systemctl stop firewalld.service
     ```

   - 禁止firewall开机启动

     ```
     systemctl disable firewalld.service
     ```

   - 查看默认防火墙状态（关闭后显示notrunning，开启后显示running）

     ```
     firewall-cmd --state
     ```

2. 配置编译环境：

   ```
   sudo yum -y install gcc-c++
   ```

   

## 下载安装



1. 检查是否有redis yum 源

   ```
   yum install redis
   ```

2. 下载fedora的epel仓库

   ```
   yum install epel-release
   ```

3. 安装redis数据库

   ```
   yum install redis
   ```

## 安装完毕后，使用下面的命令启动redis服务

   - 启动redis
   
     `service redis start`
   
   - 停止redis
   
     `service redis stop`
   
   - 查看redis运行状态
   
     `service redis status`
   
   - 查看redis进程
   
     `ps-ef | grep redis`
   
   - 设置redis为开机自动启动
   
     `chkconfig redis on`

## 设置远程连接`vi /etc/redis.conf`

   第61行 bind 0.0.0.0
   第80行  protected-mode no
   第128行    daemonize yes

   


## Redis服务查看、开启、关闭:

I. 通过ps -ef|grep redis命令查看Redis进程

ii. 开启Redis服务操作通过/etc/init.d/redis_6379 start命令，也可通过（service redis_6379 start）

iii. 关闭Redis服务操作通过/etc/init.d/redis_6379 stop命令，也可通过（service redis_6379 stop）

## redis.conf 的配置信息

| 参数                    | 说明                                                         |
| ----------------------- | ------------------------------------------------------------ |
| daemonize               | 如果需要在后台运行，把该项改为yes                            |
| pidfile                 | 配置多个pid的地址 默认在/var/run/redis.pid                   |
| bind                    | 绑定ip，设置后只接受来自该ip的请求                           |
| port                    | 监听端口，默认是6379                                         |
| loglevel                | 分为4个等级：debug verbose notice warning                    |
| logfile                 | 用于配置log文件地址                                          |
| databases               | 设置数据库个数，默认使用的数据库为0                          |
| save                    | 设置redis进行数据库镜像的频率。                              |
| rdbcompression          | 在进行镜像备份时，是否进行压缩                               |
| dbfilename              | 镜像备份文件的文件名                                         |
| Dir                     | 数据库镜像备份的文件放置路径                                 |
| Slaveof                 | 设置数据库为其他数据库的从数据库                             |
| Masterauth              | 主数据库连接需要的密码验证                                   |
| Requriepass             | 设置 登陆时需要使用密码                                      |
| Maxclients              | 限制同时使用的客户数量                                       |
| Maxmemory               | 设置redis能够使用的最大内存                                  |
| Appendonly              | 开启append only模式                                          |
| Appendfsync             | 设置对appendonly.aof文件同步的频率（对数据进行备份的第二种方式） |
| vm-enabled              | 是否开启虚拟内存支持 （vm开头的参数都是配置虚拟内存的）      |
| vm-swap-file            | 设置虚拟内存的交换文件路径                                   |
| vm-max-memory           | 设置redis使用的最大物理内存大小                              |
| vm-page-size            | 设置虚拟内存的页大小                                         |
| vm-pages                | 设置交换文件的总的page数量                                   |
| vm-max-threads          | 设置VM IO同时使用的线程数量                                  |
| Glueoutputbuf           | 把小的输出缓存存放在一起                                     |
| hash-max-zipmap-entries | 设置hash的临界值                                             |
| Activerehashing         | 重新hash                                                     |


