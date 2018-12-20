# Ubuntu安装oh my zsh

1. #### 安装zsh

   ```shell
   sudo apt-get update
   sudo apt-get install zsh
   ```

2. #### 变系统的默认shell为zsh

   ```shell
   chsh -s /bin/zsh
   ```

3. #### 配置密码文件，解决chsh: PAM认证失败的问题

   ```shell
   sudo vi /etc/passwd
   把第一行的/bin/bash改成/bin/zsh，这个是root用户的。
   把最后一行的/bin/bash改成/bin/zsh，这个应该是每台电脑的登录用户名+计算机名组成的。
   ```

4. #### 安装oh-my-zsh

   ```shell
   sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
   ```

5. #### 安装autojump

   ```shell
   sudo apt-get update
   sudo apt-get install autojump
   gedit /usr/share/doc/autojump/README.Debian
   sudo gedit .zshrc
   最后一行加上
   . /usr/share/autojump/autojump.sh
   source ~/.zshrc
   ```

6.安装zsh-syntax-highlighting语法高亮插件

官网：<https://github.com/zsh-users/zsh-syntax-highlighting>

安装：

```shell
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
```

生效：

```shell
source ~/.zshrc
```

 7.安装zsh-autosuggestions语法历史记录插件

官网：<https://github.com/zsh-users/zsh-autosuggestions>

安装：

```shell
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
plugins=(zsh-autosuggestions)
```

配置

```shell
sudo vi ~/.zshrc
#plugins处添加zsh-autosuggestions
plugins=(
  git
  zsh-autosuggestions
)

#最后一行
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
```

生效：

```shell
source ~/.zshrc
```

8. 配置主题

   官方主题参考：<https://github.com/robbyrussell/oh-my-zsh/wiki/External-themes>

   ```shell
   sudo vim ~/.zshrc
   ```

   找到ZSH_THEME="agnoster"，修改为：ZSH_THEME="ys"；

   生效：

```shell
source ~/.zshrc
```

9. 字体乱码

   ```shell
   git clone https://github.com/powerline/fonts.git
   sudo ./fonts/install.sh
   ```

   