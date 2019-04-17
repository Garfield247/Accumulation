### Centos7时区更改

```
# 列出所有时区
timedatectl list-timezones 
# 将硬件时钟调整为与本地时钟一致, 0 为设置为 UTC 时间
timedatectl set-local-rtc 1 
# 设置系统时区为上海
timedatectl set-timezone Asia/Shanghai
#其实不考虑各个发行版的差异化, 从更底层出发的话, 修改时间时区比想象中要简单:

#正确的方式是添加软连进行修改
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#下面是不正确的
# cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```

