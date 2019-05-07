# GoogleChromeDebInstall

## 下载

- 手动下载

1. 打开 Google Chrome 浏览器官网下载地址 ：http://www.google.cn/intl/zh-CN/chrome/browser/desktop/index.html
2. 选择“下载 Chrome（Linux 版）”点击“下载 Chrome”

- 命令下载

  ```
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  ```

## 安装

1. 进入 Download 目录

   ```
   cd ~/Downloads
   ```

2. 使用命令

   ```
   sudo dpkg -i google-chrome-stable_current_amd64.deb
   ```

3. 初次安装时可能遇到google-chrome-stable的错误，这时安装 google-chrome-stable

   ```
   sudo apt-get install google-chrome-stable
   ```

4. 若仍然报如上图所示的依赖错误，只需按照提示执行

   ```
   sudo apt-get -f install
   ```

5. 重新进行安装

   ```
   sudo dpkg -i google-chrome-stable_current_amd64.deb
   ```
## ChromeDriver安装

1. 下载对应版本的驱动文件
   网址：https://chromedriver.storage.googleapis.com/index.html
   
2. 解压到/usr/bin
```shell
sudo unzip chromedriver_linux64.zip -d /usr/bin
```
   
