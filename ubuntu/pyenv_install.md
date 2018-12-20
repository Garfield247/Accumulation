1. ####  将 pyenv 检出到你想安装的目录。建议路径为： `$HOME/.pyenv` 

   ```shell
   cd
   git clone git://github.com/yyuu/pyenv.git .pyenv
   ```

2. #### 添加环境变量。`PYENV_ROOT`指向 pyenv 检出的根目录，并向 `$PATH` ;添加 `PYENV_ROOT/bin` 以提供访问 `pyenv` 这条命令的路径

   ```shell
   echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
   echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
   ```
   ###### 这里的 shell 配置文件（`~/.bash_profile`）依不同 Linux 而需作修改——Zsh：`~/.zshenv`；Ubuntu：`~/.bashrc`

3. #### 向 shell 添加 `pyenv init` 以启用 shims 和命令补完功能

   ```shell
   echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
   ```
   ###### 配置文件的位置同上一条一样需要修改

4. #### 重启 shell（因为修改了 `$PATH` ）

   ```shell
   exec $SHELL
   ```

5. #### 下载python解决方案

   1. 将要安装的python版本提前下载好放置`~/.pyenv/cache`目录下，没有则创建

   2. 安装Python在Ubuntu下的依赖

      ```shell
      sudo apt-get install build-essential python-dev python-setuptools python-pip python-smbus build-essential libncursesw5-dev libgdbm-dev libc6-dev zlib1g-dev libsqlite3-dev tk-dev libssl-dev openssl libffi-dev
      ```

   3. 使用`pyenv install v.v.v`

   4. 若未解决尝试删除`/tmp`目录下与python相关的文件

6. ###### Sublime text 3 和 Anaconda 不能智能识别 pyenv下python路径，默认仍然指向本机自带python。准确的说Sublime text 3在桌面图标启动下不能识别user的$PATH，默认是root的￥PATH，而Anaconda 在 Virtualenv environment下根本找不到正确的bin，原因未知。土人办法，直接更改相应的path。

   1. 添加新的builde system，然后配置如下：

      ```json
      { 
        "cmd": ["python3.4","-u", "$file"], //强制执行python3.4版本，可替换成需要的版本
        "path": "$PATH:/home/user/.pyenv/shims:/home/user/.pyenv/bin"
       }
      ```

   2. 为Anaconda添加配置如下：

      ```json
      {
      "python_interpreter": "/home/user/.pyenv/shims/python"
      }
      ```

      ​

