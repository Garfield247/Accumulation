# Nginx 安装



### 一、安装编译工具及库文件

```
yum -y install make zlib zlib-devel gcc-c++ libtool  openssl openssl-devel
```

### 二、首先要安装 PCRE

PCRE 作用是让 Nginx 支持 Rewrite 功能。

1、下载 PCRE 安装包，下载地址： <http://downloads.sourceforge.net/project/pcre/pcre/8.35/pcre-8.35.tar.gz>

```
wget http://downloads.sourceforge.net/project/pcre/pcre/8.35/pcre-8.35.tar.gz
```

2、解压安装包:

```
tar zxvf pcre-8.35.tar.gz
```

3、进入安装包目录

```
cd pcre-8.35
```

4、编译安装 

```
./configure
make && make install
```

5、查看pcre版本

```
pcre-config --version
```

### 安装 Nginx

1、下载 Nginx，下载地址：<http://nginx.org/download/nginx-1.6.2.tar.gz>

```
wget http://nginx.org/download/nginx-1.6.2.tar.gz
```

2、解压安装包

```
tar zxvf nginx-1.6.2.tar.gz
```

3、进入安装包目录

```
cd nginx-1.6.2
```

4、编译安装

```
./configure --prefix=/usr/local/webserver/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre=/usr/local/src/pcre-8.35
make
make install
```

5、查看nginx版本

```
/usr/local/webserver/nginx/sbin/nginx -v
```

到此，nginx安装完成。