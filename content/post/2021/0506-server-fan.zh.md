---
title: 'Server饭-用API发微信通知或用微信控制你的服务器'
date: 2021-05-06
author: Muninn
slug: 'server-fan-intro'
tags: ['golang','server.fan']
---

大家好，这是又一个向微信发通知的服务。这样的服务其实不少，一定是有新的特色我才好意思来介绍。
[Server饭](https://letserver.run)不仅可以给微信发通知，还能反过来用微信和服务器产生交互。大概像下面这样：

![Intro](https://static.crandom.com/hackfan/intro.png)

好了，还是先介绍基础功能吧。

## 主动发送通知

给自己发消息是最常用的功能。  
拉到文末扫码关注服务号，或者在微信搜索 "LetServerRun" 这个服务号关注。  
在服务号发送 `token` 命令查看自己的用户 token 。  
使用用户 token，您就可以用 API 向公众号发警告消息了：

```bash
curl "https://api.letserver.run/message/info?token=YOUR-TOKEN&msg=hello"
```

这个 GET 接口是为了调试和轻量使用场景的，在程序中使用的话有[一系列接口](https://letserver.run/ref/)和SDK。

## 反向控制服务器

**Server饭**的特色功能是用微信控制服务器做简单的事情。就像一开始的图里那样。
放心，不需要你提供ssh密钥，为了安全，命令能做什么完全由你定义。

实现的原理是在服务号中你发的命令会被存储在云端，
Agent 每分钟向云端发起请求检查一次，如果有命令则拉回来执行它。
执行完成之后可以返回成功或者失败的结果，你就会在微信服务号上看到。

Agent 哪里来呢？有这么几种选择：

* 最自由：调用我们的API自己写
* 省事点：调用 SDK 自己写
* 够用就好：直接用我们几个开源的方案

这里我们先使用一个[开源的通用 Agent](https://github.com/hack-fan/skadi-agent-shell)来上手。  
它可以帮你在服务器执行特定的命令。后面我们可以根据需求，自己通过 API 或 SDK，集成 Agent 或自己编写。

假设你的服务器是 Debian/Ubuntu ,如果是别的请参考 [安装通用Agent](/docs/basic/common-agent/)  
如果您本身就是 root 用户，麻烦去掉所有命令中的 `sudo`

```bash
# 注册仓库
curl -1sLf \
  'https://dl.cloudsmith.io/public/hackfan/skadi/setup.deb.sh' \
  | sudo -E bash
# 更新
apt update
# 安装
apt install skadi
```

在安装后，因为还没有 Token，所以并没有自动启动。  
Token 哪来的呢？在服务号输入命令: `agent add 名字` (名字是要你给它取个简单的名字，以后每次都要用它发命令)  
然后将得到的 Token 写入配置文件，像下面这样。
你也可以编辑 `/etc/skadi/skadi.yml` 这个文件自己写入。

```bash
# 写入 Token
sudo skadi AGENT-TOKEN
# 启动服务
sudo systemctl start
```

只有第一次需要配置Token后手动启动服务，服务器重启它是会依靠systemd自己启动的。

然后就可以试用这个 Agent 了。

在公众号输入 `名字 help` ，看看 Agent 自己的帮助。  
这个官方的通用 Agent 功能由你部署它的服务器上的 `/etc/skadi/skadi.yml` 这个配置文件定义。

然后你可以顺次输入`名字 date`,`名字 lsroot`,`名字 free -m`,`名字 Hi Fool`,
去试用，接下来，更改配置文件就可以完成重启服务，查看状态等简单的动作了。

只是想现在看看的话，也可以看看[代码仓库的版本](https://github.com/hack-fan/skadi-agent-shell/blob/main/example.skadi.yml)

## 更多功能

因为目前只是提供了一个舞台，更多的功能在持续的发掘中，我们会陆续更新文档中的 cookbook：

* 在 CI 服务中通知微信，甚至直接给 Agent 发任务进行持续部署
* Agent 之间链式发送任务配合完成工作
* 集成在业务系统中当作一个简单的控制台，比如清除缓存，封禁用户等操作，微信上就搞定了。
* 当成一个[延迟队列](https://letserver.run/docs/basic/delayed-queue/)使用
* 控制家里的电脑
* 控制路由器或者 NAS
* 更多用法等待你开发脑洞~

最后，二维码在这里哦，暂时用不到也可以扫扫留着备用，只有重大更新才会推送通知，平时0骚扰哦。

![LetServerRun](https://static.crandom.com/hackfan/letserverrun.jpg)
