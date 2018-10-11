### 安装

1. 在 `/etc/yum.repos.d ` 创建一个`mongodb-org.repo `源文件

   ```
   cd /etc/yum.repos.d/
   touch mongodb-org.repo
   vi mongodb-org.repo
   
   [mongodb-org-3.4]
   name=MongoDB Repository
   baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/
   gpgcheck=0
   enabled=1
   #gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc
   ```

2. 更新`yum`源

   ```
   yum update
   ```

3. 安装MongoDB

   ```
   yum install -y mongodb-org
   ```

4. 启动MongoDB

   ```
   service mongod start
   chkconfig mongod on
   ```

5. 配置远程访问

   ```
   vi /etc/mongod.conf

   BindIP 127.0.0.1 ==> 0.0.0.0
   ```



### 相关命令

启动MongoDB
```
$ sudo service mongod start
```
设置开机启动
```
$ sudo chkconfig mongod on
```
停止MongoDB
```
$ sudo service mongod stop
```
重启MongoDB
```
$ sudo service mongod restart
```
注意： 在Centos 7 版本中，运行上述命令虽然也能达到效果，但还是建议使用如下命令：

启动MongoDB
```
$ sudo systemctl start mongod.service
```
验证MongoDB是否成功启动
```
$ sudo cat /var/log/mongodb/mongod.log
```
如出现`[thread1] waiting for connections on port <port>`

其中的默认为27017，在 /etc/mongod.conf中配置，则启动成功！

设置开机启动
```
$ sudo systemctl enable mongod.service
```
停止MongoDB
```
$ sudo systemctl stop mongod.service
```
重启MongoDB
```
$ sudo systemctl restart mongod.service
```
### 卸载MongoDB

彻底卸载MongoDB，必须移除MongoDB应用程序，移除配置文件和任何包含数据及日志的目录。下面的指南是彻底卸载MongoDB的必须步骤。

警告：如下步骤将会彻底卸载MongoDB，包括其配置文件和所有的数据库文件。这个过程是不可逆的，所以确保在执行这些步骤之前已经备份了你的配置文件和数据文件。

I. 停止MongoDB
```
$ sudo service mongod stop
```
II. 移除MongoDB包
移除之前安装的所有MongoDB包

```
$ sudo yum erase $(rpm -qa | grep mongodb-org)
```
III. 删除数据文件及日志文件
删除MongoDB数据库和日志文件

```
$ sudo rm -r /var/log/mongodb
```
```
$ sudo rm -r /var/lib/mongo
```

