## 问题:

使用DJango链接数据库时遇到

**RuntimeError: cryptography is required for sha256_password or caching_sha2_password**

## 原因:

遇到这个问题是由于在mysql8之前的版本使用的密码加密规则是mysql_native_password，但是在mysql8则是caching_sha2_password。



## 处理:

1. 修改加密规 

   ```sql
   ALTER USER 'root'@'localhost' IDENTIFIED BY 'password' PASSWORD EXPIRE NEVER; 
   ```

2. 更新一下用户的密码

   ```sql
   ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password'; 
   ```

3. 刷新权限

   ```sql
   FLUSH PRIVILEGES; 
   ```

4. 再重置下密码：

   ```sql
   alter user 'root'@'localhost' identified by 'password';
   ```

   

