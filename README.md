
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkgtemp

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/Lightbridge-KS/pkgtemp/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Lightbridge-KS/pkgtemp/actions/workflows/R-CMD-check.yaml)

<!-- badges: end -->

> R Markdown Template for Developing R Package :package:

## Goal

`pkgtemp` contains as series of
[usethis](https://usethis.r-lib.org/index.html) and other commands in an
**R Markdown** that provides a template to *kick-start* your R package
development process. If you want to use **your own template** from
GitHub, this package will facilitate that too.

## Prerequisites

You should be somewhat familiar with how to create R Package. Checkout
these resources to learn more:

-   [**R Packages Book**](https://r-pkgs.org/index.html) by Hadley
    Wickham and Jenny Bryan.

-   [**usethis**](https://usethis.r-lib.org/index.html): a workflow
    package that `pkgtemp` relies on.

(`pkgtemp` assumes that R package is develop in RStudio. If you use
other IDE you may need to adapt your workflow accordingly.)

## Installation

You can install the development version of pkgtemp like so:

``` r
# install.packages("remotes")
remotes::install_github("Lightbridge-KS/pkgtemp")
```

## Templates

-   [**Build Package
    Template:**](./inst/rmarkdown/templates/build/skeleton/skeleton.Rmd)
    contains a set of R functions to run in each step of package
    development.

## Workflow

**Create R Package by:**

``` r
usethis::create_package("~/path/to/yourpkg")
```

**Create R Markdown Template for package development by:**

``` r
pkgtemp::use_pkgbuild_rmd()
```

This will:

-   Create folder `dev/`.

-   Write and open R Markdown file `dev/build.Rmd` (generate locally)

**Go to
[build.Rmd](./inst/rmarkdown/templates/build/skeleton/skeleton.Rmd)**.
You will see 2 types of command in there:

-   **Non-commented commands:** are the command for initial setup. I
    recommend you run at the first visit. They are at the top of R
    Markdown.

-   **Commented commands:** you can choose to run in any order as you
    like.

### Example

``` r
# Create a new package -------------------------------------------------
path <- file.path(tempdir(), "yourpkg")
usethis::create_package(path)
#> ✔ Creating '/var/folders/ry/z9m8k9cs4594pv3458npy1zw0000gn/T/RtmpU7eQdS/yourpkg/'
#> ✔ Setting active project to '/private/var/folders/ry/z9m8k9cs4594pv3458npy1zw0000gn/T/RtmpU7eQdS/yourpkg'
#> ✔ Creating 'R/'
#> ✔ Writing 'DESCRIPTION'
#> Package: yourpkg
#> Title: What the Package Does (One Line, Title Case)
#> Version: 0.0.0.9000
#> Authors@R (parsed):
#>     * First Last <first.last@example.com> [aut, cre] (YOUR-ORCID-ID)
#> Description: What the package does (one paragraph).
#> License: `use_mit_license()`, `use_gpl3_license()` or friends to pick a
#>     license
#> Encoding: UTF-8
#> Roxygen: list(markdown = TRUE)
#> RoxygenNote: 7.1.2
#> ✔ Writing 'NAMESPACE'
#> ✔ Setting active project to '<no active project>'

# only needed since this session isn't interactive
usethis::proj_activate(path)
#> ✔ Setting active project to '/private/var/folders/ry/z9m8k9cs4594pv3458npy1zw0000gn/T/RtmpU7eQdS/yourpkg'
#> ✔ Changing working directory to '/var/folders/ry/z9m8k9cs4594pv3458npy1zw0000gn/T/RtmpU7eQdS/yourpkg/'
.old_wd <- setwd(path) # Only in this example

# Create Rmd Template for PKG Development
pkgtemp::use_pkgbuild_rmd(open = FALSE)
#> ✔ Creating 'dev/'
#> ✔ Writing 'dev/build.Rmd'
#> ✔ Adding '^dev$' to '.Rbuildignore'
#> • Edit 'dev/build.Rmd'
```

## Custom Template

Everyone can have a different package development workflow. This second
approach will allows you to use your default template from a file in
GitHub.

Here how it works:

-   Create your own R Markdown template for building package in Github.
    (for example, mine is
    [here](https://github.com/Lightbridge-KS/workflows-rmd/blob/main/pkgbuild.Rmd))

-   Provide a default GitHub URL where `pkgtemp` will find as your
    remote template. You’ll need to config global option in
    `~/.Rprofile` as follows.

``` r
# To edit `~/.Rprofile`
usethis::edit_r_profile()
```

Copy code below to `~/.Rprofile` and provide your `pkgbuild_url` as URL
to your default template.

``` r
if (interactive() && requireNamespace("pkgtemp", quietly = TRUE)) {

  pkgtemp::set_github_template_url(
    pkgbuild_url = "https://github.com/OWNER/REPO/blob/REF/path/to/default-template.Rmd"
  )
}
```

-   To use your **default template** from GitHub, create R package as
    usual and call the previous function `use_pkgbuild_rmd()` with
    `remote = TRUE`.

``` r
pkgtemp::use_pkgbuild_rmd(remote = TRUE)
```

Alternatively, If you want to use any other GitHub template **just once
in a while**, provides a `url` directly.

``` r
pkgtemp::use_pkgbuild_rmd(url = "https://github.com/OWNER/REPO/blob/REF/path/to/one-off-template.Rmd")
```

------------------------------------------------------------------------

Last updated: 2022-05-03
