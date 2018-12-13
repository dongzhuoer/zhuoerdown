testthat::context("Testing gitbook")
if (basename(getwd()) == 'testthat') setwd('../..')  # workspace is reset per file



testthat::test_that("Testing r-ninja", {
    testthat::skip_if_not_installed('rmini')
    
    testthat::expect_true(T);

    setwd('data-raw/r-ninja');
    bookdown::render_book('', gitbook('https://bookdown.org/yihui/r-ninja/'), output_dir = '../../tests/testthat/output/r-ninja', new_session = T);
});
