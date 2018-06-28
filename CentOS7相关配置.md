CentOS7相关配置

1. 虚拟机下网络配置

   ```
   1.打开网络配置文件
   vi /etc/sysconfig/network-scripts/ifcfg-ensXXXX
   2.将ONBOOT=no改为yes
   3.重启网络服务
   service network restart
   ```

   ​