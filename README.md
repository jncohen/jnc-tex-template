# jnc-tex-template

A customizable LaTeX template for academic manuscripts with Pandoc
compatibility and toggleable formatting modes.

This template is designed for use with **Pandoc** or **Quarto**
workflows and supports modular formatting controls for common submission
contexts (journal articles, working papers, blind review drafts).

------------------------------------------------------------------------

## Design Principles

-   Engine-agnostic (pdfLaTeX / XeLaTeX / LuaLaTeX)
-   Pandoc-native
-   Minimal visual styling assumptions
-   Explicit toggle controls
-   Version-controlled evolution
-   Stable filename, versioned via Git tags

This repository is intended as formatting infrastructure, not a full
document class replacement.

------------------------------------------------------------------------

## Supported Features

### Toggleable Modes (via YAML)

  Variable           Effect
  ------------------ -------------------------------------------------
  `titlepage`        Use dedicated title page vs `\maketitle`
  `blind`            Anonymize author block (for review submissions)
  `anonymize`        Suppress identifying metadata and review-sensitive sections
  `doublespace`      Double spacing (else 1.5 spacing)
  `linenumbers`      Enable line numbers
  `numbersections`   Toggle section numbering
  `maincolumns`      Set body text columns (`1` or `2`)
  `runningtitle`     Set short running header text

Example:

``` yaml
titlepage: true
blind: false
anonymize: false
doublespace: false
linenumbers: false
numbersections: true
maincolumns: 1
runningtitle: "Short Running Title"
```

### Title Page Metadata

The template supports richer title-page metadata from Pandoc/Quarto
author objects. For each author you can include:

- `name`
- `affiliation`
- `email`
- `orcid`
- `address`
- `web` (or `url`)

It also supports top-level `date` and `subtitle`.

Example:

```yaml
title: "My Manuscript"
subtitle: "An optional subtitle"
date: "2026-02-22"
runningtitle: "My Manuscript"
titlepage: true
maincolumns: 2
anonymize: false
author:
  - name: "Jane Doe"
    affiliation: "Department of Economics, University X"
    email: "jane@university.edu"
    orcid: "0000-0000-0000-0000"
    address: "123 Academic Way, City, Country"
    web: "https://janedoe.example"
```

When `anonymize: true`, identifying fields are replaced/suppressed in
the rendered front matter and acknowledgements are hidden.


------------------------------------------------------------------------

## Usage (Quarto)

``` yaml
format:
  pdf:
    template: jnctemplate.tex
```

------------------------------------------------------------------------

## Usage (Pandoc CLI)

``` bash
pandoc paper.md   --template=jnctemplate.tex   -o paper.pdf
```

------------------------------------------------------------------------

## Typography and Layout

-   Palatino-style typography (`mathpazo` / `TeX Gyre Pagella`)
-   1-inch margins
-   Controlled float density
-   Scaled images to prevent overflow
-   Structured `longtable` handling
-   Bold, small captions
-   Clean section hierarchy via `titlesec`


------------------------------------------------------------------------

## Intended Scope

This template is designed for:

-   Empirical research articles
-   Quantitative manuscripts
-   Software-method papers
-   Working papers
-   Blind review submissions

It is not intended to replace journal-specific `.cls` files where
required.


