---
date: 2019-02-03T15:27:09+08:00
title: Should RESTful APIs Follow HTTP Status Code Standards?
tags: ["restful","api","microservice"]
---

## The Origin

Here's how it started: I was invited to answer [a question on Zhihu](https://www.zhihu.com/question/310737821) about whether to use HTTP 404 when an ID is not found. I answered fairly early, when there were only one or two responses. I thought this was uncontroversial — in an academic setting discussing technical matters, of course you should follow the standards. But a few hours later, I was stunned. The "invent your own codes" camp was in first place. Thankfully, the "everything returns 200" camp didn't gain much traction, or I really would have lost it.

## Why Follow the Standards

People who say "handle special cases specially, don't be bound by standards" usually haven't fully understood the subject and use that line as an excuse to cut corners. In practice, most projects don't have that many special cases.

### Better Compatibility with Libraries

Most mature HTTP client libraries are designed around RFC standards for error handling. While implementations differ, they always document how errors are handled. Using RFC standard codes maximizes compatibility across HTTP clients. You might say your current HTTP client doesn't check status codes — but you can't guarantee you won't refactor later, and that the new client won't either.

In JavaScript, the popular library axios treats any code outside the 200 range as an exception by default. In Python, the most popular HTTP client, requests, provides even more detailed status code handling.

### Easier Onboarding for Developers

From a team management perspective, our principle is to minimize a project's custom "conventions" — that way they're easier to follow. Wherever standards exist, don't invent something more complex. Both the maintainers and consumers of an API change over time, and every new person joining the project pays a cost to learn unnecessary custom conventions.

## The Easiest Approach: Follow the Big Players

When setting conventions for a project, the least reliable method is guessing; slightly better is asking on forums; better still is Googling; but the simplest is looking at what major companies do. APIs are public-facing — there's nothing easier to find references for. Let's see:

* [Google](https://cloud.google.com/apis/design/errors) — follows the standard
* [GitHub](https://developer.github.com/v3/#client-errors) — follows the standard
* [Microsoft](https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#711-http-status-codes) — follows the standard (their API guidelines are genuinely instructive)
* [Twitter](https://developer.twitter.com/en/docs/ads/general/guides/response-codes) — follows the standard
* [Alibaba Cloud](https://help.aliyun.com/document_detail/25491.html) — follows the standard
* Tencent Cloud — does NOT follow the standard; returns 200 for everything. Tencent's tech is rather chaotic, with each project doing its own thing. But their latest unified standard mandates all-200 with error codes in the response body.
* [Baidu Cloud](https://cloud.baidu.com/doc/BCC/API.html) — follows the standard

## My Recommendation

Many people use bare-bones web frameworks and mistakenly believe that returning an error status code means you can't include a response body. In fact, for any status code other than 204, you should always include a body.

In your project conventions, you can require that status codes follow the RFC standard (or a chosen subset with uncommon codes removed). For any non-2xx code, always return an error structure like this:

```json
{
    "error": "UserNotFound",
    "message": "The user was not found"
}
```

This creates a three-tier error structure. The first tier is the status code, giving consumers a rough idea of what went wrong. The second tier is a machine-readable error key — a predefined string with no spaces — that consumers use to determine what to do next. The third tier is a human-readable message that consumers may choose to display directly to end users.

For microservice projects, require every service — regardless of language — to unify errors in this format. If a developer says their framework doesn't support it, that's not a good framework and it's time to refactor. A good framework not only lets you customize error responses, but also lets you customize "framework-level errors" like route-not-found.

## In Closing

I truly don't understand how the most absurd answer — inventing a `600` status code — could end up with the most votes. Do Zhihu users have any independent judgment at all? As long as someone presents themselves earnestly and drops a bit of credentials, people upvote regardless of how nonsensical the content is. Perhaps it really isn't the right place to answer technical questions anymore.
