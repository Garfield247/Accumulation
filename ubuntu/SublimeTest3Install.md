安装GPG密钥：

```
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
```

确保apt已设置为使用https源：

```
sudo apt-get install apt-transport-https
```

选择要使用的频道：

- 稳定版

  ```
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list 
  ```


- 开发版

  ```
  echo "deb https://download.sublimetext.com/ apt/dev/" | sudo tee /etc/apt/sources.list.d/sublime-text.list 
  ```

  

更新apt源并安装Sublime Text

```
sudo apt-get update
sudo apt-get install sublime-text
```