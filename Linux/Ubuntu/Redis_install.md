# ubuntu 安装redis

1. 安装
```shell
sudo apt-get update
sudo apt-get install redis-server
```

2. 配置远程访问, 编辑文件`/etc/redis/redis.conf`
```shell
bind 127.0.0.1 >> bind 0.0.0.0
```

