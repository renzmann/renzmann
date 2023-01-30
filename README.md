I mostly do data-oriented things in Python using Emacs.

## Wanna use my dotfiles?
At your own risk!  Here's what I do to install my Unix configuration:

```sh
cd $HOME
git init
git remote add origin git@github.com:renzmann/renzmann
git pull
git checkout --force main
```

Then I install editor configs as needed.

```sh
git clone git@github.com:renzmann/.emacs.d --depth 1
git clone git@github.com:renzmann/config-nvim ~/.config/nvim --depth 1
git clone git@github.com:renzmann/.vim --depth 1
```

Each of these is their own repo ready to be cloned into their canonical
configuration location.  See the instructions in each one for installation:

[renzmann/.emacs.d](https://github.com/renzmann/.emacs.d)
[renzmann/.vim](https://github.com/renzmann/.vim)
[renzmann/config-nvim](https://github.com/renzmann/config-nvim)
