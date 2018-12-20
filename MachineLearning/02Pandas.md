# Pandas

### pandas的数据结构

pandas常用的包

三剑客

```python
import numpy as np
import pandas as pd
from pandas import Series,DataFrame
```

### 1丶Series

Series是一种类似与一维数组的对象，由下面两个部分组成：

- values：一组数据（ndarray类型）
- index：相关的数据索引标签

1. #### Series的创建

   两种创建方式：

   (1) 由列表或numpy数组创建

```python
#默认索引为0到N-1的整数型索引
  s1 = Series([1,2,3,4,5,6])
 #还可以通过设置index参数指定索引
  s1.index = list('abcdef')
 #特别地，由ndarray创建的是引用，而不是副本。对Series元素的改变也会改变原来的ndarray对象中的元素。（列表没有这种情况）
```

​	(2)由字典创建

```
d1 = {'name':'dancer','age':19,'address':'beijing'}
Series(d1)
```

2. #### Series的索引和切片

   可以使用中括号取单个索引（此时返回的是元素类型），或者中括号里一个列表取多个索引（此时返回的仍然是一个Series类型）。分为显示索引和隐式索引：

   (1) 显式索引：

   ```
   - 使用index中的元素作为索引值
   - 使用.loc[]（推荐）注意，此时是闭区间
   ```

    (2) 隐式索引：

   ```
   - 使用整数作为索引值
   - 使用.iloc[]（推荐）注意，此时是半开区间
   ```

   ​

3. #### Series的基本概念

   1. 可以把Series看成一个定长的有序字典

   2. 可以通过shape，size，index,values等得到series的属性

   3. 可以使用head(),tail()分别查看前n个和后n个值(当索引没有对应的值时，可能出现缺失数据显示NaN（not a number）的情况)

   4. 可以使用pd.isnull()，pd.notnull()，或自带isnull(),notnull()函数检测缺失数据

      ```
      s1.isnull()
      # 返回的仍然是一个Series对象
      s.notnull()
      ```

      ​

   5. 使用Bool_list访问数组对象

      ```python
      bool_list = [True,True,False,False]
      s = Series(np.array([1,2,3,4]))
      s[bool_list]
      ```

      ​

4. #### Series的运算

   1. 适用于numpy的数组运算也适用于Series
   2. Series之间的运算
      - 在运算中自动对齐不同索引的数据
      - 如果索引不对应，则补NaN

   ```python
   s1.add(s2,fill_value = 0)		#加
   s1.sub(s2,fill_value = 0)		#减
   s1.mul(s2,fill_value = 1)		#乘
   s1.div(s2,fill_value = 1)		#除
   #fill_value在元素中包nan时所替代的值
   ```





### 2丶DataFrame

DataFrame是一个【表格型】的数据结构，可以看做是【由Series组成的字典】（共用同一个索引）。DataFrame由按一定顺序排列的多列数据组成。设计初衷是将Series的使用场景从一维拓展到多维。DataFrame既有行索引，也有列索引。

- 行索引：index

- 列索引：columns

- 值：values（numpy的二维数组）

  #### 1.  DataFrame的创建

  最常用的方法是传递一个字典来创建。DataFrame以字典的键作为每一【列】的名称，以字典的值（一个数组）作为每一列。

  此外，DataFrame会自动加上每一行的索引（和Series一样）。

  同Series一样，若传入的列与字典的键不匹配，则相应的值为NaN。

  ```python
  #DataFrame属性：values、columns、index、shape
  df = DataFrame(data = data, index = index, columns = columns)
  ```

  #### 2.  DataFrame的索引

  (1) 对列进行索引

      - 通过类似字典的方式
      - 通过属性的方式

   可以将DataFrame的列获取为一个Series。返回的Series拥有原DataFrame相同的索引，且name属性也已经设置好了，就是相应的列名。

  (2) 对行进行索引

      - 使用.ix[]来进行行索引
      - 使用.loc[]加index来进行行索引
      - 使用.iloc[]加整数来进行行索引

   同样返回一个Series，index为原来的columns。

  (3) 对元素索引的方法

  ```
  - 使用列索引
  - 使用行索引(iloc[3,1]相当于两个参数;iloc[[3,3]] 里面的[3,3]看做一个参数)
  - 使用values属性（二维numpy数组）
  ```

  【注意】 直接用中括号时：

  - 索引表示的是列索引
  - 切片表示的是行切片

  #### 3.  DataFrame的运算

  （1） DataFrame之间的运算

  同Series一样：

  - 在运算中自动对齐不同索引的数据
  - 如果索引不对应，则补NaN

   下面是Python 操作符与pandas操作函数的对应表：

| Python Operator | Pandas Method(s)                       |
| --------------- | -------------------------------------- |
| ``+``           | ``add()``                              |
| ``-``           | ``sub()``, ``subtract()``              |
| ``*``           | ``mul()``, ``multiply()``              |
| ``/``           | ``truediv()``, ``div()``, ``divide()`` |
| ``//``          | ``floordiv()``                         |
| ``%``           | ``mod()``                              |
| ``**``          | ``pow()``                              |

  （2） Series与DataFrame之间的运算

  【重要】

  - 使用Python操作符：以行为单位操作（参数必须是行），对所有行都有效。（类似于numpy中二维数组与一维数组的运算，但可能出现NaN）

  - 使用pandas操作函数：

         axis=0：以列为单位操作（参数必须是列），对所有列都有效。
         axis=1：以行为单位操作（参数必须是行），对所有行都有效。

         ## 例

  ```
  df1.add(df2,axis=0,fill_value=0)
  ```

  ​