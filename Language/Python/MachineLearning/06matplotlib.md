# day06 matplotlib

###  一丶Matplotlib基础知识

Matplotlib中的基本图表包括的元素

  + x轴和y轴  
    水平和垂直的轴线


  + x轴和y轴刻度  
    刻度标示坐标轴的分隔，包括最小刻度和最大刻度


  + x轴和y轴刻度标签  
    表示特定坐标轴的值


  + 绘图区域  
    实际绘图的区域

  ##### 绘图基础

1. ##### 只含单一曲线的图

```python
#  Example 
x = np.arange(0,100,10)
plt.plot(x,x)
```

2. ##### 包含多个区曲线的图

- 可以使用多个plot函数（推荐），在一个图中绘制多个曲线

```
#  Example 
x = np.linspace(0,2*np.pi,100)
plt.plot(x,np.sin(x))
plt.plot(x,np.cos(x))
```
- 也可以在一个plot函数中传入多对X,Y值，在一个图中绘制多个曲线

  ```
  #  Example 
  x = np.arange(0,10,1)
  line0,line1,line2 = plt.plot(x,x,x,x*2,x,x/2)
  ```


3. ##### 网格线grid

   设置grid参数（参数与plot函数相同），使用plt面向对象的方法，创建多个子图显示不同网格线

   - lw代表linewidth，线的粗细

   - alpha表示线的明暗程度

   - color代表颜色

   - ls代表linestyle，线的样式

     ```python
     # 使用plt.grid绘制网格线
     plt.grid(True)
     # 设置网格线的axis参数，保留横向或者纵向的网格线
     plt.grid(axis='x')
     plt.grid(axis='y')
     # 网格线样式设置
     axes1.grid(color = 'red')#颜色
     axes2.grid(ls = '--')#样式
     axes3.grid(lw = 5)#线宽
     axes1.grid(alpha = 0.1)#透明度
     ```

     | 样式   | 参数      | 参数      |
     | ---- | ------- | ------- |
     | 直线   | solid   | '-'     |
     | 虚线   | dashed  | '--'    |
     | 点画线  | dashdot | '-.'    |
     | 虚线   | dotted  | ':'     |
     | 无    | 'None'  | ' 'or'' |

4. ##### 坐标轴界限axis,xlim,ylim

   - 方式一

     ```python
     plt.axis([-5,15,-1,2])
     ```

   - 方式二

     ```python
     plt.xlim(-4,4)
     plt.ylim(-2,2)
     ```

   - 拓展

     ```python
     #euqal   scaled   image  功能类似,保证绘图去的xy等比例
     plt.axis('image')
     # 让图像在中心显示
     plt.axis('tight')
     #隐藏刻度线
     plt.axis('off')
     ```

5. ##### 标签title

   ```python
   #  Example 
   plt.title('TITLE',rotation = 0,color = 'g',fontsize = 30,horizontalalignment='right',loc='right')
   ```

   | 参数                  | 说明                            |
   | ------------------- | ----------------------------- |
   | 'TITLE'             | 标题,传入字符串                      |
   | rotation            | 旋转角度                          |
   | color               | 字体颜色                          |
   | fontsize            | 字体大小                          |
   | horizontalalignment | 文本对其方向'left','right','center' |
   | loc                 | 标题位置'left','right','center'   |

6. ##### 图例 legend

   - 方法一

     ```python
     x  = np.arange(-10,10,1)
     plt.plot(x,x,label='normal')
     plt.plot(x,x**2,label='fast')
     plt.plot(x,np.sin(x),label='slow')

     plt.legend()
     ```

   - 方法二

     ```
     plt.plot(x,x,x,x*2,x,x/2)
     plt.legend(['normal','fast','slow'])
     ```

   - 参数

     - ### loc参数

       - loc参数用于设置图例标签的位置，一般在legend函数内
       - matplotlib已经预定义好几种数字表示的位置

     |     字符串     |  数值  |     字符串      |  数值  |
     | :---------: | :--: | :----------: | :--: |
     |    best     |  0   | center left  |  6   |
     | upper right |  1   | center right |  7   |
     | upper left  |  2   | lower center |  8   |
     | lower right |  4   |    center    |  10  |
     | lower left  |  3   | upper center |  9   |
     |    right    |  5   |              |      |

     ```python
     #用法
     #loc参数可以是2元素的元组,用于自定义图例位置,传入的值诶X轴Y轴的长度倍数
     plt.legend(loc = 0)
     plt.legend(loc = [0,1.1])
     ```

     - ### ncol参数

       ```python
       #ncol控制图例中有几列,在legend中设置ncol
       plt.legend(ncol = 2)
       ```

7. ##### 保存图片

   fig = plt.figure()

   figure.savefig的选项

   - filename
     含有文件路径的字符串或Python的文件型对象。图像格式由文件扩展名推断得出，例如，.pdf推断出PDF，.png推断出PNG （“png”、“pdf”、“svg”、“ps”、“eps”……）

   - dpi
     图像分辨率（每英寸点数），默认为100

   - facecolor
     图像的背景色，默认为“w”（白色）

     ```
     x = np.arange(0,10,1)

     fig = plt.figure()
     plt.plot(x,x,x,x*2,x,x/2)
     plt.legend(['nomarl','fast','slow'])

     fig.savefig('1706_fig.jpg',dpi = 200,facecolor = 'green')
     ```

8. ##### 分离子画布（视图）

   ```
   #创建画布
   plt.figure(figsize=(12,9))
   #分离画布
   axes1 = plt.subplot(2,3,1)
   axes2 = plt.subplot(2,3,2)
   axes3 = plt.subplot(2,3,3)
   #绘图
   axes1.plot(x,np.sin(x))
   axes2.plot(x,x*2,x,x/2)
   axes3.plot(x,x**3)
   ```

   ​

### 二丶设置plot的风格和样式

```
plot语句中支持除X,Y以外的参数，以字符串形式存在，来控制颜色、线型、点型等要素，语法形式为：
plt.plot(X, Y, 'format', ...)
```

- 点和线的样式

  - 颜色

    + 别名
        + color='r'

    + 合法的HTML颜色名
        + color = 'red'

    |  颜色  |  别名  | HTML颜色名 |  颜色  |  别名  | HTML颜色名 |
    | :--: | :--: | :-----: | :--: | :--: | :-----: |
    |  蓝色  |  b   |  blue   |  绿色  |  g   |  green  |
    |  红色  |  r   |   red   |  黄色  |  y   | yellow  |
    |  青色  |  c   |  cyan   |  黑色  |  k   |  black  |
    | 洋红色  |  m   | magenta |  白色  |  w   |  white  |


    + HTML十六进制字符串
        + color = '#eeefff'       


    + 归一化到[0, 1]的RGB元组
        + color = (0.3, 0.3, 0.4)

  - 透明度

    alpha参数

    ```
    plt.plot(x,x**2,alpha = 0.5)
    ```

  - 背景色

    ```
    #设置背景色，通过plt.subplot()方法传入facecolor参数，来设置坐标轴的背景色
    plt.subplot(facecolor = 'cyan')
    ```

  - 线型

    - 线型(!!!这里不是网格线的线型)

    | 线条风格 |  描述  |     线条风格     |  描述   |
    | :--: | :--: | :----------: | :---: |
    | '-'  |  实线  |     ':'      |  虚线   |
    | '--' | 破折线  |   'steps'    |  阶梯线  |
    | '-.' | 点划线  | 'None' / '，' | 什么都不画 |

    ```python
    #Example
    plt.plot(x,x**2,ls='steps')
    ```

    - 线宽

      ```
      #linewidth或lw参数
      plt.plot(x,x**2,lw=3)
      ```

      ```python
      #不同宽度的破折线
      #dashes参数 eg.dashes = [20,50,5,2,10,5]
      #设置破折号序列各段的宽度

      x = np.arange(-np.pi,np.pi,0.1)
      plt.plot(x,np.sin(x),dashes = [10,1,3,5,7,8])
      ```

    - 点型

      - marker 设置点形

      - markersize 设置点形大小

      - 点型参数

        |  标记  |    描述    |         标记         |    描述    |
        | :--: | :------: | :----------------: | :------: |
        | '1'  | 一角朝下的三脚架 |        '3'         | 一角朝左的三脚架 |
        | '2'  | 一角朝上的三脚架 |        '4'         | 一角朝右的三脚架 |
        | 's'  |   正方形    |        'p'         |   五边形    |
        | 'h'  |   六边形1   |        'H'         |   六边形2   |
        | '8'  |   八边形    |        ','         |    像素    |
        | '.'  |    点     |        'x'         |    X     |
        | '\*' |    星号    |        '+'         |    加号    |
        | 'o'  |    圆圈    |        'D'         |    菱形    |
        | 'd'  |   小菱形    | '','None',' ',None |    无     |
        | '\_' |   水平线    |        '\|'        |   竖直线    |
        | 'v'  | 一角朝下的三角形 |        '<'         | 一角朝左的三角形 |
        | '^'  | 一角朝上的三角形 |        '>'         | 一角朝右的三角形 |

      - 设置方法

        ```

        ```

        ​

        ```python
        #Example
        plt.plot(x,np.sin(x),marker = '>',markersize = 25)
        ```

    - 多参数连用

      ```python
      #颜色、点型、线型，可以把几种参数写在一个字符串内进行设置 'r-.o'
      plt.plot(x,np.sin(x),'r--o',x,np.cos(x),'b:h')
      ```

    -  更多点和线的设置

       |       参数        |   描述   |       参数        |   描述   |
       | :-------------: | :----: | :-------------: | :----: |
       |     color或c     |  线的颜色  |  linestyle或ls   |   线型   |
       |  linewidth或lw   |   线宽   |     marker      |   点型   |
       | markeredgecolor | 点边缘的颜色 | markeredgewidth | 点边缘的宽度 |
       | markerfacecolor | 点内部的颜色 |   markersize    |  点的大小  |

    - ##### 在一条语句中为多个曲线进行设置

      1. 多个曲线统一设置

      ```python
       #属性名声明
       # 多条线统一设置的正确方式
       plt.plot(x,x,x,x*2,x,x/2,color = 'purple',ls = '--',marker = 's')
       # 不能使用参数简写形式同时对多个线进行设置
       plt.plot(x,x,x,x*2,x,x/2,'rh--')
      ```

      2. 多个曲线不同设置

      ```python
      #无需属性声明
      plt.plot(x,x,'rh--',x,x*2,'bs:',x,x/2,'g-.h')
      ```

      3. 面向对象设置方式

      ```python
      import matplotlib as mpl

      #对实例使用一系列的setter方法
      #plt.plot()方法返回一个包含所有线的列表，设置每一个线需要获取该线对象
      lines = plt.plot();
      line = lines[0]
      line.set_linewith()
      line.set_linestyle()
      line.set_color()

      axes = plt.subplot()#获取画板
      set_title()
      set_facecolor()
      ```

      4. 使用plt.setp()方法

      ```
      line = plt.plot(x,x**2)
      plt.setp(line,ls = '--',color = 'r',marker = 's')
      ```

    - X轴,Y轴坐标刻度

       - plt.xticks()和plt.yticks()方法

         ```
         #需指定刻度值和刻度名称 plt.xticks([刻度列表],[名称列表])
         #支持fontsize、rotation、color等参数设置
         x = np.arange(0,100,10)
         plt.plot(x,x)

         # 参数一：用来重新设置刻度值
         # 参数二：重新设置刻度标签
         # 两个参数的长度一定要匹配
         plt.xticks([0,50,100],('min','0','max'))

         # 设置y轴的字体大小和颜色以及旋转角度
         plt.yticks([0,20,40,60,80],[0,2,4,6,8],color = 'red',fontsize = 15,rotation=90)
         ```

       - 面向对象方法

         ```
         #使用画板的如下方法设置刻度axes = plt.subplot()
         #set_xticks、set_yticks 设置刻度值
         #set_xticklabels、set_yticklabels 设置刻度名称
         axes = plt.subplot()
         axes.plot(x,x)

         # 设置刻度
         axes.set_xticks([0,30,60,90])
         axes.set_yticks([0,50,100])
         # 设置标签
         axes.set_xticklabels(['a','b','c','d'])
         axes.set_yticklabels(['min',0,'max'])
         ```

       - 正弦余弦

         ```
         #LaTex语法，用 ππ 、 σσ 等表达式在图表上写上希腊字母
         x = np.arange(-np.pi,np.pi,0.1)
         plt.figure(figsize=(12,9))
         plt.plot(x,np.sin(x),x,np.cos(x))

         plt.xticks([-np.pi,-np.pi/2,0,np.pi/2,np.pi],['-$\pi$','-$\pi$/2',0,'$\pi$/2','$\pi$'],
                   fontsize = 15)
         ```

### 三丶2D图形

1. ##### 直方图hist()

   【直方图的参数只有一个x！！！不像条形图需要传入x,y】

   hist()的参数

   - bins
     可以是一个bin数量的整数值，也可以是表示bin的一个序列。默认值为10

   - normed
     如果值为True，直方图的值将进行归一化处理，形成概率密度，默认值为False

   - color
     指定直方图的颜色。可以是单一颜色值或颜色的序列。如果指定了多个数据集合,例如DataFrame对象，颜色序列将会设置为相同的顺序。如果未指定，将会使用一个默认的线条颜色

   - orientation
     通过设置orientation为horizontal创建水平直方图。默认值为vertical

     ```python
     data = DataFrame(np.random.randint(0,100,size = (100,3)))

     # 设置直方图的外观
     plt.hist(data,bins=10,color = ['r','g','b'],normed= True,orientation = 'vertical')
     ```

     ​

2. ##### 条形图bar()、barh()

   【条形图有两个参数x,y】

   - width 纵向设置条形宽度

   - height 横向设置条形高度

     ```
     # left bottom    表示条形图底部的刻度
     # height width   表示条形图的值（条形图的高度）
     # width  height  表示条形图自身的宽度
     x = np.linspace(10,100,10)
     plt.bar(left = np.arange(0,10,1), height = x,width = 0.8)
     plt.barh(bottom = np.arange(0,10,1),width = x, height = 0.9)
     ```

3. ##### 饼图pie()

   【饼图也只有一个参数x】

   饼图适合展示各部分占总体的比例，条形图适合比较各部分的大小

   ```python
   plt.pie([48,14,89,32],labels=['python','c','java','php'],labeldistance=0.7,
          autopct='%1.1f%%',pctdistance = 0.3,explode = [0.1,0,0,0],
          colors = ['cyan','yellow','pink','#00ffaa'],shadow = True,startangle = 90)
   #labels参数设置每一块的标签；
   #labeldistance参数设置标签距离圆心的距离（比例值）
   #autopct参数设置比例值的显示格式(%1.1f%%)；
   #pctdistance参数设置比例值文字距离圆心的距离
   #explode参数设置每一块顶点距圆形的长度（比例值,列表）；
   #colors参数设置每一块的颜色（列表）；
   #shadow参数为布尔值，设置是否绘制阴影
   #startangle参数设置饼图起始角度
   ```

4. ##### 散点图scatter()

   【散点图需要两个参数x,y，但此时x不是表示x轴的刻度，而是每个点的横坐标！】

   ```
   x = np.random.randn(1000)
   y = np.random.randn(1000)
   color = np.random.random(size = (1000,3))
   size = np.random.randint()
   plt.scatter(x,y,c = color,marker = 'd',s = 9)
   ```

### 四丶图形内的文字,注释,箭头

#####   控制文字属性的方法:  


|  Pyplot函数   |            API方法             |         描述         |
| :---------: | :--------------------------: | :----------------: |
|   text()    |     mpl.axes.Axes.text()     |  在Axes对象的任意位置添加文字  |
|  xlabel()   |  mpl.axes.Axes.set_xlabel()  |      为X轴添加标签       |
|  ylabel()   |  mpl.axes.Axes.set_ylabel()  |      为Y轴添加标签       |
|   title()   |  mpl.axes.Axes.set_title()   |    为Axes对象添加标题     |
|  legend()   |    mpl.axes.Axes.legend()    |    为Axes对象添加图例     |
|  figtext()  |   mpl.figure.Figure.text()   | 在Figure对象的任意位置添加文字 |
| suptitle()  | mpl.figure.Figure.suptitle() | 为Figure对象添加中心化的标题  |
| annnotate() |   mpl.axes.Axes.annotate()   | 为Axes对象添加注释（箭头可选）  |

  所有的方法会返回一个matplotlib.text.Text对象

```python
plt.plot(x,np.sin(x))
#在Axes对象的任意位置添加文字
plt.text(2,0,'tesst')
#为X轴添加标签
plt.xlabel('xlabel')
#为Y轴添加标签
plt.ylabel('ylabel')
#在Figure对象的任意位置添加文字
plt.figtext(0.5,0.3,'figtext')
#为Figure对象添加中心化的标题
plt.suptitle('suptitle')
#为Axes对象添加注释（箭头可选）
plt.annotate('annotate',xy = (2,0.7),xytext=(2.5,0.9),
             arrowprops = dict(arrowstyle='->',connectionstyle='arc3,rad=.2'))
```

