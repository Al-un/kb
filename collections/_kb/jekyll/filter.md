---
tech: jekyll
tags: [jekyll, filter]
---

## Filterting arrays with `where`, `group_by` and `sort`

In this website, KB files are sorted by technologies:

```
collections:
    - kb
        - css
        - javascript
        - jekyll
        - ruby
        - ...
```

And such technologies are reported in front-matters:

```
---
tech: css
title: Flex
---
```

To generate this left menu (irrelevant tags ommited):

```html
{% raw %}
<!-- Group by "tech" front matter and order tech by name     -->
<!-- Improvement: loop and split by file path?               -->
{% assign kb_techs = site.kb | group_by : "tech" | sort: "name" %}

{% for kb_tech in kb_techs %}

    <!-- User friendly name stored in data -->
    <h4>{{ site.data.kb[kb_tech.name] }}</h4>

    <!-- Loop through grouped items -->
    {% for kb_item in kb_tech.items %}
    <a href="{{ kb_item.url | relative_url }}">
        {{ kb_item.title }}
    </a>
    {% endfor %}

{% endfor %}
{% endraw %}
```

Sources:

- [where and group by](https://blog.webjeda.com/jekyll-filters/#simple-jekyll-filters)
