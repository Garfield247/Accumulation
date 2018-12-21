# Apt命令详解

*apt-cache和apt-get是apt包的管理工具，他们根据/etc/apt/sources.list里的软件源地址列表搜索目标软件、并通过维护本地软件包列表来安装和卸载软件。*

**查看本机是否安装软件：  whereis  package_name   或者  which  package_name**

1.搜索软件

```shell
sudo  apt-cache  search  package_name
```

其中还可以使用正则表达式 sudo apt-cache search sof* 这样就可以搜索到源上面所有以sof开头的软件包。

2.查看软件包信息

```shell
sudo apt-cache show package_name
```

3.查看软件包依赖关系

```shell
sudo apt-cache show depends package_name
```

4.查看每个软件包的简要信息

```shell
sudo apt-cache dump
```

5.安装软件

```shell
sudo apt-get install  package_name
```

6.更新已安装的软件包

```shell
sudo apt-get  upgrade
```

7.更新软件包列表

```shell
sudo apt-get update
```

8.卸载一个软件包但是保留相关的配置文件

```shell
sudo apt-get remove package_name
```

9.卸载一个软件包同时删除配置文件

```shell
apt-get -purge remove package_name
```

10.删除软件包的备份

```shell
apt-get clean
```

 

 Ubuntu 16.04 LTS 中使用 ATP 命令与老版本 Ubuntu 中软件包管理的用法对比：

| apt 命令         | 取代的命令           | 命令的功能                     |
| ---------------- | -------------------- | ------------------------------ |
| apt install      | apt-get install      | 安装软件包                     |
| apt remove       | apt-get remove       | 移除软件包                     |
| apt purge        | apt-get purge        | 移除软件包及配置文件           |
| apt update       | apt-get update       | 刷新存储库索引                 |
| apt upgrade      | apt-get upgrade      | 升级所有可升级的软件包         |
| apt autoremove   | apt-get autoremove   | 自动删除不需要的包             |
| apt full-upgrade | apt-get dist-upgrade | 在升级软件包时自动处理依赖关系 |
| apt search       | apt-cache search     | 搜索应用程序                   |
| apt show         | apt-cache show       | 显示装细节                     |

