CentOS7相关配置

##虚拟机下网络配置

1. 打开网络配置文件
    ```shell
    vi /etc/sysconfig/network-scripts/ifcfg-ensXXXX
    ```
2. 将ONBOOT=no改为yes
3. 重启网络服务
    ```shell
    service network restart
    ```


## 时区更改


1. 列出所有时区
    ```shell
    timedatectl list-timezones
    ```
2. 将硬件时钟调整为与本地时钟一致, 0 为设置为 UTC 时间
    ```shell
    timedatectl set-local-rtc 1
    ```
3. 设置系统时区为上海
    ```shell
    timedatectl set-timezone Asia/Shanghai
    ```

其实不考虑各个发行版的差异化, 从更底层出发的话, 修改时间时区比想象中要简单:

正确的方式是添加软连进行修改
```shell
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```
下面是不正确的
```shell
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```

