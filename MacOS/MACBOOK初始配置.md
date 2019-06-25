# MACBOOK初始配置

## 安装Homebrew

执行以下命令（官网[https://brew.sh](https://brew.sh/) ）

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## 安装git

```shell
brew install git
```

## 安装zsh&oh-my-zsh

1. 将默认SHELL改为zsh

   ```shell
   chsh -s /bin/zsh
   ```

2. 安装oh-my-zsh

   ```shell
   sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
   ```

3. 插件安装

   - autojump(自动跳转)

     1. 安装

        ```shell
        brew install autojump
        ```

     2. 配置

        在~/.zshrc的plugins中添加
        
        ```shell
        plugins=(git
        	autojump
        )
        ```
     
- zsh-syntax-highlighting（语法高亮）
   
  1. 安装
   
     ```shell
        brew install zsh-syntax-highlighting
        
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        ```
   
  2. 配置
     
        在~/.zshrc的plugins中添加
     
        ```shell
        plugins=(git
        	autojump
          zsh-syntax-highlighting
        )
        ```
     
   -  zsh-autosuggestions
   
     1. 安装
   
        ```shell
        brew install zsh-autosuggestions	
        ```
   
     2. 配置
   
        在~/.zshrc 中写入
   
        ```shell
        source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        ```
   
   4. 字体安装
   
      ```shell
      git clone https://github.com/powerline/fonts.git
      sudo ./fonts/install.sh
      ```
   
      
   
      
