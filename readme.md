# zhuoerdown

## Overview

library files for Zhuoer Dong's *down projects


```r
readr::read_lines('_bookdown.yml') %>% 
    stringr::str_replace('^  "model-building.Rmd"', '#  "model-building.Rmd"') %>% 
    readr::write_lines('_bookdown.yml')

gitbook <- yaml::yaml.load_file('_output.yaml')$`bookdown::gitbook`;
gitbook$css %<>% c(zhuoerdown::gitbook$css);
gitbook$highlight = zhuoerdown::gitbook$highlight;
gitbook$split_by = 'section+number';
gitbook$config$toc$before = '<li><a href="http://r4ds.had.co.nz/">R for Data Science</a></li>';
gitbook$config$toc$after = zhuoerdown::gitbook$config$toc$after;
gitbook$config$sharing = zhuoerdown::gitbook$config$sharing;
gitbook$config$fontsettings$theme = zhuoerdown::gitbook$config$fontsettings$theme;

bookdown::render_book(
    '', do.call(bookdown::gitbook, gitbook), new_session = T, 
    output_dir = paste0(Sys.getenv('W'), '/GitHub/dongzhuoer/bookdown.zhuoer/r4ds'));

```


