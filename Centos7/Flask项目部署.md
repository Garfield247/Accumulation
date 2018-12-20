# Flask项目部署

### 技术选型

|        | 版本      |
| ------ | ------- |
| python | 3.6.4   |
| Nginx  | 1.13.10 |
| uwsgi  | 2.0.17  |



### 一、NGINX安装

#####安装依赖软件

```
yum install -y gcc gcc-c++ autoconf automake zlib zlib-devel openssl openssl-devel pcre pcre-devel
```

##### 创建nginx运行账户www，不允许直接登录系统

```
useradd www -s /sbin/nologin
```

##### 安装Nginx

```
tar -zxvf nginx-1.13.10.tar.gz
cd nginx-1.13.10

./configure --prefix=/usr/local/nginx --user=www --group=www --without-http_memcached_module --with-http_stub_status_module --with-http_ssl_module    

make && make install	
```

##### 编辑nginx开机启动脚本

```
#!/bin/bash
# nginx Startup script for the Nginx HTTP Server
# it is v.0.0.2 version.
# chkconfig: - 85 15
# description: Nginx is a high-performance web and proxy server.
# It has a lot of features, but it's not for everyone.
# processname: nginx
# pidfile: /var/run/nginx.pid
# config: /usr/local/nginx/conf/nginx.conf
nginxd=/usr/local/nginx/sbin/nginx
nginx_config=/usr/local/nginx/conf/nginx.conf
nginx_pid=/usr/local/nginx/logs/nginx.pid
RETVAL=0
prog="nginx"
# Source function library.
. /etc/rc.d/init.d/functions
# Source networking configuration.
. /etc/sysconfig/network
# Check that networking is up.
[ ${NETWORKING} = "no" ] && exit 0
[ -x $nginxd ] || exit 0
# Start nginx daemons functions.
start() {
if [ -e $nginx_pid ];then
echo "nginx already running...."
exit 1
fi
echo -n $"Starting $prog: "
daemon $nginxd -c ${nginx_config}
RETVAL=$?
echo
[ $RETVAL = 0 ] && touch /var/lock/subsys/nginx
return $RETVAL
}
# Stop nginxc daemons functions.
stop() {
echo -n $"Stopping $prog: "
killproc $nginxd
RETVAL=$?
echo
[ $RETVAL = 0 ] && rm -f /var/lock/subsys/nginx /usr/local/nginx/logs/nginx.pid
}
reload() {
echo -n $"Reloading $prog: "
#kill -HUP `cat ${nginx_pid}`
killproc $nginxd -HUP
RETVAL=$?
echo
}
# See how we were called.
case "$1" in
start)
start
;;
stop)
stop
;;
reload)
reload
;;
restart)
stop
start
;;
status)
status $prog
RETVAL=$?
;;
*)
echo $"Usage: $prog {start|stop|restart|reload|status|help}"
exit 1
esac
exit $RETVAL

```

##### 设置nginx开启启动
```
cp /root/nginx/nginx /etc/init.d/ 		#拷贝启动文件
chmod 755 /etc/init.d/nginx 			#赋予文件执行权限
chkconfig nginx on 						#设置开机启动
service nginx start					
```

