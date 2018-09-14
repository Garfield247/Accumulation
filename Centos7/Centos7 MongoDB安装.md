# Centos7 MongoDB安装

## 环境准备

```shell
#创建MongoDB程序存放目录
mkdir /usr/local/mongodb 
#创建数据存放目录
mkdir /data/mongodata -p
#创建日志存放目录
mkdir /data/log/mongolog -p 
```

## 安装

``` shell
#解压安装包
tar -zxvf mongodb-linux-x86_64-rhel70-3.2.7.tgz
#进入解压目录
cd mongodb-linux-x86_64-rhel70-3.2.7
#将所有文件copy到/usr/local目录下
cp -r * /usr/local/mongodb/
```

## 配置环境变量

```shell
#创建mongo.sh
touch /etc/profile.d/mongo.sh
#将mongodb加入环境变量
export PATH=$path:/usr/local/mongodb/bin
#使配置生效
source /etc/profile
```

## 创建配置文件

```shell
vi /usr/local/mongodb/bin/mongodb.conf

#数据文件存放目录
dbpath = /data/mongodata
#日志文件存放目录
logpath = /data/log/mongolog/mongodb.log
#主机
0.0.0.0
#端口
port = 27017
#以守护程序的方式启用，即在后台运行
fork = true   
nohttpinterface = true
```



## 启动服务

```

```

