# Manjaro Gnome 常见问题解决方案

1. 安装Visual Studio Code以后默认的文件管理器会被改为它

    解决方案：

    1. 查看默认的文件管理器

        ```
        xdg-mime query default inode/directory
        ```

        结果显示

        ```bash
        visual-studio-code.desktop
        ```

    2. 设置默认文件管理器（inode/directory）为Nautilus

        ```
        xdg-mime default org.gnome.Nautilus.desktop inode/directory
        ```

        <!--其他Gnome桌面环境下适用，但是名称要根据/usr/share/applications下的该文档管理器的名称去设置，否则无效-->



1. 