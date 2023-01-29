# NanoPi-R4S-R4SE
## 👉使用本固件前，请严格遵守国家互联网使用相关法律规定,不要违反国家法律规定！👈

### 固件分类 在[releases](https://github.com/gngpp/NanoPi-R4S-2021/releases)有备注关键词
- docker版：全插件+docker
- 风扇链接 [点击进入](https://s.click.taobao.com/t?e=m%3D2%26s%3Dd8Ack0Lbx8McQipKwQzePOeEDrYVVa64LKpWJ%2Bin0XJRAdhuF14FMXpyNmcFd6mT8sviUM61dt2T0mcOGN1M6FAj1gqltKaEfKzCcEr0EW0YuhTK3FPxiHMT7yc3NZrQKSOkJV8harV3phaPbavinqGCwVfdcN0wcSpj5qSCmbA%3D)  建议用这种风扇

### 固件格式
- **ext4:** 固件文件名中带有 ext4 字样的文件为搭载 ext4 文件系统固件ext4 格式的固件更适合熟悉 Linux 系统的用户使用，在 Linux 下可以比较方便地调整 ext4 分区的大小;
- **squashfs:** 固件文件名中带有 squashfs 字样的文件为搭载 squashfs 文件系统固件而 squashfs 格式的固件适用于“不折腾” 的用户，其优点是可以比较方便地进行系统还原哪怕你一不小心玩坏固件，只要还能进入控制面板或 SSH就可以很方便地进行“系统还原操作”。

### 注：不要用恢复备份。。不保证某个插件是否正常运行。。。建议重新设置贼好！

### 默认编译  

- 用户名：root 密码：password  管理IP：10.0.1.1
- 下载地址：https://github.com/gngpp/NanoPi-R4S-R4SE/releases
- 电报群：https://t.me/DHDAXCW

### 支持在线升级，自动扩容根分区
- SSH进入终端
```
# 会保存配置备份
bash +x ~/update.sh
# 跳过备份
SKIP_BACK=1 bash +x ~/update.sh
# 默认走代理下载，如不需要代理下载固件，执行下面命令
PROXY=false bash +x ~/update.sh
```

### 预览
<img src="./preview/login.png"/>
<img src="./preview/home.png"/>
<img src="./preview/vssr.png"/>
<img src="./preview/light.png"/> 

# [赏个鸡腿吧](https://afdian.net/@dhdaxcw/plan)
### https://afdian.net/@dhdaxcw/plan

请不要fork我项目，因为yml文件中已托管到我本地服务器，目的是为了加速编译。
如果想fork自己编译，那就请到yml文件中修改下面
```bash
23行 runs-on: self-hosted 改为 runs-on: ubuntu-20.04
185行 runs-on: self-hosted 改为 runs-on: ubuntu-20.04
```
另外，如果改上面的，那还要改编译线程，我默认是-j72
改好就可以用github的机器编译了

## 鸣谢

特别感谢以下项目：

Openwrt 官方项目：

<https://github.com/openwrt/openwrt>

Lean 大的 Openwrt 项目：

<https://github.com/coolsnowwolf/lede>

immortalwrt 的 OpenWrt 项目：

<https://github.com/immortalwrt/immortalwrt>

P3TERX 大佬的 Actions-OpenWrt 项目：

<https://github.com/P3TERX/Actions-OpenWrt>

SuLingGG 大佬的 Actions 编译框架 项目：

https://github.com/SuLingGG/OpenWrt-Rpi
