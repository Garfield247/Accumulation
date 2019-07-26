如果程序处理的数据比较多、比较复杂，那么在程序运行的时候，会占用大量的内存，当内存占用到达一定的数值，程序就有可能被操作系统终止，特别是在限制程序所使用的内存大小的场景，更容易发生问题。下面我就给出几个优化Python占用内存的几个方法。

说明：以下代码运行在Python3。

## **举个栗子**

我们举个简单的场景，使用Python存储一个三维坐标数据，x,y,z。

### Dict

使用Python内置的数据结构Dict来实现上述例子的需求很简单。

```python
ob = {'x':1, 'y':2, 'z':3}
```

查看以下ob这个对象占用的内存大小：

```python
sys.getsizeof(ob)
240
```

简单的三个整数，占用的内存还真不少，想象以下，如果有大量的这样的数据要存储，会占用更大的内存。

| 数据量      | 占用内存大小 |
| :---------- | :----------- |
| 1 000 000   | 240 Mb       |
| 10 000 000  | 2.40 Gb      |
| 100 000 000 | 24 Gb        |

### Class

对于喜欢面向对象编程的程序员来说，更喜欢把数据包在一个class里。使用class使用同样需求：



```
class Point:  
		def __init__(self, x, y, z):        
				self.x = x        
				self.y = y        
				self.z = z
>>> ob = Point(1,2,3)
```

class的数据结构和Dict区别就很大了，我们来看看这种情况下占用内存的情况：

| 字段          | 占用内存 |
| :------------ | :------- |
| PyGC_Head     | 24       |
| PyObject_HEAD | 16       |
| `__weakref__` | 8        |
| `__dict__`    | 8        |
| TOTAL         | 56       |

对象的`__dict__`中存储了一些self.xxx的一些东西。从Python 3.3开始，key使用了共享内存存储， 减少了RAM中实例跟踪的大小。

```python
print(sys.getsizeof(ob),sys.getsizeof(ob.__dict__))
56 112
```

| 数据量      | 占用内存 |
| :---------- | :------- |
| 1 000 000   | 168 Mb   |
| 10 000 000  | 1.68 Gb  |
| 100 000 000 | 16.8 Gb  |

可以看到内存占用量，class比dict少了一些，但这远远不够。

### `_slots_`

从class的内存占用分布上，我们可以发现，通过消除`__dict__`和`__weakref__`，可以显着减少RAM中类实例的大小，我们可以通过使用`__slots__`来达到这个目的。

```python
class Point:
		__slots__ = 'x', 'y', 'z'
    def __init__(self, x, y, z):
    		self.x = x        
    		self.y = y        
    		self.z = z
>>> ob = Point(1,2,3)
>>> print(sys.getsizeof(ob))
64
```

可以看到内存占用显著的减少了

| 字段          | 内存占用 |
| :------------ | :------- |
| PyGC_Head     | 24       |
| PyObject_HEAD | 16       |
| x             | 8        |
| y             | 8        |
| z             | 8        |
| TOTAL         | 64       |

| 数据量      | 占用内存 |
| :---------- | :------- |
| 1 000 000   | 64Mb     |
| 10 000 000  | 640Mb    |
| 100 000 000 | 6.4Gb    |

默认情况下,Python的新式类和经典类的实例都有一个dict来存储实例的属性。这在一般情况下还不错，而且非常灵活，乃至在程序中可以随意设置新的属性。但是，对一些在”编译”前就知道有几个固定属性的小class来说，这个dict就有点浪费内存了。

当需要创建大量实例的时候，这个问题变得尤为突出。一种解决方法是在新式类中定义一个 `__slots__`属性。

`__slots__`声明中包含若干实例变量，并为每个实例预留恰好足够的空间来保存每个变量；这样Python就不会再使用dict，从而节省空间。

那么用slot就是非非常那个有必要吗？使用`__slots__`也是有副作用的：

1. 每个继承的子类都要重新定义一遍`__slots__`
2. 实例只能包含哪些在`__slots__`定义的属性，这对写程序的灵活性有影响，比如你由于某个原因新网给instance设置一个新的属性，比如instance.a = 1, 但是由于a不在`__slots__`里面就直接报错了，你得不断地去修改`__slots_`_或者用其他方法迂回的解决
3. 实例不能有弱引用（weakref）目标，否则要记得把`__weakref__`放进`__slots_`_

最后，namedlist和attrs提供了自动创建带`__slot__`的类，感兴趣的可以试试看。

### Tuple

Python还有一个内置类型元组，用于表示不可变数据结构。元组是固定的结构或记录，但没有字段名称。对于字段访问，使用字段索引。在创建元组实例时，元组字段一次性与值对象关联：

```
>>> ob = (1,2,3)
>>> x = ob[0]
>>> ob[1] = y 
# ERROR
```

元组的示例很简洁：

```
>>> print(sys.getsizeof(ob))
72
```

可以看只比`__slot__`多8byte：

| 字段          | 占用内存(bytes) |
| :------------ | :-------------- |
| PyGC_Head     | 24              |
| PyObject_HEAD | 16              |
| ob_size       | 8               |
| [0]           | 8               |
| [1]           | 8               |
| [2]           | 8               |
| TOTAL         | 72              |

### Namedtuple

通过namedtuple我们也可以实现通过key值来访问tuple里的元素：

```
Point = namedtuple('Point', ('x', 'y', 'z'))
```

它创建了一个元组的子类，其中定义了用于按名称访问字段的描述符。对于我们的例子，它看起来像这样:

```
class Point(tuple):
    @property     
		def _get_x(self):         
				return self[0]     
		
		@property     
		def _get_y(self):         
				return self[1]     
		
		@property     
		def _get_y(self):         
				return self[2]   
		
		def __new__(cls, x, y, z):         
				return tuple.__new__(cls, (x, y, z))
```

此类的所有实例都具有与元组相同的内存占用。大量实例会留下稍大的内存占用：

| 数据量      | 内存占用 |
| :---------- | :------- |
| 1 000 000   | 72 Mb    |
| 10 000 000  | 720 Mb   |
| 100 000 000 | 7.2 Gb   |

### Recordclass

python的第三方库recordclassd提供了一个数据结构recordclass.mutabletuple，它几乎和内置tuple数据结构一致，但是占用更少的内存。

```
 >>> Point = recordclass('Point', ('x', 'y', 'z')) >>> ob = Point(1, 2, 3)
```

实例化以后，只少了PyGC_Head:

| 字段          | 占用内存 |
| :------------ | :------- |
| PyObject_HEAD | 16       |
| ob_size       | 8        |
| x             | 8        |
| y             | 8        |
| y             | 8        |
| TOTAL         | 48       |

到此，我们可以看到，和`__slot__`比，又进一步缩小了内存占用：

| 数据量      | 内存占用 |
| :---------- | :------- |
| 1 000 000   | 48 Mb    |
| 10 000 000  | 480 Mb   |
| 100 000 000 | 4.8 Gb   |

### Dataobject

recordclass提供了另外一个解决方法：在内存中使用与__slots__类相同的存储结构，但不参与循环垃圾收集机制。通过recordclass.make_dataclass可以创建出这样的实例：

```
>>> Point = make_dataclass('Point', ('x', 'y', 'z'))
```

另外一个方法是继承自dataobject

```
class Point(dataobject):    
		x:int    
		y:int   
		z:int
```

以这种方式创建的类将创建不参与循环垃圾收集机制的实例。内存中实例的结构与__slots__的情况相同，但没有PyGC_Head：

| 字段          | 内存占用(bytes) |
| :------------ | :-------------- |
| PyObject_HEAD | 16              |
| x             | 8               |
| y             | 8               |
| y             | 8               |
| TOTAL         | 40              |

```
>>> ob = Point(1,2,3)
>>> print(sys.getsizeof(ob))
40
```

要访问这些字段，还使用特殊描述符通过其从对象开头的偏移量来访问字段，这些对象位于类字典中：

```
mappingproxy({'__new__': <staticmethod at 0x7f203c4e6be0>, .......................................   'x': <recordclass.dataobject.dataslotgetset at 0x7f203c55c690>,   'y': <recordclass.dataobject.dataslotgetset at 0x7f203c55c670>,   'z': <recordclass.dataobject.dataslotgetset at 0x7f203c55c410>})

```

| 数据量      | 内存占用 |
| :---------- | :------- |
| 1 000 000   | 40 Mb    |
| 10 000 000  | 400 Mb   |
| 100 000 000 | 4.0 Gb   |

### Cython

有一种方法基于Cython的使用。它的优点是字段可以采用C语言原子类型的值。例如：

```
cdef class Python:
	cdef public int x, y, z
 			def __init__(self, x, y, z):
 			self.x = x
			self.y = y
 			self.z = z
```

这种情况下，占用的内存更小：

```
>>> ob = Point(1,2,3)
>>> print(sys.getsizeof(ob))
32
```

内存结构分布如下:

| 字段          | 内存占用(bytes) |
| :------------ | :-------------- |
| PyObject_HEAD | 16              |
| x             | 4               |
| y             | 4               |
| y             | 4               |
| пусто         | 4               |
| TOTAL         | 32              |

| 数据量      | 内存占用 |
| :---------- | :------- |
| 1 000 000   | 32 Mb    |
| 10 000 000  | 320 Mb   |
| 100 000 000 | 3.2 Gb   |

但是，从Python代码访问时，每次都会执行从int到Python对象的转换，反之亦然。

### Numpy

在纯Python的环境中，使用Numpy能带来更好的效果，例如:

```
>>> Point = numpy.dtype(('x', numpy.int32), ('y', numpy.int32), ('z', numpy.int32)])
```

创建初始值是0的数组：

```
>>> points = numpy.zeros(N, dtype=Point)
```

| 数据量      | 内存占用 |
| :---------- | :------- |
| 1 000 000   | 12 Mb    |
| 10 000 000  | 120 Mb   |
| 100 000 000 | 1.2 Gb   |



可以看出，在Python性能优化这方面，还是有很多事情可以做的。Python提供了方便的同时，也需要暂用较多的资源。在不通的场景下，我需要选择不同的处理方法，以便带来更好的性能体验。