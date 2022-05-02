

# pkgbuild ----------------------------------------------------------------



test_that("use_pkgbuild_rmd() can create file", {

  testpkg <- paste(sample(letters, 4), collapse = "")
  # Create testing PKG
  testpkg_path <- file.path(tempdir(), testpkg)
  usethis::create_package(testpkg_path, open = FALSE)
  usethis::proj_activate(testpkg_path)
  .old_wd <- setwd(testpkg_path)

  # Create build.Rmd
  use_pkgbuild_rmd(open = FALSE)
  # Check file
  expect_true(file.exists("dev/build.Rmd"))

  setwd(.old_wd)

})


# Copy Build --------------------------------------------------------------



test_that("cp_pkgbuild_rmd() can copy file", {

  expect_true(cp_pkgbuild_rmd(tempfile(fileext = ".Rmd")))

})


