# Flask项目部署

### WEB工作原理

- 客户端 <=> WEB服务器(apache/nginx) <=> uWSGI <=> Python(Flask) <=> 数据库

### nginx安装

- 将共享的文件拷贝到虚拟机
- 关闭selinux和iptables
- 安装过程见《nginx安装.txt》

### 虚拟主机配置

- 在主配置文件(/usr/local/nginx/conf/nginx.conf)最后一个大括号的上面添加一行内容：`include vhost/*.conf;`

- 创建vhost文件夹：`mkdir vhost`

- 在vhost目录下创建一个虚拟主机的配置文件，如：www.test.com.conf

  ```nginx
  server {
      listen 80;
      server_name www.test.com test.com;

      location / {
          root html/test;
          index index.html;
      }
  }
  ```

- windows下修改文件：`C:\Windows\System32\drivers\etc\hosts`

  ```
  10.0.108.130		www.test.com
  ```

### uWSGI

- 安装uwsgi：`pip3 install uwsgi`

- 添加软链接：`ln -s /usr/local/python3/bin/uwsgi /usr/bin/uwsgi`

- 配置http

  `uwsgi --http 10.0.108.130:5000 --wsgi-file blog.py --callable app`

- 配置socket

  `uwsgi --socket 127.0.0.1:5000 --wsgi-file blog.py --callable app`

- 配置选项

  ```
  --http			# 采用http协议
  --socket		# socket进行通信
  --wsgi-file		# 将数据交给哪个模块
  --callable		# 具体交给哪个对象
  ```

### 完整部署

- nginx虚拟主机

  ```nginx
  server {
      listen 80;
      server_name www.test.com test.com;

      location / {
          include uwsgi_params;
      	uwsgi_pass 127.0.0.1:5000;
      }
  }
  ```

- uwsgi配置

  命令：`uwsgi --socket 127.0.0.1:5000 --wsgi-file blog.py --callable app`

  文件：

  ```ini
  [uwsgi]
  socket = 127.0.0.1:5000
  wsgi-file = blog.py
  callable = app
  ```

- flask，blog.py文件

  ```python
  from flask import Flask

  app = Flask(__name__)

  @app.route('/')
  def index():
      return 'Hello Flask'

  if __name__ == '__main__':
      app.run()
  ```

- 静态资源处理

  ```nginx
  server {
    	location /static {
        	root html/test;
    	}
    	...
  }
  ```

  > 测试：在html/test下创建static目录，然后拷贝一张图片
  >
  > 浏览器输入：www.test.com/static/123.jpg