# day04 Pandas数据处理

### 1、删除重复元素

```python
df1.drop_duplicates(keep='last',inplace=True)
# keep指定保留第一个还是最后一个，first保留第一个，last保留最后一个
# inplace True:修改数据的原始结构，Fasle不修改原始结构，产生新数据
```

如果使用pd.concat([df1,df2],axis = 1)生成新的DataFrame，新的df中columns相同，使用duplicate()和drop_duplicates()都会出问题

### 2. 映射

映射的含义：创建一个映射关系列表，把values元素和一个特定的标签或者字符串绑定

包含三种操作：

- replace()函数：替换元素
- 最重要：map()函数：新建一列
- rename()函数：替换索引

### replace()函数：替换元素

#### Series替换操作

- 单值替换

  - 普通替换

    ```python
    # 单值替换
    s1.replace(to_replace='dancer',value='DANCER')
    # 替换数字
    s1.replace(100,500)
    # 替换空值 在Series里面，None值无法进行替换，np.nan是可以被替换和识别的
    s1.replace(np.nan,'空值')
    ```

  - 字典替换(推荐）

    ```python
    # 使用字典替换
    s1.replace(to_replace={'dancer':'DANCER'})
    ```

  - 使用limit和metho

    ```python
    # method 对指定的值使用相邻的值填充
    # limit 指定填充次数
    # 注意：不要在使用value参数 method和limit参数不能在DataFrame中使用
    s2.replace(to_replace=100,method='bfill',limit=1)
    ```

    d参数

- 多值替换

  - 列表替换

    ```python
    # 列表替换
    # 第一个列表是要替换的目标值
    # 第二个列表是要替换的新值
    # 注意：两个列表长度要匹配
    s1.replace(['dancer','susan',np.nan],['DANCER','SUSAN','空值'])
    ```

  - 字典替换（推荐）

    ```python
    # 字典替换
    map_dic = {'?':'未知数',100:'满分',np.nan:'空值'}
    s1.replace(map_dic)
    ```

#### DataFrame替换操作

- 单值替换

  - 普通替换

    ```python
    # 搜寻整个表格当中与to_replace匹配的值，使用value进行替换
    df.replace(to_replace='?',value='未知数')
    df.replace(to_replace='优秀',value='一般')
    ```

  - 按列指定单值替换{列标签：替换值}

    ```python
    # 第一个参数是一个字典，描述了要替换的值，键表示列名称，值表示要替换的目标值
    # 第二个参数要替换的新数据
    df.replace({'Java':np.nan},100)
    ```


- 多值替换

  - 列表替换

    ```python
    # 列表替换
    # 列表替换同Series的列表替换
    df.replace(['优秀',np.nan,'?'],['一般','缺失','未知'])
    ```

  - 单字典替换（推荐）

    ```python
    # 做替换操作时，往往会创建一个范围比较大的字典
    # None可以用作字典的键
    # 在DataFrame的替换中，None可以匹配None和np.nan
    # 在使用的时候要注意None 或np.nan的有效性
    map_dic = {'aaa':'AAA','不及格':'有故事',np.nan:'123空值'}
    df.replace(map_dic)
    ```

### map()函数：新建一列

- map(字典) 字典的键要足以匹配所有的数据，否则出现NaN
- map()可以映射新一列数据
- map()中可以使用lambd表达式
- map()中可以使用方法，可以是自定义的方法

**注意** map()中不能使用sum之类的函数，for循环

```python
# 键值对一般要保证够用，不然会出现空值
number_list = {'dancer':'01','lucy':'02','tom':'03','Tom':'04'}
df['number'] = df['name'].map(number_list)
```

```python
# 修改一列的值，使用函数
def add_score(item):
    return item+10
df['python'] = df['python'].map(add_score)
# 使用lambda表达式
lambda x : x+10
df['Java'] = df['Java'].map(lambda item : item-10)
```

#### transform()和map()类似

```python
def transform_func(item):
    return item+10
df['python'] = df['python'].transform(transform_func)
```

###  rename()函数：替换索引

使用rename()函数替换行索引

- index 替换行索引

  ```python
  # 替换行索引，指定index参数
  name_dic = {oldName:newName}
  df1.rename(index=name_dic)
  ```

- columns 替换列索引

  ```python
  # 替换列索引，指定columns参数
  name_dic = {oldName:newName}
  df1.rename(columns=name_dic)
  ```

- level 指定多维索引的维度

  ```python
  # 使用level参数来控制替换的索引层级
  mul_df.rename(columns = mul_dic,level = 1)
  ```

### 3. 使用聚合操作对数据异常值检测和过滤

使用describe()函数查看每一列的描述性统计量

```
df1.describe()
```

### 4. 排序

#### 使用.take()函数排序

```
- take()函数接受一个索引列表，用数字表示
- eg:df.take([1,3,4,2,5])
```

可以借助np.random.permutation()函数随机排序

### 5. 数据分类处理【重点】

数据聚合是数据处理的最后一步，通常是要使每一个数组生成一个单一的数值。

数据分类处理：

- 分组：先把数据分为几组
- 用函数处理：为不同组的数据应用不同的函数以转换数据
- 合并：把不同组得到的结果合并起来

数据分类处理的核心：

```
 - groupby()函数
 - groups属性查看分组情况
```

```
# 可以通过groups属性查看分组情况，但是不要企图用DataFrame的方式展示数据
df.groupby('column').groups
# 一般是进行聚合操作处理后在查看结果，这里展示查看总和的聚合操作
df.groupby('column').sum()
```

## 6.0 高级数据聚合

#### 使用groupby分组后，也可以使用transform和apply提供自定义函数实现更多的运算

- df.groupby('item')['price'].sum() <==> df.groupby('item')['price'].apply(sum)
- transform和apply都会进行运算，在transform或者apply中传入函数即可
- transform和apply也可以传入一个lambda表达式