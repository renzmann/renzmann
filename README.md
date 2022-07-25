I do science; mostly in Python

## Wanna use my dotfiles?
At your own risk! I won't help if you break something.
Make sure to read the [bootstrapping
file](https://raw.githubusercontent.com/renzmann/renzmann/main/bootstrap.sh)
before running the command below to know exactly what it's going to do. In
summary:

1. Obliterate existing .vim and .config/nvim directories
1. Initialize the current directory as a git repo
1. Set origin to my dotfiles repo
1. Recursively check out editor configs, like (neo)vim stuff

```sh
cd $HOME && curl https://robbmann.io/boostrap.sh | sh -
```

## Just want my (Neo)vim or emacs config?
Each of these is their own repo ready to be cloned into the canonical configuration location.
See the instructions in each one for installation:

[renzmann/dotvim](https://github.com/renzmann/dotvim)  
[renzmann/config-nvim](https://github.com/renzmann/config-nvim)  
[renzmann/.emacs.d](https://github.com/renzmann/.emacs.d)  
