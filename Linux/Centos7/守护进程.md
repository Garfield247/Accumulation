守护进程（Daemon）是运行在后台的一种特殊进程。它独立于控制终端并且周期性地执行某种任务或等待处理某些发生的事件。

1. 在`/etc/systemd/system/`下创建一个systemd的文件`transferdata.service`

2. 内容如下

   ```
   [Unit]
   Description=test deamon
   After=rc-local.service

   [Service]
   Type=simple
   User=root
   Group=root
   WorkingDirectory=/project/dispose_transfer
   ExecStart=/project/.env/bin/python3 /project/dispose_transfer/main.py
   Restart=always

   [Install]
   WantedBy=multi-user.target
   ```

   ​

3. 启动: `systemctl start transferdata.service`

4. 开机启动：把 `systemctl start test.service` 命令添加到 `/etc/rc.d/rc.local`中