
test_that("find_packages recognizes different library call variants", {

  packs <- find_packages(dirname(system.file("package-test.R", package = "abmisc")))

  expect_equal(
    paste0("pack", 1:4),
    packs
  )

})
