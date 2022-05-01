



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
#'
#' @return A path to newly created file.
#' @export
#'
#' @examples
#' \dontrun{
#' # Write `dev/build.Rmd` and open for edit
#' use_pkgbuild_rmd()
#' }
use_pkgbuild_rmd <- function(overwrite = FALSE,
                             open = rlang::is_interactive()
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
    dest_path <- copy_build_rmd(dest)
  } else {
    ## Not has dir
    dir_create_dev(d)
    dest_path <- copy_build_rmd(dest)
  }
  # Ignore
  ## Add `^dev$` to build ignore
  usethis::use_build_ignore(d)
  # Edit file
  usethis::edit_file(dest, open = open)
  # Return path to newly created file
  invisible(dest_path)
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

# Copy Build --------------------------------------------------------------



#' Copy build.rmd to destination
#'
#' overwrite the existing file.
#'
#' @param dest destination to copy
#'
#' @return path of destination and write usethis UI to console
#' @noRd
copy_build_rmd <- function(dest = "dev/build.Rmd") {

  is_success <- file.copy(
    from = pkgtemp_paths()[["path_build_rmd"]],
    to = dest,
    overwrite = TRUE
  )

  stopifnot(is_success)
  usethis::ui_done("Writing {usethis::ui_value(dest)}")
  dest

}
