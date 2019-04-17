# day03 pandas层次化索引

1. ### 创建多层行索引丶列索引

   - 隐式构造

     最常见的方法是给DataFrame构造函数的index或columns参数传递两个或更多的数组

     ```python
     columns = [['column2','column2','column2','column2'],['column1','column1','column1','column1']]
     index = ['index','index','index']
     df = DataFrame(data = data ,columns = columns, index = index)
     ```

   - 显示构造pd.MultiIndex

     - 使用数组

       ```python
       columns = pd.MultiIndex.from_arrays([['column2','column2','column2','column2'],['column1','column1','column1','column1']],names = ['column2_name','column1_name'])
       index = ['index','index','index']
       df = DataFrame(data = data ,columns = columns, index = index)
       ```

     - 使用tuple

       ```python
       columns = pd.MultiIndex.from_tuples([('column2','column1'),('column2','column1'),('column2','column1'),('column2','column1')])
       index = ['index','index','index']
       df = DataFrame(data = data ,columns = columns, index = index)
       ```

     - 使用product(推荐)

       ```python
       columns = pd.MultiIndex.from_product([['column2_1','column2_2'],['column1_1','column1_2','column1_3']])
       index = ['index','index','index']
       df = DataFrame(data = data ,columns = columns, index = index)
       ```

2. ### 多层索引对象的索引与切片操作

   - Series的操作

     1. 索引

        - 对于Series来说，直接中括号[]与使用.loc()完全一样，推荐使用.loc中括号索引和切片。

          ```python
          s1['index','index']
          s1.loc['index','index']
          ```

        - iloc方法无视index值

          ```python
          s['index'].iloc[0]
          ```

     2. 切片

        ```python
        s1['index':'index']
        s['index'].iloc[0:3]
        ```

   - DataFrame操作

     ```python
     df.loc['index'].loc['column']
     #注意在对行索引的时候，若一级行索引还有多个，对二级行索引会遇到问题！也就是说，无法直接对二级索引进行索引，必须让二级索引变成一级索引后才能对其进行索引！
     ```

3. 索引的堆(stack)

   | 方法      | 说明                                      |
   | ------- | --------------------------------------- |
   | stack   | 使用stack()的时候，level等于哪一个，哪一个就消失，出现在行里。   |
   | unstack | 使用unstack()的时候，level等于哪一个，哪一个就消失，出现在列里。 |

   ```python
   #将行索引变为列索引
   df.unstack(level = 0)
   #将列索引变成行索引
   df.stack(level = 0)
   ```

4. 聚合操作

   - 需要指定axis

   - 和堆相反，聚合的时候，axis等于哪一个，哪一个就保留。

     ```python
     #对列进行聚合
     df.aggregate_function(axis=0)
     #对行进行聚合
     df.aggregate_function(axis=1)
     ```

     ​

     ​

