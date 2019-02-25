# flask表单

### flask-moment

1. 说明：这个扩展是一个时间本地化显示的库，非常方便

2. 安装：`pip install flask-moment`

3. 使用：

   ```python
   from flask_moment import Moment
   moment = Moment(app)
   ```

4. 模板使用

   ```html
   {% extends 'bootstrap/base.html' %}

   {% block content %}
   <div>时间日期：{{ moment(current_time).format('L') }}</div>
   <div>私人定制：{{ moment(current_time).format('YYYY-MM-DD') }}</div>
   <div>发表于：{{ moment(current_time).fromNow() }}</div>
   {% endblock %}

   {% block scripts %}
       {{ super() }}
       {# 原则上需要导入jquery，bootstrap已经导入，可以省略 #}
       {{ moment.include_jquery() }}
       {# 加载moment.js #}
       {{ moment.include_moment() }}
       {# 显示中文，默认显示英文 #}
       {{ moment.locale('zh-CN') }}
   {% endblock %}
   ```

### 原生表单

1. 创建一个模板文件login.html，内容如下：

   ```html
   <form method="post">
       用户名：<input type="text" name="username" />
       <input type="submit" value="立即登录" />
   </form>
   ```

2. 添加测试的视图函数，内容如下：

   ```python
   @app.route('/login/', methods=['GET', 'POST'])
   def login():
       if request.method == 'GET':
           return render_template('login.html')
       else:
           # request.form中存放了所有的表单提交数据
           return 'Hello %s' % request.form['username']
   ```

### flask-wtf

1. 说明：是一个关于表单的扩展库，可以提供跨站请求伪造保护的功能，使用非常方便

2. 安装：`pip install flask-wtf`

3. 使用：

   1. 定义表单类

   ```python
   # 设置秘钥
   app.config['SECRET_KEY'] = '123456'

   # 导入表单基类
   from flask_wtf import FlaskForm
   # 导入相关字段
   from wtforms import StringField, SubmitField
   # 导入相关验证器类
   from wtforms.validators import DataRequired

   class NameForm(FlaskForm):
       name = StringField('用户名', validators=[DataRequired()])
       submit = SubmitField('提交')
   ```

   2. 添加视图函数

   ```python
   @app.route('/')
   def index():
       # 创建表单对象
       form = NameForm()
       # 渲染时分配到模板文件
       return render_template('form.html', form=form)
   ```

   3. 表单渲染

   ```html
   {# 原生渲染 #}
   <form>
       {{ form.hidden_tag() }}
       {{ form.name.label() }}{{ form.name(id='xxx',class='yyy') }}
       {{ form.submit() }}
   </form>

   {# bootstrap渲染 #}
   {% extends 'bootstrap/base.html' %}
   {% import 'bootstrap/wtf.html' as wtf %}
   {% block content %}
       <div class="container">{{ wtf.quick_form(form) }}</div>
   {% endblock %}
   ```

   4. 表单校验

   ```python
   @app.route('/', methods=['GET', 'POST'])
   def index():
       # 创建表单对象
       form = NameForm()
       name = None
       # 表单校验
       if form.validate_on_submit():
           name = form.name.data
           form.name.data = ''
       # 渲染时分配到模板文件
       return render_template('form.html', form=form, name=name)
   ```

   5. POST重定向GET

   ```python
   @app.route('/', methods=['GET', 'POST'])
   def index():
       # 创建表单对象
       form = NameForm()
       # 表单校验
       if form.validate_on_submit():
           session['name'] = form.name.data
           return redirect(url_for('index'))
       name = session.get('name')
       # 渲染时分配到模板文件
       return render_template('form.html', form=form, name=name)
   ```

4. 常见字段类型

   | 字段类型                | 说明                       |
   | ------------------- | ------------------------ |
   | StringField         | 普通文本字段                   |
   | PasswordField       | 密码文本字段                   |
   | SubmitField         | 提交按钮                     |
   | HiddenField         | 隐藏文本字段                   |
   | TextAreaField       | 多行文本字段                   |
   | DateField           | 文本字段，datetime.date格式     |
   | DateTimeField       | 文本字段，datetime.datetime格式 |
   | IntegerField        | 文本字段，整数类型                |
   | FloatField          | 文本字段，小数类型                |
   | BooleanField        | 复选框，值为True或False         |
   | RadioField          | 单选框                      |
   | SelectField         | 下拉列表                     |
   | FileField           | 文件上传字段                   |
   | SelectMultipleField | 可选择多个值                   |
   | FormField           | 把表单作为字段嵌入另一个表单           |
   | FieldList           | 一组指定类型的字段                |
   | DecimalField        | 文本字段，值为 decimal.Decimal  |

5. 常见验证器类

   | 验证器          | 说明               |
   | ------------ | ---------------- |
   | DataRequired | 确保字段有值(并且if判断为真) |
   | Email        | 邮箱地址             |
   | IPAddress    | IPv4的IP地址        |
   | Length       | 规定字符长度           |
   | NumberRange  | 输入数值的范围          |
   | EqualTo      | 验证两个字段的一致性       |
   | URL          | 有效的URL           |
   | Regexp       | 正则验证             |
   | AnyOf        | 确保输入值在可选值列表中     |
   | NoneOf       | 确保输入值不在可选值列表中    |
   | Optional     | 无输入值时跳过其他验证函数    |

   自定义字段验证：就是写一个'validate_字段'的函数，如下：

   ```python
   class NameForm(FlaskForm):
       name = StringField('用户名', validators=[DataRequired()])
       submit = SubmitField('提交')

       # 自定义字段验证
       def validate_name(self, field):
          if len(field.data) < 6:
              raise ValidationError('用户名长度不能少于6个字符')
   ```

### flash消息显示

1. 说明：

   当用户发出请求后，有时状态发生了改变，需要给与提示、警告等信息时，通过可以弹出警告框，然后用户可以手动取消掉。

2. 使用：

   在合适的时候书写flash消息，使用flash函数

   ```python
   @app.route('/', methods=['GET', 'POST'])
   def index():
       # 创建表单对象
       form = NameForm()
       # 表单校验
       if form.validate_on_submit():
           last_name = session.get('name')
           # 原来有，并且与现在的不一样，给出提示消息
           if last_name and last_name != form.name.data:
               flash('大哥，又换签名')
           session['name'] = form.name.data
           return redirect(url_for('index'))
       name = session.get('name')
       # 渲染时分配到模板文件
       return render_template('form.html', form=form, name=name)
   ```

   在模板文件中，通过get_flashed_messages函数获取所有的flash消息，如下：

   ```html
   {% for message in get_flashed_messages() %}
   <div class="alert alert-warning alert-dismissible" role="alert">
       <button type="button" class="close" data-dismiss="alert" 
               aria-label="Close"><span
               aria-hidden="true">&times;</span></button>
       {{ message }}
   </div>
   {% endfor %}
   ```

3. 建议：若整个的项目多处使用flash消息，可以将flash消息的显示放在基模板中

### 扩展

1. 环境变量

   window

   ```
   终端：
   	设置：set XXX=yyy
   	获取：set XXX
   代码：
   	import os
   	app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY') or '123456'
   ```

   Linux

   ```
   导出：export SECRET_KEY=123456
   打印：echo $SECRET_KET
   ```

   说明：写在环境变量中，可以避免直接的将隐私信息公布于众

2. 本地库文件

   ```python
   # 使用(bootstrap)本地库中的文件
   app.config['BOOTSTRAP_SERVE_LOCAL'] = True
   ```

   > 如果觉得不合适，也可以更换成信任的cdn

3. 主机信任

   1. 生成密钥对

      ```
      ssh-keygen：产生密钥对，默认在~/.ssh/目录下生成两个文件id_rsa、id_rsa.pub
      ```

   2. 在需要信任的主机上创建信任文件~/.ssh/authorized_keys，将公钥粘贴过去

   3. 友情提醒：测试需要关闭防火墙及selinux

      ```
      临时关闭：
      	service iptables stop
      	setenforce 0
      永久关闭：
      	chkconfig iptables off
      	修改配置文件/etc/selinux/config，SELINUX=disabled
      ```

   4. 免密码登录测试：ssh 用户名@主机地址

   ​

