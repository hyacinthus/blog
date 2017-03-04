---
title: 程序起名要慎重
author: muninn
type: post
date: -001-11-30T00:00:00+00:00
url: /2011/03/10/python_error.html
duoshuo_thread_id:
  - 1184800744742584345
categories:
  - 未分类
tags:
  - python

---
今天为了玩python的random模块

我兴高采烈的建了个文件叫random.py

打下 import random

什么？为什么eclipse里提示错误呢……

我想了许久 终于明白是优先发现本目录有random的文件

就是它自己 当然不能导入了

于是连忙改了个名字 错误消失了

可没有结束

&#160;

写了个函数 运行 报错了

TypeError: &#8216;module&#8217; object is not callable

奇怪 难道是改名要反应时间？

我关掉eclipse 重新打开 运行 还是报错！

在网上搜搜这错误 一看 人家都是真错了

我这真没错啊

于是想起来去服务器上试试

命令行里一试验 没问题呀

写个文件试试 也没问题呀

这奇怪了……

我想先写了程序传服务器上用吧

&#160;

这期间我又本地运行了几次 一直报错

再重启 还是报错

……

两个小时后

我抱着不到黄河心不死的精神又运行了次

没问题了 可以执行了

&#160;

eclipse 作为一个电脑程序 你反射弧也太长了吧！