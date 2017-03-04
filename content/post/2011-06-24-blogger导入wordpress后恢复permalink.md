---
title: blogger导入wordpress后恢复permalink
author: muninn
type: post
date: -001-11-30T00:00:00+00:00
url: /2011/06/24/blogger导入wordpress后恢复permalink.html
duoshuo_thread_id:
  - 1184800744742584362
categories:
  - 未分类
tags:
  - blogger
  - wordpress

---
blogger导入wordpress官方就提供有插件

但是倒入后每篇文章的链接就变了

之前搜索引擎搜索出来的结果 点就去就是404无法找到

以下两步可以修复这个问题

&#160;

首先 在wordpress里配置permalink为custom 填写成这样

/%year%/%monthnum%/%postname%.html

&#160;

然后 新建一个php文件

把下面的代码复制进去保存 上传到服务器上

执行这个文件

它会把postname替换成之前blogger上的

&#160;

<pre class="brush: php;">&lt;?php
require_once('wp-load.php');
 
$res = $wpdb-&gt;get_results("SELECT post_id, meta_value FROM $wpdb-&gt;postmeta WHERE meta_key = 'blogger_permalink'");
$wpdb-&gt;print_error();
 
foreach ($res as $row){
$slug = explode("/",$row-&gt;meta_value);
$slug = explode(".",$slug[3]);
 
$wpdb-&gt;query("UPDATE $wpdb-&gt;posts SET post_name ='" . $slug[0] . "' WHERE ID = $row-&gt;post_id");
$wpdb-&gt;print_error();
}
 
echo "DONE";
?&gt;</pre>

&#160;

好了 大功告成