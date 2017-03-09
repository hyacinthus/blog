---
title: 在 Windows 10 文件管理器右键启动 PowerShell
author: muninn
type: post
date: 2016-01-22T07:26:23+00:00
url: /2016/01/22/在-windows-10-文件管理器右键启动-powershell.html
duoshuo_thread_id:
  - 6242509840929784577
categories:
  - 技术
tags:
  - windows

---
大家应该都知道 在文件管理器 按住 shift 右键就有“在此处打开命令行窗口”
  
需要用命令行的时候还是挺方便的

这也只能怪 Windows 直接打开 cmd 或者 PowerShell
  
目录都停在 “C:\WINDOWS\system32>”
  
很不方便

那么当习惯了 PowerShell 之后
  
可以激活当前文件夹下的 PowerShell 无疑很好
  
其实很简单

在注册表找到
  
[**HKEY\_CLASSES\_ROOT\Directory\Background\shell\cmd\command**]
  
把值改成
  
**powershell.exe -NoExit Set-Location &#8220;%V&#8221;**

好了 显示的还是在此处打开命令行窗口 不过打开的是 PowerShell
  
不知道还有没有更完美的方案 可以显示在此处打开 PowerShell