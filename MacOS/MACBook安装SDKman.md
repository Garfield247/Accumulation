# SDKMAN ! 

***The Software Development Kit Manager***

顾名思义，软件开发工具吧的管理工具。那么sdkman可以管理哪些kit呢？ant,java,gradle,maven,springboot-cli,groovy，kotlin,scala这些基于jvm的开发语言都包括进来。

## 安装

1. 下载安装脚本

   ```
   curl -s "https://get.sdkman.io" | bash
   ```

   > 如果Shell解释器是zsh，则bash改为zsh。

2. 执行初始化脚本

   ```
   source "$HOME/.sdkman/bin/sdkman-init.sh"
   ```

3. 检验是否安装成功

   ```
   sdk version
   ```

   > 如果输出  `sdkman {{version}}` 则代表安装成功

4. 添加环境变量使其自动加载配置脚本

   ```
   echo 'export SDKMAN_DIR="$HOME/.sdkman"
   [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" && -z $(which sdkman-init.sh | grep '/sdkman-init.sh') ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"' >> ~/.bash_profile
   ```

   >  这里的 shell 配置文件（`~/.bash_profile`）依不同 SHELL 而需作修改——Zsh：`~/.zshenv`；Bash：`~/.bashrc`

    

    

    

    

## 使用

以Java为例

1. 查看可用Java版本

   ```
   sdk list java
   ```

2. 指定版本安装

   ```
   sdk install java {{version}}
   ```

3. 切换版本

   ```
   sdk default java {{version}}
   ```

   