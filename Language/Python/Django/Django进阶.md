Django 进阶
===========


1. [HTTP Objects](https://docs.djangoproject.com/en/2.0/ref/request-response/)
    - HttpRequest
        - 自身属性
            * request.path -> `/foo/bar/`
            * request.method
            * request.GET
            * request.POST
            * request.COOKIES
            * request.FILES -> `{name1: file1, name2: file2, ...}`
            * request.META['REMOTE_ADDR']
            * request.META['HTTP_USER_AGENT']
        - 中间件添加的属性
            * request.session
            * request.user
        - 方法
            * request.get_full_path() -> `/foo/bar/?a=123`
            * request.get_signed_cookie(key)
    - HttpResponse
        - 属性
            * response.status_code
            * response.content
        - 方法
            * response.set_cookie(key, value, max_age=None)
    - JsonHttpResponse
        - `response = JsonHttpResponse({'a': 12, 'b': 'xyz'})`

2. Django 中间件
    - 最简单的中间件

            def simple_middleware(get_response):
                # do_something_for_init()
    
                def middleware(request):
                    # do_something_before_views()
    
                    response = get_response(request)  # views 函数在这里执行
    
                    # do_something_after_views()
    
                    return response
    
                return middleware

    - 中间件类

            class MyMiddleware:
                def __init__(self, get_response):
                    self.get_response = get_response
    
                def __call__(self, request):
                    response = self.get_response(request)
                    return response
    
                def process_view(self, request, view_func, view_args, view_kwargs):
                    pass

    - Django-1.10 以前的中间件

            from django.utils.deprecation import MiddlewareMixin

            class MyMiddleware(MiddlewareMixin):
                def process_request(self, request):
                    pass
    
                def process_view(self, request, view_func, view_args, view_kwargs):
                    pass
    
                def process_response(self, request, response):
                    return response

    - 执行顺序
        - process_request, process_view 从上往下执行
        - process_response 从下往上执行
    - [内置中间件的排序](https://docs.djangoproject.com/en/2.0/ref/middleware/#middleware-ordering)

3. Form 表单
    - form 的 method 只能是 POST 或 GET
    - method=GET 时, 表单提交的参数会出现在 URL 里
    - 属性和方法
        - form.is_valid()
        - form.has_changed()
        - form.cleaned_data['fieldname']
    - Form 的定义和使用

            from django.forms import Form
            from django.forms import IntegerField, CharField, DateField, ChoiceField
    
            class TestForm(Form):
                TAGS = (
                    ('py', 'python'),
                    ('ln', 'linux'),
                    ('dj', 'django'),
                )
                fid = IntegerField()
                name = CharField(max_length=10)
                tag = ChoiceField(choices=TAGS)
                date = DateField()
    
            data = {'fid': 123, 'name': '1234567890', 'tag': 'dj', 'date': '2017-12-17'}
            form = TestForm(data)
            print(form.is_valid())
            print(form.cleaned_data)  # cleaned_data 属性是 is_valid 函数执行时动态添加的

    - ModelForm

            class UserForm(ModelForm):
                class Meta:
                    model = User
                    fields = ['name', 'birth']

4. 模板
    - base.html 模板推荐布局

            <!DOCTYPE html>
            <html>
            <head>
                <title>{{title}}</title>
                <link rel="stylesheet" type="text/css" href="/static/css/style.css">
                {% block "ext_css" %}{% endblock %}
            </head>
            <body>
                <!-- {% block "navbar" %}{% endblock %} -->
                {% block "sidebar" %}{% endblock %}
                {% block "content" %}{% endblock %}
                <!-- {% block "foot" %}{% endblock %} -->
                {% block "ext_js" %}{% endblock %}
            </body>
            </html>

    - [内建 Tags](https://docs.djangoproject.com/en/2.0/ref/templates/builtins/#ref-templates-builtins-tags)
        - `autoescape`

                {% autoescape off %}
                    {{ body }}
                {% endautoescape %}

        - `csrf_token`

                <form>
                {% csrf_token %}
                </form>

        - `for...endfor` 中的变量
            * `forloop.counter`     从 1 开始计数
            * `forloop.counter0`    从 0 开始计数
            * `forloop.revcounter`  逆序计数到 1
            * `forloop.revcounter0` 逆序计数到 0
            * `forloop.first`       是否是循环中的第一个
            * `forloop.last`        是否是循环中的最后一个
            * `forloop.parentloop`  用于引用上级循环中的变量, 如 `{{ forloop.parentloop.counter }}`
        - empty 子句

                {% for x in lst %}
                    <div>...</div>
                {% empty %}
                    <div>Sorry</div>
                {% endfor %}

        - load: 加载自定义 Tag `{% load foo.bar %}`
        - url: 根据 url name 替换 `{% url 'your-url-name' v1 v2 %}`
        - static

                {% load static %}
                <img src="{% static "img/smile.jpg" %}">

            或

                {% load static %}
                <img src="{% get_static_prefix %}img/smile.jpg">

    - [内建的 filter](https://docs.djangoproject.com/en/2.0/ref/templates/builtins/#built-in-filter-reference)
        - safe 和 escape: `{{ var|safe|escape }}`

    - [使用 Jinja2 替换内置模板引擎](https://docs.djangoproject.com/en/2.0/topics/templates/#django.template.backends.jinja2.Jinja2)

5. ORM
    - 什么是 ORM
    - CURD (Create/Update/Retrieve/Delete)
    - [Field](https://docs.djangoproject.com/en/2.0/ref/models/fields/)
    - Field 选项
        * `null`    针对数据库, 允许数据库该字段为 Null
        * `blank`   针对 Model 本身, 允许传入字段为空. blank 为 True 时, 对数据库来说, 该字段依然为必填项
        * `default` 尽量使用 default, 少用 null 和 blank
        * `choices`
        * `primary_key` 非必要时不要设置, 用默认 id, 保持条目自增、有序
        * `unique`
        * `db_index`    (True | False)
        * `max_length`
        * `auto_now`     每次 save 时，更新为当前时间
        * `auto_now_add` 只记录创建时的时间, 保存时不更新
    - [QuerySet](https://docs.djangoproject.com/en/2.0/ref/models/querysets/)
        - 方法
            * 创建: `create() / get_or_create() / update_or_create() / bulk_create()`
            * 条件过滤和排除: `filter() / exclude()`
            * 只加载需要的字段: `only() / defer()`
            * `order_by() / count() / exists()`
            * `latest() / earliest()`
            * `first() / last()`
        - 查找条件
            * `filter(id__in=[123, 555, 231])`
            * `filter(id__range=[123, 456])`
            * `filter(name__contains='123')`
            * `filter(name__regex='^\w+\d+')`
            * `gt / gte / lt / lte`
    - 其他 ORM
        * sqlalchemy
        * peewee
    - 主键和外键约束
        - 内部系统、传统企业级应用可以使用 (需要数据量可控，数据库服务器数量可控)
        - 互联网行业不建议使用
            - 性能缺陷
            - 不能用于分布式环境
            - 不容易做到数据解耦

6. Cache
    - 默认缓存: `from django.core.cache import cache`
    - BACKEND: `DatabaseCache / MemcachedCache / LocMemCache`
    - LOCATION: IP:Port 绑定, 只有一个时配制成字符串链接, 有多台时配制为列表
    - 使用 Redis 做缓存

            CACHES = {
                "default": {
                    "BACKEND": "django_redis.cache.RedisCache",
                    "LOCATION": "redis://127.0.0.1:6379/1",
                    "OPTIONS": {
                        "CLIENT_CLASS": "django_redis.client.DefaultClient",
                        "PICKLE_VERSION": -1,
                    }
                }
            }

    - 基本方法
        * `cache.set(key, value, timeout=None)`
        * `cache.get(key, default=None)`
        * `cache.delete(key)`
        * `cache.incr('num')`
        * `cache.decr('num')`
        * `cache.get_or_set(key, default, timeout=None)`
        * `cache.set_many({'a': 1, 'b': 2, 'c': 3})`
        * `cache.get_many(['a', 'b', 'c'])`
    - 全站缓存中间件: `django.middleware.cache.UpdateCacheMiddleware`
        - 前置中间件
        - 缓存期限: CACHE_MIDDLEWARE_SECONDS
    - 页面缓存装饰器: `from django.views.decorators.cache import cache_page`
    - 属性缓存装饰器: `from django.utils.functional import cached_property`
    - pickle
        * dumps
        * loads

7. Cookie 和 Session
    - Cookie: `response.set_cookie(key, value, max_age=None)`
    - Session 配置
        1. 开启 Session 中间件: `django.contrib.sessions.middleware.SessionMiddleware`
        2. 配置缓存
        3. 配置 Session 引擎: `SESSION_ENGINE = "django.contrib.sessions.backends.cache"`
    - 可选项
        * `SESSION_COOKIE_AGE`              缓存时间, 默认 2 周
        * `SESSION_COOKIE_NAME`             Session 名, 默认 'sessionid'
        * `SESSION_EXPIRE_AT_BROWSER_CLOSE` 浏览器关闭页面时, Session 是否设为过期
        * `SESSION_SAVE_EVERY_REQUEST`      每次请求时, 是否强制保存一次 Session
    - 用法
        * `request.session.session_key`     查看 session_id
        * `request.session.modified`        session 是否发生过修改
        * `request.session['uid'] = 1234`   当 session 发生更改时会自动保存
        * `request.session.get('uid')`      取值
        * `request.session.save()`          手动保存

8. Logging
    - 日志级别
        * DEBUG
        * INFO
        * WARNING
        * ERROR
        * FATAL
    - 使用
        * logger.debug('xxxxxxxx')
        * logger.info('xxxxxxxx')
        * logger.warning('xxxxxxxx')
        * logger.error('xxxxxxxx')
        * logger.fatal('xxxxxxxx')
    - 查找、分析
        * tail
        * head
        * less
        * awk
        * grep
    - [配置](https://docs.python.org/2/library/logging.html)

            LOGGING = {
                'version': 1,
                'disable_existing_loggers': True,
                'formatters': {
                    'simple': {
                        'format': '%(asctime)s %(module)s.%(funcName)s: %(message)s',
                        'datefmt': '%Y-%m-%d %H:%M:%S',
                    },
                    'verbose': {
                        'format': '%(asctime)s %(levelname)s [%(process)d-%(threadName)s] '
                                  '%(module)s.%(funcName)s line %(lineno)d: %(message)s',
                        'datefmt': '%Y-%m-%d %H:%M:%S',
                    }
                },
    
                'handlers': {
                    'inf': {
                        'class': 'logging.handlers.TimedRotatingFileHandler',
                        'filename': '/data/web/gnt.out',
                        'when': 'W0',  # 每周一切割日志
                        'backupCount': 5,
                        'formatter': 'simple',
                        'level': 'DEBUG' if DEBUG else 'INFO',
                    },
                    'err': {
                        'class': 'logging.handlers.TimedRotatingFileHandler',
                        'filename': '/data/web/gnt.err',
                        'when': 'D',  # 每天切割日志
                        'backupCount': 5,
                        'formatter': 'verbose',
                        'level': 'WARNING',
                    }
                },
    
                'loggers': {
                    'inf': {
                        'handlers': ['inf'],
                        'level': 'DEBUG',
                        'propagate': True,
                    },
                    'err': {
                        'handlers': ['err'],
                        'level': 'DEBUG',
                        'propagate': True,
                    }
                }
            }

9. Django 的性能
    - Django 自身优化
        - 充分之用缓存
        - 惰性求值和迭代器
        - 尽量使用 `defer()` 和 `only()` 查找
        - 尽量使用 `count()` 和 `exists()`
        - 模板中 `{% block %}` 性能优于 `{% include %}`
        - [开启模板缓存](https://docs.djangoproject.com/en/2.0/ref/templates/api/#django.template.loaders.cached.Loader)
        - **不要使用外键！不要使用外键！不要使用外键！**
    - 其他优化
        - I/O 密集型: 异步化
            - 请求异步化
            - 数据操作异步化
            - gevent, asyncio, aiopg, aiohttp, tornado
        - 计算密集型
            - 耗时操作用 [Celery](http://docs.jinkan.org/docs/celery/) 等工具异步完成
        - 分库分表
            - 取余、哈希
            - 范围
            - 一致性哈希
        - 索引优化
        - 慢查询优化 ([相关工具: DjangoDebugToolbar](https://django-debug-toolbar.readthedocs.io))
        - Gunicorn 开启多进程模式利用多核
        - PyPy
        - Cython

10. Python / Django 环境加载
    - sys.argv
    - sys.path
    - os.environ

11. Git
    - 常用操作
        * git init
        * git clone
        * git add
        * git commit -m 'xxxxxxxx'
        * git push
        * git pull
        * git fetch
        * git log
        * git checkout
        * git branch
        * git merge
    - 代码管理
        * code review
            - 发现代码逻辑问题
            - 代码风格及规范化问题
            - 算法问题
            - 错误的使用方式
            - 能够学习其他人的优秀代码
        * 分支: master / dev / feature

12. Blog
    1. 基础功能
        1. 看文章
        2. 写文章
        3. 查看文章列表
        4. 根据正文搜索文章
        5. 可以评论
    2. 扩展功能
        0. 实现分页功能: 首页文章列表每页显示 5 篇文章
        1. 实现一个基于 redis 的文章缓存
        2. 给首页增加一个模块, 显示最受欢迎的 10 篇文章 (点击率最高的)
        3. 创建用户模块
            * 实现注册、登录功能
            * 添加用户个人信息展示
            * 开发头像上传功能
        4. 写一个装饰器, 在 blog.log 文件中输出阅读文章的用户 IP, 及所读文章的 ID
        5. 基于日志的简单统计
            * 计算出阅读次数最多的文章: `awk '{print $6}' blog6.log | sort | uniq -c | sort -r`

            * 计算出每个访客读了多少篇文章: `awk '{print $5}' blog6.log | sort | uniq -c | sort -r`

        6. 写一个中间件, 限制用户的访问频率最大为每秒 2 次，超过 2 次时，等待至合理时间再返回
        7. 给文章增加 Tag 功能:
            * 每篇文章可以添加多个 Tag
            * 每个 Tag 分类下有多篇文章
            * 点击每个 Tag 直接跳转到此 tag 的文章列表
            * 不要使用外键
        8. 实现权限管理功能
            * 未登录用户只能查看文章
            * 普通注册用户，可以发表评论
            * 管理员，可以发表和删除文章、评论
        9. [使用 Gunicorn 驱动 Django, 对比性能差异](http://docs.gunicorn.org/en/latest/install.html)
            * 文件描述符
            * 单台服务器最大连接数
            * TCP 连接上限
        10. Nginx
            * 负载均衡: 轮询, 权重, IP 哈希

                                   User Requests
                                 |    |    |    |
                                 V    V    V    V
                                 www.example.com
                                     DNS 轮训
                                   /         \
                                  V           V
                              Nginx            Nginx
                           113.5.3.10        110.2.9.11         ---> Nginx 绑定公网 IP
                           /        |        |       \
                          V         V        V        V
                    AppServer  AppServer  AppServer  AppServer  ---> Gunicorn + Django
                    10.0.0.1   10.0.0.2   10.0.0.3   10.0.0.3   ---> AppServer 绑定内网 IP
                    weight:2   weight:5   weight:10  weight:20  ---> 权重

            * 为什么用 Nginx, 不直接用 gunicorn
            * 代理网站、图片
            * Nginx 和 Apache 的区别

        11. 压力测试
            * ab
            * webbench
        12. 其他: uWSGI, tornado

13. 项目
    - 代码组织
    - 常用组件
        - nginx
        - [Redis](http://redisdoc.com/)
        - MySQL
        - 软件安装
            * `apt-get`
            * `yum`
            * `make` / `make install`
    - DB 集群
        * 主从备份
        * 一主两从
        * 双主互备

14. 静态文件存储
    - 线上系统 Django 会关掉自身的静态文件处理
    - 用 Nginx 代理静态文件
    - CDN (内容分发网络)
        * 基于缓存技术为静态资源 (主要是多媒体资源) 提供访问加速的服务
        * 在不同地区部署镜像服务器节点
        * 定期与源站做内容同步
