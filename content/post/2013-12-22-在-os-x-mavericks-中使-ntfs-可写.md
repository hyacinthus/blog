---
title: 在 OS X Mavericks 中使 NTFS 可写
author: muninn
type: post
date: 2013-12-22T05:44:07+00:00
url: /2013/12/22/在-os-x-mavericks-中使-ntfs-可写.html
duoshuo_thread_id:
  - 1184800744742584412
categories:
  - 技术
tags:
  - apple
  - homebrew
  - MAC OS

---
现在的移动硬盘甚至u盘一般都用NTFS文件系统了
  
但是NTFS在苹果的操作系统里是只读的
  
有一个收费的软件可以管理NTFS的设备
  
但是我们自己努力一下也能用开源的程序做到

首先你得要有homebrew
  
对了 当然要把NTFS设备先都拔掉
  
然后在安装完ntfs-3g后 还要使用sudo做一些事情
  
一般人就是卡在了这里

<pre class="lang:sh decode:true ">brew update
brew upgrade fuse4x
brew upgrade ntfs-3g
sudo mv /sbin/mount_ntfs /sbin/mount_ntfs.orig
sudo ln -s /usr/local/sbin/mount_ntfs /sbin/mount_ntfs
brew info fuse4x-kext</pre>

然后fuse4x-kext显示出了一些信息 要照着它做
  
也就是两个命令 这里请复制你屏幕显示出来的命令
  
别复制下面的示例

<pre class="lang:sh decode:true ">sudo /bin/cp -rfX /usr/local/Cellar/fuse4x-kext/0.9.2/Library/Extensions/fuse4x.kext /Library/Extensions
sudo chmod +s /Library/Extensions/fuse4x.kext/Support/load_fuse4x</pre>

好了 现在再插上NTFS设备就已经可以写了