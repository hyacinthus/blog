---
title: How to Make Hugo Ignore Obsidian Templates
date: 2026-03-09
author: Hyacinthus
slug: hugo-obsidian-template
tags:
  - hugo
  - obsidian
  - ClaudeCode
draft: false
---
Today I dug up my blog that I haven't written in for years, ready to start writing again. Naturally, that meant switching to a new theme.

Times have changed. After cloning the repo, I opened Claude Code and typed: please switch the theme to [PaperMod](https://adityatelange.github.io/hugo-PaperMod/), stop using git submodules, adapt to the latest version of Hugo, and fix any potential errors. In no time, everything was done.

Years ago I used VSCode or Typora, but now I use Obsidian. Since Hugo posts need Front Matter, I asked Claude to create a template in the `content` directory so I could conveniently insert Front Matter. That's when the nightmare began.

In the past couple of months, AI has evolved to a frightening degree. With Claude Code in hand, it feels like being invincible yet having no worthy opponent — I've written or modified many projects and it basically hits whatever I point at. But this template issue stumped it. Hugo refused to ignore the template files no matter what. Switching to a hidden folder made Hugo ignore them, but Obsidian ignored them too, making them useless as templates. Claude started trying to convince me to open the project root directory in Obsidian instead of the `content` directory — absolutely unacceptable. I then brought in Gemini, but it couldn't solve it either. After going back and forth many times, trying numerous approaches, Gemini just walked through the same pitfalls Claude had already fallen into.

In the end, I had to step in myself. After studying Hugo, I discovered that the `ignoreFiles` config must be placed at the very beginning of `hugo.toml`. It's that simple — if this key appears after certain other keys, it silently stops working. This is probably a bug in Hugo. I searched through many discussions, and none of them mentioned this.

Here's the official documentation — many people on Reddit say this config doesn't work: https://gohugo.io/configuration/all/#ignorefiles