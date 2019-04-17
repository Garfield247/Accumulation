# 数据模型(Model)

### 回顾数据库

1. 分类：

   关系型数据库：MySQL、Oracle、SQLite、...

   非关系型数据库：MongoDB、Redis、...

2. 选择：

   数据库没有好坏，要根据项目需求来定；盲目的评价或跟风只能证明你是个生瓜蛋。

### flask-sqlalchemy

1. 说明：提供了大多数关系型数据库的支持，而且提供了ORM

2. 安装：`pip install flask-sqlalchemy`

3. 连接配置：只需指定数据库地址

   ```
   配置选项：SQLALCHEMY_DATABASE_URI
   MySQL：mysql://username:password@host/database
   sqlite：
   	linux：sqlite:////path/to/database
   	windows：sqlite:///c:/path/to/database
   ```

4. 使用：

   ```python
   # 导入类库
   from flask_sqlalchemy import SQLAlchemy

   # 配置数据库连接地址
   base_dir = os.path.abspath(os.path.dirname(__file__))
   database_uri = 'sqlite:///' + os.path.join(base_dir, 'date.sqlite')
   app.config['SQLALCHEMY_DATABASE_URI'] = database_uri

   # 创建对象
   db = SQLAlchemy(app)
   ```

5. 添加数据模型类

   ```python
   # 定义数据模型，继承自Model
   class User(db.Model):
       # 不指定表名时，默认将模型类的大驼峰转换为小写加下划线
       # 如：UserModel => user_model
       __tablename__ = 'users'
       id = db.Column(db.Integer, primary_key=True)
       username = db.Column(db.String(32), unique=True)
       email = db.Column(db.String(64), unique=True)
   ```

6. 创建表删除表

   ```python
   # 创建数据库(中的表)
   @app.route('/create/')
   def create():
     	# 创建的表如果已经存在，则不会再次创建
       # 需要更新表的时候，只能删除原来的，然后再创建
       db.drop_all()
       db.create_all()
       return '数据库创建完成'
     
   # 删除数据库(中的表)
   @app.route('/drop/')
   def drop():
       db.drop_all()
       return '数据库删除完成'
   ```

7. 添加终端创建删除数据库的命令

   ```python
   # 在终端操作时给与对话框提示，根据用户输入的y/n，返回True/False
   from flask_script import prompt_bool

   # 数据表改动发出警告(消耗额外的内存)，设为False就不再提示了
   app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

   # 创建数据库
   @manager.command
   def createall():
       db.drop_all()
       db.create_all()
       return '数据库创建完成'

   # 删除数据库
   @manager.command
   def dropall():
       if prompt_bool('确定要删除数据库然后跑路吗?'):
           db.drop_all()
           return '数据库删除完成'
       return '删除需谨慎'
   ```

   > 创建：python manage.py createall
   >
   > 删除：python manage.py dropall

### 数据的CURD操作

1. 增加数据

   ```python
   # 在每次请求结束后，自动提交数据库操作，否则每次都要手动提交
   app.config['SQLALCHEMY_COMMIT_ON_TEARDOWN'] = True

   @app.route('/insert/')
   def insert():
       # 创建一个数据模型
       # shaomeng = User(username='shaomeng', email='shaomeng@163.com')
       # 增加一条数据
       # db.session.add(shaomeng)

       # 添加多条数据
       zongran = User(username='zongran', email='zongran@163.com')
       wangke = User(username='wangke', email='keke@163.com')
       zhichuan = User(username='zhichuan', email='chuanchuan@163.com')
       db.session.add_all([zongran, wangke, zhichuan])
       # 提交操作，每次操作完之后都要手动提交，除非设置自动提交
       db.session.commit()
       return '数据添加成功'
   ```

2. 查询数据

   ```python
   @app.route('/select/<uid>')
   def select(uid):
       # 根据id查询
       u = User.query.get(uid)
       if u:
           return u.username
       return '不存在此用户'
   ```

3. 更新数据

   ```python
   @app.route('/update/<uid>')
   def update(uid):
       u = User.query.get(uid)
       if u:
           u.email = 'xxx@163.com'
           # 再次添加到数据库，系统会自动判断更新还是增加数据
           db.session.add(u)
           return '数据已更新'
       return '查无此人'
   ```

4. 删除数据

   ```python
   @app.route('/delete/<uid>')
   def delete(uid):
       u = User.query.get(uid)
       if u:
           db.session.delete(u)
           return '数据已删除'
       return '查无此人'
   ```

5. 各种查询操作

   ```python
   @app.route('/selectby/')
   def select_by():
       # 根据主键(id)查询
       #u = User.query.get(2)
       #return u.username
       # 获取所有数据
       #users = User.query.all()
       #return ','.join(u.username for u in users)
       # 指定等值条件查询，可以指定多个等值的条件
       #u = User.query.filter_by(username='zongran').first()
       #return u.email
       # 指定任意条件，也可以指定多个条件（等值条件写两个==）
       #u = User.query.filter(User.id > 3).first()
       #return u.username
       # 有就返回，没有就报404错误
       #u = User.query.get_or_404(8)
       #return u.username
       #u = User.query.filter(User.id > 8).first_or_404()
       #return u.username
       # 统计总记录数
       total = User.query.count()
       return str(total)
   ```

   > 自行测试：limit、offset、order_by、group_by、paginate

### 设计模型参考

1. 常见列类型

   | 类型名          | Python类型           | 说明         |
   | ------------ | ------------------ | ---------- |
   | Integer      | int                | 32位        |
   | SmallInteger | int                | 16位        |
   | BigInteger   | int/long           | 不限制的整数     |
   | Float        | float              | 浮点数        |
   | String       | str                | 变长字符串      |
   | Text         | str                | 变长字符串，做了优化 |
   | Boolean      | bool               | 布尔值        |
   | Date         | datetime.date      | 日期         |
   | Time         | datetime.time      | 时间         |
   | DateTime     | datetime.datetime  | 日期和时间      |
   | Interval     | datetime.timedelta | 时间间隔       |

2. 常见列选项

   | 选项          | 说明                |
   | ----------- | ----------------- |
   | primary_key | 是否作为主键索引，默认为False |
   | unique      | 是否作为唯一索引，默认为False |
   | index       | 是否作为普通索引，默认为False |
   | nullable    | 是否可以为空，默认为True    |
   | default     | 设置默认值             |

   > 1. 插入数据时可以不传的情况：自增的主键、可以为空的、有默认值的
   > 2. flask-sqlalchemy要求每个表都要有一个主键，通常字段名字为id

### 数据库的迁移

1. 说明：当数据模型更改时，需要将更改应用的数据库，这个过程叫数据库迁移；前面的方案有点暴力，需要删除原有的数据表，然后再创建新的，但是数据也丢失了；更好的解决方案是，既能更新数据库，又不删除原有的数据，请使用flask-migrate扩展库。

2. 安装：`pip install migrate`

3. 配置：

   ```
   # 导入数据库迁移相关类库
   from flask_migrate import Migrate, MigrateCommand

   # 创建数据库迁移对象
   migrate = Migrate(app, db)

   # 添加命令操作命令
   manager.add_command('db', MigrateCommand)
   ```

4. 使用

   ```
   1.初始化数据库迁移的仓库，会创建一个migrations的文件夹，存放迁移脚本
   	python manage.py db init
   2.创建迁移脚本，会根据模型与数据表的差异创建弥补差异的脚本
   	python manage.py db migrate
   3.执行迁移脚本，完成数据库的迁移
   	python manage.py db upgrade
   ```

   > 说明：不是所有的迁移都会成功，迁移时需要检查迁移结果，有问题时手动解决

### 添加自定义终端shell命令

1. 说明：默认有一个shell命令，但是没有导入任何数据，需要手动导入

2. 自行添加一个终端的shell命令，需要构造一个，然后添加到终端操作

   ```python
   # 添加终端操作名shell，因为自带的shell没有导入任何数据
   from flask_script import Shell
   def shell_make_context():
       # 以字典的形式返回数据
       return dict(db=db, User=User, app=app)
   manager.add_command('shell', Shell(make_context=shell_make_context))
   ```

3. 测试

   ```shell
   python manage.py shell
   ```

   > 添加之后，再次启动shell环境，其中的数据无需再手动导入。

### 练习：

1. 想一想flask大型项目目录结构
2. 试着书写一下用户的注册、登录