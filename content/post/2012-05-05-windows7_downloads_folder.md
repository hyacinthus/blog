---
title: 找回被迅雷摧残的下载文件夹
author: muninn
type: post
date: 2012-05-05T09:37:23+00:00
url: /2012/05/05/windows7_downloads_folder.html
duoshuo_thread_id:
  - 1184800744742584323
categories:
  - 鄙视
tags:
  - windows

---
windows7的一项我特别满意的改进就是

多了&#8221;下载&#8221;文件夹

我每次都给它精心挑选一个地方

然后还在开始菜单里显示出来

带着蓝色箭头的文件夹十分好看

[<img class="alignnone size-full wp-image-316008" title="ahBzfm11bmlubnRlY2gtaHJkcg0LEgVNZWRpYRjT0xMM" src="https://tech.crandom.com/wp-content/uploads/2012/05/ahBzfm11bmlubnRlY2gtaHJkcg0LEgVNZWRpYRjT0xMM.png" alt="" width="74" height="86" />][1]

&nbsp;

可是 如果你安装了迅雷

又把默认下载路径设置成下载文件夹

废话 下载文件夹不用来当默认下载路径还干什么

然后呢&#8230; 文件夹就被摧残成了迅雷的难看图标

那个橙色的文件夹 比迅雷本身的标志还难看很多

然后开始菜单里的&#8221;下载&#8221;还会变成downloads

在其他的一列中文里 产生违和感

&nbsp;

其实这文件夹的外观和名字

都是在其下的一个隐藏文件desktop.ini决定的

在文件夹选项里先暂时打开显示隐藏文件和显示系统文件

然后就能看到这个desktop.ini了

只需要把它修改成如下内容

&nbsp;

<pre class="lang:default decode:true ">[.ShellClassInfo] 
LocalizedResourceName=@%SystemRoot%system32shell32.dll,-21798 
IconResource=%SystemRoot%system32imageres.dll,-184</pre>

&nbsp;

然后 记得这一步

右键点击 属性 然后把它设置成只读

这下迅雷没法改了吧

&nbsp;

最后再次鄙视一下迅雷

 [1]: https://tech.crandom.com/wp-content/uploads/2012/05/ahBzfm11bmlubnRlY2gtaHJkcg0LEgVNZWRpYRjT0xMM.png