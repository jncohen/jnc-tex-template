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
  `anonymize`        Suppress all identifying metadata (authors, date, acknowledgements) for blind review
  `doublespace`      Double spacing (else 1.5 spacing)
  `linenumbers`      Enable line numbers
  `numbersections`   Toggle section numbering
  `maincolumns`      Set body text columns (`1` or `2`)
  `runningtitle`     Set short running header text

Example:

``` yaml
anonymize: false
doublespace: false
linenumbers: false
numbersections: true
maincolumns: 1
runningtitle: "Short Running Title"
```

### Complete YAML Header

The following is a full working YAML header illustrating all supported
fields. Place this at the top of your `.md` or `.qmd` source file,
delimited by `---`.

```yaml
---
title: "My Manuscript Title"
subtitle: "An Optional Subtitle"
date: "2026-03-03"
runningtitle: "Short Running Title"

author:
  - name: "Jane Doe"
    affiliation: "Department of Sociology, University X"
    email: "jane@university.edu"
    orcid: "0000-0000-0000-0001"
  - name: "John Smith"
    affiliation: "Department of Economics, University Y"
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

anonymize: false
doublespace: false
linenumbers: false
numbersections: false
maincolumns: 1
---
```

The `bibliography` field points to your `.bib` file (relative path from
the source document). The `csl` field controls citation style; `default.csl`
(bundled) uses author-date format with enhanced support for modern source
types (see below). To use a different style, replace it with any CSL file
from the [Zotero CSL repository](https://www.zotero.org/styles).

### Supported Source Types in `default.csl`

The bundled CSL handles modern source types that standard styles format
poorly or not at all. Set the Zotero item type as follows:

  Source                          Zotero Item Type     Notes
  ------------------------------- -------------------- -------------------------------------------
  Journal article                 Journal Article      DOI shown automatically
  Book                            Book                 —
  Book chapter                    Book Section         —
  Dissertation / thesis           Thesis               Set Type field (PhD, MA, etc.)
  Technical / institutional report Report              Set Type and Report Number
  Preprint / working paper        Manuscript           Set Genre: "Working Paper", "Preprint", etc.
  Research dataset                Dataset              Set Version and Publisher (repository)
  R package / software            Software             Set Version; Publisher = CRAN or GitHub
  Blog post                       Blog Post            Set Accessed date for retrieval statement
  Social media post               Forum Post           Set container-title to platform name
  YouTube video / podcast         Video Recording      Set Genre: [Video] or [Podcast episode]
  Conference presentation         Presentation         —
  General web page                Web Page             Set Accessed date for retrieval statement

When `anonymize: true`, all identifying fields — authors, date,
acknowledgements — are suppressed from the rendered title page.

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
pandoc paper.md --template=jnctemplate.tex -o paper.pdf
```

------------------------------------------------------------------------

## Typography and Layout

-   Palatino-style typography (`mathpazo` / `Latin Modern Roman` for XeLaTeX/LuaLaTeX)
-   1-inch margins
-   1.5 spacing default (double spacing optional)
-   Deterministic float spacing (`intextsep`, `textfloatsep`)
-   Scaled images to prevent overflow
-   Structured `longtable` handling
-   Bold, small captions
-   Clean section hierarchy via `titlesec` (section / subsection / subsubsection)

------------------------------------------------------------------------

## Intended Scope

This template is designed for:

-   Empirical research articles
-   Quantitative manuscripts
-   Working papers
-   Blind review submissions

It is not intended to replace journal-specific `.cls` files where
required.
