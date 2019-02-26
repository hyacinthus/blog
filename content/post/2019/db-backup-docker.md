---
date: 2019-02-26T19:26:30+08:00
title: 用 Docker 无脑备份数据库
tags: ["db","mysql","docker"]
---

每次有一个新的数据库，都要琢磨着配置一个备份。当然你可能有一个祖传的 shell 脚本，重新配置一下放到 crontab 里就可以了。但是无论是查看和修改配置，还是查看 crontab 都不是那么方便。

今天介绍一个 Docker 镜像，只需要简单的配置启动，就可以。地址在这里：[https://hub.docker.com/r/deitch/mysql-backup/](https://hub.docker.com/r/deitch/mysql-backup/) 但你也许不需要点开链接，先看完我的例子吧。

```yaml
version: '3.7'
services:
  backup:
    image: databack/mysql-backup
    volumes:
     - /root/dbbackup:/db
    environment:
     - DB_DUMP_TARGET=/db
     - DB_USER=root
     - DB_PASS=root
     - DB_SERVER=xxx.xxx.xxx.xxx
    user: root
    deploy:
      placement:
        constraints:
          - node.id == YOURDOCKERSWARMNODEID
```

讲要点

### Version
我用了最新版的 docker-compose 格式，优点就是不用在装 docker-compose ... 使用新版 Docker 自带的 `docker stack -c backup.yml backup` 这样子启动 stack 就好。这样机器就只用装 docker 一个包。  
如果你想用旧版的 docker-compose 点开上边作者的 readme 里有例子。

### Volumes
这个镜像支持备份到本地，文件服务器，云端。这里是备份到本地，需要 mkdir 创造一个目录，并且 mount 到容器上。备份云端自行去看相关的环境变量，就不用挂载数据卷了。

### Environment
众所周知用 docker 镜像输入和配置就靠环境变量了，像我这样备份到本地可以复制我这个，记得填写服务器地址，也可以是 compose 或者 stack 中的一个服务名称。别的情况就去 readme 中看说明吧。

### User
这个作者比较谨慎，容器里居然用了 1005 的 uid ，存储用云端不用管，用本地就没权限了，这里让容器用 root 运行。

### Deploy
这个是 docker stack 的配置，这里为了让它只在一个机器启动一个实例，你要是 swarm 就一个机器也可以不配置这个。要是多个机器，要用 `docker node ls` 看一下，填个指定 id 进来，相应的你就在那个机器上建目录了。

就这样，主要只是给大家介绍一下存在这么个东西。有需要可以自己看说明的。我还搞过云函数+对象存储的备份方案，比如腾讯云的 scf+cos ，好处是不要服务器也基本不要钱……但还是比复制粘贴个配置文件启动 docker 服务麻烦太多了。