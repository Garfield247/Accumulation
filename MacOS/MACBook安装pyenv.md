# Pyenv_Install

##  安装

1. ####  将 pyenv 检出到你想安装的目录。建议路径为： `$HOME/.pyenv`

   ```shell
   cd
   git clone git://github.com/yyuu/pyenv.git .pyenv
   ```

2. #### 添加环境变量。`PYENV_ROOT`指向 pyenv 检出的根目录，并向 `$PATH` ;添加 `PYENV_ROOT/bin` 以提供访问 `pyenv` 这条命令的路径

   ```shell
   echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
   echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
   ```
   ###### 这里的 shell 配置文件（`~/.bash_profile`）依不同 SHELL 而需作修改——Zsh：`~/.zshrc`；Bash：`~/.bashrc`

3. #### 向 shell 添加 `pyenv init` 以启用 shims 和命令补完功能

   ```shell
   echo 'eval "$(pyenv init -)"' >> ~/.zshrc
   ```
   ###### 配置文件的位置同上一条一样需要修改

4. #### 重启 shell（因为修改了 `$PATH` ）

   ```shell
   exec $SHELL
   ```


## 使用

- `pyenv install --list `
     列出可安装版本 

- `pyenv install <version> `
     安装对应版本 

- `pyenv install -v <version> `
     安装对应版本，若发生错误，可以显示详细的错误信息 

- `pyenv versions `
     显示当前使用的python版本 

- `pyenv which python `
     显示当前python安装路径

- ` pyenv global <version> `
     设置默认Python版本 

- `pyenv local <version> `
     当前路径创建一个.python-version, 以后进入这个目录自动切换为该版本

- ` pyenv shell <version> `
     当前shell的session中启用某版本，优先级高于global 及 local



## 在pyenv 下安装Python（3.6.4为例）

1. 将要安装的python版本的tar.xz格式的源码包提前下载好放置`~/.pyenv/cache`目录下，没有cache文件夹则创建

   ```shell
   mkdir ~/.pyenv/cache
   wget -P ~/.pyenv/cache https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz
   ```

2. 安装依赖(python3.X 通用)

   - MacOS

   使用HomeBrew安装Python3将所需依赖库安装上

   ```shell
   brew install python3
   ```

   - ubuntu

   ```shell
   sudo apt-get install build-essential python-dev python-setuptools python-pip python-smbus build-essential libncursesw5-dev libgdbm-dev libc6-dev zlib1g-dev libsqlite3-dev tk-dev libssl-dev openssl libffi-dev libssl-dev zlib1g-dev libbz2-dev libreadline-dev xz-utils liblzma-dev python-openssl -y
   ```
   - Centos

   ```
   sudo yum install zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel \
   openssl-devel xz xz-devel libffi-devel
   ```

   

3. 使用`pyenv install <version> `命令进行安装

   ```
   pyenv install 3.6.4
   ```

   **若报错尝试删除`/tmp`目录下与python相关的文件**

4. 将全局Python版本设置为3.6.4

   ```
   pyenv global 3.6.4
   ```

   **重启Terminal 输入`python -V`若输出3.6.4则代表配置成功**

   

## 使用`pyenv-virtualenv` 

- 安装

  1. **查看pyenv-virtualenv到插件目录**

     ```
     $ git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
     ```

  2. （可选）**添加pyenv virtualenv-init到shell**以启用virtualenvs的自动激活。

     ```
     $ echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
     ```

     这里的 shell 配置文件（`~/.bash_profile`）依不同 SHELL 而需作修改——Zsh：`~/.zshenv`；Bash：`~/.bashrc`

  3. **重新启动shell以启用pyenv-virtualenv**

     ```
     $ exec  $SHELL
     ```

- 创建

  从默认版本创建虚拟环境

  ```
  pyenv virtualenv env
  ```

  创建3.6.4版本的虚拟环境

  ```
  pyenv virtualenv 3.6.4 env-3.6.4
  ```

- 激活

  ```
  pyenv activate env-3.6.4
  ```

- 关闭

  ```
  pyenv deactivate
  ```

- 自动激活

  ```
  # 使用pyenv local 虚拟环境名
  # 会把`虚拟环境名`写入当前目录的.python-version文件中
  # 关闭自动激活 -> pyenv deactivate
  # 启动自动激活 -> pyenv activate env-3.6.4
  pyenv local env-3.6.4
  ```

- 删除

  ```
  pyenv uninstall env-3.6.4 
  ```

  

 

 

 