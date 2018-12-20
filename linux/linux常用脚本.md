# Linux常用脚本

## 根据关键字关闭进程

- 命令

```shell
ps -ef| grep tomcat|awk '{print $2}'|xargs kill -9
```

- 脚本

```shell
#!/bin/bash

sp_pid=`ps -ef | grep KEYWORD | grep -v grep | awk '{print $2}'`
if [ -z "$sp_pid" ];
then
    echo "[ not find KEYWORD pid ]"
else
    echo "find result: $sp_pid "
    kill -9 $sp_pid
fi
```

