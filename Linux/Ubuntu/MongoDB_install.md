# MongoDB_Install_on_deepin

### 一.相关程序安装包介绍

**MongoDB 在他们自己的仓库中提供了官方支持的包。其存储库包含以下软件包**

- `mongodb-org` : 此包是元数据包，它可以实现自动安装下面的4个组件包
- `mongodb-org-mongos` : 此包里面有 `mongos` 守护程序
- `mongodb-org-shell` : 此包里面有 `mongo shell` 环境
- `mongodb-org-tools` : 此包里面有 `MongoDB` 工具，`mongoimport`、`bsondump`、`mongodump`、`mongoexport`、`mongofiles`、`mongoimport`、`mongooplog`、`mongoperf`、`mongorestore`、`mongostat` 以及 `mongotop`
- `mongodb-org-server` : 包里面有 `mongod` 守护程序，以及相关的配置和初始化(init)脚本。

mongodb-org-server 软件包提供的初始化脚本使用 `/etc/mongod.conf` 配置文件启动 [mongod](https://docs.mongodb.com/manual/reference/program/mongod/#bin.mongod)。

有关使用此初始化脚本的详细信息，请参阅运行 [MongoDB Community Edition](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/#run-mongodb-community-edition)。

这些软件包与 `Debian` 提供的 `mongodb`，`mongodb-server` 以及 `mongodb-clients` 软件包相冲突。

默认情况下，软件包提供 `/etc/mongod.conf` 配置文件的 `bind_ip` z值为 `127.0.0.1`。在初始化副本集之前需要根据系统环境修改此设置。

### 二.安装 MongoDB

*如果需要安装其他不同版本的 MongoDB，可以参考该版本的文档。本安装指南仅支持 64 位系统。*

**1.导入 MongoDB 公钥**

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
```

如果报错 ` gpg: keyserver receive failed: No dirmngr` ，则安装Dirmngr（dirmngr - GNU隐私保护网络证书管理服务）

```
sudo apt-get install dirmngr
```

**2.创建 MongoDB 的软件源 /etc/apt/sources.list.d/mongodb-org-3.6.list**
可以选择安装 Debian 7 的 `Wheezy` 仓库

```
echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.6 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
```

也可以使用 Debian 8 的 `Jessie`　仓库

```
echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.6 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
12
```

当前软件仅支持 Debian 7 的 `Wheezy` 和 Debian 8 的 `Jessie`

### 三.更新 `apt-get`

```
sudo apt-get update
```

### 四.安装 MongoDB 软件包

**1.安装最新的稳定版本**

```
sudo apt-get install -y mongodb-org
```

**安装 MongoDB 的特定版本**
要安装特定发行版，必须单独地指定每个组件包以及版本号，如下例所示：

```
sudo apt-get install -y mongodb-org = 3 .6.2 mongodb-org-server = 3 .6.2 mongodb-org-shell = 3 .6.2 mongodb-org-mongos = 3 .6.2 mongodb-org-tools = 3 .6.2
```

如果只安装 `mongodb-org=3.6.2` 且不包含组件包，则无论指定的是什么版本，安装的每个 `MongoDB` 软件包都是最新版本。

**2.防止版本更新**

通过 `aot-get` 虽然可以指定任何可用的 `MongoDB` 版本， 但是当更新的版本变得可用时将升级包。为防止意外升级，要将 `MongoDB` 的版本固定为当前安装的版本

```
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections
```

### 五.解决没有 `/home/mongodb` 目录的问题

```
sudo mkdir /home/mongodb
sudo chown -R mongodb:mongodb /home/mongodb
```

### 六.运行 MongoDB

**1. 启动 MongoDB 服务**

命令启动 MongoDB 的 `mongod` 服务项

```
sudo systemctl start mongod
```

**2. 停止 MongoDB 服务**

```
sudo systemctl stop mongod
```

**3. 重启 MongoDB 服务**

```
sudo systemctl restart mongod
```

**4.设置开机启动或禁用 MOngoDB 开机自启**
设置开机自启

```
sudo systemctl enable mongod
```

如果不想开机自启，也可以禁用开机启动

```
sudo systemctl disable mongod
```

**6. 开始使用 MongoDB**

如果想获取帮助, [MongoDB](https://docs.mongodb.com/manual/#getting-started) 提供了开始指导。查看[开始指南](https://docs.mongodb.com/manual/#getting-started) 可以获取有用的帮助信息。

在命令窗口输入 `monogo` 进入 `MongoDB` 交互模式， `Control+C` 或 输入`exit` 退出命令窗口，此时后台 `mongod` 必须在运行状态。

```
mongo
```

### 七.删除 MongoDB

要从系统中完全删除 `MongoDB`，必须删除 `MongoDB` 应用程序本身，配置文件以及包含数据和日志的任何目录。
**Note: **这个删除MongoDB过程是不可逆的，包括程序配置文件、数据库文件都将被删除。所以，删除前，请备份好配置文件和数据库文件。

**1. 停止 MongoDB 服务**

```
sudo systemctl stop mongod
```

**2.删除软件**
移除已经安装的MongoDB程序

```
sudo apt-get purge mongodb-org*
```

**3.删除数据目录**
删除 MongoDB 数据库文件和日志文件

```
sudo rm -r /var/log/mongodb
sudo rm -r /var/lib/mongodb
```

*注意删除自己创建的数据目录*
