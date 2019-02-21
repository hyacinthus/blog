---
date: 2019-02-03T15:27:09+08:00
title: RESTful API 中的 Status code 是否要遵守规范
tags: ["restful","api","microservice"]
---

## 缘起
事情是这样的，我在知乎受到邀请回答[一个问题](https://www.zhihu.com/question/310737821)，主要是问 ID 找不到到底要不要用 Status 404 。我回答的还是比较早的，那时候只有一两个回答。我本来以为这是没啥争议的，在一个学术的地方讨论学术问题，当然是要遵守规范了，结果过了几个小时大跌眼镜。自造 code 党竟然支持率第一，还好平时见的也很多的全 200 党没有受到支持，不然真的吐血了。

## 为什么要遵守规范
一般那种说特殊情况特殊处理，不要拘泥于规范的人，大多都是自己没搞清楚某些知识，拿这句话当作偷懒的借口。其实一般做项目没那么多特殊情况。

### 为了更好的适应各种库
大部分完善的 HTTP 请求库，都会依照 RFC 的规范去设计错误处理的流程，虽然处理方式各有不同，但一定会在文档说明错误处理的部分的。使用 RFC 标准能最大限度的兼容各种 HTTP 客户端。你说现在你用的HTTP客户端不处理 Status Code，但是你没法保证将来不重构，重构的时候还是不处理。

一般调用 api 使用 js 或者 python 的概率比较大，我们看看知名的库。在 js 里，最近比较流行的 axios 默认会把 200 系列外的 code 归到异常里。在 python 里，最流行的 http client 是 requests ，它更为详尽的预处理了 status code 。

### 为了开发者更好上手
另外在管理团队的方面，我们的原则是尽量的减少一个项目的“规范”，这样才能更容易去遵守。能用标准的地方，一定不要自己定一个更复杂的规则。无论是服务端的维护者还是 API 的消费者是会换人流动的，每个进入项目的人熟悉一大堆无谓的自定义项目规范都要成本。

## 更简单的办法是参考大厂
其实给项目定规范，最不靠谱的是自己拍脑袋，稍好一点的是去知乎或论坛问，更好一点的是去 google 搜，最简单的是直接去看大厂的产品或者规范啊。 API 本来就是个公开暴露的东西，还有比这更好找参考的吗？我们来看看：
* [Google](https://cloud.google.com/apis/design/errors) 遵守规范
* [Github](https://developer.github.com/v3/#client-errors) 遵守规范
* [Microsoft](https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#711-http-status-codes)  遵守规范 顺便说一句，微软的 API 规范真的很具有指导意义。
* [Twitter](https://developer.twitter.com/en/docs/ads/general/guides/response-codes) 遵守规范
* [阿里云](https://help.aliyun.com/document_detail/25491.html) 遵守规范
* 腾讯云 不遵守规范 全部 200 事实上腾讯的技术比较混乱，每个项目都不一样。但最新要执行的统一规范是全部 返回 200 用返回值中的错误码表明错误。
* [百度云](https://cloud.baidu.com/doc/BCC/API.html#.E8.AE.A4.E8.AF.81.E6.9C.BA.E5.88.B6) 遵守规范

## 我的建议
很多人也许用着很简陋的 Web 框架，导致误以为返回了错误码，就不能返回 Response Body 了。其实你返回 204 外的任何 Status Code，最好都伴随着返回 Body 。

在项目规范里，可以规定 Status Code 遵照 RFC 标准，或者选定一个集合出来，把一些不常用的去掉。然后如果不是200系列的代码，必须伴随着这样的一个错误结构：
```json
{
    "error": "UserNotFound",
    "message": "该用户没有找到"
 }
```
这样错误分为了三层结构，第一层是 Status Code，使用者能大概知道是什么问题。第二层Error 是一个 Key 使用约定好的无空格的英文，给使用者做判断用，使用者可以根据 Key 自定义接下来的操作。第三层是 message ，有些 Key 使用者可以决定直接把 Message 显示个终端客户。

如果是微服务项目，需要要求每个服务不管用什么语言，都要把错误统一成这个样子。如果开发者告诉你框架不支持，那这一定不是个好框架，改重构了。好的框架不仅能让你自定义错误内容，还能做到所谓的“框架自己出错的返回”也由你自定义。比如路由没有找到之类的。
