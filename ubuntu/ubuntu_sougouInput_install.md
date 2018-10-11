# Ubuntu搜孤输入法安装

## 下载

打开官网http://pinyin.sogou.com/linux，点击自己对应的系统位数安装包，然后下载。

## 安装

打开安装目录，调出终端。

```
sudo dpkg -i sogoupinyin×××××.deb

sudo apt-get install -f 
```

（如果出现安装出错，就重复该命令安装几次直到成功）

## 配置

打开“系统设置“，点击”语言支持“，然后把里面的IBus改为fcitx，注销重新登录