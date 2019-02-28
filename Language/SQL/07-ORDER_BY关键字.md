# SQL ORDER BY 关键字

------

ORDER BY 关键字用于对结果集进行排序。

------

## SQL ORDER BY 关键字

ORDER BY 关键字用于对结果集按照一个列或者多个列进行排序。

ORDER BY 关键字默认按照升序对记录进行排序。如果需要按照降序对记录进行排序，您可以使用 DESC 关键字。

### SQL ORDER BY 语法

```sql
SELECT column_name,column_name
FROM table_name
ORDER BY column_name,column_name ASC|DESC;
```

 

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
+----+--------------+---------------------------+-------+---------+
```

------

## ORDER BY 实例

下面的 SQL 语句从 "Websites" 表中选取所有网站，并按照 "alexa" 列排序：

```sql
实例
SELECT * FROM WebsitesORDER BY alexa;
```

执行输出结果：

![img](https://edu.aliyun.com/files/course/2017/09-24/005959f7d70e033211.jpg)

 

------

## ORDER BY DESC 实例

下面的 SQL 语句从 "Websites" 表中选取所有网站，并按照 "alexa" 列降序排序：

```sql
实例
SELECT * FROM WebsitesORDER BY alexa DESC;
```

执行输出结果：

![img](https://edu.aliyun.com/files/course/2017/09-24/010031f80c56149416.jpg)

 

------

## ORDER BY 多列

下面的 SQL 语句从 "Websites" 表中选取所有网站，并按照 "country" 和 "alexa" 列排序：

```sql
实例
SELECT * FROM WebsitesORDER BY country,alexa;
```

执行输出结果：

![img](https://edu.aliyun.com/files/course/2017/09-24/0100535b982b715330.jpg)