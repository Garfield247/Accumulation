# day08机器学习KNN

1. ### k-近邻算法原理

     简单地说，K-近邻算法采用测量不同特征值之间的距离方法进行分类。

     - 优点：精度高、对异常值不敏感、无数据输入假定。
     - 缺点：时间复杂度高、空间复杂度高。
     - 适用数据范围：数值型和标称型。

2. ### 在scikit-learn库中使用k-近邻算法

     - 分类问题：

       ```python
       from sklearn.neighbors import KNeighborsClassifier
       # samples 
       # 训练数据
       X_train = []
       # 类标签
       y_train = []
       # 1. 确定机器学习的模型
       # n_neighbors 的取值会影响分类结果，需手动调试，选择评分最高的参数最佳
       knnclf = KNeighborsClassifier(n_neighbors=5)
       # 2.训练数据（把样本集的数据输入到机器学习模型中）
       knnclf.fit(X_train,y_train)
       # 3.预测数据
       y_ = knnclf.predict(x_test)
       y_
       # 4.绘制图像
       ```

     - 回归问题：

       ```python
       from sklearn.neighbors import KNeighborsRegressor
       # samples 
       # 训练数据
       X_train = []
       # 类标签
       y_train = []
       # 1. 确定机器学习的模型
       # n_neighbors 的取值会影响分类结果，需手动调试，选择评分最高的参数最佳
       knnrgr = KNeighborsRegressor(n_neighbors=5)
       # 2.训练数据（把样本集的数据输入到机器学习模型中）
       knnrgr.fit(X_train,y_train)
       # 3.预测数据
       y_ = knnrgr.predict(x_test)
       y_
       # 4.绘制图像
       ```

       ​

