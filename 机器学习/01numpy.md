# numpy

- 安装

  ```
  pip install numpy
  ```

- 导入

  ```python
  import numpy as np
  ```
  ​

# ndarray

### 一丶创建

1. 直接使用python list创建

   ```python
   n1 = np.array(list1)
   ```

2. 使用numpy中的函数创建

   ```
   1.  np.ones(shape, dtype=None, order='C')
   	生成由1组成的数组
   	shape可以指定数字或元祖
   2.  np.zeros(shape, dtype=float, order='C')
   	生成由1组成的数组
   	shape可以指定数字或元祖
   3.  np.full(shape, fill_value, dtype=None, order='C')
   	生成自定义填充内容的数组
   	shape可以指定数字或元祖
   	fill_value指定填充内容,格式为数字
   4.  np.eye(N, M=None, k=0, dtype=float)
   	对角线为1其他的位置为0
   	N,M指定行数列数
   	k代表偏移值,为正右偏移,为负左偏移
   5.  np.linspace(start, stop, num=50, endpoint=True, retstep=False, dtype=None)
   	对一个数值区间进行等分
   	start,stop起始值
   	num等分的份数
   	endpoint是否使用末尾值
   	retstep是否显示步长
   6.  np.arange([start, ]stop, [step, ]dtype=None)
   	生成一个等差数列
   	start,stop起始值
   	step步长默认为1
   7.  np.random.randint(low, high=None, size=None, dtype='l')	
   	在一个指定的数值区间内生成随机整数的数组
   	low,high最大值最小值
   	size数组样式,可以为数字或数组
   8.  np.random.randn(d0, d1, ..., dn)  
   	生成标准正态分布的样本集
   	标准正太分布　np.random.normal()
   9. 	9) np.random.random(size=None)  
   	生成0到1的随机数
   ```

   ​

### 二丶属性

- ndim  :  维度
- shape :  形状
- size  :  长度
- dtype : 元素类型

### 三丶操作

1. 索引

   ```python
   n1[0][0]
   n1[0,0]
   #两种方法等效
   ```

2. 切片

   参考列表的切片

3. 变形

   n1.reshape()
   传入一个元祖

4. 级联

   ```
   np.concatenate() 级联需要注意的点：
   1.级联的参数是列表：一定要加中括号或小括号
   2.维度必须相同
   3.形状相符
   4.【重点】级联的方向默认是shape这个tuple的第一个值所代表的维度方向
   5.可通过axis参数改变级联的方向
   ```



| 函数                                |  说明  |          备注          |
| --------------------------------- | :--: | :------------------: |
| np.concatenate((n1,n2),axis=None) |  级联  | # axis指定级联方向取值0 or 1 |
| np.hstack((n1,n2))                | 水平级联 |          \           |
| np.vstack((n1,n2))                | 垂直级联 |          \           |

   

5. 切分

  | 函数        | 说明   |
  | --------- | ---- |
  | np.split  | 切分   |
  | np.vsplit | 竖向切分 |
  | np.hsplit | 横向切分 |

6. 副本


```python
n2 = n1.copy()
```

### 四丶聚合

常用聚合操作

| 函数          | NaN-safe Version | 说明     |
| :---------- | :--------------- | ------ |
| n1.sum()    | np.nansum()      | 求和     |
| n1.max()    | np.nanmax()      | 求最大值   |
| n1.min()    | np.nanmin()      | 求最小值   |
| n1.mean()   | np.anmean()      | 求平均数   |
| n1.argmax() | np.nanaremax()   | 最大值的索引 |
| n1.argmin() | np.nanargmin()   | 最小值的索引 |
| np.prod()   | np.nanprod()     | 连乘     |
| np.std()    | np.nanstd()      | 方差     |
|             |                  |        |

### 五丶矩阵

##### 基本矩阵操作

1. 加减法

   ```
   n1 + n2
   ```

2. 乘法

   ```
   np.dot(n1,n2)
   ```

#####  广播

```
【重要】ndarray广播机制的两条规则
规则一：为缺失的维度补1
规则二：假定缺失元素用已有值填充
```

### 六丶排序

| 函数                | 说明   | 备注   |
| ----------------- | ---- | ---- |
| n.sort()          | 快速排序 |      |
| np.sort(n)        | 快速排序 |      |
| np.partition(a,k) | 部分排序 |      |

```
1. 快速排序
np.sort()与ndarray.sort()都可以，但有区别：
np.sort()不改变输入
ndarray.sort()本地处理，不占用空间，但改变输入
2. 部分排序
np.partition(a,k)
有的时候我们不是对全部数据感兴趣，我们可能只对最小或最大的一部分感兴趣。
当k为正时，我们想要得到最小的k个数
当k为负时，我们想要得到最大的k个数
```

