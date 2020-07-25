testthat::context("Testing gitbook")
setwd(here::here(""))  # workspace is reset per file


testthat::test_that("Testing bookdown-demo", {
    testthat::expect_true(T)

    setwd("data-raw/bookdown-demo")
    bookdown::render_book("", make_gitbook("../_output/bookdown-demo.yml", "https://bookdown.org/rstudio/bookdown-demo/"), output_dir = "../../tests/testthat/output/bookdown-demo", new_session = T)
    file.remove("packages.bib")
});


