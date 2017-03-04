---
title: 制作一个U盘中的Fedora操作系统
author: muninn
type: post
date: 2011-11-20T08:57:48+00:00
url: /2011/11/20/fedora_usb.html
duoshuo_thread_id:
  - 1184800744742584376
categories:
  - 技术
tags:
  - Fedora
  - Linux

---
以下灰色的内容纯属跑题 可以跳过

<span style="color: #808080;">最近客户的公司接受银监会检查</span>

<span style="color: #808080;">其实领导们也不知到人家要查些啥</span>

<span style="color: #808080;">开始项目经理说是删除所有涉密资料</span>

<span style="color: #808080;">后来科长说删除所有与工作无关的东西</span>

<span style="color: #808080;">再后来处长说卸载所有的没有版权的软件</span>

<span style="color: #808080;">结果越传越神 说人家有个黑盒子 接到电脑上删除的违规内容也能找出来</span>

<span style="color: #808080;">终于今天行长发话了 全行格式化硬盘 重装系统 只许再装个office</span>

<span style="color: #808080;">这就是中国</span>

<span style="color: #808080;"><br /></span>

<span style="color: #808080;">当然 早在前天 行里强制每个人安装的&ldquo;杀毒软件&rdquo;就悄悄替每个人先优化了下系统</span>

<span style="color: #808080;">因为是在外地工作嘛 晚上得把笔记本拿回家</span>

<span style="color: #808080;">然后我和同时发现都上不了网</span>

<span style="color: #808080;">我大概看了下 说是肯定是路由怀了 因为都登录不到路由的页面嘛</span>

<span style="color: #808080;">然后就把路由reset了好几遍 发现没用 想着只好再买个路由了</span>

<span style="color: #808080;">于是把网线拔到我电脑上 直接拨号 结果还是上不去！</span>

<span style="color: #808080;">怪了 打电话给宽带通 人家那边说一切正常啊</span>

<span style="color: #808080;">说了许久 人家可能没办法 承认他们出了问题 工程师正在处理&#8230;</span>

<span style="color: #808080;">那天真是委屈宽带通的mm了 一直感觉很歉意</span>

<span style="color: #808080;">后来我个宿舍的人说 我感觉电脑的症状 像我们集体中了什么特厉害的病毒</span>

<span style="color: #808080;">因为我ping 127.0.0.1都ping不通啊 肯定是本地有什么问题</span>

<span style="color: #808080;">同事当然说不可能 我也笑笑说我也觉得不可能 这年头哪能碰到这么nb的病毒</span>

<span style="color: #808080;">第二天到了公司</span>

<span style="color: #808080;">所有把笔记本拿回家的同事都说他们家的网怀了或者笔记本坏了</span>

<span style="color: #808080;">我们这时才恍然大悟</span>

<span style="color: #808080;">是我们的笔记本集体被做了改动</span>

<span style="color: #808080;">这个改动挺厉害的 我后来研究了很久 都没有发现是在哪里动的手脚</span>

<span style="color: #808080;">路由啊 设备啊 驱动啊 安全设置啊 防火墙啊 都完全正常</span>

<span style="color: #808080;">没办法 对windows底层不熟悉 要是linux也许还能找出一些端倪</span>

<span style="color: #808080;">于是为了上网 这段时间只能想办法了</span>

<span style="color: #808080;">自然而然我就想到做一个usb的操作系统 插上就能上网</span>

<span style="color: #808080;">于是同事翻出来个很久的笔记本 果然能上网 然后给我下载了一个Fedora 16的镜像</span>

&nbsp;

这个镜像 一定要选x64 Live版的

因为U盘上的操作系统 很多东西都会载入内存 很费内存

我笔记本内存4G 如果用32bit的 那么就浪费了1G的内存 速度差很多的

后来观察用一会以后 内存很容易就几乎占满了 然后U盘版又不会有swap

&nbsp;

U盘 最好是大于8G的 不过理论上大于1G就可以了

因为Fedora 16的镜像是600M出头

但是如果真要在U盘上好好用 还要在u盘上制作一个文件当作启动后挂载根目录的设备

和虚拟机用文件模拟硬盘完全是类似的

&nbsp;

U盘的文件系统 我现在用的是Fat32

优点是还可以继续在windows上当u盘用

缺点是只支持4G的文件 上一节说的那个文件 最大就只能4G

将来是装不了多少软件的 不过也够用了

我当时是想绝一点 使用Linux格式化成ext4

然后把16G的u盘全虚拟成这个操作系统的硬盘 然后就只当作启动盘用了

最后失败了 失败在下一节所说的制作软件在Fedora 16下有bug 用不成

真不明白他们自家的软件不支持自家最新的系统

还有一些其他做系统的办法 但是我不会做上面提到的那个虚拟硬盘的文件 就放弃了

&nbsp;

制作工具使用Fedora官方提供的Liveusb-creator

有这些需要注意的

Win7下必须使用管理员启动

左上的按钮可以载入镜像 载入后在控制台会有说明

左下的列表里选择u盘 一定别选错了 慎重

右下的横条 就是选择将来根分区的大小了

如果是fat32格式的u盘 那么就选择4095M好了

然后点最下边的按钮 就开始做了

&nbsp;

做完了插在电脑上

更改bios用u盘启动 或者有的电脑可以按F12之类的选择启动设备

就可以启动一个全新的Fedora了

启动后将就是可以用的

我的dell笔记本只是没有无线网卡的驱动

其他软件驱动之类的一些东西 下一篇有空再说把