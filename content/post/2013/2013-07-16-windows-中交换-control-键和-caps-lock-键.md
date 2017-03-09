---
title: Windows 中交换 Control 键和 Caps Lock 键
author: muninn
type: post
date: 2013-07-16T08:09:42+00:00
url: /2013/07/16/windows-中交换-control-键和-caps-lock-键.html
duoshuo_thread_id:
  - 1184800744742584402
categories:
  - 技术
tags:
  - windows

---
How to swap the caps and ctrl in windows
  
本篇文章有效的操作系统：Windows XP/Vista/7

  1. <span style="line-height: 14px;">在开始的搜索框或者运行框输入regedit ，打开注册表管理器。</span>
  2. 转到  HKEY\_LOCAL\_MACHINE -> System -> CurrentControlSet -> Control -> KeyBoard Layout
  3. 在此文件夹“新建” ， “二进制值”
  4. 修改新建的名字为：Scancode Map
  5. 在其上点右键，选择修改二进制数据，输入如下数据。第一列不用输入。所以不好复制，手输吧。

> 0000 00 00 00 00 00 00 00 00
  
> 0008 03 00 00 00 1d 00 3a 00
  
> 0010 3a 00 1d 00 00 00 00 00
  
> 0018 

好了 现在重启电脑 应该一切生效了 只用改这一处两个键就交换了

出处： https://www.kodiva.com/post/swapping-caps-lock-and-control-keys