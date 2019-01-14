---
tech: surge
title: Getting Started
tags: [surge]
---

Surge deployment is purely CLI-based. Install surge first:

```sh
npm install -g surge
```

> For some reasons, it does not work with `yarn global add surge` on my Windows
> 10 laptop:
>
> ```sh
> [1/4] Resolving packages...
> warning surge > du@0.1.0: no longer maintained
> warning surge > fstream-ignore > minimatch@2.0.10: Please update to minimatch 3.0.2 or higher to avoid a RegExp DoS issue
> warning surge > request > hawk > boom@4.3.1: This version is no longer maintained. Please upgrade to the latest version.
> [2/4] Fetching packages...
> info fsevents@1.2.4: The platform "win32" is incompatible with this module.
> info "fsevents@1.2.4" is an optional dependency and failed compatibility check. Excluding it from installation.
> [3/4] Linking dependencies...
> error An unexpected error occurred: "EBUSY: resource busy or locked, rmdir 'C:\\%USERHOME%\\AppData\\Local\\Yarn\\Data\\global\\node_modules\\windows-build-tools\\node_modules\\.bin'".
> ```

and deploy current folder:

```sh
surge --project path/to/deployed/website --domain {my-domain}
```

Credentials are required here and you can create an account at this moment

## Additional stuff

Surge documentation is pretty well done:

- [Using a custom domain](https://surge.sh/help/adding-a-custom-domain)

  ```sh
  CNAME mycustomdomain.al-un.fr na-west1.surge.sh
  surge --domain (https://)mycustomdomain.al-un.fr
  ```

- [Force redirect HTTP to HTTPS](https://surge.sh/help/using-https-by-default)

  ```sh
  surge --domain https://my-project.al-un.fr
  ```

- [Listing project](https://surge.sh/help/listing-all-your-projects)

  ```sh
  surge list
  ```

- [Deleting a project](https://surge.sh/help/tearing-down-a-project)

  ```sh
  surge teardown myproject.surge.sh
  ```

- [Forcing `www.mysite.com` (1) or `mysite.com` (2)](https://surge.sh/help/redirecting-www-to-root-automatically)

  ```sh
  # 1:
  surge --domain www.mysite.com
  # 2:
  surge --domain mysite.com
  ```
