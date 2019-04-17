# 认识Linux

### 什么是操作系统？

操作系统严格意义上来说只是一个内核，是一套管理软硬件资源的软件组件；

我们通常所说的操作系统指的是发行版，包括：内核 + 桌面环境 + 常用软件

- windows：Windows NT
- Linux：Linux

### 常见的操作系统

- 桌面端：Windows系列、Ubuntu(Linux)、Mac OS
- 服务端：Windows Server、Linux系列、Unix系列
- 移动端：Android、iOS、AliOS、windows phone、Symbian、Black Berry

### 32位和64位的区别？

简单理解就是双车道与4车道的区别，实际的区别是寻址空间及并发处理的区别。

- 32位：理论为2^32，即4G，实际的最大内存为3.25G
- 64位：理论为2^64，实际的电脑主板最大为128G

### Linux系统简介

简单来说，就是一个19岁的芬兰大学生(林纳斯.托瓦兹)，为了学习CPU386的性能，他认为做好的方式就是写一个操作系统，而此时没有合适的操作系统，于是就自己动手写了一个，后来开源后得到的广大牛人的支持和帮助，才有了今天的linux。

依赖的五大支柱：

1. 基于Unix操作系统
2. 参考Minix操作系统
3. GNU计划
4. POSIX标准
5. 互联网的发展

### Linux发型版本

发行版其实就是在内核的基础上，添加特定的桌面环境和常用软件，省去了自己组装的麻烦

- 桌面版：ubuntu(desktop)、ubuntu kylin、deepin
- 服务器：ubuntu(server)、CentOS、Redhat、debian

### CentOS系统安装

1. 安装虚拟机

   Virtual Box、VMWare、PD(msc)

   提醒：Virtual Box最小，比较节省资源，安装基本是一路next。

2. 安装CentOS 6.8系统

   ```
   1.打开Virtual Box，点击新建，然后一路Next
   2.修改虚拟硬盘的文件位置和大小(20G)
   3.选中对应的虚拟机，然后点击设置
   4.点击存储选项，点击控制器右侧的一个'+'，选择ios(系统镜像文件)
   5.点击网络选项，选择桥接网卡，之后点击OK，完成配置
   6.回到主页面，选择对应的虚拟机，然后点击启动
   7.选择第一项，直接安装
   8.跳过Skip，跳过镜像文件的检验
   9.点击next，然后选择中文件简体，然后再选择键盘(美国英语式)
   10.下一步，然后点击，"是，忽略所有数据"
   11.给计算机起个名字，然后下一步
   12.选择市区，"亚洲/上海"
   13.设置跟用户密码，一定要牢记，若密码过于简单会有提醒，选择"无论如何都使用"
   14.选择安装类型，"使用所有空间"，然后点击下一步
   15.将修改写入磁盘
   16.安装成功会显示"重新引导"
   17.登录使用"root"用户，密码是前面设置的密码
   ```

3. 配置网卡

   1. 打开配置文件/etc/sysconfig/network-scripts/ifcfg-eth0

   ```shell
   vi /etc/sysconfig/network-scripts/ifcfg-eth0
   ```

   2. 进入编辑模式，按'i'字母，左下角会有'Insert'提示信息
   3. 将该文件的ONBOOT的指由no该为yes，如下：

   ```
   ONBOOT=yes
   ```

   4. 保存退出

   ```
   Esc：有编辑模式进入到正常模式
   shift + zz：保存退出
   ```

   5. 重启网络服务

   ```shell
   service network restart
   ```

   6. 测试网络

   ```
   ifconfig：查看网卡信息
   ping：测试网络连通性，如：ping baidu.com，Ctrl + c结束测试
   ```

### 基本命令

1. vi：是一个非常强大的终端编辑工具

   ```
   vi 文件名		 # 打开指定的文件
   i			   # 进入编辑模式
   Esc			    # 切换到正常模式
   shift + zz		# 保存退出 
   ```

2. 网络测试相关

   ```
   ifconfig：查看网卡信息
   ping：测试网络连通性，如：ping baidu.com，Ctrl + c结束测试
   	-c 可以指定测试包的发送次数
   ```

3. 服务控制

   ```shell
   service network restart | start | stop
   ```

4. 最最常用

   ```
   pwd：查看当前工作目录
   ls：list，列表展示指定目录的内容
   cd：切换工作目录
   ```

5. 快捷操作

   ```
   tab：自动补全命令或参数，当出现多个命令相同时点击两次tab会列出所有
   Ctrl + c：结束当前进程
   clear：清屏，快捷操作：Ctrl + L
   上下按钮：查看历史命令
   history：查看所有历史命令
   ```

### 系统启动流程

1. 基本输入输出系统(BIOS)

   系统上电后，做基本的硬件检查

2. 主引导分区(MBR)

   启动引导程序(Bootloader)

3. 启动引导程序(Bootloader)

   在操作系统启动之前运行的一段程序，将软硬件带到一个合适的环境，为操作系统的运行做准备(加载OS、解压、对硬件进行初始化、将控制权交给OS)

4. 操作系统(OS)

   操作系统运行第一个程序（守护进程/sbin/init）

5. 守护进程(/sbin/init)

   解析/etc/inittab文件，该文件指定了系统运行的级别，然后根据系统级别进行后续的初始化操作，运行级别如下：

   ```
   0：关机
   1：单用户
   2：没有NFS的多用户
   3：有网络的多用户
   4：保留，未使用
   5：图形界面
   6：重启
   ```

   > init 数字		# 进行运行模式的切换
   >
   > runlevel		# 查看运行级别
   >
   > who -r		# 查看运行级别

6. 执行系统初始化脚本/etc/rc.d/rc.sysinit

7. 根据运行级别，执行对应的目录的初始化脚本 /etc/rc.d/rcX.d，X表示运行级别

8. 执行用户自定义的初始化操作 /etc/rc.d/rc.local

9. 用户登录

   1. 桌面环境(GNOME、KED)
   2. 命令行终端(小黑屏)

10. 远程连接

    xshell、putty

    22端口、ssh协议

### 系统管理命令

关机：init 0、halt、poweroff、shutdown -h now

重启：init 6、reboot、shutdown -r +5 "哥要关机了"

