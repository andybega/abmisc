
test_that("find_packages recognizes different library call variants", {

  packs <- find_packages(dirname(system.file("package-test.R", package = "abmisc")))

  # depending on where this is run, "abmisc" and "testthat" will also show up.
  # take those out
  packs <- packs[!packs %in% c("abmisc", "testthat")]

  expect_equal(
    paste0("pack", 1:4),
    packs
  )

})
