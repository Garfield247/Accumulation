# SQL WHERE 子句

------

WHERE 子句用于过滤记录。

------

## SQL WHERE 子句

WHERE 子句用于提取那些满足指定标准的记录。

### SQL WHERE 语法

```sql
SELECT column_name,column_name
FROM table_name
WHERE column_name operator value;
```

 

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
| 3  | 阿里云大学      | http://edu.aliyun.com/   | 4689  | CN      |
| 4  | 微博          | http://weibo.com/         | 20    | CN     |
| 5  | Facebook     | https://www.facebook.com/ | 3     | USA     |
+----+--------------+---------------------------+-------+---------+
```

 

------

## WHERE 子句实例

下面的 SQL 语句从 "Websites" 表中选取国家为 "CN" 的所有网站：

```sql
实例
SELECT * FROM Websites WHERE country='CN';
```

 

执行输出结果：

![img](https://edu.aliyun.com/files/course/2017/09-24/00523646b785888443.jpg)

 

------

## 文本字段 vs. 数值字段

SQL 使用单引号来环绕文本值（大部分数据库系统也接受双引号）。

在上个实例中 'CN' 文本字段使用了单引号。

如果是数值字段，请不要使用引号。

```sql
实例
SELECT * FROM Websites WHERE id=1;
```

执行输出结果：

![img](https://edu.aliyun.com/files/course/2017/09-24/00530849f210107230.jpg)

 

------

## WHERE 子句中的运算符

下面的运算符可以在 WHERE 子句中使用：

| 运算符  | 描述                                                       |
| ------- | ---------------------------------------------------------- |
| =       | 等于                                                       |
| <>      | 不等于。**注释：**在 SQL 的一些版本中，该操作符可被写成 != |
| >       | 大于                                                       |
| <       | 小于                                                       |
| >=      | 大于等于                                                   |
| <=      | 小于等于                                                   |
| BETWEEN | 在某个范围内                                               |
| LIKE    | 搜索某种模式                                               |
| IN      | 指定针对某个列的多个可能值                                 |