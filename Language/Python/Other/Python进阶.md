Python 进阶
===========



1. PEP8 编码规范, 以及开发中的一些惯例和建议
    - 代码编排:
        * 缩进 4 个空格, 禁止空格与 Tab 混用
        * 行长 80: 防止单行逻辑过于复杂
    - 适当添加空行
        * 函数间: 顶级函数间空 2 行, 类的方法之间空 1 行
        * 函数内: 同一函数内的逻辑块之间, 空 1 行
        * 文件结尾: 留一个空行
    - import
        * 顺序
            1. 标准库
            2. 第三方库
            3. 自定义库
        * 单行不要 import 多个库
        * 模块内用不到的不要去 import
    - 空格
    - 注释
        * 行注释
        * 块注释
        * 引入外来算法或者配置时须在注释中添加源连接, 标明出处
        * 函数和类尽可能添加 `docstring`
    - 命名
        * 包名、模块名、函数名、方法名全部使用小写, 单词间用下划线连接
        * 类名、异常名使用 CapWords 的方式, 异常名结尾加 `Error` 或 `Wraning` 后缀
        * 全局变量尽量使用大写, 一组同类型的全局变量要加上统一前缀, 单词用下划线连接
    - 字符串拼接尽量使用 `join` 方式: 速度快, 内存消耗小
    - 语意明确、直白
        * `not xx in yy` vs `xx not in yy`
        * `not a is b` vs `a is not b`
    - 程序构建
        * 一个函数只做一件事情, 并把这件事做好
        * 大的功能用小函数之间灵活组合来完成
        * 避免编写庞大的程序, “大”意味着体积庞大, 逻辑复杂甚至混乱
    - 函数名必须有动词, 最好是 do_something 的句式, 或者 somebody_do_something 句式
    - 自定义的变量名、函数名不要与标准库中的名字冲突
    - pip install pep8
    - 练习: 规范化这段代码

            from django.conf import settings
            import sys, os
            mod=0xffffffff
            def foo ( a , b = 123 ) :
                c = { 'x' : 111 , 'y' : 222 }  # 定义一个字典
                d = [ 1, 3 , 5 ]
                return a , b , c
            def bar(x):
                if x%2 ==0: return true

2. `*` 和 `**` 的用法
    - 函数定义

            def foo(*args, **kwargs):
                pass

    - 参数传递

            def foo(x, y, z, a, b):
                print(x)
                print(y)
                print(z)
                print(a)
                print(b)
            lst = [1, 2, 3]
            dic = {'a': 22, 'b': 77}
            foo(*lst, **dic)

    - 强制命名参数

            def foo(a, *, b, c=123):
                pass

    - 解包语法: `a, b, *ignored, c = [1, 2, 3, 4, 5, 6, 7]`

2. Python 的赋值和引用
    - `==, is`: `==` 判断的是值, `is` 判断的是内存地址 (即对象的id)
    - 小整数对象: [-5, 256]
    - `copy, deepcopy` 的区别
        * `copy`: 只拷贝表层元素
        * `deepcopy`: 在内存中重新创建所有子元素
        * ![copy and deepcopy](img/Copy.png)

    - 练习1: 说出执行结果

            def extendList(val, lst=[]):
                lst.append(val)
                return lst
    
            list1 = extendList(10)
            list2 = extendList(123, [])
            list3 = extendList('a')

    - 练习2: 说出下面执行结果

            from copy import copy, deepcopy
            from pickle import dumps, loads
    
            a = [1, 2, 3]
            b = [a] * 3
            c = copy(b)
            d = deepcopy(b)
            e = loads(dumps(b, 4))
    
            b[1].append(999)
            c[1].append(999)
            d[1].append(999)
            e[1].append(999)
            d[1].append(777)
            e[1].append(777)

    - 自定义 deepcopy: `my_deepcopy = lambda item: loads(dumps(item, 4))`

3. 迭代器, 生成器, itertools, yield, 列表 / 字典 / 集合的推导

        class Range:
            def __init__(self, start, end):
                self.start = start - 1
                self.end = end
    
            def __iter__(self):
                return self
    
            def __next__(self):
                self.start += 1
                if self.start < self.end:
                    return self.start
                else:
                    raise StopIteration()

    - iterator: 任何实现了 `__iter__` 和 `__next__` (python2中是 `next()`) 方法的对象都是迭代器.
        * `__iter__`返回迭代器自身
        * `__next__` 返回容器中的下一个值
        * 如果容器中没有更多元素, 则抛出StopIteration异常

    - generator: 生成器其实是一种特殊的迭代器, 不需要自定义 `__iter__` 和 `__next__`
        * 生成器函数 (yield)
        * 生成器表达式

    - 练习1: 自定义一个迭代器, 实现斐波那契数列

            class Fib:
                def __init__(self, count):
                    self.prev = 0
                    self.curr = 1
                    self.count = count
    
                def __iter__(self):
                    return self
    
                def __next__(self):
                    if self.count > 0:
                        # 计数
                        self.count -= 1
                        # 计算当前的值
                        current = self.curr
                        # 为下次做准备
                        self.prev, self.curr = self.curr, (self.curr + self.prev)
                        # 返回当前值
                        return current
                    else:
                        raise StopIteration()

    - 练习2: 自定义一个生成器函数, 实现斐波那契数列

                def fib(max_value):
                    prev = 0
                    curr = 1
                    while curr < max_value:
                        yield curr
                        prev, curr = curr, curr + prev

    - 练习3: 定义一个随机数迭代器, 随机范围为 [1, 50], 最大迭代次数 30

            import random
    
            class RandomIter:
                def __init__(self, start, end, times):
                    self.start = start
                    self.end = end
                    self.max_times = times
                    self.count = 0
    
                def __iter__(self):
                    return self
    
                def __next__(self):
                    self.count += 1
                    if self.count <= self.max_times:
                        return random.randint(self.start, self.end)
                    else:
                        raise StopIteration()

    - 迭代器、生成器有什么好处？
        * 节省内存
        * 惰性求值
    - itertools
        * 无限迭代
            + `count(start=0, step=1)`
            + `cycle(iterable)`
            + `repeat(object [,times])`
        * 有限迭代
            + `chain(*iterables)`
        * 排列组合
            + `product(*iterables, repeat=1)` 笛卡尔积
            + `permutations(iterable[, r-length])` 全排列
            + `combinations(iterable, r-length)` 组合


4. `method`, `classmethod` 和 `staticmethod`
    - `method`: 通过实例调用时, 可以引用类内部的任何属性和方法
    - `classmethod`: 无需实例化, 可以调用类属性和类方法, 无法取到普通的成员属性和方法
    - `staticmethod`: 无论用类调用还是用实例调用, 都无法取到类内部的属性和方法, 完全独立的一个方法

    - 练习: 说出下面代码的运行结果

            class Test(object):
                x = 123
    
                def __init__(self):
                    self.y = 456
    
                def bar1(self):
                    print('i am a method')
    
                @classmethod
                def bar2(cls):
                    print('i am a classmethod')
    
                @staticmethod
                def bar3():
                    print('i am a staticmethod')
    
                def foo1(self):
                    print(self.x)
                    print(self.y)
                    self.bar1()
                    self.bar2()
                    self.bar3()
    
                @classmethod
                def foo2(cls):
                    print(cls.x)
                    # print(cls.y)
                    # cls.bar1()
                    Test.bar2()
                    Test.bar3()
    
                @staticmethod
                def foo3(obj):
                    print(obj.x)
                    print(obj.y)
                    obj.bar1()
                    obj.bar2()
                    obj.bar3()
    
            t = Test()
            t.foo1()
            t.foo2()
            t.foo3()

5. Python 魔术方法
    1. `__str__`, `__repr__`
    2. `__init__` 和 `__new__`
        * `__new__` 返回一个对象的实例, `__init__` 无返回值
        * `__new__` 是一个类方法
            + 单例模式

                    class A(object):
                        '''单例模式'''
                        obj = None
                        def __new__(cls, *args, **kwargs):
                            if cls.obj is None:
                                cls.obj = object.__new__(cls)
                            return cls.obj

    3. 比较运算、数学运算
        * 运算符重载
            + `+`: `__add__(value)`
            + `-`: `__sub__(value)`
            + `*`: `__mul__(value)`
            + `/`: `__truediv__(value)` (Python 3.x), `__div__(value)` (Python 2.x)
            + `//`: `__floordiv__(value)`
            + `%`: `__mod__(value)`
            + `&`: `__and__(value)`
            + `|`: `__or__(value)`

        * 练习: 实现字典的 `__add__` 方法, 作用相当于 d.update(other)

                class Dict(dict):
                    def __add__(self, other):
                        if isinstance(other, dict):
                            new_dict = {}
                            new_dict.update(self)
                            new_dict.update(other)
                            return new_dict
                        else:
                            raise TypeError('not a dict')

        * 比较运算符的重载
            + `==`: `__eq__`
            + `!=`: `__ne__`
            + `>`: `__gt__`
            + `>=`: `__ge__`
            + `<`: `__lt__`
            + `<=`: `__le__`

        * 练习: 完成一个类, 实现数学上无穷大的概念

                class Inf:
                    def __lt__(self, other):
                        return False
                    def __le__(self, other):
                        return False
                    def __ge__(self, other):
                        return True
                    def __gt__(self, other):
                        return True
                    def __eq__(self, other):
                        return False
                    def __ne__(self, other):
                        return True

    4. 容器方法
        * `__len__, __iter__, __contains__`
        * `__getitem__` 对 `string, list, tuple, dict` 有效
        * `__setitem__` 对 `list, dict` 有效
        * `__missing__` 对 `dict` 有效

                class Dict(dict):
                    def __missing__(self, key):
                        self[key] = None  # 当检查到 Key 缺失时, 可以做任何默认行为

    5. 可执行对象: `__call__`
    6. with:
        * `__enter__` 进入 `with` 代码块前的准备操作
        * `__exit__` 退出时的善后操作
    7. `__setattr__, __getattribute__, __getattr__, __dict__`
        * 常用来做属性监听

                class A:
                    '''TestClass'''
                    z = [7,8,9]
                    def __init__(self):
                        self.x = 123
                        self.y = 'abc'
    
                    def __setattr__(self, name, value):
                        print('set %s to %s' % (name, value))
                        object.__setattr__(self, name, value)
    
                    def __getattribute__(self, name):
                        print('get %s' % name)
                        return object.__getattribute__(self, name)
    
                    def __getattr__(self, name):
                        print('not has %s' % name)
                        return -1
    
                    def foo(self, x, y):
                        return x ** y
    
                # 对比
                a = A()
                print(A.__dict__)
                print(a.__dict__)

    8. 描述器: `__set__, __get__`
        * <http://pyzh.readthedocs.io/en/latest/Descriptor-HOW-TO-Guide.html>
        * 常见应用场景: ORM 的各种 Field 类
    9. 槽: `__slots__`
        * 固定类所具有的属性
        * 实例不会分配 `__dict__`
        * 实例无法动态添加属性
        * 优化内存分配

                class A:
                    __slots__ = ('x', 'y')

6. Python 性能之困
    1. 计算密集型
        * CPU 长时间满负荷运行, 如图像处理、大数据运算、圆周率计算等
        * 计算密集型: 用 C 语言补充
        * Profile, timeit
    2. I/O 密集型: 网络 IO, 文件 IO, 设备 IO 等
        * 多线程 / 多进程 / 协程
        * 阻塞 -> 非阻塞
        * 同步 -> 异步
    3. GIL 全局解释器锁
        * 它确保任何时候都只有一个Python线程执行。
          ![GIL](./img/GIL.png "GIL")
    4. 什么是进程、线程、协程？
        * 进程: 资源消耗大, 系统整体开销大, 数据通信不方便
        * 线程: 资源消耗小, 可共享数据。上下文开销大。按时间片强制切换, 不够灵活
        * 协程: 内存开销更小, 上下文切换开销更小。可根据事件切换, 更加有效的利用 CPU
    5. 什么是同步、异步、阻塞、非阻塞？
        * 同步, 异步: 客户端调用服务器接口时
        * 阻塞, 非阻塞: 服务端发生等待
    6. 事件驱动 + 多路复用
        * 轮询: select, poll
        * 事件驱动: epoll 有效轮询
    7. Greenlets / gevent | tornado / asyncio
    8. 线程安全, 锁
        * 获得锁之后, 一定要释放, 避免死锁
        * 获得锁之后, 执行的语句, 只跟被锁资源有关
        * 区分普通锁 Lock, 可重入锁 RLock
        * 线程之间的数据交互尽量使用 Queue
    9. gevent
        * monkey.patch
        * gevent.sleep 非阻塞式等待
        * Queue 协程间数据交互, 避免竞争

7. 装饰器
    - 最简装饰器

            def deco(func):
                def wrap(*args, **kwargs):
                    return func(*args, **kwargs)
                return wrap
    
            @deco
            def foo(a, b):
                return a ** b

    - 原理
        * 对比被装饰前后的 `foo.__name__` 和 `foo.__doc__`

                from functools import wraps
                def deco(func):
                    '''i am deco'''
                    @wraps(func)
                    def wrap(*args, **kwargs):
                        '''i am wrap'''
                        return func(*args, **kwargs)
                    return wrap

        * 简单过程

                fn = deco(func)
                fn(*args, **kwargs)

        * 多个装饰器调用过程

                @deco1
                @deco2
                @deco3
                def foo(x, y):
                    return x ** y

    - 带参数的装饰器

            def deco(n):
                def wrap1(func):
                    def wrap2(*args, **kwargs):
                        return func(*args, **kwargs)
                    return wrap2
                return wrap1

    - 装饰器类和 `__call__`

    - 使用场景
        * 参数、结果检查
        * 缓存、计数
        * 日志、统计
        * 权限管理
        * 重试
        * 其他

    - 练习1：写一个 timer 装饰器, 计算出被装饰函数调用一次花多长时间, 并把时间打印出来
    - 练习2: 写一个权限管理装饰器, 权限分为 `admin / member / guest` 三级
    - 练习3: 写一个 Retry 装饰器

            import time
    
            class retry(object):
                def __init__(self, max_retries=3, wait=0, exceptions=(Exception,)):
                    self.max_retries = max_retries
                    self.exceptions = exceptions
                    self.wait = wait
    
                def __call__(self, f):
                    def wrapper(*args, **kwargs):
                        for i in range(self.max_retries + 1):
                            try:
                                result = f(*args, **kwargs)
                            except self.exceptions:
                                time.sleep(self.wait)
                                continue
                            else:
                                return result
                    return wrapper

8. 闭包
    - 说出下面函数返回值

            def foo():
                l = []
                def bar(i):
                    l.append(i)
                    return l
                return bar
    
            f1 = foo()
            f2 = foo()
    
            # 说出下列语句执行结果
            f1(1)
            f1(2)
            f2(3)

    - 作用域
        * global
        * nonlocal
        * globals()
        * locals()
        * vars()

                local namespace
                    |
                    V
                global namespace
                    |
                    V
                builtin namespace

    - 更深入一点: `__closure__`

9. Garbage Collection (GC)
    - 引用计数
        * 优点: 简单、实时性高
        * 缺点: 消耗资源、循环引用

                l1, l2 = [], []
                l1.append(l2)
                l2.append(l1)

        ![GC](./img/GC.png)

    - 标记-清除, 分代收集

10. 继承、多继承、多态、Mixin、super
    - 继承
    - 多态
    - 多继承 和 Mixin
    - super

            class A:
                def __init__(self):
                    print('enter A')
                    self.x = 111
                    print('exit A')


            class B(A):
                def __init__(self):
                    print('enter B')
                    A.__init__(self)
                    # super().__init__()
                    print('exit B')


            class C(A):
                def __init__(self):
                    print('enter C')
                    A.__init__(self)
                    # super().__init__()
                    print('exit C')


            class D(B, C):
                def __init__(self):
                    print('enter D')
                    B.__init__(self)
                    C.__init__(self)
                    # super().__init__()
                    print('exit D')
    
            d = D()

11. 一些技巧和误区
    1. 格式化打印
        * json.dumps(obj, indent=4)
        * json 压缩: `json.dumps(obj, separators=[',',':'])`
        * pprint
    2. 确保能取到有效值
        * `d.get(k, default)`
        * `d.setdefault`
        * `defaultdict`
        * `a or b`
        * `x = a if foo() else b`
    3. try...except... 的滥用
        * 不要把所有东西全都包住, 程序错误需要报出来
        * 使用 `try...except` 要指明具体错误, `try` 结构不是用来隐藏错误的, 而是用来有方向的处理错误的
    4. 利用 dict 做模式匹配

            def do1():
                print('i am do1')
    
            def do2():
                print('i am do2')
    
            def do3():
                print('i am do3')
    
            def do4():
                print('i am do4')
    
            mapping = {1: do1, 2: do2, 3: do3, 4: do4}
            mod = random.randint(1, 10)
            func = mapping.get(mod, do4)
            func()

    5. `inf, -inf, nan`
    6. pyenv, venv, 命名空间
        * [pyenv](https://github.com/pyenv/pyenv-installer): 管理 Python 版本
        * venv: 创建虚拟环境, 做环境隔离, venv 目录直接放到项目的目录里
    7. property: 把一个方法属性化

            class C(object):
                @property
                def x(self):
                    "I am the 'x' property."
                    return self._x
                @x.setter
                def x(self, value):
                    self._x = value
                @x.deleter
                def x(self):
                    del self._x

    8. else 子句: `if, for, while, try`
    9. collections 模块
        * defaultdict
        * namedtuple
        * Counter
