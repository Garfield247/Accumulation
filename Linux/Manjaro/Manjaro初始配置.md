## 源更新

manjaro系统安装软件从源获取，默认的源速度比较慢，需要排列，更新

```
sudo pacman-mirrors -g      //排列源
sudo pacman-mirrors -i -c China -m rank //上面的命令太慢或者不好用的话，也可以用这个。更新镜像排名
sudo pacman -Syyu            //更新系统
```

# 

## 添加中科大的源

 编辑文件/etc/pacman.conf
 在文件里面添加如下内容：

```
[archlinuxcn]

SigLevel = Optional TrustedOnly

Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
```

运行下面命令

```
sudo pacman -Syy && sudo pacman -S archlinuxcn-keyring
```

