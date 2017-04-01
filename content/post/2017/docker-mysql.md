+++
date = "2017-03-28T21:12:49+08:00"
title = "在 Docker 中使用 mysql 的一些技巧"
tags = ["mysql","docker"]
draft = false

+++

今天我写一点在 Docker 容器中使用 MYSQL 的 tips.
要不要在生产环境使用 Docker 运行数据库这么深奥的问题，等我踩足够的坑再来写吧。
但是至少在开发和测试环境你可以用 docker 管理数据库啊。

## Compose file
先贴一个我常用的 docker-compose 片段，后边进行详细的解释。这是日常使用的状态，此处省略了别的服务。

```
version: '2'
services:
    mysql:
        image: mysql:5.7.16
        ports:
        - ${DB_PORT}:3306
        environment:
        - TZ=Asia/Shanghai
        command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
        volumes:
        - ./mysql_data:/var/lib/mysql
        restart: unless-stopped
```

## 版本
一定要锁定镜像到最小的版本，因为mysql镜像升级后需要你手动在容器中执行命令去 `mysql-upgrade`，否则很久之后，你才发现有的数据已经损坏了。
实在想升级，升级步骤如下：

* 如果是用 `docker run` 启动的，那么停掉再启动个新的。如果是用 ` docker-compose` 启动的，直接改版本号 pull 镜像重新 up。
* 在新的版本启动后执行 `docker exec -it 你的容器名称或id mysql-upgrade`

## 端口
如果想在外部通过工具访问，需要将3306端口映射到host上的一个端口，不准备外部访问的环境则不必。
一般来说开发和测试环境还是经常需要登到数据库上查看的。

## 时区
添加环境变量 `TZ` 让mysql用你的默认时区启动。
这是因为 mysql 的基础镜像是 debian， 这个环境变量可以声明 debian 的时区，然后被 mysql 继承。

## 字符编码
mysql 的镜像默认编码是 `latin1` 这可不行，在中国我们一般都用 `UTF8` 。
一般我们要是在主机上配置 mysql 的话，是去修改配置文件。但使用容器时映射进去一个配置文件是很复杂的。
于是我们有个简单的办法，mysql 接受很多 flag 通过启动时传入。其中就有声明服务器默认编码的。
我们的 `command` 命令就是给 mysql 在启动时加了两个参数。

## 存储
容器中有需要持久化存储的内容时就会有点麻烦。一般有两种方案，一种是映射主机的一个目录，一种是利用数据卷。
在很长时间的使用中，我总结出了这个比较方便的办法。

* 因为 `docker-compose` 有个潜规则就是大家一般都在有 compose 文件那个目录执行命令。
* 于是我们做一个以环境名称命名的文件夹，里边是 compose 文件，`.env` 文件，和各种需要持久化的文件夹。
* 在 compose 文件中，我们映射文件夹用相对目录。
* 最后，这个文件夹就是一个整体，只需要把它拷贝在任何机器任何地方都可以启动这个环境。

## 初始化
mysql 容器在首次启动的时候，必须指定一个root密码才能启动，指定的方式是声明环境变量 `MYSQL_ROOT_PASSWORD` 。
一旦在指定的数据文件夹发现已经存在库的时候，这个参数就会被忽略掉。
所以我们只需要在第一次启动的时候加上，后面有了数据后都去掉就好了。

## 导入导出
在容器中运行的 mysql 该怎么导入导出数据或结构呢？照这么做吧：

```bash
# Backup
docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql

# Restore
docker exec -i CONTAINER /usr/bin/mysql -u root --password=root DATABASE < backup.sql
```

就这么多吧，还有什么 Tips ，欢迎大家补充。
