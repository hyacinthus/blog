---
title: 在vim中查看python文档
author: muninn
type: post
date: 2012-04-30T07:58:02+00:00
url: /2012/04/30/pydoc_in_vim.html
duoshuo_thread_id:
  - 1184800744742584391
categories:
  - 技术
tags:
  - python
  - vim

---
众所周知python有个命令是pydoc

可以启动文档服务器 或者直接查看文档

&#160;

但是有时候在vim中还是懒得再去命令行里或者网页里查文档

于是找到个插件

可以直接在vim中查python文档

<https://www.vim.org/scripts/script.php?script_id=910>

&#160;

不过我在gvim中用

不是特别满意

主要因为我习惯把gvim全屏

然后可以纵向分屏左右各显示一个文件

而这个插件会横向分屏显示文档

于是我把它改了改

如果你恰好也是全屏使用gvim

那么这个效果应该还不错

它会在右侧打开一个60宽度的窗口显示doc

文件在这里

<https://gist.github.com/2552337>

&#160;

比较常用的功能是把光标停在一个词上

然后按大写的K

这时候就会自动搜索这个的单词的文档

当然也可以用Pydoc命令查询模块文档

和Pydocs命令查询关键字的文档 相当于 pydoc –k

vim要求自定义命令必须大写开头

挺烦人的