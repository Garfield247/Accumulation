# SQL SELECT TOP, LIMIT, ROWNUM 子句

------

## SQL SELECT TOP 子句

SELECT TOP 子句用于规定要返回的记录的数目。

SELECT TOP 子句对于拥有数千条记录的大型表来说，是非常有用的。

**注释：**并非所有的数据库系统都支持 SELECT TOP 子句。

### SQL Server / MS Access 语法

```sql
SELECT TOP number|percent column_name(s)
FROM table_name;
```

------

## MySQL 和 Oracle 中的 SQL SELECT TOP 是等价的

### MySQL 语法

```sql
SELECT column_name(s)
FROM table_name
LIMIT number;
```

### 实例

```sql
SELECT *
FROM Persons
LIMIT 5;
```

### Oracle 语法

```sql
SELECT column_name(s)
FROM table_name
WHERE ROWNUM <= number;
```

 

### 实例

```sql
SELECT *
FROM Persons
WHERE ROWNUM <=5;
```

------

## 演示数据库

在本教程中，我们将使用 RUNOOB 样本数据库。

下面是选自 "Websites" 表的数据：

```sql
mysql> SELECT * FROM Websites;
+----+---------------+---------------------------+-------+---------+
| id | name          | url                       | alexa | country |
+----+---------------+---------------------------+-------+---------+
|  1 | Google        | https://www.google.cm/    |     1 | USA     |
|  2 | 淘宝          | https://www.taobao.com/   |    13 | CN      |
|  3 | 阿里云大学      | http://edu.aliyun.com/    |  5000 | USA     |
|  4 | 微博           | http://weibo.com/         |    20 | CN      |
|  5 | Facebook      | https://www.facebook.com/ |     3 | USA     |
|  7 | stackoverflow | http://stackoverflow.com/ |     0 | IND     |
+----+---------------+---------------------------+-------+---------+
```

 

------

## SQL SELECT TOP 实例

下面的 SQL 语句从 "Websites" 表中选取头两条记录：

## 实例

SELECT * FROM Websites LIMIT 2;

执行以上 SQL，数据如下所示：

![img](https://edu.aliyun.com/files/course/2017/09-24/01133829c15b883823.jpg)

 

------

## SQL SELECT TOP PERCENT 实例

在 Microsoft SQL Server 中还可以使用百分比作为参数。

下面的 SQL 语句从 "Customers" 表中选取前面 50% 的记录：

## 实例

以下操作在 Microsoft SQL Server 数据库中可执行。

SELECT TOP 50 PERCENT * FROM Websites;