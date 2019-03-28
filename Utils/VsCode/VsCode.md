# VsCode

## Extensions

- `Sublime Text Keymap and Settings Importer`
- `Code Runner`
- `VSCode Great Icons`
- `vscode-database`
- `Chinese (Simplified) Language Pack for Visual Studio Code`
- `Prettify JSON`

- `Maridown pdf`

## VSCode 同步设置及扩展插件 实现设备上设置统一

#### Step1.

 安装 同步插件"Settings Sync"

#### Step2. 

进入github -> Settings 在左侧 Developer settings -> Personal access tokens 

#### Step3. 

点击按钮 Generate new token 新增一个token

#### Step4. 

回到VSCode配置将token配置到本地

(Sync: Update / Uplaod Settings) Shift + Alt + U 在弹窗里输入你的token， 回车后会生成syncSummary.txt文件

#### **Step5. **

**设置上同步下载设置**

(Sync: Download  Settings) Shift + Alt + D 在弹窗里输入你的gist值，稍后片刻便可同步成功

#### **Step6. **

**如果要重置同步设置，变更其它token**

Ctrl+P / F1 弹出输入>sync,即可重新配置你的其它token来同步