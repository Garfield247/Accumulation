# SQL SELECT 语句

------

SELECT 语句用于从数据库中选取数据。

------

## SQL SELECT 语句

SELECT 语句用于从数据库中选取数据。

结果被存储在一个结果表中，称为结果集。

### SQL SELECT 语法

```sql
SELECT column_name,column_name
FROM table_name;
```

与

```sql
SELECT * FROM table_name;
```

------

## 演示数据库

在本教程中，我们将使用 RUNOOB 样本数据库。

下面是选自 "Websites" 表的数据：

```
 
+----+--------------+---------------------------+-------+---------+
| id | name         | url                       
| alexa | country |
+----+--------------+---------------------------+-------+---------+
| 1  | Google       | https://www.google.cm/    | 1     | USA     |
| 2  | 淘宝          | https://www.taobao.com/   | 13    | CN      |
| 3  | 阿里云大学      | http://edu.aliyun.com/    | 4689  | CN      |
| 4  | 微博          | http://weibo.com/         | 20    | CN      |
| 5  | Facebook     | https://www.facebook.com/ | 3     | USA     |
+----+--------------+---------------------------+-------+---------+
```

------

## SELECT Column 实例

下面的 SQL 语句从 "Websites" 表中选取 "name" 和 "country" 列：

```sql
实例
SELECT name,country FROM Websites;
```

输出结果为:

![img](https://edu.aliyun.com/files/course/2017/09-24/004901dd0b1c875531.jpg)

------

## SELECT * 实例

下面的 SQL 语句从 "Websites" 表中选取所有列：

```sql
实例
SELECT * FROM Websites;
```

输出结果为:

![img](https://edu.aliyun.com/files/course/2017/09-24/0048513e4100288550.jpg)

------

## 结果集中的导航

大多数数据库软件系统都允许使用编程函数在结果集中进行导航，比如：Move-To-First-Record、Get-Record-Content、Move-To-Next-Record 等等。