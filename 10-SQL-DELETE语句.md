# SQL DELETE 语句

------

DELETE 语句用于删除表中的记录。

------

## SQL DELETE 语句

DELETE 语句用于删除表中的行。

### SQL DELETE 语法

```sql
DELETE FROM table_name
WHERE some_column=some_value;
```

|      |      |
| ---- | ---- |
|      |      |

------

## 演示数据库

在本教程中，我们将使用 RUNOOB 样本数据库。

下面是选自 "Websites" 表的数据：

```sql
+----+--------------+---------------------------+-------+---------+
| id | name         | url      | alexa | country |
+----+--------------+---------------------------+-------+---------+
| 1  | Google       | https://www.google.cm/    | 1     | USA     |
| 2  | 淘宝          | https://www.taobao.com/   | 13    | CN      |
| 3  | 阿里云大学      | http://edu.aliyun.com/    | 4689  | CN      |
| 4  | 微博          | http://weibo.com/         | 20    | CN    |
| 5  | Facebook     | https://www.facebook.com/ | 3     | USA     |
|  6 | 百度         | https://www.baidu.com/    |     4 | CN      |
|  7 | stackoverflow | http://stackoverflow.com/ |     0 | IND     |
+----+---------------+---------------------------+-------+---------+
```

 

------

## SQL DELETE 实例

假设我们要从 "Websites" 表中删除网站名为 "百度" 且国家为 CN 的网站 。

我们使用下面的 SQL 语句：

```sql
实例
DELETE FROM WebsitesWHERE name='百度' AND country='CN';
```

执行以上 SQL，再读取 "Websites" 表，数据如下所示：

![img](https://edu.aliyun.com/files/course/2017/09-24/011109d5b9e0053950.jpg)

------

## 删除所有数据

您可以在不删除表的情况下，删除表中所有的行。这意味着表结构、属性、索引将保持不变：

```sql
DELETE FROM table_name;

或

DELETE * FROM table_name;
```

**注释：**在删除记录时要格外小心！因为您不能重来！

