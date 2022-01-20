# Vim Nginx Syntax Highlighting

Extraction of the Nginx Vim syntax files from http://hg.nginx.org/nginx/.

## Installation

I recommend using [Tim Pope's pathogen
plugin](https://github.com/tpope/vim-pathogen), [Shougo's NeoBundle
plugin](https://github.com/Shougo/neobundle.vim) or [Gmarik's Vundle
plugin](https://github.com/gmarik/Vundle.vim) to install this.

## How this repository is created

``` shell
git init
git remote add nginx git@github.com:nginx/nginx.git
git pull -u nginx master
git filter-branch --subdirectory-filter contrib/vim HEAD -- --all
git reset --hard
git gc
git prune
```

## Updating this repository

``` shell
git checkout -b rebase
git fetch nginx master
git reset --hard nginx/master
git filter-branch -f --subdirectory-filter contrib/vim HEAD -- --all
git checkout master
git merge rebase
git branch -D rebase
```

## License

Same terms as [Nginx itself](http://nginx.org/LICENSE).
