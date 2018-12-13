testthat::context("Testing gitbook")
if (basename(getwd()) == 'testthat') setwd('../..')  # workspace is reset per file


testthat::test_that("Testing bookdown-demo", {
    testthat::expect_true(T)
    
    setwd('data-raw/bookdown-demo')
    bookdown::render_book('', make_gitbook('https://bookdown.org/rstudio/bookdown-demo/', '../_output-bookdown-demo.yaml'), output_dir = '../../tests/testthat/output/bookdown-demo', new_session = T)
    file.remove('packages.bib')
});


