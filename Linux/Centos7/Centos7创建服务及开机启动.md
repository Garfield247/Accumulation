# Centos7创建服务及开机启动

安装依赖组件

```shell
yum install net-tools
```

创建服务程序

```shell
vi /etc/init.d/{server}
```

写入如下内容

```shell
#!/bin/bash
# description: {server}
#chkconfig: 2345 80 90
#description:auto_run
PORT=6800 #服务内容
HOME="/var/scrapyd" #日志路径
BIN="/project/.env_scrapyd/bin/scrapyd" #启动命令

pid=`netstat -lnopt | grep :$PORT | awk '/python/{gsub(/\/python/,"",$7);print $7;}'`
start() {
   if [ -n "$pid" ]; then
      echo "server already start,pid:$pid"
      return 0
   fi

   cd $HOME
   nohup $BIN >> $HOME/scrapyd.log 2>&1 &
   echo "start at port:$PORT"
}

stop() {
   if [ -z "$pid" ]; then
      echo "not find program on port:$PORT"
      return 0
   fi

   #结束程序，使用讯号2，如果不行可以尝试讯号9强制结束
   kill -9 $pid
   echo "kill program use signal 9,pid:$pid"
}

status() {
   if [ -z "$pid" ]; then
      echo "not find program on port:$PORT"
   else
      echo "program is running,pid:$pid"
   fi
}

case $1 in
   start)
      start
   ;;
   stop)
      stop
   ;;
   status)
      status
   ;;
   *)
      echo "Usage: {start|stop|status}"
   ;;
esac

exit 0

```

赋予可执行权限

```shell
chmod +x /etc/init.d/{server}
```

命令

- 启动

  `service {server} start`

- 停止

  `service {server} stop`

- 重启

  `service {server} restart`

- 查看状态

  `service {server} status`

- 开机启动

  `systemctl enable {server}.service`

