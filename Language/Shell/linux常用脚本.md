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

## 遍历删除某种文件

- 命令

```shell
find . -name "*.pyc"  | xargs rm -f
```

## 查看程序的进程是否存在，若不存在则启动脚本，每60s检查一次

```shell
#!/bin/sh
while true;
do
processExist=`ps aux | grep 进程的名字 | grep -v "grep" `
if [ -z $processExist ];then
   echo "proecss is restarted"
  /home/hzjj/auto_run.sh  # 启动程序的脚本所在的绝对路径
else
  echo "process is running"
fi
sleep 60 #每 60s检查一次
done
```
## 按文件夹进行压缩
```
for i in `find ./* -type d`;do zip $i.zip ./$i/;done
```
