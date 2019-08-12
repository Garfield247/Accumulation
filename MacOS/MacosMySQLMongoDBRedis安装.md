MacOS安装MySQL、MongoDB、Redis

## Mysql5.7

### 安装

```shell
brew install mysql@5.7
```

### 环境变量

1. 添加

    ```shell
    echo 'export PATH="/usr/local/opt/openssl/bin:$PATH"' >> ~/.bash_profile
    ```

2. 刷新环境变量

    ```shell
    source ~/.bash_profile
    ```

### 启动服务

```shell
brew services start mysql@5.7
```

### 初始配置

1. 开启初始化配置工具

    ```
    mysql_secure_installation
    ```

2. 配置过程

    ```java
    Securing the MySQL server deployment.
    
    Connecting to MySQL using a blank password.
    
    VALIDATE PASSWORD COMPONENT can be used to test passwords
    and improve security. It checks the strength of password
    and allows the users to set only those passwords which are
    secure enough. Would you like to setup VALIDATE PASSWORD component?
    
    Press y|Y for Yes, any other key for No: y   //使用密码验证
    
    There are three levels of password validation policy:   
    
    LOW    Length >= 8
    MEDIUM Length >= 8, numeric, mixed case, and special characters
    STRONG Length >= 8, numeric, mixed case, special characters and dictionary                  file
    
    Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG: 0  // 选择密码验证等级
    Please set the password for root here.
    
    New password:    // 输入新密码
    
    Re-enter new password: 
    
    Estimated strength of the password: 50 
    Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) : y  
    By default, a MySQL installation has an anonymous user,
    allowing anyone to log into MySQL without having to have
    a user account created for them. This is intended only for
    testing, and to make the installation go a bit smoother.
    You should remove them before moving into a production
    environment.
    
    Remove anonymous users? (Press y|Y for Yes, any other key for No) : y   //删除匿名用户
    Success.
    
    
    Normally, root should only be allowed to connect from
    'localhost'. This ensures that someone cannot guess at
    the root password from the network.
    
    Disallow root login remotely? (Press y|Y for Yes, any other key for No) : n // 是否禁止远程登录
    
     ... skipping.
    By default, MySQL comes with a database named 'test' that
    anyone can access. This is also intended only for testing,
    and should be removed before moving into a production
    environment.
    
    
    Remove test database and access to it? (Press y|Y for Yes, any other key for No) : y  // 是否删除测试库
     - Dropping test database...
    Success.
    
     - Removing privileges on test database...
    Success.
    
    Reloading the privilege tables will ensure that all changes
    made so far will take effect immediately.
    
    Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y  // 刷新数据库权限
    Success.
    
    All done!   // 完成
    ```

    

## MongoDB

### 安装

```
brew install mongodb
```

### 启动服务

```
brew services start mongodb
```

### 配置文件

`/usr/local/etc/mongod.conf`

```python
systemLog:
  destination: file
  path: /usr/local/var/log/mongodb/mongo.log
  logAppend: true
storage:
  dbPath: /usr/local/var/mongodb
net:
  bindIp: 127.0.0.1
```



## Redis

安装

```
brew install redis
```

启动服务

```
brew services start redis
```

配置文件

`/usr/local/etc/redis.conf`

```
//第61行 
bind 0.0.0.0 
//第80行 
protected-mode no 
//第128行 
daemonize yes
```

