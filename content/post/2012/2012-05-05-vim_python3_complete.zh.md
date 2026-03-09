---
title: Vim7.3的python3自动补全
author: muninn
type: post
date: 2012-05-05T09:03:53+00:00
url: /2012/05/05/vim_python3_complete.html
duoshuo_thread_id:
  - 1184800744742584394
categories:
  - 技术
tags:
  - python
  - vim

---
现在新的东西已经完全用python3写了

所以我不顾一切把所有默认设置都调成了为python3服务

&nbsp;

此文的前提是vim的编译选项必须有+python3

使用:version命令可以查看

Windows版默认是有的 如下图

dyn代表是支持动态加载

如果python和python3都有 那必然是动态加载的

不然会冲突嘛

[<img class="alignnone size-full wp-image-316010" title="1" src="https://tech.crandom.com/wp-content/uploads/2012/05/1.png" alt="" width="271" height="49" />][1]

&nbsp;

有了这个以后 你还必须要安装有python3.1

现在都用3.2了 但是你还是得再安装个3.1

因为几个vim编译版都是用3.1的python编译的&#8230;

在vim里执行如下命令 要是不报错就没问题了

:python3 print(&#8220;hello world&#8221;)

注意vim和python必须都是32位或者64位

要是不统一当然也不行 dll不兼容的

&nbsp;

在vim的autoload文件夹 应该有python3complete.vim这个文件

打开看 它的方法是python3complete#Complete

它可以支持python3的语法自动补全

不过 很遗憾 没有地方用它

&nbsp;

然后我们到ftplugin这个文件夹

此文件夹是在启用了filetype plugin后

会在检测到文件类型后加载里边相应文件类型的插件

找到python.vim

找到如下行

[<img class="alignnone size-medium wp-image-316011" title="2" src="https://tech.crandom.com/wp-content/uploads/2012/05/2-300x29.png" alt="" width="300" height="29" srcset="https://tech.crandom.com/wp-content/uploads/2012/05/2-300x29.png 300w, https://tech.crandom.com/wp-content/uploads/2012/05/2.png 371w" sizes="(max-width: 300px) 85vw, 300px" />][2]

&nbsp;

本来它使用的是python2的补全

只需要在python后加个3就好了 就是我们刚看到的那个方法

&nbsp;

重启vim

现在Ctrl+x Ctrl+o的补全 应该就是python3版的了

 [1]: https://tech.crandom.com/wp-content/uploads/2012/05/1.png
 [2]: https://tech.crandom.com/wp-content/uploads/2012/05/2.png