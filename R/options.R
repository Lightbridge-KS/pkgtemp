#' Set Github Template URL
#'
#' @description You can use your own template from GitHub.
#' Provide URL to your template file in GitHub to argument in this function.
#'
#' @param pkgbuild_url A string identifying a GitHub file URL for "Build Package" template
#'
#' @return a list of all `pkgtemp` options sorted by name.
#' @export
#'
#' @examples
set_github_template_url <- function(pkgbuild_url = NULL) {

  options("pkgtemp.pkgbuild_url" = pkgbuild_url)

}


#' Get Github Template URL from Option
#'
#' If no specified option is set, ERROR
#'
#' @param type type of template URL
#'
#' @return A URL
#' @noRd
get_github_template_url <- function(type = c("pkgbuild_url")) {

  type <- match.arg(type)
  url <- switch (type,
    "pkgbuild_url" = { getOption("pkgtemp.pkgbuild_url") }
  )

  if(is.null(url)) {
    usethis::ui_stop("Please set '{type}' via {usethis::ui_code('set_github_template_url()')}")
  }
  url

}
