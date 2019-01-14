---
title: controller the rails way
articles:
  - _kb/rails/routing.md
---

learnzone-rails looks like a good Java project...but it is not coded in Java! Trying
to switch to a more _Rails-ish_ way:

- Using concerns (modules) instead of abstract classes
- Exception handlers are using concerns instead of `try...catch...` each methd
- Responders!

According to [this SO question](https://stackoverflow.com/questions/25998437/why-is-respond-with-being-removed-from-rails-4-2-into-its-own-gem),
`respond_with` has been removed from Rails 4.2. Question is: _what is now the recommended practice?_

- _option 1_: copy pasting `respond_to`
- _option 2_: [`responder` gem](https://github.com/plataformatec/responders)
