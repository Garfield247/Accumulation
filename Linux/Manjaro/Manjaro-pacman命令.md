Pacman 是一个命令行工具，这意味着当你执行下面的命令时，必须在终端或控制台中进行。

1、更新系统

在 Arch Linux 中，使用一条命令即可对整个系统进行更新：

```
pacman -Syu
```

如果你已经使用 `pacman -Sy` 将本地的包数据库与远程的仓库进行了同步，也可以只执行：

```
pacman -Su
```

2、安装包

- `pacman -S 包名` 例如，执行 `pacman -S firefox` 将安装 Firefox。你也可以同时安装多个包，只需以空格分隔包名即可。
- `pacman -Sy 包名` 与上面命令不同的是，该命令将在同步包数据库后再执行安装。
- `pacman -Sv 包名` 在显示一些操作信息后执行安装。
- `pacman -U` 安装本地包，其扩展名为 pkg.tar.gz。

3、删除包

- `pacman -R 包名` 该命令将只删除包，不包含该包的依赖。
- `pacman -Rs 包名` 在删除包的同时，也将删除其依赖。
- `pacman -Rd 包名` 在删除包时不检查依赖。

4、搜索包

- `pacman -Ss 关键字` 这将搜索含关键字的包。
- `pacman -Qi 包名` 查看有关包的信息。
- `pacman -Ql 包名` 列出该包的文件。

5、其他用法

- `pacman -Sw 包名` 只下载包，不安装。
- `pacman -Sc` Pacman 下载的包文件位于 /var/cache/pacman/pkg/ 目录。该命令将清理未安装的包文件。
- `pacman -Scc` 清理所有的缓存文件。