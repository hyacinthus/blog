---
title: 非Windows系统升级Dell笔记本BIOS
author: muninn
type: post
date: 2011-10-05T08:14:28+00:00
url: /2011/10/05/update_bios.html
duoshuo_thread_id:
  - 1184800744742584372
categories:
  - 技术
  - 未分类
tags:
  - Linux
  - windows

---
为了装Fedora折腾了很久升级BIOS

我那个本是Dell E5410 一年多了也没升级过BIOS

然后想升级的时候 发现Linux系统想要升级很难啊

&#160;

首先去dell的驱动支持里找 看到我那个bios最新版本是A11

而我的是A04

先下载下来 不过这是windows版的

dell的驱动页面并没有Linux的驱动

&#160;

于是我到网上搜索到这个网站

<https://linux.dell.com/>

dell专门为linux做支持的

根据教程去找我的bios

晕&#8230;步骤倒是很清楚 但是硬件列表里就没有我的机器&#8230;

&#160;

然后我就想把驱动提取出来 在linux用工具自己刷

网上都说dell的bios的exe文件支持-writehdrfile参数

但是&#8230;怎么敲都没用啊

双击可以用 在cmd里加参数也不报错但是就没有反应

&#160;

那么只剩下一条路了

找个DOS盘启动了然后执行这个文件

这个exe据说是16位和32位兼容的 在dos里也可以用

DOS还真不好找 我随便用U盘做了个winPE

可是&#8230;程序虽然能执行 但是它死活都说我没插电源不能继续&#8230;

看来是winPE也不行啊

最后还是老老实实找了个DOS

在里边执行那个BIOS的exe文件 就好了

&#160;

虽然刷BIOS看起来没啥用

但高手们都说肯定是对启动时间啊硬件兼容啊有好处的

聊胜于无把&#8230;