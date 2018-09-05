

#' @title rebuild your favorite book with custom tuning
#'
#' @param url string. url of the original book
#' @param custom_format string. path to the custom `_output.yaml` file
#' @param download_link string. the url of the compressed file of latest book. if `NULL`, will use zhuoer's GitLab, repository name deduced from `url`
#'
#' @return
#' @export
#'
#' @examples
gitbook <- function(url, custom_format = NULL, download_link = NULL) {
    if (is.null(download_link)) download_link = basename(url) %>% paste0('https://gitlab.com/dongzhuoer/', ., '.gitbook/repository/master/archive.zip');

    get_gitbook <- function(path){yaml::yaml.load_file(path)[['bookdown::gitbook']]};

    #" the gitbook format by the author of the original book
    if (file.exists('_output.yml'))
      author_gitbook <- get_gitbook('_output.yml')
    else if (file.exists('_output.yaml'))
      author_gitbook <- get_gitbook('_output.yaml')
    else
      author_gitbook <- list();
    #" Zhuoer Dong's cherished gitbook format
    common_gitbook <- get_gitbook(pkg_file('_output.yaml'))
    #" Zhuoer Dong's adjustment for this particular book
    this_gitbook <- if (is.null(custom_format)) list() else get_gitbook(custom_format)
    #" merge options
    gitbook <- author_gitbook %>%
    	rmarkdown:::merge_output_options(common_gitbook) %>%
    	rmarkdown:::merge_output_options(this_gitbook)
    #" some tasks more complicated than simply override
    gitbook$css %<>% c('bookdown.css');
    gitbook$config$toc$before %<>% c(paste0('<li><a href="', download_link, '">download (unzip, open index.html)</a></li>'), .);
    gitbook$config$toc$before %<>% c(paste0('<li><a href="', url, '">original book</a></li>'), .);

	do.call(bookdown::gitbook, gitbook);
}

# setwd('data-raw/bookdown-demo')
# bookdown::render_book('', gitbook('.'), new_session = T)
# bookdown::render_book('', gitbook('.', '../_output.yaml'), new_session = T)

# setwd('data-raw/r-ninja')
# bookdown::render_book('', gitbook('https://bookdown.org/yihui/r-ninja/'), new_session = T)

# setwd('../..')
