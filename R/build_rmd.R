



#' Create R Markdown Template for Building Package
#'
#' @description Create R Markdown file which contains functions
#' to use in R package development process. [use_pkgbuild_rmd()] will:
#'
#' * Create `dev/build.Rmd` relative to the package root
#' * Add `^dev$` to `.Rbuildignore`
#' * Open `build.Rmd` for editing
#'
#' @param overwrite If `dev/build.Rmd` already exist, `TRUE`
#' to overwrite an existing file, `FALSE` to throw an error.
#' @param open Whether to open the file for interactive editing.
#' @param download_gh If `FALSE` use local template.
#' If `TRUE` use GitHub template, you need to set GitHub URL which contains file
#' to download from using [set_github_template_url()].
#'
#' @return A path to newly created file.
#'
#' @seealso
#' * [set_github_template_url()]: for setting GitHub URL to download your own template file
#'
#' @export
#'
#'
#' @examples
#' \dontrun{
#' # Write `dev/build.Rmd` and open for edit
#' use_pkgbuild_rmd()
#' }
use_pkgbuild_rmd <- function(overwrite = FALSE,
                             open = rlang::is_interactive(),
                             download_gh = FALSE
) {

  d <- "dev/"; f <- "build.Rmd"
  dest <- paste0(d, f)

  has_file <- file.exists(dest)
  has_dir <- dir.exists(d)

  if (!overwrite && has_file) {
    ## Not overwrite and has file: error
    usethis::ui_stop("{usethis::ui_value(dest)} already exist, \\
                       to overwrite set \\
                       {usethis::ui_code('overwrite = TRUE')}")
  }

  if (has_dir) {
    ## (Has dir + has file + overwrite) or (Has dir + no file)
    get_pkgbuild_rmd(download_gh = download_gh)
  } else {
    ## Not has dir
    dir_create_dev(d)
    get_pkgbuild_rmd(download_gh = download_gh)
  }
  # Ignore
  ## Add `^dev$` to build ignore
  usethis::use_build_ignore(d)
  # Edit file
  usethis::edit_file(dest, open = open)
  # Return path to newly created file
  invisible(dest)
}




# Get Build ---------------------------------------------------------------

#' Get pkgbuild template by download or copy from Local
#'
#' @param download_gh
#'
#' @return logical if operation success
#' @noRd
get_pkgbuild_rmd <- function(download_gh = FALSE) {

  if (download_gh) {

    dl_pkgbuild_rmd()

  } else {

    cp_pkgbuild_rmd()

  }

}

# Download Build ----------------------------------------------------------

#' Download File from Github URL
#'
#' @param dest destination to save
#'
#' @return logical whether success
#' @noRd
dl_pkgbuild_rmd <- function(dest = "dev/build.Rmd") {

  url <- get_github_template_url("pkgbuild_url")

  is_success <- usethis::use_github_file(
    repo_spec = url,
    save_as = dest
  )

  is_success
}

# Copy Build --------------------------------------------------------------



#' Copy build.rmd to destination
#'
#' overwrite the existing file.
#'
#' @param dest destination to copy
#'
#' @return logical if operation success
#' @noRd
cp_pkgbuild_rmd <- function(dest = "dev/build.Rmd") {

  is_success <- file.copy(
    from = pkgtemp_paths()[["path_build_rmd"]],
    to = dest,
    overwrite = TRUE
  )

  stopifnot(is_success)
  usethis::ui_done("Writing {usethis::ui_value(dest)}")
  is_success

}

# Create Dev --------------------------------------------------------------



#' Create dev/
#'
#' display usethis UI to console
#'
#' @param dir dir to create
#'
#' @return
#' @noRd
dir_create_dev <- function(dir = "dev/") {

  is_success  <- dir.create(dir)

  if(is_success) {
    usethis::ui_done("Creating {usethis::ui_value(dir)}")
  }
}

