# zhuoerdown
[![Build Status](https://travis-ci.com/dongzhuoer/zhuoerdown.svg?branch=master)](https://travis-ci.com/dongzhuoer/zhuoerdown)



## Overview

build others' bookdown book in Zhuoer Dong's preference



## Installation

```r
if (!('remotes' %in% .packages(T))) install.packages('remotes');
remotes::install_github('dongzhuoer/zhuoerdown');
```



## Why this package

bookdown 好，书多，free。中国网速慢，界面不喜欢。可离线的 zip



## Usage

You may find it cool and desire to similar thing. Unfortunately mainly 我个人使用

quick： 懂 travis，定制 _output.yaml 和 global: env: 

or you are willing to learn it after 


## Features

- add [bookdown.css](https://github.com/dongzhuoer/zhuoerdown/blob/master/inst/bookdown.css)
- add several links in TOC
- customize output by [_output.yaml](https://github.com/dongzhuoer/zhuoerdown/blob/master/inst/_output.yaml), then by user provided `_output.yaml` (in `extra/`)
