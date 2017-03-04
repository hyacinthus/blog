---
title: Vim的leader键无法更改
author: muninn
type: post
date: 2013-07-14T11:23:31+00:00
url: /2013/07/14/vim的leader键无法更改.html
duoshuo_thread_id:
  - 1184800744742584406
categories:
  - 技术
tags:
  - vim

---
遇到个当时感觉很诡异的问题
  
我使用
  
let mapleader=&#8221;,&#8221;
  
将leader键设置成逗号
  
可是 一些用了leader键的快捷键怎么都不起作用
  
开始以为是让别的配置文件覆盖了
  
找了许久 发现没有
  
更多的坎坷就不说了
  
最后在leader键的说明里找到一行字
  
大意是

如果你使用mapleader重新定义了leader键
  
那么只有在此之后定义的使用leader的快捷键才会使用新的配置
  
以前的还是默认的反斜杠

好吧 写出来提醒大家 看有缘人能不能搜到

另外 有个别插件有自己的私有的leader键 是要额外设置的
  
比如就我所知的perl的那个很全面地插件就是这样