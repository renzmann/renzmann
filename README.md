# renzmann

I do science; mostly in python

## Wanna use my dotfiles?
At your own risk! I won't help if you break something.
Make sure to read the [bootstrapping
file](https://raw.githubusercontent.com/renzmann/renzmann/main/bootstrap.sh)
before running the command below to know exactly what it's going to do. In
summary:

1. Initialize the current directory as a git repo
2. Set origin to my dotfiles repo
3. Recursively check out editor configs, like (neo)vim stuff

```sh
cd $HOME && curl https://raw.githubusercontent.com/renzmann/renzmann/main/bootstrap.sh | sh -
```
