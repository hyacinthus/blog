---
title: 修改Micolog的侧边栏
author: muninn
type: post
date: 2011-03-06T00:00:00+00:00
url: /2011/03/06/micolog_sidebar.html
duoshuo_thread_id:
  - 1184800744742584346
categories:
  - 未分类
tags:
  - GAE
  - Micolog

---
记得一次见过哪个朋友的博客

侧边栏有个阅读次数最少的文章列表

顿时觉得很有趣

一般都是将最热门的列出来

而我觉得将最冷门的列出来一则可以提醒自己这些文章为什么这么烂

一则还可以让读者看看这些隐藏在角落里的内容

&#160;

小小研究了下 修改这个还算简单 有三个地方要改

我在鸣的群里也看到过有人想改侧边栏显示的条数 则也很容易做到

首先修改model.py这个文件

在Blog这个类下面 找到hotposts

我们复制这一段函数 山寨一个coldposts

除了改名字 把 order(&#8216;-readtimes&#8217;) 这里的负号去掉

在这里可以看到它默认取了8条 想修改各种条数是可以在这里修改的

&#160;

好了 因为我们改了数据模型 相应的必须修改索引

这样才能顺利取出符合这个条件的内容 于是修改index.yaml

增加这样一个索引

> &#8211; kind: Entry   
> &#160; properties:   
> &#160; &#8211; name: entrytype   
> &#160; &#8211; name: published   
> &#160; &#8211; name: readtimes

&#160;

最后 当然是修改模板了

在模板的sidebar.html里边 把热门的一段复制了

然后除了修改名字 把 {% for entry in blog.hotposts %} 当然也修改成coldposts

好了

现在一切都搞定了
