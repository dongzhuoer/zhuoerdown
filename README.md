# zhuoerdown
[![Build Status](https://travis-ci.com/dongzhuoer/zhuoerdown.svg?branch=master)](https://travis-ci.com/dongzhuoer/zhuoerdown)

## Overview

build others' bookdown book in Zhuoer Dong's preference

## Installation

```r
if (!('remotes' %in% .packages(T))) install.packages('remotes');
remotes::install_github('dongzhuoer/zhuoerdown');
```

## Usage


We use `zhuoerdown` environment varible to distinguish building my own book from building other's book.

Although some part may seem redundant for `zhuoerdown=true`, it make possible to share the same code for both approaches. 



### `.travis.yml`

We offer three examples:

- r4ds: https://github.com/dongzhuoer/build-r4ds/blob/master/.travis.yml
- yihui-blogdown: https://github.com/dongzhuoer/build-yihui-blogdown/blob/master/.travis.yml
- nutshell: https://github.com/dongzhuoer/nutshell/blob/master/.travis.yml



### Overview

There are mainly three directories:

- `input/` for input `.Rmd` files
- `output/` for GitBook output
- `repo/` for deploying the output to GitLab

[**zhuoerdown**](https://github.com/dongzhuoer/zhuoerdown) provides the following capacity:

- add [bookdown.css](https://github.com/dongzhuoer/zhuoerdown/blob/master/inst/bookdown.css)
- add several links in TOC
- customize output by [_output.yaml](https://github.com/dongzhuoer/zhuoerdown/blob/master/inst/_output.yaml), then by user provided `_output.yaml` (in `extra/`)


# details

1. Travis add all three tokens to environment variable



### parse package dependency

```bash
# possibly used pacakge
cat *.Rmd | grep -Po '[\w\.]+(?=::)' | sort -u | sed 's/$/,/' 
# cited package
cat *.Rmd | grep -Po '(?<=\[@R-)[\w\.]+' | sort -u | sed 's/$/,/' 
```


### customize TOC

- 章超过一页一般就collapse，如 r4ds, rmarkdown
- 所有内容在 2～3页，展开显示，如 blogdown
- 子标题严重不均匀，尤其要展开，如 bookdown



### technical details

The biggest restraint is that `bookdown::render_book()` requires workspace at the book folder.

For _blogdown_, `.Rmd` lives in `docs/`. If you `setwd()` to there, many paths would be relative to it (like `../../output`, `../../extra/_output.yaml`). 

So I thought about adding a environment variable `input_sub_dir`. But _blogdown_ doesn't collaborate, it refer to the some source code of the package by `../R/***.R`.

Suddenly, I realized that instead of setting every path relative to workspace, we can have `to_work_dir` to walk to `$work_dir`. In this way, every other path remains unchanged (`output`, `extra/_output.yaml`), user only need to customize `rmd_dir` & `to_work_dir`, like `rmd_dir=.; to_work_dir=..;`, `rmd_dir=docs; to_work_dir=../..;`.

