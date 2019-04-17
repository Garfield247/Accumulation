使用[PowerShell Gallery](https://www.powershellgallery.com/packages/oh-my-posh/2.0.225)来安装posh-git和oh-my-posh

```
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
```

写好配置文件，就不用每次打开再配置了

```
if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }
notepad $PROFILE
```

在打开的配置文件中加入以下内容：

```
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Agnoster
```

其中`Set-Theme Agnoster`设置了Agnoster主题，可以用`$ThemeSettings`检查当前的主题

