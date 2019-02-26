​	[下载页面](http://idea.lanyus.com/) 

  进入页面之后，有一个破解补丁下载选项，点进去下载补丁。

  下载下来之后，放到`pycharm`安装目录的bin目录中，而且bin目录下还有`pycharm.vmoptions`和`pycharm.vmoptions64`等其他文件。当我们吧破解补丁放到该bin目录下之后，需要对`pycharm.vmoptions`和`pycharm.vmoptions64`进行修改，在两个文件的最后加入相同的一行代码即可，具体为：

```shell
sudo vim /opt/pycharm-professional/bin/pycharm.vmoptions
```

   该命令执行之后会用VIM文本编辑器打开`pycharm.vmoptions`文件，然后我们在最后加入内容如下：

```
-javaagent:/opt/pycharm-professional/bin/JetbrainsCrack-2.6.10-release-enc.jar
```

  同理，我们打开pycharm.vmoptions64文件，也在最后加入上面一行内容即可。

```
需要注意的是：加入具体内容要根据你自己的pycharm的安装路径和破解补丁的名字而做相应的改变，前面的-javaagent:是不变的，紧接着就是你下载好的放在pycharm安装目录下的bin目录中破解补丁的绝对路径。
```

  然后，我们执行bin目录下的pycharm.sh文件

```
$：./pycharm.sh
```

  此时就会出现激活页面，然后在Acrivation code中选择界面的时候,写入下面注册代码即可激活完成(有效期到2099)

```
ThisCrackLicenseId-{"licenseId":"ThisCrackLicenseId","licenseeName":"idea","assigneeName":"","assigneeEmail":"idea@163.com","licenseRestriction":"For This Crack,Only Test! Please support genuine!!!","checkConcurrentUse":false,"products":[{"code":"II","paidUpTo":"2099-12-31"},{"code":"DM","paidUpTo":"2099-12-31"},{"code":"AC","paidUpTo":"2099-12-31"},{"code":"RS0","paidUpTo":"2099-12-31"},{"code":"WS","paidUpTo":"2099-12-31"},{"code":"DPN","paidUpTo":"2099-12-31"},{"code":"RC","paidUpTo":"2099-12-31"},{"code":"PS","paidUpTo":"2099-12-31"},{"code":"DC","paidUpTo":"2099-12-31"},{"code":"RM","paidUpTo":"2099-12-31"},{"code":"CL","paidUpTo":"2099-12-31"},{"code":"PC","paidUpTo":"2099-12-31"}],"hash":"2911276/0","gracePeriodDays":7,"autoProlongated":false}
```