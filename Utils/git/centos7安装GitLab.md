## centos7安装GitLab

### 下载相应版本rpm包

https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el7/
我此处下载9.3.6版本。

```shell
# wget https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el7/gitlab-ce-9.3.6-ce.0.el7.x86_64.rpm
# yum -y install gitlab-ce-9.3.6-ce.0.el7.x86_64.rpm
```

### 更改仓库地址及访问

```shell
# cd /etc/gitlab/
# egrep -v "^$|^#" gitlab.rb 
external_url 'http://gitlab.xxxx.com'
git_data_dirs({ "default" => { "path" => "/xxx/gitlab/git-data", 'gitaly_address' => 'unix:/var/opt/gitlab/gitaly/gitaly.socket' } })
```

### 生效配置

```shell
#使配置生效
# gitlab-ctl reconfigure
#启动GitLab 
# gitlab-ctl start
```

默认nginx端口是80，如果有占用，需要更改.
输入ip或者域名可以访问到git，第一次访问需要更改密码。

### GitLab常用命令

```shell
sudo gitlab-ctl start    # 启动所有 gitlab 组件；
sudo gitlab-ctl stop        # 停止所有 gitlab 组件；
sudo gitlab-ctl restart        # 重启所有 gitlab 组件；
sudo gitlab-ctl status        # 查看服务状态；
sudo gitlab-ctl reconfigure        # 启动服务；
sudo vim /etc/gitlab/gitlab.rb        # 修改默认的配置文件；
gitlab-rake gitlab:check SANITIZE=true --trace    # 检查gitlab；
sudo gitlab-ctl tail        # 查看日志；
```

## git数据迁移

**高版本的Gitlab无法恢复低版本备份的数据,需要注意在b服务器部署和a服务器一样版本的gitlab,部署好环境后开始备份和数据迁移.**

### 查看gitlab版本的命令

```shell
# gitlab-rake gitlab:env:info
```

### 备份原a服务器上的的数据

```shell
# gitlab-rake gitlab:backup:create RAILS_ENV=production
```

PS: 备份后的文件一般是位于/var/opt/gitlab/backups下, 自动生成文件名文件名如1481529483_gitlab_backup.tar

### 将步骤2生成的tar文件拷贝到b服务器上相应的backups目录下

可以利用scp进行直接拷贝.

```shell
# scp username@src_ip:/var/opt/gitlab/backups/1481529483_gitlab_backup.tar /var/opt/gitlab/backups
```

PS: username为原服务器的用户名，src_ip原服务器IP地址

### 在b服务器恢复数据

```shell
# gitlab-rake gitlab:backup:restore RAILS_ENV=production BACKUP=1481529483
```

PS：BACKUP的时间点必须与原服务器备份后的文件名一致

恢复完之后访问薪git，可以看到数据跟老git完全一致！