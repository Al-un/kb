---
tech: ubuntu
title: Python & Django
---

Ubuntu LTS comes with Python pre-installed but for Docker or bare-metal

## Install Python (easy way)

Install pre-requisites (from <https://github.com/pyenv/pyenv/wiki/Common-build-problems>):

```sh
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
```

Install Python & pip:

```sh
sudo apt install python3
sudo apt install python3-pip
```

## Install Python (manual way)

From <https://www.quora.com/How-can-one-install-a-specific-version-of-Python-in-Ubuntu>:

```sh
# Dependencies
sudo apt-get install build-essential checkinstall
sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev

# Download
cd ~/Downloads/
wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz

# Install
tar -xvf Python-<version>.tgz
cd Python-<version> 
./configure
make
sudo checkinstall
```

If required, create a symlink:

```sh
ln -s /usr/local/bin/python3.5 /usr/bin/python
```

## Pipenv

Install pipenv:

```sh
pip3 install pipenv
````

If necessary by `pipenv`:

```sh
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
```

## Pyenv

<https://github.com/pyenv/pyenv> works very well with `pipenv`:

```
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc

echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc

exec "$SHELL"
```

Now if the `Pipfile` file requires a specific Python version, `pyenv`
can be called to install the reaquired version.
