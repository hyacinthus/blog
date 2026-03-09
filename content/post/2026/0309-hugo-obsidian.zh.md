---
title: Obsidian 的模板在 Hugo 中怎么忽略
date: 2026-03-09
author: Hyacinthus
slug: hugo-obsidian-template
tags:
  - hugo
  - obsidian
  - ClaudeCode
draft: false
---
今天把我几年没写的 Blog 翻出来，准备重新开始写点东西。既然如此，当然要换一个新的模板。

现在时代不同了，我 Clone 好之后，打开 claude code，输入：请把模板换成 [PaperMod](https://adityatelange.github.io/hugo-PaperMod/) 放弃使用 git submodule，适配最新版的 hugo，修复任何潜在的错误。很快，一切都搞定了。

很多年前，我还是用 VSCode 或者 Typora，现在用的是 Obsidian，因为 Hugo 的文章需要 Front Matter，我就让 claude 在 content 中创建 template，让我可以方便的插入 Front Matter。然后噩梦就开始了。

这两个月，AI 已经进化到可怕，Claude Code 在手有种天下无敌茫然四顾的感觉，写了或者改了很多项目现在基本上指哪打哪。结果这个 Template，难住了它，Hugo 无论如何都不忽略，改成了隐藏文件夹，hugo 倒是忽略，obsidian 也忽略了，无法用做模板。它开始劝说我，在 obsidian 里打开项目根目录，而不是 content 目录，这怎么能忍。又祭出 Gemini，依然无解，反反复复改很多次，尝试了若干种办法，把 Claude 走过的坑再走一遍。

最后，还是亲自出马吧，我研究了一下 hugo，发现 `ignoreFiles` 这个配置要放在 hugo.toml 的最前边，就是这么简单，这个 key 如果出现在某个 key 后边就失效了。这应该是 hugo 的一个 bug 吧。我搜索到了很多讨论，都没提到这一点。

这是原始文档，很多人在 reddit 说这个配置是无效的： https://gohugo.io/configuration/all/#ignorefiles