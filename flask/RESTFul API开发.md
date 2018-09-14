# RESTFul API开发

### 什么是RESTFul？

1. 简介

   ```
   REST即表述性状态传递（英文：Representational State Transfer，简称REST）是Roy Fielding博士在2000年他的博士论文中提出来的一种软件架构风格。它是一种针对网络应用的设计和开发方式，可以降低开发的复杂性，提高系统的可伸缩性。

   一种软件架构风格、设计风格，而不是标准，只是提供了一组设计原则和约束条件。它主要用于客户端和服务器交互类的软件。基于这个风格设计的软件可以更简洁，更有层次，更易于实现缓存等机制。

   REST 指的是一组架构约束条件和原则。满足这些约束条件和原则的应用程序或设计就是 RESTful。遵循restful开发的应用程序结构(API)称为RESTFul API。

   RESTFul的接口都是围绕资源以及对资源的各种动作展开的。
   ```

2. 资源

   ```
   所谓的资源就是在网络中存在的任意实体，哪怕是一条简单信息。
   ```

3. 动作

   ```
   所谓动作就是数据的CURD。在开发者设计良好的前提下，对网络资源的动作都可抽象为对资源的CURD操作。RESTFul对网络的操作抽象为HTTP的GET、POST、PUT、DELETE等请求的方式以完成对资源的增删改查。具体对照如下：
   ```

   | 方法     | 行为     | 示例                               |
   | ------ | ------ | -------------------------------- |
   | GET    | 获取资源信息 | http://127.0.0.1:5000/source     |
   | GET    | 获取指定资源 | http://127.0.0.1:5000/source/250 |
   | POST   | 创建新的资源 | http://127.0.0.1:5000/source     |
   | PUT    | 更新指定资源 | http://127.0.0.1:5000/source/250 |
   | DELETE | 删除指定资源 | http://127.0.0.1:5000/source/250 |

4. 数据

   ```
   通常传输的数据格式都采用JSON，有时也可以通过URL的参数进行传递
   ```

5. 工具

   ```
   说明：postman是一款非常好用的API开发测试工具，可以模拟各种请求
   提醒：安装包，一路next完成安装，演示一个地址的访问
   ```

### 原生实现

1. 准备数据

   ```python
   # 测试数据
   posts = [
       {
           'id': 1,
           'title': 'Python语法',
           'content': 'python语法很简单，但是每次问题都出现在语法上'
       },
       {
           'id': 2,
           'title': 'HTML',
           'content': '不就是几个标签的问题嘛，但是要细心点'
       }
   ]
   ```

2. 获取资源列表

   ```python
   # 获取资源列表
   @app.route('/posts')
   def get_posts_list():
       return jsonify({'posts': posts})
   ```

3. 获取指定资源

   ```python
   # 获取指定资源
   @app.route('/posts/<int:pid>')
   def get_posts(pid):
       p = list(filter(lambda p: p['id'] == pid, posts))
       if len(p) == 0:
           abort(404)
       return jsonify({'posts': p[0]})
   ```

4. 添加新的资源

   ```python
   # 添加新的资源
   @app.route('/posts', methods=['POST'])
   def create_posts():
       if not request.json or 'title' not in request.json or 'content' not in request.json:
           abort(400)
       # 创建新资源
       p = {
           'id': posts[-1]['id'] + 1,
           'title': request.json['title'],
           'content': request.json['content']
       }
       # 保存资源
       posts.append(p)
       return jsonify({'posts': p}), 201
   ```

5. 修改指定资源

   ```python
   # 修改指定资源
   @app.route('/posts/<int:pid>', methods=['PUT'])
   def update_posts(pid):
       p = list(filter(lambda p: p['id'] == pid, posts))
       if len(p) == 0:
           abort(404)
       if 'title' in request.json:
           p[0]['title'] = request.json['title']
       if 'content' in request.json:
           p[0]['content'] = request.json['content']
       return jsonify({'posts': p[0]})
   ```

6. 删除指定资源

   ```python
   # 删除指定资源
   @app.route('/posts/<int:pid>', methods=['DELETE'])
   def delete_posts(pid):
       p = list(filter(lambda p: p['id'] == pid, posts))
       if len(p) == 0:
           abort(404)
       posts.remove(p[0])
       return jsonify({'result': '数据已删除'})
   ```

7. 添加认证(flask-httpauth)

   ```python
   # 导入类库
   from flask_httpauth import HTTPBasicAuth

   # 创建认证对象
   auth = HTTPBasicAuth()

   # 验证回调函数，返回True表示验证成功，False表示验证失败
   @auth.verify_password
   def verify_password(username, password):
       # 理论这里应该读取数据库进行检验
       if username == 'Jerry' and password == '123456':
           return True
       return False

   # 定制认证错误
   @auth.error_handler
   def unauthorized():
       return jsonify({'error': 'Unauthorized Access'}), 403
     
   # 获取资源列表
   @app.route('/posts')
   # 资源保护，该资源只有通过认证才能访问
   @auth.login_required
   def get_posts_list():
       return jsonify({'posts': posts})
   ```

### flask-restful

1. 说明：是一个实现RESTFul API开发的扩展库，需要安装`pip install flask-restful`

2. 配置使用：

   ```python
   # 导入类库
   from flask_restful import Api, Resource
   # 创建Api对象
   api = Api(app)
   # 添加资源类，一个完整资源需要两个资源类
   class UserAPI(Resource):
       def get(self, uid):
         	# 返回数据为字典类型
           return {'User': 'GET'}

       def put(self, uid):
           return {'User': 'PUT'}

       def delete(self, uid):
           return {'User': 'DELETE'}


   class UserListAPI(Resource):
       def get(self):
           return {'UserList': 'GET'}

       def post(self):
           return {'UserList': 'POST'}

   # 将资源添加到API，添加时可以指定多个路由地址
   api.add_resource(UserAPI, '/users/<int:uid>', '/u/<int:uid>')
   api.add_resource(UserListAPI, '/users')
   # 若创建Api时没有指定app，后面初始化app时要写在添加资源之后
   # api.init_app(app)
   ```

3. 添加认证

   ```python
   class UserAPI(Resource):
       # 添加认证
       decorators = [auth.login_required]
   ```

4. 基于token的认证

   ```python
   @auth.verify_password
   def verify_password(username_or_token, password):
       if username_or_token == 'Jerry' and password == '123456':
           g.username = username_or_token
           return True
       # 再次进行尝试，验证是否是有效的token
       s = Serializer(app.config['SECRET_KEY'])
       try:
           data = s.loads(username_or_token)
           g.username = data.get('username')
           return True
       except:
           return False
   ```

5. 需要提供获取token的方法

   ```python
   @app.route('/get_token')
   @auth.login_required
   def generate_token():
       s = Serializer(app.config['SECRET_KEY'], expires_in=3600)
       return s.dumps({'username': g.username})
   ```

