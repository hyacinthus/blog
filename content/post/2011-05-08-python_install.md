---
title: 在Linux/unix系统上安装最新的python
author: muninn
type: post
date: -001-11-30T00:00:00+00:00
url: /2011/05/08/python_install.html
duoshuo_thread_id:
  - 1184800744742584357
categories:
  - 未分类
tags:
  - AIX
  - Linux
  - python

---
Unix系统是自带python的

不过就我用的AIX5.3和Redhat EL 5.3来说 都带的是2.4的

2.4最不方便的是exit还要带sys.exit() 还有一些其他不同

于是只好重新装个高版本的python

&#160;

给Linux装python还是很简单的 和其他软件一样

  1. 首先在<a href="https://www.python.org/getit/" target="_blank">官方网站</a>下载 比如选Python 2.7.1 compressed source tarball
  2. 将其传到服务器上解压
  3. 进入文件夹
  4. ./configure
  5. make
  6. make install

&#160;

这就应该自动安装完了

可以打python看看版本变了没

如果没有 whereis python看看链接在哪里

一般是/usr/bin/python

把这个链接删掉修改成最新的安装的那个

安装的路径注意下之前刷的日志应该能找到

&#160;

嗯 为了访问Oracle 我还一起安装了cx_Oracle

这个安装稍微麻烦些 下次再说