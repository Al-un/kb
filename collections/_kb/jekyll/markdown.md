---
tech: jekyll
title: Markdown
tags: [jekyll, markdown]
---

## Code blocks

Code block use [`rouge`](https://github.com/jneen/rouge) for syntax highlighting. Such
blocks are defined by a couple of triple backticks or the `highlight` tag:

```markdown
{% raw %}

    ```javacript
    // some javascript code
    const sum = (a, b) => a + b;
    ```

    {% highlight javascript linenos %}
    // some javascript code
    const sum = (a, b) => a + b;
    {% endhighlight %}

{% endraw %}
```

> Do not forget to add CSS file corresponding to code colours you prefer. To
> generate the CSS files:
>   rougify style monokai.sublime > syntax.css
> rougify style monokai.sublime > syntax.css
> Check [documentation](https://github.com/jneen/rouge#css-theme-options) for
> more details

To escape special characters, use the `{% raw %}...{% endraw %}` tags.