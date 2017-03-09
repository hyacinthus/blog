---
title: wordpress被黑了
author: muninn
type: post
date: 2012-04-17T08:48:14+00:00
url: /2012/04/17/wordpress_hacked.html
duoshuo_thread_id:
  - 1184800744742584387
categories:
  - 鄙视
tags:
  - google
  - wordpress

---
话说从上周开始我的博客<a href="https://www.xiafeng.net" target="_blank">风如夏花</a>开始被google报有恶意软件

于是chrome和firefox打开都会悲剧

我检查了一圈页面 并没有发现异常

于是很忧愁 总要做点什么

&#160;

首先我换了空间 从一个虚拟主机换到了我的一个VPS

直接改用nginx做容器

然后换了域名的DNS Server 换成了cloudflare

然后重新提交审核 没用

&#160;

我又怀疑是cloudflare的问题

关掉CDN功能 提交审核 没用

&#160;

于是我怀疑我什么地方检查漏了

就又下载了一份最新的wordpress

只把旧的配置和upload文件夹移过来

重新审核 没用

&#160;

众所周知 google什么都用机器做

根本没人管这些事

所以也完全没地方问

我越来越怀疑google的机制出了什么问题

&#160;

可经过一个礼拜的煎熬后

才发现google诚不余欺 太厉害了

今天我又在绝望中打开唯一一直存在的文件

wp-config.php看了一下

里边竟然有一段eval()包裹的base64加密代码

&#160;

不得不说

隐蔽性太强了

首先一般的人访问 页面都一切正常 让人无从怀疑

只有搜索引擎访问的时候它才暴露恶意页面

其次 这个文件很有用 也不会轻易被覆盖掉

最后 它的代码还是加密的 在内容里搜索都搜索不到

&#160;

现在虽然还没有再次审核我的网站

不过相信很快就会好了

希望遇到同样问题的人能搜到我的这篇文章

&#160;

我就粘一些中英文的关键词 以便能被搜索到

&#160;

<font color="#666666">This site may harm your computer.</font>

<font color="#666666">Google has discovered harmful code on your site and will display a warning to users when they attempt to visit your pages.</font>

<font color="#666666">When Google last tested this page, no content was returned from your server. Instead, the browser was redirected to a malicious web page. It is likely that your server configuration has been modified.</font>

<font color="#666666">Google 在您的网站上发现了有害代码，用户尝试访问您的网页时，Google 会向用户显示警告。</font>

<font color="#666666">Google 上次测试此网页时，未收到您的服务器返回的任何内容，而浏览器却被重定向到了恶意网页。您服务器的配置很可能已遭到篡改。</font>