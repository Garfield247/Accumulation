day03Pandas的拼接操作

pandas的拼接分为两种：

- 级联：pd.concat, pd.append
- 合并：pd.merge, pd.join

1. ### 使用pd.concat()级联

   ```
   pd.concat((df1,df2),axis=0)
   ```

   pandas使用pd.concat函数，与np.concatenate函数类似，只是多了一些参数：

   | 参数                   | 说明                              |
   | -------------------- | ------------------------------- |
   | objs                 | 参与级连的对象                         |
   | axis=0               | 级连的轴向                           |
   | join='outer'         | 级连的方式                           |
   | join_axes=None       | 指定索引进行级联（pd.Index(data = data)) |
   | ignore_index=False   | 重新设置索引                          |
   | keys = [name1,name2] | 构建多级索引                          |

2. ### 使用append()函数添加

   ```
   df1.append(other, ignore_index=False, verify_integrity=False)
   ```

3. ##  使用pd.merge()合并

   merge与concat的区别在于，merge需要依据某一共同的行或列来进行合并

   使用pd.merge()合并时，会自动根据两者相同column名称的那一列，作为key来进行合并。

   注意每一列元素的顺序不要求一致

   ```python 
    pd.merge(left, right, how='inner', on=None, left_on=None, right_on=None, left_index=False, right_index=False, sort=False, suffixes=('_x', '_y'), copy=True, indicator=False, validate=None)
   ```

   | 参数                     | 说明                             |
   | ---------------------- | ------------------------------ |
   | left, right            | 需要合并的DataFrame                 |
   | how                    | 合并方式                           |
   | on                     | 使用on=显式指定哪一列为key,当有多个key相同时使用  |
   | left_on,right_on       | 指定左右两边的列作为key，当左右两边的key都不想等时使用 |
   | left_index,right_index | 如果需要根据索引来进行合并                  |
   | suffixes               | 指定后缀                           |

   ​

