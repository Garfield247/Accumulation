# SQL AND & OR 运算符

------

AND & OR 运算符用于基于一个以上的条件对记录进行过滤。

------

## SQL AND & OR 运算符

如果第一个条件和第二个条件都成立，则 AND 运算符显示一条记录。

如果第一个条件和第二个条件中只要有一个成立，则 OR 运算符显示一条记录。

------

## 演示数据库

在本教程中，我们将使用 RUNOOB 样本数据库。

下面是选自 "Websites" 表的数据：

```sql
+----+--------------+---------------------------+-------+---------+
| id | name         | url    | alexa | country |
+----+--------------+---------------------------+-------+---------+
| 1  | Google       | https://www.google.cm/    | 1     | USA     |
| 2  | 淘宝          | https://www.taobao.com/   | 13    | CN      |
| 3  | 阿里云大学      | http://edu.aliyun.com/    | 4689  | CN      |
| 4  | 微博          | http://weibo.com/         | 20    | CN    |
| 5  | Facebook     | https://www.facebook.com/ | 3     | USA     |
+----+--------------+---------------------------+-------+---------+
```

------

## AND 运算符实例

下面的 SQL 语句从 "Websites" 表中选取国家为 "CN" 且alexa排名大于 "50" 的所有网站：

```sql
实例
SELECT * FROM WebsitesWHERE country='CN'AND alexa > 50;
```

执行输出结果：

![img](https://edu.aliyun.com/files/course/2017/09-24/005543f5b048410478.jpg)

 

------

## OR 运算符实例

下面的 SQL 语句从 "Websites" 表中选取国家为 "USA" 或者 "CN" 的所有客户：

```sql
实例
SELECT * FROM WebsitesWHERE country='USA'OR country='CN';
```

执行输出结果：

![img](https://edu.aliyun.com/files/course/2017/09-24/0057073610ba387801.jpg)

 

------

## 结合 AND & OR

您也可以把 AND 和 OR 结合起来（使用圆括号来组成复杂的表达式）。

下面的 SQL 语句从 "Websites" 表中选取 alexa 排名大于 "15" 且国家为 "CN" 或 "USA" 的所有网站：

```
实例
SELECT * FROM WebsitesWHERE alexa > 15AND (country='CN' OR country='USA');
```

执行输出结果：

![img](https://edu.aliyun.com/files/course/2017/09-24/005717da76a9859075.jpg)