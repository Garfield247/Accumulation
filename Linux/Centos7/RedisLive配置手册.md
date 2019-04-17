# RedisLive配置手册

### 环境centos7 python2.7

1. 安装setuptools

   ```shell
   # 下载setuptools安装包
   wget http://pypi.python.org/packages/2.7/s/setuptools/setuptools-0.6c11-py2.7.egg
   # 执行安装
   sh setuptools-0.6c11-py2.7.egg
   ```

2. 安装pip

   ```shell
   # 下载pip安装包
   wget --no-check-certificate https://github.com/pypa/pip/archive/1.5.5.tar.gz
   # 解压
   tar zvxf 1.5.5.tar.gz
   # 进入解压目录
   cd pip-1.5.5
   # 执行安装
   python setup.py install
   ```

3. 下载redislive

   ```powershell
   # 从github 地址下载
   git clone https://github.com/kumarnitin/RedisLive.git
   # 进入项目目录下的src文件夹
   # 将文件redis-live.conf.example重命名为redis-live.conf
   # 在redis-live.conf文件配置redis及sqllite连接
   {
   	"RedisServers":
   	[
   		{
     			"server": "192.168.3.100",
     			"port" : 6379
   		}

   	],

   	"DataStoreType" : "redis",

   	"RedisStatsServer":
   	{
   		"server" : "192.168.3.100",
   		"port" : 6379
   	},

   	"SqliteStatsStore" :
   	{
   		"path":  "db/redislive.sqlite"
   	}
   }
   # 将redislive拷贝到 /project目录下
   ```

4. 创建python2虚拟环境

   ```shell
   # 安装virturalenv
   pip install virtualenv
   # /project目录下创建虚拟环境 .env_rl
   virtualenv .env_rl
   # 启动虚拟环境
   source .env_rl/bin/activate
   # 安装依赖
   pip install -r /project/RedisLive/requirements.txt
   ```

5. 运行RedisLive

   ```shell
   # 启动监控，duration是心跳时间
   .env_rl/bin/python /project/RedisLive/src/redis-monitor.py --duration=30    

   # 启动web服务，默认监听8888端口
   .env_rl/bin/python /project/RedisLive/src/redis-live.py                    

   ```

   ​

