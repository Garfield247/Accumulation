# Flask项目

### 项目需求

1. 用户注册、登录、激活
2. 用户信息管理
3. 博客发表、回复
4. 博客展示、分页展示
5. 收藏博客
6. 搜索、点赞、统计、排序、...

### 目录结构

```
project/
	app/					# 整个程序的包目录
		static/					# 静态资源文件
			js/						# JS脚本
			css/					# 样式表
			img/					# 图片
			favicon.ico				 # 网站图标
		templates/				# 模板文件
			common/					# 通用模板
			errors/					# 错误页面
			user/					# 用户模板
			posts/					# 帖子模板
			email/					# 邮件发送
		views/					# 视图文件
		models/					# 数据模型
		forms/					# 表单文件
		config.py				# 配置文件
		email.py				# 邮件发送
		extensions.py			# 各种扩展
	migrations/				# 数据库迁移目录
	tests/					# 测试单元
	venv/					# 虚拟环境
	requirements.txt		# 依赖包的列表
	manage.py				# 项目启动控制文件
```

### 环境准备

1. 新建一个项目，按照目录结构创建相关的目录及文件

2. 创建虚拟环境：`virtualenv venv`

   启动：`venv\Scripts\active`

   退出：`venv\Scripts\deactive.bat`

3. 生成项目依赖包文件：`pip freeze > requirements.txt`

   根据依赖包文件下载：`pip install -r requirements.txt`


### 书写步骤

1. 配置文件的书写及使用

   ```
   1.在config.py中书写配置类，对外公开一个配置字典
   2.在app/__init__.py中书写create_app函数，创建应用实例
   3.在manage.py中调用create_app创建实例并启动
   ```

2. 添加各种扩展

   ```
   1.在extensions.py中，导入类库，创建对象
   2.创建一个函数config_extensions，完成扩展的初始化操作
   3.在create_app函数中，返回之前，调用以完成扩展的添加
   ```

3. 蓝本的添加与使用

   ```
   1.在views目录下创建一个蓝本的文件，里面创建蓝本，添加视图函数
   2.在views/__init__.py中导入相关的蓝本，在配置元组中添加一条
   3.封装一个函数config_blueprint，完成蓝本的注册
   4.在create_app函数中调用config_blueprint函数
   ```

4. 定制项目基础模板

   ```
   1.在templates/common目录创建base.html，内容从bootstrap拷贝
   2.根据需要修改base.html中的内容，如：样式、内容、。。。
   3.错误页面的定制，在create_app函数中调用config_errorhandler
   4.在config_errorhandler函数中定制错误页面(顺便测试项目基础模板)
   ```

5. 邮件发送功能添加

   ```
   1.粘贴第7天中的邮件发送代码
   2.将依赖包或对象等的路径修改一下
   ```

### 练习

1. 用户注册、激活、登录、。。。

