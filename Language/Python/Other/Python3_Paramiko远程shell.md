# Python3 Paramiko 远程shell

1. ##### 安装

   ```
   pip install paramiko
   ```

2. 官方文档

   ```
   http://docs.paramiko.org/en/2.4/
   ```

3. 基本应用

   ```python
   import paramiko

   # 创建一个SSH客户端对象
   cli82 = paramiko.SSHClient()

   # 设置成默认自动接收秘钥
   cli82.set_missing_host_key_policy(paramiko.AutoAddPolicy())

   # 连接远程主机
   cli82.connect(host,port=prot,username=username,password=password,timeout=10)

   # 执行Shell命令
   stdin, stdout, stderr =cli82.exec_command(command)

   # 读取返回结果
   print(stdout.read().decode('utf-8'))

   建立一个SSHClient对象以后，除了执行命令，还可以开启一个sftp的session，用于传输文件、创建文件夹等等。

   # 新建 sftp session
   sftp = client.open_sftp()
    
   # 创建目录
   sftp.mkdir('abc')
    
   # 从远程主机下载文件，如果失败， 这个可能会抛出异常。
   sftp.get('test.sh', '/home/testl.sh')
    
   # 上传文件到远程主机，也可能会抛出异常
   sftp.put(localpath='/tmp/11.txt', remotepath='/tmp/22.txt')
   ```

   ​