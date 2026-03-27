# jnctex

A personal LaTeX template for academic manuscripts, distributed as an R package. Designed for **Pandoc** and **Quarto** workflows. All formatting controlled via YAML front matter — no manual LaTeX editing required.

---

## Installation

```r
# Install
devtools::install_github("jncohen/jnc-tex-template")

# Set up a new project (run from project root in R console)
jnctex::jnc_use()

# Update an existing project after a package upgrade
jnctex::jnc_use(overwrite = TRUE)
```

`jnc_use()` copies `jnctemplate.tex`, `fonts/`, and `default.csl` into the current directory. After running, add to your document YAML:

```yaml
template: jnctemplate.tex
fontpath: fonts/
csl: default.csl
```

**Requirements:** R with `devtools`, plus a standard TeXLive or MiKTeX installation (pdfLaTeX or XeLaTeX). Pandoc ≥ 2.11.

---

## Design Principles

- Engine-agnostic: pdfLaTeX, XeLaTeX, and LuaLaTeX
- Pandoc-native: no preprocessing scripts required
- All options in YAML — stable single-file template
- Versioned via Git tags; filename never changes

---

## Supported Features

### Font Presets

Set via the `fontset` YAML variable. Fonts are bundled with the package; no system installation required under XeLaTeX/LuaLaTeX.

| Value | Body font | Mono | Register |
|---|---|---|---|
| *(unset)* | TeX Gyre Pagella / mathpazo | — | Default |
| `humanities` | EB Garamond | — | Theory, AJS, *Sociological Theory* |
| `demography` | XITS (Times-family) | — | Quant, *Demography*, *Social Forces* |
| `methods` | Source Serif 4 | Fira Code | Computational, *SMR*, CS venues |

pdfLaTeX fallbacks use TeX distribution packages (`mathpazo`, `tgtermes`). Graceful degradation with `\PackageWarning` if fonts are unavailable.

### Toggleable Modes

| Variable | Effect |
|---|---|
| `anonymize` | Suppress author, date, acknowledgements for blind review |
| `doublespace` | Double spacing (default: 1.5×) |
| `linenumbers` | Enable line numbers |
| `maincolumns` | `1` or `2`; two-column body with auto-revert to single column for references |
| `numbersections` | Toggle section numbering |
| `runningtitle` | Right-justified running header text |
| `surname` | If set, header renders as `Surname: Running Title` |

### Complete YAML Header

```yaml
---
title: "My Manuscript Title"
subtitle: "An Optional Subtitle"
date: "March 2026"
surname: "Cohen"
runningtitle: "Short Running Title"
fontset: humanities

author:
  - name: "Jane Doe"
    department: "Department of Sociology"
    institution: "University X"
    address: "123 Main Street"
    city: "New York, NY"
    zip: "10001"
    country: "USA"
    email: "jane@university.edu"
    web: "[jane.example.edu](https://jane.example.edu)"
    orcid: "0000-0000-0000-0001"
  - name: "John Smith"
    department: "Department of Economics"
    institution: "University Y"
    email: "jsmith@university.edu"
    orcid: "0000-0000-0000-0002"

abstract: |
  This paper examines... [150–250 words recommended]

keywords:
  - sociology
  - quantitative methods
  - open science

acknowledgements: |
  The authors thank... Funding provided by...

bibliography: references.bib
csl: default.csl
template: jnctemplate.tex
fontpath: fonts/

anonymize: false
doublespace: false
linenumbers: false
numbersections: false
maincolumns: 1
---
```

**Author field reference:**

| Field | Required | Notes |
|---|---|---|
| `name` | Yes | Rendered in bold |
| `department` | No | Printed below name |
| `institution` | No | Printed below department |
| `affiliation` | No | Legacy single-string fallback |
| `address` | No | Street address |
| `city` | No | Combined with `zip` and `country` on one line |
| `zip` | No | — |
| `country` | No | — |
| `email` | No | Rendered in monospace |
| `web` | No | Markdown link syntax: `[label](url)` |
| `orcid` | No | Displayed as plain text |

The `bibliography` field points to your `.bib` file (relative to the source document). `default.csl` (bundled) uses author-date format. To use a different style, replace with any CSL file from the [Zotero CSL repository](https://www.zotero.org/styles).

---

## Usage

### Quarto

```yaml
format:
  pdf:
    template: jnctemplate.tex
    fontpath: fonts/
    csl: default.csl
```

### R Markdown

```yaml
output:
  pdf_document:
    template: jnctemplate.tex
fontpath: fonts/
csl: default.csl
```

### Pandoc CLI

```bash
pandoc paper.md \
  --template=jnctemplate.tex \
  --csl=default.csl \
  --bibliography=references.bib \
  --pdf-engine=xelatex \
  -V fontpath=fonts/ \
  -o paper.pdf
```

---

## Typography

Default layout: 1-inch margins, 1.5× spacing, 12pt base, Palatino-family serif. Override via `fontset:` for journal-register-specific typography (see Font Presets above).

- Deterministic float spacing
- Auto-scaled images
- Bold small captions
- Structured section hierarchy via `titlesec`
- `longtable` support for Pandoc-generated tables

---

## Bibliography: Supported Source Types

The bundled `default.csl` handles modern source types that standard styles format poorly. Set the Zotero item type as follows:

| Source | Zotero Item Type | Notes |
|---|---|---|
| Journal article | Journal Article | DOI shown automatically |
| Book | Book | — |
| Book chapter | Book Section | — |
| Dissertation / thesis | Thesis | Set Type field (PhD, MA, etc.) |
| Technical / institutional report | Report | Set Type and Report Number |
| Preprint / working paper | Manuscript | Set Genre: "Working Paper", "Preprint", etc. |
| Research dataset | Dataset | Set Version and Publisher (repository) |
| R package / software | Software | Set Version; Publisher = CRAN or GitHub |
| Blog post | Blog Post | Set Accessed date |
| Social media post | Forum Post | Set container-title to platform name |
| YouTube video / podcast | Video Recording | Set Genre: [Video] or [Podcast episode] |
| Conference presentation | Presentation | — |
| Web page | Web Page | Set Accessed date |

### R Packages in Zotero (Software type)

| Zotero Field | Value |
|---|---|
| Title | Package name: e.g. `ggplot2` |
| Author | Authors from `DESCRIPTION` |
| Version | From CRAN or `packageVersion()` |
| Date | Release date of version cited |
| Company | `CRAN` or `GitHub` |
| URL | `https://cran.r-project.org/package=...` |
| Accessed | Date retrieved |

Renders as: *Author, A. (Year). Title (Version x.x) [Computer software]. Publisher. URL*

---

## Non-R Installation (shell)

For users without R, `install.sh` copies the template from a local clone:

```bash
bash install.sh                          # installs to ~/Templates/jnc-tex/
JNC_TEMPLATE_DIR=/custom/path bash install.sh
```

`fetch-template.sh` pulls the latest version directly from GitHub:

```bash
bash fetch-template.sh
JNC_BRANCH=v1.0.0 bash fetch-template.sh   # pin to a release tag
```

---

## Scope

Intended for empirical articles, working papers, and blind review submissions. Not a replacement for journal-specific `.cls` files where required.
