---
title: SyntaxHighlighter在chrome中的问题
author: muninn
type: post
date: 2011-01-20T00:00:00+00:00
url: /2011/01/20/syntaxhighlighter.html
duoshuo_thread_id:
  - 1184800744742584340
categories:
  - 未分类
tags:
  - other

---
折腾了许久 终于弄好了SyntaxHighlighter

但是发现它在chrome中右侧总是有滚动条

而在IE9则没问题

于是找了找css

比如默认的shCoreDefault.css的59行

.syntaxhighlighter的一个属性

overflow: auto !important;

把auto改成hidden

这回它怎么也不出来滚动条了

就是不知道有没有什么副作用

比如代码太长的时候会显示不全？

等遇到再说吧
