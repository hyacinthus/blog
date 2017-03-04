---
title: CMD下获得所有Windows盘符
author: muninn
type: post
date: 2011-12-26T07:00:02+00:00
url: /2011/12/26/windows_drive.html
duoshuo_thread_id:
  - 1184800744742584382
categories:
  - 技术
tags:
  - windows

---
对Windows着实不熟

今天查如何用程序获得所有的硬盘找了好一会

排在前列的答案都是不对的

于是写在这里供大家参考

&#160;

使用管理员模式启动cmd终端

然后fsutil fsinfo drives命令可以列出所有的驱动器

如果只想要硬盘

可以使用fsutil fsinfo drivetype一个一个检查

相关的功能都可以靠命令本身的帮助得到

这还是一个很强大的命令的

&#160;

相信用了命令

用程序获得返回值然后解析也是很容易的