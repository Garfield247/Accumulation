# Mongodb数据迁移步骤

 

## 需求：

需要将一台linux上的mongodb数据迁移到另外一台linux上

例：A迁移到B

 

## 方案：

两个命令即可完成任务：

数据的导出：mongoexport

数据的导入：mongoimport

 

## 具体步骤：

### 导出：

1.找到A的mongodb的mongoexport所在目录。

例如：cd /usr/local/mongodb/bin

2.将数据导出，执行命令：./mongoexport -d DataBaseName -c CollectionName -o XXX.dat

其中，DataBaseName为数据库名称，CollectionName为集合名称，XXX.dat为导出后的名称

导出后的XXX.dat将在mongoexport所在的目录下。

例如：./mongoexport -d Student -c StudentInfo -o StudentInfo.dat

将数据库Student下的集合StudentInfo导出到mongoexport所在的目录下，并将其命名为StudentInfo.dat

3.按照上面的步骤将所有集合都导出来，至此导出完毕。

 

### 导入：

4.将导出的集合数据移动到B服务器上mongoimport所在的目录，可以使用命令：

sudo mv /tmp/XXX.dat /db/mongo/bin (将XXX.dat移动到/db/mongo/bin目录下)

5.找到B的mongoimport所在的目录：cd /db/mongo/bin

6.将数据导入，执行命令：

./mongoimport -h 127.0.0.1:port -u xxx -p xxx-d DataBaseName -c CollectionName XXX.dat

其中，DataBaseName为数据库名称，CollectionName为集合名称，XXX.dat为导入的集合

例如：

./mongoimport -h 127.0.0.1:27017 -u zhangsan -p zhangsan -d Student -c StudentInfo StudentInfo.dat

-h 127.0.0.1:27017：连接到本地，端口号为27017

-u zhangsan：用户名为zhangsan

-p zhangsan：密码为zhangsan

-d Student -c StudentInfo StudentInfo.dat：将StudentInfo.dat导入到数据库名称为Student，集合名称为StudentInfo中。

 

至此，迁移完毕。

 