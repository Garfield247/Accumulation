### 禁用触摸板

终端执行：

```
sudo modprobe psmouse  ##启用触摸板
sudo rmmod psmouse     ##禁用触摸板
```

如果是ThinkPad之类含有摇杆的机型可使用下述命令仅禁用触摸板而保留摇杆

```
synclient TouchpadOff=1    ##禁用触摸板
synclient TouchpadOff=0    ##恢复触摸板
```