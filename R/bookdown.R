

#' Title
#'
#' @param name
#' @param url
#'
#' @return
#' @export
#'
#' @examples
gitbook <- function(url, repo = NULL) {
    if (is.null(repo)) repo = basename(url) %>% paste0('.gitbook');

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
    if (file.exists('_output.yaml'))
    	this_gitbook <- get_gitbook('_output.yaml')
    else
    	this_gitbook <- list();
    #" merge options
    gitbook <- author_gitbook %>%
    	rmarkdown:::merge_output_options(common_gitbook) %>%
    	rmarkdown:::merge_output_options(this_gitbook)
    #" some tasks more complicated than simply override
    gitbook$css %<>% c('bookdown.css');
    gitbook$config$toc$before %<>% c(paste0('<li><a href="https://github.com/dongzhuoer/', repo, '/archive/master.zip">download (unzip, open index.html)</a></li>'), .);
    gitbook$config$toc$before %<>% c(paste0('<li><a href="', url, '">original book</a></li>'), .);

    #" to do: offline version
    # print(gitbook);

    #book_name <- basename(input_dir);

	do.call(bookdown::gitbook, gitbook);
}

# zhuoerdown::build_gitbook('r-ninja', 'https://bookdown.org/yihui/r-ninja/')
# zhuoerdown::build_gitbook('bookdown-demo', 'zhuoer.netifly.com')
# file.copy(zhuoerdown:::pkg_file('bookdown.css'), 'bookdown.css');

# bookdown::render_book('', zhuoerdown::gitbook('.', 'https://bookdown.org/yihui/r-ninja/'), new_session = T)

