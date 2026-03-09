---
title: Press the Enter key to begin the installation process
author: muninn
type: post
date: 2011-10-05T07:44:15+00:00
url: /2011/10/05/fedora_install_usb.html
duoshuo_thread_id:
  - 1184800744742584371
categories:
  - 技术
  - 未分类
tags:
  - Fedora
  - Linux

---
前几天安装Fedora的时候遇到了这个问题

无法引导入安装界面

我当然是找了个别的键盘来接上

依然无效

上google搜索 发现中文资料没有提及这个的

英文的有 在fedora和redhat的bug汇报里

下面很多人跟贴

但是没有解决办法

&#160;

在这几天里

我尝试了无数种办法

什么UltraISO 什么unetbootin 什么Live USB Creator 什么syslinux手动做

换了fedora15的32位64位桌面版和Live版 换了Fedora16的alpha版

都不行

有的是如标题所示然后不动

有的是左上角一个光标一只闪 然后不动

有的是提示了syslinux的版本 然后不动

总之最后的结果就是都卡住不动

就完全没有引导起来

&#160;

有人说是bios问题

我觉得很有可能 因为centos是能装的 fedora就不行了

于是各种坎坷的把bios升级到最新了

还是不行

&#160;

今天 Fedora 16 beta出来了

又研究了一天

居然用官方文档上一个最弱的办法搞定了 下面这个文档

[https://docs.fedoraproject.org/en-US/Fedora/15/html/Installation\_Guide/Making\_USB\_Media-UNIX\_Linux-other-dd.html][1]

只需要你是任何linux操作系统

然后搞清楚U盘的设备名 比如/dev/sdb这样

注意后面肯定没数字 有数字的是windows分过区那个数字是主分区

然后用一个很毁灭的命令 注意备份好u盘

dd if=光盘iso文件 of=/dev/sdb

敲这个命令一定一定要搞清楚后面的设备是不是u盘盘符

它会把光盘镜像完全复制到u盘 连最大容量都和你的iso一样了

然后使用命令

fdisk –l /dev/sdb

看看 没错 boot下面有个* 表明它是启动盘

&#160;

这次重启 F12 U盘启动 顺利进到Live版的fedora了

泪流满面

然后刚才那个u盘

还要用linux的fdisk命令重新分区

不然的话没法再windows上用了 windows只能格式化不能分区

它就只有刚才的镜像500m那么大&#8230;

&#160;

总结如下

装这几个Linux桌面版

首先记得使用Live版cd 可以省去很多麻烦

然后如果windows那几个工具制作的启动u盘不好使的话

试试linux的dd命令吧

 [1]: https://docs.fedoraproject.org/en-US/Fedora/15/html/Installation_Guide/Making_USB_Media-UNIX_Linux-other-dd.html