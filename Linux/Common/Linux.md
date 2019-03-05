Linux 常用操作及参数
====================

日常操作


1. - `cd`, `ls`, `cp`, `mv`, `rm`, `mkdir`
       - cp / mv / rm : -i 询问 -f 强制 -n 不覆盖
       - cp / rm: -r 递归子文件夹
       - `mkdir -p a/b/c` 按层级创建
       - `mkdir -p a/{b,c}/{d,e,f}` 同一层级创建多个

   - `pwd` 显示当前完整路径

   - `ln -s [src_file] [dst_file]`

   - `touch` 没有则创建，有则忽略

   - `history`
       - bashrc 配置显示时间: `export HISTTIMEFORMAT="[%y-%m-%d_%T]  "`
       - 修改 bashrc 后使其生效: `source ~/.bashrc` 或 `. .bashrc`

2. 进程管理
   - `ps -aux` 或 `ps ex` 查看进程

   - `top -p PID1,PID2,PID3,...,PID20`  动态监控进程

   - `free -m`  查看内存

   - `kill`
       - 给进程发送信号
       - `-9` 强制杀死进程
       - `-15` 正常终止进程
       - `-HUP` 优雅重启

   - `pkill [ProcessName]`  按名字处理进程

   - `killall [MatchedProcessName]`  处理名字匹配的进程

3. 权限管理
   - `sudo`  以管理员执行

   - `su -`  切换用户身份

   - `chmod -R`  修改权限

   - ``chown -R `id -u`:`id -g` filename``  修改所有者

4. 日志管理
   - `cat`  查看文件

   - `head -n N`  前 N 行
   - `tail -n N`  后 N 行

   - `less`
       - 按 j 向下
       - 按 k 向上
       - 按 f 向下翻屏
       - 按 b 向上翻屏
       - 按 g 到全文开头
       - 按 G 到全文结尾
       - 按 q 退出
   - `sort` 排序
   - `uniq` 去重, 依赖排序, 常跟在 sort 后面使用
   - `awk '{print $N}'`  打印出相关列

5. 查找
   - `grep`
       - 参数
           - `-rn` 递归查找目录，并打印行号
           - `--include='*.py'` 仅包含 py 文件
           - `--exclude='*.js'` 不包含 js 文件

   - `find DIR -name '*.xxx'`  找到目录下所有名字匹配的文件
       * 找出文件夹 /tmp/xyz/ 下所有的权限为 642 大小, 在 10k 到 100k 之间的 log 文件
       * `find /tmp/xyz/ -perm 0642 -size +10k -size -100k -name '*.log'`
   - `which`  精确查找当前可执行的命令
   - `where`  查找所有匹配的命令
   - `whereis`  查找匹配的目录
   - `history | awk '{print $4}' | sort | uniq -c | sort -r | head -n 10`

6. 网络管理
   - `ifconfig`  查看网卡状态

   - `netstat -natp`  查看网络连接状态

   - `ping -i 0.5`

   - `lsof -i :[PORT]` 查看占用端口的程序

   - `telnet [HOST] [PORT]`  查看远程主机网络连接状况

   - `traceroute [HOST]`  路由追踪

   - `dig [DOMAIN]`  DNS 查询

7. 下载
   - `curl`  执行 HTTP 访问，也可用来下载

   - `wget`  下载

8. 远程登录
   - `ssh [username@host]` 默认端口 22，其他端口使用 -p 参数
       - RSA key
       - GFW: `ssh -qTfnN -D 7070 [username@host]`
       - 本地执行远程命令：`ssh username@host '[command]'`
       - `ssh-keygen`

   - `scp -P [PORT] filename username@host:/path/`

   - `rsync -cvrP --exclude={.git,.hg,.svn} --delete`

9. 压缩解压
   - `tar`
       - 压缩：`tar -czf newfile.tgz files`
       - 解压：`tar -xzf file.tgz`

   - `zip`
       - 压缩 `zip -r newfile.zip src-file1 src-file2 ...`
           - `-N` 指定压缩比
       - 解压 `unzip file.zip`

10. 登录状态
    - `uname -a`
    - `hostname` 查看/修改主机名
    - `w`      查看登陆者信息
    - `who`    查看登陆者信息
    - `whoami` 当前用户名
    - `last`   最近登录记录

11. 磁盘管理
    - `du -hs` 以友好方式显示文件大小
    - `df -h`  查看磁盘分区的占用情况
    - `dd`     以块的级别进行磁盘复制
        - `if` (input file)  输入文件
        - `of` (output file) 输出文件
        - `bs` (block size)  块大小 (单位: k, m, g)
        - `count`            块数量
        - `dd if=[src_file] of=[dst_file] bs=[size] count=[num]`

12. 安装
    - `make` 编译
        1. `./configure`   执行编译的配置
        2. `make`          执行编译
        3. `make install`  安装编译文件到系统目录
        4. `make clean`    删除编译结果

    - `apt-get` debain 系 Linux 的程序安装
        - apt-get install xxx

    - `yum`     redhat 系 Linux 的程序安装
        - yum install xxx

13. 环境变量
    - `export` 设置一个全局环境变量
    - `unset`  删除变量

    - `$PATH`  可执行文件的存放目录
        - `export PATH=[your path]:$PATH`

    - `$HOME`  家目录

    - `$PWD`   当前目录

14. 基础的的 bash 脚本语句
    - `for...do...done`

            for v in `ls ./`;
            do
                echo $v
            done

    - `if...then...else...fi`

            if [[ -d src ]];then
                echo "Yes"
            else
                echo "No"
            fi

    - `echo`
    - `print`
    - `seq`  相当于 Python 下的 range
        * `seq 1 5`

                for i in `seq 1 4`;
                do
                    echo app-$i
                done

15. 手册

    - `man [command]` 操作手册

16. 其他工具
    - `vim`
        - <http://man.lupaworld.com/content/manage/ringkee/vim.htm>
        - <https://www.douban.com/group/topic/15654295/>
        - <http://www.oschina.net/question/615783_148433>
        - esc 键，默认模式
        - i 键，插入模式
        - shift + : 键，命令模式
        - :q 退出
        - .vimrc

    - `git`
        - `git init`     初始化 .git 文件夹
        - `git add`      添加追踪
        - `git reset`    取消 add 状态
        - `git commit`   提交
        - `git status`   查看当前状态
        - `git checkout` 切换分支
        - `git branch`   分支管理
        - `git pull`     拉去远程代码
        - `git push`     将本地代码推送到远程库
        - `git diff`     差异对比
        - `git log`      查看提交历史

        - 初始化新库
            1. `cd your_project_dir`
            2. `git init`
            3. `git add ./`
            4. `git commit -m 'this is my first commit'`
            5. `git remote add origin git@github.com:your_github_path.git`
            6. `git push -u origin master`

17. Python
    - `pip`
    - `virtualenv`

18. 两个符号
    - `|` 管道符: 把前面的输出结果作为后面命令的参数
    - `>` 重定向: 把前面的输出结果导入到指定的文件中

19. 目录结构

        /
         |- bin         系统可执行目录
         |- boot        启动目录
         |- dev         设备目录 /dev/null (无底洞) /dev/zero (无限 0 数据流) /dev/shm (内存文件夹)
         |- etc         配置
         |- home        用户目录
         |- lib         系统库
         |- media       挂载设备
         |- mnt (mount) 挂载设备
         |- opt         个人安装的程序
         |- proc        当前的进程、运行状态信息的目录
         |- root        管理员的目录
         |- run         运行中的程序的日志文件
         |- sbin        系统管理员的可执行目录
         |- tmp         临时文件夹
         |- usr         资源目录
         |- var         可变的、临时性的文件，各种系统日志文件
