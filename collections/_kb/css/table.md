---
tech: css
title: Tables
tags: [css, tables]
mentioned:
  - /2018/12/11/styling-table
---

Manage tables style:

- To avoid having space between `td`
  ```css
  table {
    border-collapse: collapse;
  }
  ```
  Link: [w3c tutorial](https://www.w3schools.com/CSSref/pr_border-collapse.asp)
- To have alternate rows style:
  ```css
  tr:nth-child(even) {
    background-color: #123456;
  }
  ```
  Link: [StackOverflow](https://stackoverflow.com/a/3084318/4906586)
