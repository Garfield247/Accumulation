# CentOS7 安装 MySQL5.7

## 安装

1. 先检查系统是否装有 mysql

   ```shell
   rpm -qa | grep mysql
   ```

2. 安装

   <!--这里执行安装命令是无效的，因为centos-7默认是Mariadb，所以执行以下命令只是更新Mariadb数据库-->

   ```
   yum -y install mysql
   ```

3. 删除可用

   ```
   yum -y remove mysql
   ```

4. 导入 mysql 的 repo 秘钥

   ```
   rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
   ```

5. 下载 mysql 的 repo 源

   ```
   wget http://repo.mysql.com/mysql57-community-release-el7-10.noarch.rpm
   ```

6. 安装 rpm 包

   ```
   sudo rpm -Uvh mysql57-community-release-el7-10.noarch.rpm
   ```

7. 安装 mysql

   ```
   yum install  -y  mysql-community-server
   ```

8. 启动 mysql

   ```
   service mysqld start
   ```

## 重置初始密码

1. 获取临时密码

   ```shell
   grep 'temporary password' /var/log/mysqld.log
   ```

   复制 root@localhost:后面的密码

2. 登录

   ```shell
   mysql -u root -p
   ```

   粘贴刚才的密码，登陆成功。

3. 修改密码

   ```sql
   mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'yourpassword';
   ```

   若报错 1819，进行如下操作, 再进行修改：

   ```sql
   mysql> set global validate_password_policy=0;
   mysql> set global validate_password_length=1;
   ```

## 允许远程登录

```sql
mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'yourpassword' WITH GRANT OPTION;
```

## 数据库编码

1. 查询数据库编码格式，确保是 UTF-8

   ```
   mysql> show variables like "%char%";
   ```

2. 修改 mysql 的`/etc/my.cnf` 文件中的字符集键值，在[mysqld]字段里加入

   ```
   character_set_server=utf8
   ```

3. 重启 mysql

   ```
   service mysqld restart
   ```
