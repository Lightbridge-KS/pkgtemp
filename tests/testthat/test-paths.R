

test_that("pkgtemp_paths() works", {

  paths_ls <- pkgtemp_paths()
  expect_true(file.exists(paths_ls$path_build_rmd))


})
