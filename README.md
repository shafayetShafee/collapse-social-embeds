# `collapse-social-embeds` Extension For Quarto

Make collapsible callouts with [`social-embeds`](https://github.com/sellorm/quarto-social-embeds) for HTML output format. Therefore, this filter provides Six new callouts with embedded social contents (Github gist, twitter tweets, mastodon posts, loom video, vimeo video and, youtube video).

[`Live Demo`](https://shafayetshafee.github.io/collapse-social-embeds/example.html)

:warning: **This extension requires the quarto version to be at least [`1.3`](https://quarto.org/docs/download/prerelease.html)**

## Installing

```bash
quarto add ShafayetShafee/collapse-social-embeds
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

At first specify the `collapse-social-embeds` filter in document yaml,

```
---
format: html
filters:
  - collapse-social-embeds
---
```

To make collapsible callouts with embedded content, you need to use pandoc Divs (`:::`) and specify one of the classes `.gist`, `.loom`, `.mastodon`, `.twiiter`, `.vimeo`, `.youtube` and specify the attributes with key-value pair like `user=<user_name>`.

### Github gist

To create a collapsible callouts with embedded github gist, use the class `.gist`, specify a user name to `user` attribute and a gist id to `gist_id` attribute.

```
::: {.gist user=<username> gist_id=<gist_id> }
:::

```

So to embed the gist `https://gist.github.com/tarleb/852f6ae98764bea56aeeac979f3c17be` within a collapsible callouts,

```
::: {.gist user=tarleb gist_id=852f6ae98764bea56aeeac979f3c17be }
:::

```


### Tweets

Create a collapsible callouts with embedded tweets from Twitter using the class `.twitter` and `user` and `status_id` attributes as following,

```
::: {.twitter user=<user-name> status_id=<status-id> }
:::

```

So to embed the tweet, `https://twitter.com/pandoc_tips/status/1576105972103516160?s=20&t=v_a8PrZRW8uIZLUBba6JAQ` within a collapsible callouts,

```
::: {.twitter user=pandoc_tips status_id=1576105972103516160 }
:::

```

### Mastodon

Create a collapsible callouts with embedded posts from Mastodon using the class `.mastodon` and `url` attributes as following,

```
::: {.mastodon url="<mastodon-post-url>" }
:::
```
(where the url value is wrapped with quotes)

So to embed the post `https://fosstodon.org/@pandoc/109712438144865859` within a collapsible callouts,

```
::: {.mastodon url="https://fosstodon.org/@pandoc/109712438144865859" }
:::

```


### Youtube Video

Create a collapsible callouts with embedded youtube video using the class `.youtube` and `video_id` attribute as following,

```
::: {.youtube video_id=<video id>}
:::

```
So to embed the youtube video `https://www.youtube.com/watch?v=mrvhk2XUfWo` within a collapsible callouts,

```
::: {.youtube video_id=mrvhk2XUfWo }
:::

```


### Vimeo

Create a collapsible callouts with embedded video from Vimeo using the class `.vimeo` and `video_id` attribute as following,

```
::: {.vimeo video_id=<video id>}
:::

```
So to embed the vimeo video `https://vimeo.com/783455878` within a collapsible callouts,

```
::: {.vimeo video_id=783455878 }
:::

```

### Loom

Create a collapsible callouts with embedded video from Loom using the class `.loom` and `video_id` attribute as following,

```
::: {.loom video_id=<video id>}
:::

```
So to embed the loom video `https://www.loom.com/share/8619b03224f74282b6d56cbedbcd3fc6` within a collapsible callouts,

```
::: {.loom video_id=8619b03224f74282b6d56cbedbcd3fc6 }
:::

```

To know how to get the callout attributes like `user`, `*_id`, refer to the [docs](https://github.com/sellorm/quarto-social-embeds#usage) of `social-embeds`, where everything is discussed in detail.

### General attributes

All of the above callout types has the following [four general attributes](https://quarto.org/docs/authoring/callouts.html#customizing-appearance),

- `title`: The title to appear in callout header.
- `collapse`: `true` or `false`
- `appearance`: `default`, `minimal` or `simple`
- `icon`: `true` or `false`

And we can specify them as, for example,

```
::: {.gist user=tarleb gist_id=852f6ae98764bea56aeeac979f3c17be collapse=false appearance=simple icon=false title="Lua Demo"}
:::
```

## Example

Here is the source code for examples of all of the above: [example.qmd](example.qmd) and [here](https://shafayetshafee.github.io/collapse-social-embeds/example.html) is the rendered document.


## Acknowledgement

This filter simply extends the awesome quarto shortcode extension [`social-embeds`](https://github.com/sellorm/quarto-social-embeds) with Quarto callout custom nodes.
