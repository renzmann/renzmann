I mostly do data-oriented things in Python using Emacs.

## Wanna use my dotfiles?
At your own risk!  Here's what I do to install my Unix configuration:

```sh
cd $HOME
git init
git remote add origin git@github.com:renzmann/renzmann
git pull
git checkout --force main
git submodule update --init --recursive
```

## Just want my Emacs or (Neo)vim config?
Each of these is their own repo ready to be cloned into their canonical configuration location.
See the instructions in each one for installation:

[renzmann/.emacs.d](https://github.com/renzmann/.emacs.d) 
[renzmann/.vim](https://github.com/renzmann/.vim)  
[renzmann/config-nvim](https://github.com/renzmann/config-nvim)  
