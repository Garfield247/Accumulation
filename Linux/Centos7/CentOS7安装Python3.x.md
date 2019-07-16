# CentOS7 Python3.X安装

1. 安装依赖及工具

   - 依赖

   ```shelL
   yum -y install openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel 
   ```

   - 工具

   ```shell
   yum -y install gcc wget 
   ```

2. 下载python3.6.4

   ```shell
   wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz
   ```

3. 解压tgz包到/usr/local下面

   ```shell
   tar -zxvf Python-3.6.4.tgz -C mv Python-3.6.4 /usr/local
   ```

4. 进入python目录

   ```shell
   cd /usr/local/Python-3.6.4/
   ```

5. 配置

   ```shell
   ./configure
   ```

6. 编译 make

   ```shell
   make
   ```

7. 编译，安装

   ```shell
   make install
   ```

8. 创建新的软链接到最新的python

   ```shell
   ln -s /usr/local/bin/python3.6 /usr/bin/python3
   ```

9. 查看python版本

   ```shell
   python3 -V
   ```

   

