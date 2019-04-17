# SQL UPDATE 语句

------

UPDATE 语句用于更新表中的记录。

------

## SQL UPDATE 语句

UPDATE 语句用于更新表中已存在的记录。

### SQL UPDATE 语法

```sql
UPDATE table_name
SET column1=value1,column2=value2,...
WHERE some_column=some_value;
```

 

------

## 演示数据库

在本教程中，我们将使用 RUNOOB 样本数据库。

下面是选自 "Websites" 表的数据：

```sql
+----+--------------+---------------------------+-------+---------+
| id | name         | url     | alexa | country |
+----+--------------+---------------------------+-------+---------+
| 1  | Google       | https://www.google.cm/    | 1     | USA     |
| 2  | 淘宝          | https://www.taobao.com/   | 13    | CN      |
| 3  | 阿里云大学      | http://edu.aliyun.com/    | 4689  | CN      |
| 4  | 微博          | http://weibo.com/         | 20    | CN     |
| 5  | Facebook     | https://www.facebook.com/ | 3     | USA     |
+----+--------------+---------------------------+-------+---------+
```

 

------

## SQL UPDATE 实例

假设我们要把 "速学堂" 的 alexa 排名更新为 5000，country 改为 USA。

我们使用下面的 SQL 语句：

```sql
实例
UPDATE Websites SET alexa='5000', country='USA' WHERE name='阿里云大学;
```

执行以上 SQL，再读取 "Websites" 表，数据如下所示：

![img](https://edu.aliyun.com/files/course/2017/09-24/0109106d3ad4293679.jpg)