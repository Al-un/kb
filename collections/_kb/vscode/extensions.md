---
tech: vscode
title: Extensions
tags: [vscode, ide, extensions]
---

**Table of content**:

- [CSS](#css)
- [JavaScript](#javascript)
- [Git](#git)
- [Ruby](#ruby)
- [Vue](#vue)
- [Misc](#misc)
  - themes

# CSS

- [Beautify](https://marketplace.visualstudio.com/items?itemName=michelemelluso.code-beautifier)

# JavaScript

- [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
- [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)

# Git

- [GitLens !!](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)

# Ruby

- [Ruby](https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby)
- Linter: [Rubocop](https://github.com/rubocop-hq/rubocop)
  - gem install
  - user config:
    ```json
    "ruby.lint": {
        "rubocop": true,
    }
    ```
- Auto-completion: [solargraph](https://marketplace.visualstudio.com/items?itemName=castwide.solargraph)
  - installing gem
  - Windows fix required:
    - `gem uninstall eventmachine`
    - `gem install eventmachine --platform ruby -- --use-system-libraries`
- Autoformat `rufo`

  - `gem install rufo`
  - extension install: https://marketplace.visualstudio.com/items?itemName=mbessey.vscode-rufo
    - preferred over https://marketplace.visualstudio.com/items?itemName=siliconsenthil.rufo-vscode
      because I want to Alt+Shift+F for all my languages and not having
      a specific shortcut per language
  - restart vscode
  - create a .rufo

    ```yaml
    quote_style :single
    trailing_commas false
    ```

    Because of Rubocop coding style:

    - prefer single quote https://github.com/rubocop-hq/ruby-style-guide#strings
    - no trailing commas https://github.com/rubocop-hq/ruby-style-guide#collections

I also tried:

- Auto-completion: `vscode-ruby` + `rcodetools`
  - installing gem
  - Restart VsCode
  - Nothing on `[1, 2, 3].e` + `Ctrl+Space` (expect `each`)
  - Uninstall `rcodetools` gem and remove `vscode-ruby`
- Autoformat: `vscode-ruby` + `rubocop`. Looks like rubocop is not very
  friendly with auto formatting

# Vue

- [Vetur](https://marketplace.visualstudio.com/items?itemName=octref.vetur)

Sources:

- https://medium.com/tutorialsxl/vue-js-with-visual-studio-code-getting-started-3ef9829eb13e

# Misc

- **dotenv** Tried https://github.com/zaynali53/DotENV
  - => removed

### Theme

- I use `Monokai`
- [Dracula](https://marketplace.visualstudio.com/items?itemName=dracula-theme.theme-dracula)
