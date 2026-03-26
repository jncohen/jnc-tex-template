# =============================================================================
# update-template.R
#
# NOTE: If you installed jctex via devtools::install_github(), the preferred
# update path is:
#   devtools::install_github("jncohen/jnc-tex-template")
#   jnctex::jnc_use(overwrite = TRUE)
#
# The jnc_update() function below is for non-package (manual) installs only.
#
# R equivalent of fetch-template.sh.  Downloads the latest jnctemplate.tex,
# default.csl, and all font files from GitHub.
#
# Usage (from R or RStudio):
#   source("update-template.R")
#   jnc_update()                          # update ~/Templates/jnc-tex/
#   jnc_update(dest = "path/to/dir")      # custom destination
#   jnc_update(branch = "v1.0.0")         # pin to a specific tag/release
#
# Add jnc_update() to .Rprofile for automatic updates:
#   cat('source("~/Templates/jnc-tex/update-template.R")\n',
#       file = "~/.Rprofile", append = TRUE)
# =============================================================================

jnc_update <- function(
  dest   = file.path(Sys.getenv("JNC_TEMPLATE_DIR",
                                unset = file.path("~", "Templates", "jnc-tex"))),
  branch = Sys.getenv("JNC_BRANCH", unset = "main")
) {
  dest   <- normalizePath(dest, mustWork = FALSE)
  base   <- paste0("https://raw.githubusercontent.com/jncohen/jnc-tex-template/",
                   branch)

  dir.create(file.path(dest, "fonts"), recursive = TRUE, showWarnings = FALSE)

  fetch <- function(path, local_name = basename(path)) {
    url   <- paste0(base, "/", path)
    local <- file.path(dest, local_name)
    message("  ", basename(url), " -> ", local)
    tryCatch(
      download.file(url, local, quiet = TRUE, mode = "wb"),
      error = function(e) warning("Failed to download ", url, ": ", conditionMessage(e))
    )
  }

  message("Fetching jnc-tex-template (", branch, ") to: ", dest)

  # Core files
  fetch("inst/templates/jnctemplate.tex", "jnctemplate.tex")
  fetch("inst/csl/default.csl",           "default.csl")

  # EB Garamond (humanities preset)
  message("Fetching EB Garamond fonts...")
  for (f in c("EBGaramond-Regular.otf", "EBGaramond-Bold.otf",
               "EBGaramond-Italic.otf", "EBGaramond-BoldItalic.otf")) {
    fetch(paste0("inst/fonts/", f), file.path("fonts", f))
  }

  # XITS (demography preset)
  message("Fetching XITS fonts...")
  for (f in c("XITS-Regular.otf", "XITS-Bold.otf",
               "XITS-Italic.otf", "XITS-BoldItalic.otf")) {
    fetch(paste0("inst/fonts/", f), file.path("fonts", f))
  }

  # Source Serif 4 (methods preset, body)
  message("Fetching Source Serif 4 fonts...")
  for (f in c("SourceSerif4-Regular.otf", "SourceSerif4-Bold.otf",
               "SourceSerif4-It.otf", "SourceSerif4-BoldIt.otf")) {
    fetch(paste0("inst/fonts/", f), file.path("fonts", f))
  }

  # Fira Code (methods preset, monospace)
  message("Fetching Fira Code fonts...")
  for (f in c("FiraCode-Regular.ttf", "FiraCode-Bold.ttf")) {
    fetch(paste0("inst/fonts/", f), file.path("fonts", f))
  }

  message("\nUpdate complete. Add to your document YAML:")
  message("  template: ", file.path(dest, "jnctemplate.tex"))
  message("  csl: ",      file.path(dest, "default.csl"))
  message("  fontpath: ", file.path(dest, "fonts"), "/")
  invisible(dest)
}
