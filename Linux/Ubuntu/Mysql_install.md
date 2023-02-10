# Ubuntu Mysql 5.7安装

## 安装

1.安装MySQL服务端和客户端：
```shell
sudo apt-get install mysql-server-5.7
```
> 此时会提示输入密码和确认密码

2.安装依赖：
```shell
sudo apt install libmysqlclient-dev
```

## 允许远程登录

1. 修改mysql的`/etc/mysql/mysql.conf.d/mysqld.cnf` ，在[mysqld]字段修改

```shell
bind-address=0.0.0.0
```
2. 在mysql中进行设置远程登录

```sql
mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'yourpassword' WITH GRANT OPTION;
```

## 数据库编码

1. 查询数据库编码格式，确保是 UTF-8

```shell
mysql> show variables like "%char%";
```

 2. 修改mysql的`/etc/mysql/mysql.conf.d/mysqld.cnf` 文件中的字符集键值，在[mysqld]字段里加入

```shell
character_set_server=utf8
```

3. 重启mysql

```shell
service mysqld restart
```






