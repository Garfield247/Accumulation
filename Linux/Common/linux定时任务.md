# Crontab

使用crontab你可以在指定的时间执行一个shell脚本或者一系列Linux命令。 

## 往 cron 中添加一个作业

```shell
crontab –e
```

写入一下内容

```
0 5 * * * /root/bin/texst.sh
```

这将会在每天早上5点运行 /root/bin/test.sh



## Crontab 文件：

**格式：**`{minute} {hour} {day-of-month} {month} {day-of-week} {full-path-to-shell-script}`

- `minute`: 区间为 0 – 59 
- `hour`: 区间为0 – 23 
- `day-of-month`: 区间为0 – 31 
- `month`: 区间为1 – 12. 1 是1月. 12是12月. 
- `Day-of-week`: 区间为0 – 7. 周日可以是0或7.



## Crontab 选项

- `crontab –e` : 修改 crontab 文件. 如果文件不存在会自动创建。 
- `crontab –l` : 显示 crontab 文件。 
- `crontab -r` : 删除 crontab 文件。
- `crontab -ir` : 删除 crontab 文件前提醒用户。

