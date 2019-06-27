# Centos7+Nginx+uWsgi部署Flask项目

## 安装

### Nginx

#### 第一步 - 添加Nginx存储库

要添加CentOS 7 EPEL仓库，请打开终端并使用以下命令：

```
sudo yum install epel-release
```

#### 第二步 - 安装Nginx

现在Nginx存储库已经安装在您的服务器上，使用以下`yum`命令安装Nginx ：

```
sudo yum install nginx -y
```

#### 第三步 - 启动Nginx

Nginx不会自行启动。要运行Nginx，请输入：

```
sudo systemctl start nginx
```

#### 第四步 - 设置开机自启

```
systemctl enable nginx
```

### uWsgi

直接使用pip安装

```
pip install uwsgi
```

## 关闭防火墙

### firewall

```
systemctl stop firewalld.service #停止firewall
systemctl disable firewalld.service #禁止firewall开机启动
firewall-cmd --state #查看默认防火墙状态（关闭后显示notrunning，开启后显示running）
```

### selinux

```
vim /etc/sysconfig/selinux
```

SELINUX=enforcing 改为 SELINUX=disabled

重启服务reboot

## 配置

Uwsgi

```uwsgi
[uwsgi]
socket = 127.0.0.1:5051
pythonpath = {项目路径}
module = {启动文件名称(不加py)}
wsgi-file = {启动文件的path}
callable = app
processes = 4
threads = 2
daemonize = {日志存放路径}
```

Nginx

vi /etc/nginx/conf.d/flask.conf

```
server {
        listen       80;         //默认的web访问端口
        server_name  xxxxxx;     //服务器名
        #charset koi8-r;
        access_log  /var/logs/nginx/access.log;    //服务器接收的请求日志，logs目录若不存在需要创建，否则nginx报错
        error_log  /var/logs/nginx/error.log;         //错误日志

        location / {

            include        uwsgi_params;     //这里是导入的uwsgi配置

            uwsgi_pass     127.0.0.1:5051;   //需要和uwsgi的配置文件里socket项的地址
                                             //相同,否则无法让uwsgi接收到请求。

            uwsgi_param UWSGI_CHDIR  /flask;     //项目根目录

            uwsgi_param UWSGI_SCRIPT manage:app;     //启动项目的主程序(在本地上运行
                                                     //这个主程序可以在flask内置的
                                                     //服务器上访问你的项目)
}
}
```

