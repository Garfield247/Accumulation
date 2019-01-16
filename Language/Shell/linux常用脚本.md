# Linux常用脚本

## 根据关键字关闭进程

- 命令

```shell
ps -ef| grep tomcat|awk '{print $2}'|xargs kill -9
```

- 脚本

```shell
#!/bin/bash
KEYWORD="keyword"
pids=`ps -ef | grep $KEYWORD | grep -v grep | awk '{print $2}'`
if [ -z "$pids" ];
then
    echo "[ not find $KEYWORD pid ]"
else
    echo "find result: $pids "
fi
for pid in pids
do
	kill -9 $pid
	echo "kill $pid"
done
```

