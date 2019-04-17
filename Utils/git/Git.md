# Git

1. 常用命令

   | `命名`         | `功能`                   |
   | -------------- | ------------------------ |
   | `git init`     | `初始化 .git 文件夹`     |
   | `git add`      | `添加追踪`               |
   | `git reset`    | `取消 add 状态`          |
   | `git commit`   | `提交到本地仓库`         |
   | `git status`   | `查看当前状态`           |
   | `git checkout` | `切换分支`               |
   | `git branch`   | `分支管理`               |
   | `git pull`     | `拉去远程代码`           |
   | `git push`     | `将本地代码推送到远程库` |
   | `git diff`     | `差异对比`               |
   | ``git log``    | `查看提交历史`           |

2. 常用操作

   1. 初次使用

      ```shell
      # 设置全局的用户名
      git config --global user.name "Garfield247"
      # 是指全局的邮箱地址
      git config --global user.email Garfield_lv@163.com
      # 查看配置
      git config --list
      ```

   2. 新建

      ```shell
      # 初始化本地仓库
      git init
      # 添加追踪文件‘.’表示当前目录下的所有文件
      git add .
      # 提价到本地仓库
      git commit -m "first commit"
      # 添加到远程仓库
      git remote add origin https://github.com/Garfield247/test.git
      # 推送到远程仓库的master分支
      git push -u origin master
      ```

   3. 克隆和同步

      ```shell
      # 从远程仓库克隆到本地
      git clone https://github.com/Garfield247/test.git
      # 本地更新后提交到远程
      git add .
      git status
      git git commit -m 'Submit changes'
      git push -u origin master
      # 远程仓库跟新后本地进行同步
      git pull
      ```

   4. 分支

      ```shell
      # 创建本地分支
      git branch dev
      # 切换分支
      git checkout dev
      # 提交本地分支到远程
      git push -u origin dev 
      # 合并分支
      git merge
      ```

   5. 差异对比

      ```
      git diff
      git difftool
      ```

   6. 忽略

      ```
      vi .gitignore
      *.pyc
      ```