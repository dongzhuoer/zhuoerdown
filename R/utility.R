#' @title get files in the package
pkg_file <- function(..., mustWork = TRUE) {
    system.file(..., package = 'zhuoerdown', mustWork = mustWork)
}