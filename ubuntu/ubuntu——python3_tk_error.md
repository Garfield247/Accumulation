Ubuntu Python3 tkinter 

1. python-tk/python3-tk的类库需要在操作系统层面进行安装

```
sudo apt install python3-tk (Ubuntu) 

sudo apt install tk-dev 
```

２．　重新下来了tcl/tk的源代码包：

下载链接： http://www.tcl.tk/software/tcltk/download.html

下载版本８．６的版本

Tcl 8.6.8 Sources	Tk 8.6.8 Sources
然后分别下来两者源代码，加压缩之后，切入源代码目录：

sudo ./configure 
sudo make or make test 
sudo make install 
在重新安装tck/tk之后，重新执行代码，问题依然存在。

若无法编译：出现以下错误：

X11/Xlib.h：没有该文件或目录
采用如下博客

https://www.cnblogs.com/yixiaoyang/archive/2010/11/17/1879504.html

中的方法把改装的都装好，有安装不上的也不用管，先试试是否可以编译以上文件了，我的最后一个sudo apt-get install libgl1-mesa-swx11-dev没有安装成功。但是还是可以编译以上２个包了。

按照好以上２个包后，接下来

３．　重新安装python 3

