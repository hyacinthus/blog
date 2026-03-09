---
title: Fedora16自动安装无线网卡
author: muninn
type: post
date: 2011-11-21T08:06:30+00:00
url: /2011/11/21/fedora_wifi.html
duoshuo_thread_id:
  - 1184800744742584377
categories:
  - 技术
tags:
  - Fedora
  - Linux

---
之前写过一篇在Linux安装无线网卡驱动   
现在看来太繁琐了   
而且&hellip;&hellip;Fedora16换了很新的内核 那个不好使了   
经过研究 如下步骤最简单

当然 我只研究了我这个dell本的网卡   
不过貌似大部分无线网卡都是这个厂商的   
执行这个命令看看网卡   
lspci | grep Network   
如果是Broadcom Corporation这个厂商的   
应该没有问题 我们继续   
以下都在root下执行

首先执行这两个rpm包 它会为你的yum添加我们需要的源   
rpm -Uvh https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm   
rpm -Uvh https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm   
然后可以考虑升级以下系统 当然没有时间的话 也可以不升级继续   
yum search kmod-wl   
做这一步主要是现在fedora是3.x的Linux内核了   
如果直接yum install kmod-wl是不行的   
我们接着要看下我们的系统版本   
uname -r   
然后挑选刚才search到的名字中包含自己系统编号的包安装   
在安装成功以后 等一会如果还没有出现无线网络   
可以手动加载一下驱动   
modprobe wl   
再等等就应该能看到任务栏的网络里有无线网络了