

#' @title rebuild your favorite book with custom tuning
#'
#' @param url string. url of the original book.
#' @param output_format_file string. path to the custom `_output.yaml` file.
#' @param download_link string. the url of the compressed file of latest book.
#'
#' @return list. Customized [bookdown::gitbook()], a R Markdown output format.
#' @export
#'
#' @examples
#' NULL
make_gitbook <- function(output_format_file = NULL, url = "https://example.com", download_link = "https://example.com") {
    get_gitbook_arg <- function(path){yaml::yaml.load_file(path)[["bookdown::gitbook"]]};

    #" the gitbook format by the author of the original book
    if (file.exists("_output.yml"))
      author_gitbook_arg <- get_gitbook_arg("_output.yml")
    else if (file.exists("_output.yaml"))
      author_gitbook_arg <- get_gitbook_arg("_output.yaml")
    else
      author_gitbook_arg <- list();
    #" Zhuoer Dong's cherished gitbook format
    common_gitbook_arg <- get_gitbook_arg(pkg_file("_output.yml"))
    #" Zhuoer Dong's adjustment for this particular book
    current_gitbook_arg <- if (is.null(output_format_file)) list() else get_gitbook_arg(output_format_file)
    #" merge options
    final_gitbook_arg <- author_gitbook_arg %>%
    	rmarkdown:::merge_output_options(common_gitbook_arg) %>%
    	rmarkdown:::merge_output_options(current_gitbook_arg)
    #" some tasks more complicated than simply override
    final_gitbook_arg$css %<>% c("bookdown.css");
    final_gitbook_arg$config$toc$before %<>% c(paste0('<li><a href="', download_link, '">download (unzip, open index.html)</a></li>'), .);
    final_gitbook_arg$config$toc$before %<>% c(paste0('<li><a href="', url, '">original book</a></li>'), .);

    do.call(bookdown::gitbook, final_gitbook_arg);
}
