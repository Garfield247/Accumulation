##### 1. 自己新建一个脚本,如centnet-service.sh

经过后面的几个步骤后,这个脚本在开机的时候会执行,在这个脚本里面可以写你开机的时候想执行的命令,如启动tomcat,oracle等服务

##### 2. 在脚本中输入启动服务的命令,如(开机启动tomcat):

```
#!/bin/bash
export JDK_HOME=/home/java/jdk1.8.0_91
export JAVA_HOME=/home/java/jdk1.8.0_91
/home/tomcat/apache-tomcat-8.0.36/bin/startup.sh

```

##### 3. 执行如下命令,将该脚本标记为可执行文件(添加可执行的权限)

```
chmod +x /home/centnet/centnet-service.sh 

```

##### 4. 执行如下命令将/etc/rc.d/rc.local文标记为可执行文件

在centos7中,/etc/rc.d/rc.local文件的权限被降低了,开机的时候执行在自己的脚本是不能起动一些服务的,执行下面的命令可以文件标记为可执行的文件

```
chmod +x /etc/rc.d/rc.local

```

##### 5. 打开/etc/rc.d/rc.local文件,在最后面添加如下脚本

```
/home/centnet/centnet-service.sh

```

这样,centnet-service.sh这个脚本在开机的时候就会被执行了,以后再这里面写启动服务的命令就可以了