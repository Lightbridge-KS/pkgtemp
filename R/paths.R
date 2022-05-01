#' Return list of paths in pkgtemp
#'
#' @return
#' @noRd
pkgtemp_paths <- function() {

  path_build_rmd <- system.file(
    "rmarkdown/templates/build/skeleton/skeleton.Rmd",
    package = "pkgtemp", mustWork = TRUE
  )

  list(
    path_build_rmd = path_build_rmd
  )
}
