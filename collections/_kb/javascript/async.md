---
tech: javascript
title: Async / await
mentioned:
---

`await` basically turns asynchronous code into synchronous-like syntax. However,
a method using the `await` feature must be declared as `async` so that the method
can be put on hold while awaiting for the completion of asynchronous task.

## Basic usage

A traditional _then-able_ code is written like:

```javascript
function loadContent() {
  fetch(API_PATH + SOME_PATH)
    .then(response => response.json())
    .then(data => doSomethingWithData(data))
    .catch(err => handleError(err));
}
```

The same code can be written as:

```javascript
async function loadContent() {
  try {
    const resp = await fetch(API_PATH + SOME_PATH);
    const data = await resp.json();
    doSomethingWithData(data);
  } catch (err) {
    handleError(err);
  }
}
```

Notice that _catch-able_ syntax is now replaced by a `try/catch` block

## Asynchronous loop

Async cannot be combined with `forEach`:

```javascript
async function printFiles() {
  const files = await getFilePaths();

  await Promise.all(
    files.map(async file => {
      const contents = await fs.readFile(file, "utf8");
      console.log(contents);
    })
  );
}
```

From [StackOverflow](https://stackoverflow.com/a/37576787/4906586)
