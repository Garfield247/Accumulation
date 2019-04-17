# SQL SELECT DISTINCT 语句

------

SELECT DISTINCT 语句用于返回唯一不同的值。

------

## SQL SELECT DISTINCT 语句

在表中，一个列可能会包含多个重复值，有时您也许希望仅仅列出不同（distinct）的值。

DISTINCT 关键词用于返回唯一不同的值。

### SQL SELECT DISTINCT 语法

```sql
SELECT DISTINCT column_name,column_name
FROM table_name;
```

------

在本教程中，我们将使用 RUNOOB 样本数据库。

下面是选自 "Websites" 表的数据：

```sql
+----+--------------+---------------------------+-------+---------+
| id | name         | url    | alexa | country |
+----+--------------+---------------------------+-------+---------+
| 1  | Google       | https://www.google.cm/    | 1     | USA     |
| 2  | 淘宝          | https://www.taobao.com/   | 13    | CN      |
| 3  | 阿里云大学      | http://edu.aliyun.com/    | 4689  | CN      |
| 4  | 微博          | http://weibo.com/         | 20    | CN   |
| 5  | Facebook     | https://www.facebook.com/ 
| 3     | USA     |+----+--------------+---------------------------+-------+---------+
```

 

------

## SELECT DISTINCT 实例

下面的 SQL 语句仅从 "Websites" 表的 "country" 列中选取唯一不同的值，也就是去掉 "country" 列重复值：

```sql
实例
SELECT DISTINCT country FROM Websites;
```

 

输出结果：

![img](https://edu.aliyun.com/files/course/2017/09-24/00504447d5f6130350.jpg)

