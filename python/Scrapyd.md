# Scrapyd

## 安装

```shell
#通用安装方式
pip install scrapyd
#Ubuntu软件包安装
apt - get  install  scrapyd
```

## 文件目录

| 路径                           | 说明                                       |
| ---------------------------- | ---------------------------------------- |
| /etc/scrapyd                 | Scrapyd配置文件。                             |
| /var/log/scrapyd/scrapyd.log | Scrapyd主要的日志文件。                          |
| /var/log/scrapyd/scrapyd.out | 从Scrapyd流程捕获的标准输出以及从其生成的任何子流程。           |
| /var/log/scrapyd/scrapyd.err | 从Scrapyd捕获的标准错误以及从其生成的任何子进程。请记住，如果遇到问题，请检查此文件，因为错误可能不会记录到`scrapyd.log`文件中。 |
| /var/log/scrapyd/project     | 除主服务日志文件外，Scrapyd还在每个爬网过程中存储一个日志文件：      |
| /var/lib/scrapyd/            | 用于存储数据文件的目录                              |

## 配置

### 配置文件

Scrapyd在以下位置搜索配置文件，并按照最新优先顺序进行解析：

- `/etc/scrapyd/scrapyd.conf` （UNIX）
- `c:\scrapyd\scrapyd.conf` （Win）
- `/etc/scrapyd/conf.d/*` （按字母顺序排列，Unix）
- `scrapyd.conf`
- `~/.scrapyd.conf` （用户主目录）

HTTP_PORT

HTTP JSON API将侦听的TCP端口。默认为`6800`。

### bind_address

网站和json webservices将侦听的IP地址。默认为`127.0.0.1`（localhost）

### max_proc

将开始的并发Scrapy进程的最大数量。如果未设置，或`0`将使用系统中可用的cpus数乘以`max_proc_per_cpu`选项中的值。默认为`0`。

### max_proc_per_cpu

每个cpu将启动的最大并发Scrapy进程数。默认为`4`。

### debug

是否启用调试模式。默认为`off`。当启用调试模式时，当处理JSON API调用时出现错误时，将返回完整的Python回溯（作为纯文本响应）。

### eggs_dir

项目蛋将被存储的目录。

### dbs_dir

项目数据库将被存储的目录（这包括蜘蛛队列）。

### logs_dir

Scrapy日志的存储目录。如果要禁用存储日志，请将此选项设置为空，如下所示：

```
logs_dir =

```

### items_dir

new versionadded :: 0.15
Scrapy项目将被存储的目录。此选项默认处于禁用状态，因为您需要使用数据库或Feed导出器。将其设置为非空结果可以通过覆盖scrapy设置来将抓取的项目源数据存储到指定的目录`FEED_URI`。

### jobs_to_keep

new versionadded :: 0.15

每个蜘蛛保持完成的工作数量。默认为`5`。这是指日志和项目。

此设置是`logs_to_keep`在以前的版本中命名的。

### finished_to_keep

new versionadded :: 0.14

保留在启动器中的完成进程的数量。默认为`100`。这只反映在网站/作业端点和相关的json web服务上。

### poll_interval

用于轮询队列的时间间隔，以秒为单位。默认为`5.0`。可以是浮动的，比如`0.2`

### runner

将用于启动子流程的模块。您可以使用您自己的模块自定义从Scrapyd启动的Scrapy进程。

### application

返回要使用的（Twisted）应用程序对象的函数。如果要通过添加和删除自己的组件和服务来扩展Scrapyd，可以使用此选项。

欲了解更多信息，请参阅[Twisted Application Framework](http://twistedmatrix.com/documents/current/core/howto/application.html)

### webroot

代表到达scrapyd的接口的Twisted网络资源。Scrapyd包含与网站的接口，以提供对应用程序Web资源的简单监控和访问。该设置必须提供扭曲网页资源的根类。

### node_name

```
.. versionadded :: 1.1
```

每个节点的节点名称与显示主机名相似。默认为`${socket.gethostname()}`。

### 示例配置文件

这是一个包含所有默认设置的示例配置文件：

```
[scrapyd]
eggs_dir    = eggs
logs_dir    = logs
items_dir   =
jobs_to_keep = 5
dbs_dir     = dbs
max_proc    = 0
max_proc_per_cpu = 4
finished_to_keep = 100
poll_interval = 5.0
bind_address = 127.0.0.1
http_port   = 6800
debug       = off
runner      = scrapyd.runner
application = scrapyd.app.application
launcher    = scrapyd.launcher.Launcher
webroot     = scrapyd.website.Root

[services]
schedule.json     = scrapyd.webservice.Schedule
cancel.json       = scrapyd.webservice.Cancel
addversion.json   = scrapyd.webservice.AddVersion
listprojects.json = scrapyd.webservice.ListProjects
listversions.json = scrapyd.webservice.ListVersions
listspiders.json  = scrapyd.webservice.ListSpiders
delproject.json   = scrapyd.webservice.DeleteProject
delversion.json   = scrapyd.webservice.DeleteVersion
listjobs.json     = scrapyd.webservice.ListJobs
daemonstatus.json = scrapyd.webservice.DaemonStatus
```

# API 

以下部分描述了Scrapyd JSON API中的可用资源。

## daemonstatus.json 

检查服务的负载状态。

- 支持的请求方法： `GET`

示例请求：

```
curl http://localhost:6800/daemonstatus.json
```

响应示例：

```
{ "status": "ok", "running": "0", "pending": "0", "finished": "0", "node_name": "node-name" }
```

## addversion.json 

将项目添加到项目中，如果项目不存在则创建项目。

- 支持的请求方法： `POST`
- 参数：
  - `project` （字符串，必填） - 项目名称
  - `version` （字符串，必填） - 项目版本
  - `egg` （file，required） - 包含项目代码的Python egg

示例请求：

```
$ curl http://localhost:6800/addversion.json -F project=myproject -F version=r23 -F egg=@myproject.egg
```

响应示例：

```
{"status": "ok", "spiders": 3}
```

注意

Scrapyd使用[distutils LooseVersion](http://epydoc.sourceforge.net/stdlib/distutils.version.LooseVersion-class.html)来解释您提供的版本号。

必要时，默认情况下将使用项目的最新版本。

[schedule.json](https://scrapyd.readthedocs.io/en/stable/api.html#schedule-json)和[listspiders.json](https://scrapyd.readthedocs.io/en/stable/api.html#listspiders-json)允许您显式设置所需的项目版本。



## schedule.json 

安排蜘蛛运行（也称为作业），返回作业ID。

- 支持的请求方法： `POST`
- 参数：
  - `project` （字符串，必填） - 项目名称
  - `spider` （字符串，必填） - 蜘蛛名称
  - `setting` （字符串，可选） - 运行蜘蛛时使用的Scrapy设置
  - `jobid` （字符串，可选） - 用于标识作业的作业ID，覆盖默认生成的UUID
  - `_version` （string，optional） - 要使用的项目版本
  - 任何其他参数都作为spider参数传递

示例请求：

```shell
$ curl http://localhost:6800/schedule.json -d project=myproject -d spider=somespider
```

响应示例：

```json
{"status": "ok", "jobid": "6487ec79947edab326d6db28a2d86511e8247444"}
```

传递spider参数（`arg1`）和设置（[DOWNLOAD_DELAY](http://doc.scrapy.org/en/latest/topics/settings.html#download-delay)）的示例请求：

```shell
curl http://localhost:6800/schedule.json -d project=myproject -d spider=somespider -d setting=DOWNLOAD_DELAY=2 -d arg1=val1
```

注意

使用scrapyd安排的蜘蛛应该允许任意数量的关键字参数，因为报废将内部生成的蜘蛛参数发送给正在调度的蜘蛛



## cancel.json 

0.15版本的新功能。

取消蜘蛛游戏（又名作业）。如果作业处于待处理状态，则会将其删除。如果作业正在运行，它将被终止。

- 支持的请求方法： `POST`
- 参数：
  - `project` （字符串，必填） - 项目名称
  - `job` （字符串，必填） - 作业ID

示例请求：

```shell
curl http://localhost:6800/cancel.json -d project=myproject -d job=6487ec79947edab326d6db28a2d86511e8247444
```

响应示例：

```
{"status": "ok", "prevstate": "running"}
```

## listprojects.json 

获取上传到此Scrapy服务器的项目列表。

- 支持的请求方法： `GET`
- 参数：无

示例请求：

```shell
$ curl http://localhost:6800/listprojects.json
```

响应示例：

```json
{"status": "ok", "projects": ["myproject", "otherproject"]}
```

## listversions.json 

获取某些项目可用的版本列表。版本按顺序返回，最后一个版本是当前使用的版本。

- 支持的请求方法： `GET`
- 参数：
  - `project` （字符串，必填） - 项目名称

示例请求：

```shell
$ curl http://localhost:6800/listversions.json?project=myproject
```

响应示例：

```json
{"status": "ok", "versions": ["r99", "r156"]}
```

## listspiders.json 

获取某个项目的最后一个（除非被覆盖）版本中可用的蜘蛛列表。

- 支持的请求方法： `GET`
- 参数：
  - `project` （字符串，必填） - 项目名称
  - `_version` （string，optional） - 要检查的项目的版本

示例请求：

```shell
$ curl http://localhost:6800/listspiders.json?project=myproject
```

响应示例：

```shell
{"status": "ok", "spiders": ["spider1", "spider2", "spider3"]}
```



## listjobs.json 

0.15版本的新功能。

获取某个项目的待处理，正在运行和已完成的作业列表。

- 支持的请求方法： `GET`
- 参数：
  - `project` （字符串，必填） - 项目名称

示例请求：

```shell
$ curl http://localhost:6800/listjobs.json?project=myproject
```

响应示例：

```json
{"status": "ok",
 "pending": [{"id": "78391cc0fcaf11e1b0090800272a6d06", "spider": "spider1"}],
 "running": [{"id": "422e608f9f28cef127b3d5ef93fe9399", "spider": "spider2", "start_time": "2012-09-12 10:14:03.594664"}],
 "finished": [{"id": "2f16646cfcaf11e1b0090800272a6d06", "spider": "spider3", "start_time": "2012-09-12 10:14:03.594664", "end_time": "2012-09-12 10:24:03.594664"}]}
```

注意

所有作业数据都保存在内存中，并在重新启动Scrapyd服务时重置。

## delversion.json 

删除项目版本。如果给定项目没有更多可用版本，则该项目也将被删除。

- 支持的请求方法： `POST`
- 参数：
  - `project` （字符串，必填） - 项目名称
  - `version` （字符串，必填） - 项目版本

示例请求：

```shell
$ curl http://localhost:6800/delversion.json -d project=myproject -d version=r99
```

响应示例：

```json
{"status": "ok"}
```

## delproject.json 

删除项目及其所有上载的版本。

- 支持的请求方法： `POST`
- 参数：
  - `project` （字符串，必填） - 项目名称

示例请求：

```shell
$ curl http://localhost:6800/delproject.json -d project=myproject
```

响应示例：

```shell
{"status": "ok"}
```

