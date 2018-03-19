context("Testing gitbook")


setwd('../../data-raw/bookdown-demo');

test_that("Testing bookdown-demo", {
    bookdown::render_book('', zhuoerdown::gitbook('https://bookdown.org/rstudio/bookdown-demo/'), new_session = T);
    expect_true(T);
});



setwd('../../data-raw/r-ninja');

test_that("Testing r-ninja", {
    bookdown::render_book('', zhuoerdown::gitbook('https://bookdown.org/yihui/r-ninja/'), new_session = T);
    expect_true(T);
});
