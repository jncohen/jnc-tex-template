# jnctex

A personal LaTeX template for academic manuscripts, distributed as an R package. Designed for **R Markdown** workflows. All formatting is controlled via YAML front matter — no manual LaTeX editing required.

---

## Contents

1. [Prerequisites](#1-prerequisites)
2. [Installation](#2-installation)
3. [Project setup](#3-project-setup)
4. [Your first document](#4-your-first-document)
5. [Font presets and layout](#5-font-presets-and-layout)
6. [Title page and author block](#6-title-page-and-author-block)
7. [Writing body text](#7-writing-body-text)
8. [Citations and bibliography](#8-citations-and-bibliography)
9. [Tables](#9-tables)
10. [Figures](#10-figures)
11. [Preparing for submission](#11-preparing-for-submission)
12. [Journal-style mode](#12-journal-style-mode)
13. [Quick reference: all YAML variables](#13-quick-reference-all-yaml-variables)
14. [Bibliography: supported source types](#14-bibliography-supported-source-types)
15. [Non-R installation](#15-non-r-installation)

---

## 1. Prerequisites

You need three things installed before using this template.

**R and RStudio.** If you are reading this you almost certainly have both. R ≥ 4.0 and a recent RStudio are sufficient.

**A TeX distribution.** LaTeX does the actual typesetting. Install one of the following:

- **macOS** — [MacTeX](https://www.tug.org/mactex/) (full install, ~5 GB) or `tinytex::install_tinytex()` in R (lightweight, installs on demand)
- **Windows** — [MiKTeX](https://miktex.org/) or `tinytex::install_tinytex()`
- **Linux** — `sudo apt install texlive-full` (Debian/Ubuntu) or equivalent

TinyTeX is the easiest option if you are starting fresh:

```r
install.packages("tinytex")
tinytex::install_tinytex()
```

**Pandoc.** RStudio ships with Pandoc. If you compile from the R console outside RStudio, install Pandoc separately from [pandoc.org](https://pandoc.org/installing.html). Pandoc ≥ 2.11 is required.

---

## 2. Installation

Install the package from GitHub using `devtools`:

```r
install.packages("devtools")          # if not already installed
devtools::install_github("jncohen/jnc-tex-template")
```

This installs the R package, which contains the template file, bundled fonts, and the citation style.

---

## 3. Project setup

Open your project in RStudio (or set the working directory to your project folder), then run:

```r
jnctex::jnc_use()
```

This copies three things into your project folder:

| File / folder | What it is |
|---|---|
| `jnctemplate.tex` | The LaTeX template — leave this alone |
| `fonts/` | Bundled OpenType fonts (EB Garamond, XITS, Source Serif 4, Fira Code) |
| `default.csl` | Author-date citation style |

Your project folder will look something like this:

```
my-paper/
├── paper.Rmd          ← your document
├── references.bib     ← your bibliography
├── jnctemplate.tex    ← copied by jnc_use()
├── default.csl        ← copied by jnc_use()
└── fonts/             ← copied by jnc_use()
    ├── EBGaramond-Regular.otf
    ├── XITS-Regular.otf
    └── ...
```

**Updating.** After upgrading the package, re-run `jnc_use(overwrite = TRUE)` to pull in any template changes.

---

## 4. Your first document

Create a new R Markdown file (`paper.Rmd`) with this minimal YAML header:

```yaml
---
title: "My Paper Title"
author:
  - name: "Your Name"
output:
  pdf_document:
    template: jnctemplate.tex
bibliography: references.bib
csl: default.csl
fontpath: fonts/
---
```

Then write your document body in standard R Markdown below the `---`.

**Knitting to PDF.** Click the **Knit** button in RStudio (select "Knit to PDF"), or run from the R console:

```r
rmarkdown::render("paper.Rmd")
```

This produces `paper.pdf` in the same folder. If it is your first compile with TinyTeX and any LaTeX packages are missing, TinyTeX will download them automatically — this takes a minute the first time, then they are cached.

**The `fontpath` variable** tells the template where to find the bundled fonts. `fonts/` works when the `.Rmd` file is in the same folder as the `fonts/` directory. If your document is in a subfolder, adjust the path: `fontpath: ../fonts/`.

---

## 5. Font presets and layout

The `fontset` variable switches between typographic registers matched to common sociology journal styles.

```yaml
fontset: humanities    # EB Garamond — theory, AJS, Sociological Theory
fontset: demography    # XITS (Times-family) — Demography, Social Forces
fontset: methods       # Source Serif 4 + Fira Code — SMR, computational work
# (unset)             # TeX Gyre Pagella (Palatino-family) — default
```

Each preset adjusts the body font, margins, line spacing, and section heading style as a coordinated package. You do not need to tweak individual settings.

| Preset | Body font | Margins | Spacing | Headings |
|---|---|---|---|---|
| *(unset)* | Palatino-family | 1 in | 1.5× | Bold |
| `humanities` | EB Garamond | 1.3 in | 1.55× | Small caps |
| `demography` | XITS / Times | 1 in | 1.5× | Bold + rule |
| `methods` | Source Serif 4 | 0.9 in | 1.25× | Bold + color + rule |

**pdfLaTeX fallback.** The bundled fonts require XeLaTeX or LuaLaTeX, which R Markdown uses by default when the fonts are present. If you are using pdfLaTeX for some reason, the template falls back gracefully to TeX distribution fonts and emits a warning in the log.

**Spacing override.** To force double spacing regardless of preset (common for journal submission):

```yaml
doublespace: true
```

---

## 6. Title page and author block

The template generates a full title page from YAML. All fields are optional except `title`.

```yaml
---
title: "The Organizational Basis of Wage Inequality"
subtitle: "Evidence from Linked Employer-Employee Data"
date: "April 2026"

surname: "Cohen"
runningtitle: "Organizational Basis of Wage Inequality"

author:
  - name: "Joseph N. Cohen"

author_dept:  "Department of Sociology"
author_inst:  "Queens College, City University of New York"
author_addr:  "65-30 Kissena Blvd., Queens, NY 11367, USA"
author_email: "joseph.cohen@qc.cuny.edu"
author_web:   "https://jncohen.commons.gc.cuny.edu"
author_orcid: "0000-0002-6197-4453"

abstract: |
  This paper examines how organizational characteristics shape
  wage determination. Using linked employer-employee data...
  [150–250 words recommended]

keywords:
  - wage inequality
  - organizations
  - economic sociology

acknowledgements: |
  The author thanks... Data provided by...
---
```

**Running header.** The right-side running header renders as `Surname: Running Title` when both `surname` and `runningtitle` are set, `Running Title` alone when only `runningtitle` is set, and the document `title` when neither is set.

**Multiple authors.** Add additional `- name:` entries under `author:`. Contact details (`author_dept`, `author_inst`, etc.) appear once below all author names — they are intended for the corresponding author.

```yaml
author:
  - name: "Jane Doe"
  - name: "John Smith"
  - name: "Maria Garcia"
```

**Methods preset title page.** When `fontset: methods`, the title page uses a left-aligned layout with a full-width accent rule, rather than the centered layout used by the other presets.

---

## 7. Writing body text

The document body is standard R Markdown. A few things worth knowing for academic manuscripts.

**Sections.** Use `#` for top-level sections, `##` for subsections, `###` for sub-subsections. By default, sections are unnumbered. To number them:

```yaml
numbersections: true
```

**Section numbering depth** goes to three levels (1.2.3) when `numbersections: true`.

**Paragraphs.** Leave a blank line between paragraphs. First-line indent is applied automatically — do not add manual indentation.

**Emphasis.** `*italics*` and `**bold**`. Use italics for titles and foreign terms; use bold sparingly.

**Footnotes.** Standard Pandoc footnote syntax:

```markdown
This claim requires qualification.^[See the discussion in Smith (2018), who
argues that the relationship is conditional on organizational size.]
```

**Inline R.** knitr evaluates inline R expressions. Use this for reporting statistics so numbers stay in sync with your data:

```markdown
The sample includes `r nrow(df)` respondents across
`r length(unique(df$firm_id))` firms.
```

**Two-column layout.** For a two-column body (uncommon in sociology but used in some venues):

```yaml
maincolumns: 2
```

The bibliography automatically reverts to a single column.

---

## 8. Citations and bibliography

Citations are handled by Pandoc's built-in citation processor (citeproc) using your `.bib` file and a CSL style file. No BibTeX or biber compilation step is needed.

### Setting up your bibliography file

Create a `references.bib` file in your project folder. If you use **Zotero**, export your library (or a collection) using Better BibTeX: right-click → Export Collection → Better BibTeX → keep file updated. The exported `.bib` file stays in sync as you add sources.

Point the template at your bibliography in the YAML header:

```yaml
bibliography: references.bib
csl: default.csl
```

The bundled `default.csl` produces author-date citations in a Chicago-derived format extended to cover modern source types (datasets, software, preprints). To use a different style, replace `default.csl` with any `.csl` file from the [Zotero style repository](https://www.zotero.org/styles).

### In-text citations

Pandoc uses `@key` syntax for citations, where `key` is the BibTeX key in your `.bib` file.

| Markdown | Output |
|---|---|
| `@smith2020` | Smith (2020) |
| `[@smith2020]` | (Smith 2020) |
| `[@smith2020, p. 45]` | (Smith 2020, p. 45) |
| `[@smith2020; @jones2018]` | (Smith 2020; Jones 2018) |
| `[-@smith2020]` | (2020) — suppresses author name |

**RStudio visual editor.** If you use RStudio's visual markdown editor, use Insert → Citation to search Zotero or DOI directly without typing BibTeX keys by hand.

### Where the bibliography appears

Pandoc automatically appends the bibliography at the end of the document body. You do not need to add any special command or section header — the References heading is generated automatically.

To force a page break before the references section, add this at the end of your document body:

```markdown
\clearpage
```

Or place the bibliography under a manual heading by adding this at the very end of your `.Rmd`:

```markdown
# References
```

Pandoc will place the bibliography under that heading rather than appending a new one.

### Citation keys and Zotero

Better BibTeX's default key format (`[auth:lower][year][title:lower:keepfirst:nopunct]`) produces readable, consistent keys. Set your preferred format in Zotero → Edit → Preferences → Better BibTeX → Citation key formula.

---

## 9. Tables

Tables are the area that requires the most care, especially when preparing for journal submission.

### Basic markdown tables

For simple tables you can write them directly in markdown:

```markdown
| Variable | Mean | SD | N |
|---|---:|---:|---:|
| Log wage | 2.84 | 0.61 | 4,210 |
| Tenure (years) | 6.3 | 5.1 | 4,210 |
| Firm size (log) | 4.7 | 1.8 | 4,210 |

: Descriptive statistics
```

Pandoc converts markdown tables to `longtable` environments in LaTeX.

### knitr tables with `knitr::kable()`

For tables generated from R objects, `knitr::kable()` is the standard approach:

````markdown
```{r desc-table, echo=FALSE}
knitr::kable(
  summary_table,
  format    = "latex",
  booktabs  = TRUE,
  caption   = "Descriptive statistics",
  col.names = c("Variable", "Mean", "SD", "N"),
  digits    = 2
)
```
````

By default, `knitr::kable()` with `format = "latex"` produces a `longtable` environment. The template automatically applies `footnotesize` font and single spacing to all `longtable` environments.

### Tables for journal submission

Journal submission requires tables to appear **after the references**, with `[Insert Table N about here]` markers in the text body. This requires two things: enabling `journal_style` mode and generating tables as `table` float environments rather than `longtable`.

The critical setting is `longtable = FALSE`:

```r
knitr::kable(
  summary_table,
  format    = "latex",
  booktabs  = TRUE,
  longtable = FALSE,      # produces a table float, not longtable
  caption   = "Descriptive statistics."
)
```

With `longtable = FALSE`, knitr wraps the table in a `\begin{table}...\end{table}` float. When `journal_style: true`, the `endfloat` package defers these to after the bibliography and replaces them with bold centered markers in the text. See [§ 12](#12-journal-style-mode) for the full workflow.

### kableExtra for styled tables

The `kableExtra` package extends `knitr::kable()` with additional formatting:

```r
library(kableExtra)

knitr::kable(
  summary_table,
  format    = "latex",
  booktabs  = TRUE,
  longtable = FALSE,
  caption   = "Descriptive statistics.",
  digits    = 2
) |>
  kable_styling(latex_options = "hold_position") |>
  add_header_above(c(" " = 1, "Full sample" = 3))
```

`latex_options = "hold_position"` adds `[!h]` to the float specifier, which is overridden in `journal_style` mode — all floats are deferred regardless of specifier.

### Table notes

To add a source or method note below a table:

```r
knitr::kable(...) |>
  footnote(
    general       = "Data: NLSY97. Standard errors in parentheses.",
    general_title = "Note:",
    footnote_as_chunk = TRUE
  )
```

---

## 10. Figures

Figures are inserted using standard R Markdown code chunks. Pandoc wraps figure output in `\begin{figure}...\end{figure}` float environments, which the template auto-scales to fit the page.

### R-generated figures

````markdown
```{r wage-dist, echo=FALSE, fig.cap="Distribution of log wages by firm size quintile.", fig.width=6, fig.height=4, out.width="85%"}
ggplot(df, aes(x = log_wage, fill = firm_quintile)) +
  geom_density(alpha = 0.4) +
  labs(x = "Log wage", y = "Density", fill = "Firm size quintile") +
  theme_minimal()
```
````

Key chunk options:

| Option | What it does |
|---|---|
| `fig.cap` | Caption text |
| `fig.width`, `fig.height` | Figure dimensions in inches (controls aspect ratio) |
| `out.width` | Output width as a percentage of text width, e.g. `"85%"` |
| `fig.align` | `"center"` (default), `"left"`, `"right"` |
| `fig.pos` | LaTeX placement specifier, e.g. `"h"` for here |

### External image files

```markdown
![Distribution of log wages by firm size quintile.](figures/wage-dist.pdf){width=85%}
```

PDF and EPS figures produce the sharpest output. PNG and JPEG also work — use at least 300 dpi for print quality.

### Figure placement

By default, LaTeX places figures where they fit best. To request placement near the source location, add `fig.pos = "h"` to the chunk. In `journal_style` mode, placement specifiers are ignored — all figures are deferred to after the bibliography.

---

## 11. Preparing for submission

Most journals require some combination of double spacing, line numbers, anonymization, and tables/figures after the references. Each is a one-line YAML change.

### Anonymous review

Suppresses author name, date, acknowledgements, and affiliation from the title page. All other content is unchanged.

```yaml
anonymize: true
```

Remove or set to `false` when submitting the final accepted version.

### Double spacing

```yaml
doublespace: true
```

Overrides the preset line spacing. Footnotes and the bibliography remain single-spaced.

### Line numbers

```yaml
linenumbers: true
```

Adds continuous line numbers in the left margin. **Known issue:** line number gutter alignment may drift slightly at 1.5× or 2× spacing due to an interaction between the `lineno` and `setspace` packages. The counter itself is always correct. Using `doublespace: true` is more reliable than the default 1.5× spacing when line numbers are active.

**Do not combine `linenumbers: true` with `journal_style: true`.** The two modes interact poorly. Use line numbers for the review draft; switch to journal style for the final submission format.

### A typical review-submission YAML

```yaml
---
title: "The Organizational Basis of Wage Inequality"
subtitle: "Evidence from Linked Employer-Employee Data"
date: "April 2026"
surname: "Cohen"
runningtitle: "Organizational Basis of Wage Inequality"

author:
  - name: "Joseph N. Cohen"
author_dept:  "Department of Sociology"
author_inst:  "Queens College, City University of New York"
author_email: "joseph.cohen@qc.cuny.edu"

abstract: |
  [Your abstract here.]

keywords:
  - wage inequality
  - organizations

bibliography: references.bib
csl: default.csl
template: jnctemplate.tex
fontpath: fonts/

fontset: demography
anonymize: true
doublespace: true
linenumbers: true
---
```

---

## 12. Journal-style mode

Many journals require tables and figures to appear as separate pages **after the references**, with placeholder markers in the manuscript body. Set `journal_style: true` to enable this.

```yaml
journal_style: true
```

With `journal_style` active, every `figure` and `table` float is replaced in the text body by a bold, centered marker:

```
[Insert Table 1 about here]

[Insert Figure 1 about here]
```

The actual floats are collected and printed after the bibliography — tables first (one per page), then figures (one per page).

### Two-pass compilation required

`journal_style` mode uses the `endfloat` LaTeX package, which requires **two compilation passes**. On the first pass, floats are written to auxiliary files (`.ttt` for tables, `.fff` for figures). On the second pass, those files are typeset after the bibliography.

**Knit twice** when you first enable `journal_style`, or after adding or removing floats:

```r
rmarkdown::render("paper.Rmd")   # first pass
rmarkdown::render("paper.Rmd")   # second pass — floats placed correctly
```

RStudio's Knit button runs a single pass. Run `rmarkdown::render()` from the console, or use `latexmk` which detects the need for additional passes automatically:

```bash
latexmk -xelatex paper.tex
```

### Table floats are required

The deferral mechanism works on LaTeX **float environments** (`figure`, `table`). It does not affect `longtable`, which is a non-float.

Pandoc's default for markdown table syntax is `longtable`. To get tables deferred in `journal_style` mode, use `longtable = FALSE` in `knitr::kable()`:

```r
# This table WILL be deferred
knitr::kable(df, format = "latex", booktabs = TRUE, longtable = FALSE,
             caption = "Descriptive statistics.")

# This table will NOT be deferred (longtable is the default)
knitr::kable(df, format = "latex", booktabs = TRUE)
```

Markdown pipe table syntax (`| col | col |`) also produces `longtable` and will not be deferred. For journal-mode tables, always use `knitr::kable(..., longtable = FALSE)`.

### Journal-style submission YAML

```yaml
---
title: "The Organizational Basis of Wage Inequality"
surname: "Cohen"
runningtitle: "Organizational Basis of Wage Inequality"

author:
  - name: "Joseph N. Cohen"
author_dept:  "Department of Sociology"
author_inst:  "Queens College, City University of New York"
author_email: "joseph.cohen@qc.cuny.edu"

abstract: |
  [Your abstract here.]

bibliography: references.bib
csl: default.csl
template: jnctemplate.tex
fontpath: fonts/

fontset: demography
doublespace: true
journal_style: true
---
```

### Known limitations

- `float [H]` placement specifiers are ignored; `endfloat` defers all floats regardless.
- Do not combine with `linenumbers: true`.
- Markdown table syntax and `knitr::kable()` without `longtable = FALSE` produce non-deferred output.

---

## 13. Quick reference: all YAML variables

### Document metadata

| Variable | Type | Description |
|---|---|---|
| `title` | string | Document title (required) |
| `subtitle` | string | Subtitle, rendered below title |
| `date` | string | Date string on title page |
| `surname` | string | Author surname for running header |
| `runningtitle` | string | Short title for running header |
| `abstract` | block | Abstract text |
| `keywords` | list | Keyword list, rendered below abstract |
| `acknowledgements` | block | Acknowledgements on title page |

### Author block

`author:` takes a list of `- name:` entries. Contact details are top-level variables and appear once below all author names.

| Variable | Description |
|---|---|
| `author_dept` | Department |
| `author_inst` | Institution |
| `author_addr` | Street address |
| `author_email` | Email (rendered in monospace) |
| `author_web` | Website (`[label](url)` syntax) |
| `author_orcid` | ORCID identifier |

### Typography and layout

| Variable | Values | Description |
|---|---|---|
| `fontset` | `humanities` \| `demography` \| `methods` \| *(unset)* | Font and layout preset |
| `fontpath` | path string | Path to bundled fonts directory |
| `doublespace` | `true` \| `false` | Full double spacing, overrides preset |
| `numbersections` | `true` \| `false` | Number section headings |
| `maincolumns` | `1` \| `2` | Body column count; bibliography always single-column |

### Submission modes

| Variable | Values | Description |
|---|---|---|
| `anonymize` | `true` \| `false` | Suppress identifying metadata for blind review |
| `linenumbers` | `true` \| `false` | Add continuous line numbers |
| `journal_style` | `true` \| `false` | Defer floats to after bibliography with markers; requires two compilation passes |

### Bibliography

| Variable | Description |
|---|---|
| `bibliography` | Path to `.bib` file |
| `csl` | Path to CSL style file |

### Complete YAML header

```yaml
---
title: "My Manuscript Title"
subtitle: "An Optional Subtitle"
date: "April 2026"
surname: "Cohen"
runningtitle: "Short Running Title"
fontset: humanities

author:
  - name: "Jane Doe"
  - name: "John Smith"

author_dept:  "Department of Sociology"
author_inst:  "Queens College, City University of New York"
author_addr:  "65-30 Kissena Blvd., Queens, NY 11367"
author_email: "jane@university.edu"
author_web:   "https://jane.example.edu"
author_orcid: "0000-0000-0000-0001"

abstract: |
  This paper examines... [150-250 words recommended]

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
journal_style: false
linenumbers: false
numbersections: false
maincolumns: 1
---
```

---

## 14. Bibliography: supported source types

The bundled `default.csl` handles modern source types that standard styles format poorly. Set the Zotero item type as follows:

| Source | Zotero item type | Notes |
|---|---|---|
| Journal article | Journal Article | DOI shown automatically |
| Book | Book | — |
| Book chapter | Book Section | — |
| Dissertation / thesis | Thesis | Set Type field: PhD, MA, etc. |
| Technical / institutional report | Report | Set Type and Report Number |
| Preprint / working paper | Manuscript | Set Genre: "Working Paper", "Preprint", etc. |
| Research dataset | Dataset | Set Version and Publisher (repository name) |
| R package / software | Software | Set Version; Publisher = CRAN or GitHub |
| Blog post | Blog Post | Set Accessed date |
| Social media post | Forum Post | Set container-title to platform name |
| YouTube video / podcast | Video Recording | Set Genre: [Video] or [Podcast episode] |
| Conference presentation | Presentation | — |
| Web page | Web Page | Set Accessed date |

### R packages in Zotero

Cite R packages using the Software item type:

| Zotero field | Value |
|---|---|
| Title | Package name, e.g. `ggplot2` |
| Author | Authors from the `DESCRIPTION` file |
| Version | From CRAN or `packageVersion("ggplot2")` |
| Date | Release date of the version cited |
| Company | `CRAN` or `GitHub` |
| URL | `https://cran.r-project.org/package=...` |
| Accessed | Date retrieved |

Renders as: *Author (Year). Title (Version x.x.x) [Computer software]. Publisher. URL*

---

## 15. Non-R installation

For users without R, two shell scripts are provided.

**From a local clone:**

```bash
bash install.sh                              # installs to ~/Templates/jnc-tex/
JNC_TEMPLATE_DIR=/custom/path bash install.sh
```

**Directly from GitHub:**

```bash
bash fetch-template.sh
JNC_BRANCH=v1.0.0 bash fetch-template.sh    # pin to a release tag
```

After installation, add to your document YAML:

```yaml
template: ~/Templates/jnc-tex/jnctemplate.tex
fontpath: ~/Templates/jnc-tex/fonts/
csl: ~/Templates/jnc-tex/default.csl
```

And compile with Pandoc directly:

```bash
pandoc paper.md \
  --template=~/Templates/jnc-tex/jnctemplate.tex \
  --csl=~/Templates/jnc-tex/default.csl \
  --bibliography=references.bib \
  --pdf-engine=xelatex \
  -V fontpath=~/Templates/jnc-tex/fonts/ \
  -o paper.pdf
```

---

## Design principles

- Engine-agnostic: pdfLaTeX, XeLaTeX, and LuaLaTeX
- Pandoc-native: no preprocessing scripts required
- All options in YAML — stable single-file template
- Versioned via Git tags; filename never changes
- Intended for empirical articles, working papers, and blind review submissions; not a replacement for journal-specific `.cls` files where those are requireding author.

```yaml
author:
  - name: "Jane Doe"
  - name: "John Smith"
  - name: "Maria Garcia"
```

**Methods preset title page.** When `fontset: methods`, the title page uses a left-aligned layout with a full-width accent rule, rather than the centered layout used by the other presets.

---

## 7. Writing body text

The document body is standard R Markdown. A few things worth knowing for academic manuscripts.

**Sections.** Use `#` for top-level sections, `##` for subsections, `###` for sub-subsections. By default, sections are unnumbered. To number them:

```yaml
numbersections: true
```

**Section numbering depth** goes to three levels (1.2.3) when `numbersections: true`.

**Paragraphs.** Leave a blank line between paragraphs. First-line indent is applied automatically — do not add manual indentation.

**Emphasis.** `*italics*` and `**bold**`. Use italics for titles and foreign terms; use bold sparingly.

**Footnotes.** Standard Pandoc footnote syntax:

```markdown
This claim requires qualification.^[See the discussion in Smith (2018), who
argues that the relationship is conditional on organizational size.]
```

**Inline R.** knitr evaluates inline R expressions. Use this for reporting statistics so numbers stay in sync with your data:

```markdown
The sample includes `r nrow(df)` respondents across
`r length(unique(df$firm_id))` firms.
```

**Two-column layout.** For a two-column body (uncommon in sociology but used in some venues):

```yaml
maincolumns: 2
```

The bibliography automatically reverts to a single column.

---

## 8. Citations and bibliography

Citations are handled by Pandoc's built-in citation processor (citeproc) using your `.bib` file and a CSL style file. No BibTeX or biber compilation step is needed.

### Setting up your bibliography file

Create a `references.bib` file in your project folder. If you use **Zotero**, export your library (or a collection) using Better BibTeX: right-click → Export Collection → Better BibTeX → keep file updated. The exported `.bib` file stays in sync as you add sources.

Point the template at your bibliography in the YAML header:

```yaml
bibliography: references.bib
csl: default.csl
```

The bundled `default.csl` produces author-date citations in a Chicago-derived format extended to cover modern source types (datasets, software, preprints). To use a different style, replace `default.csl` with any `.csl` file from the [Zotero style repository](https://www.zotero.org/styles).

### In-text citations

Pandoc uses `@key` syntax for citations, where `key` is the BibTeX key in your `.bib` file.

| Markdown | Output |
|---|---|
| `@smith2020` | Smith (2020) |
| `[@smith2020]` | (Smith 2020) |
| `[@smith2020, p. 45]` | (Smith 2020, p. 45) |
| `[@smith2020; @jones2018]` | (Smith 2020; Jones 2018) |
| `[-@smith2020]` | (2020) — suppresses author name |

**RStudio visual editor.** If you use RStudio's visual markdown editor, use Insert → Citation to search Zotero or DOI directly without typing BibTeX keys by hand.

### Where the bibliography appears

Pandoc automatically appends the bibliography at the end of the document body. You do not need to add any special command or section header — the `## References` heading is generated automatically.

To force a page break before the references section, add this at the end of your document body, just before any other closing content:

```markdown
\clearpage
```

Or put the bibliography under a manual heading by adding at the very end of your `.Rmd`:

```markdown
# References
```

Pandoc will place the bibliography under that heading rather than appending a new one.

### Citation keys and Zotero

If your BibTeX keys look like `smith2020inequality`, a consistent naming convention makes citing easier. Better BibTeX's default key format (`[auth:lower][year][title:lower:keepfirst:nopunct]`) produces readable keys. Set your preferred format in Zotero → Edit → Preferences → Better BibTeX → Citation key formula.

---

## 9. Tables

Tables are the area that requires the most care, especially when preparing for journal submission.

### Basic markdown tables

For simple tables you can write them in markdown directly:

```markdown
| Variable | Mean | SD | N |
|---|---:|---:|---:|
| Log wage | 2.84 | 0.61 | 4,210 |
| Tenure (years) | 6.3 | 5.1 | 4,210 |
| Firm size (log) | 4.7 | 1.8 | 4,210 |

: Descriptive statistics {#tbl-desc}
```

Pandoc converts markdown tables to `longtable` environments in LaTeX.

### knitr tables with `knitr::kable()`

For tables generated from R objects, `knitr::kable()` is the standard approach:

````markdown
```{r}
#| label: tbl-desc
#| echo: false

knitr::kable(
  summary_table,
  format    = "latex",
  booktabs  = TRUE,
  caption   = "Descriptive statistics",
  col.names = c("Variable", "Mean", "SD", "N"),
  digits    = 2
)
```
````

By default, `knitr::kable()` with `format = "latex"` produces a `longtable` environment (multi-page capable). The template automatically applies `footnotesize` font and single spacing to all `longtable` environments.

### Tables for journal submission

Journal submission requires tables to appear **after the references**, with `[Insert Table N about here]` markers in the text body. This requires two things: enabling `journal_style` mode and generating tables as `table` float environments rather than `longtable`.

The critical setting in `knitr::kable()` is `longtable = FALSE`:

```r
knitr::kable(
  summary_table,
  format     = "latex",
  booktabs   = TRUE,
  longtable  = FALSE,           # ← produces a table float, not longtable
  caption    = "Descriptive statistics."
)
```

With `longtable = FALSE`, knitr wraps the table in a `\begin{table}...\end{table}` float environment. When `journal_style: true`, the `endfloat` package defers these floats to after the bibliography and replaces them with bold centered markers in the text.

See [§ 12 Journal-style mode](#12-journal-style-mode) for the full workflow.

### kableExtra for styled tables

The `kableExtra` package extends `knitr::kable()` with additional formatting:

```r
library(kableExtra)

knitr::kable(
  summary_table,
  format    = "latex",
  booktabs  = TRUE,
  longtable = FALSE,
  caption   = "Descriptive statistics.",
  digits    = 2
) |>
  kable_styling(latex_options = "hold_position") |>
  add_header_above(c(" " = 1, "Full sample" = 3))
```

**Note:** `latex_options = "hold_position"` adds `[!h]` to the float specifier, which is overridden in `journal_style` mode (all floats are deferred regardless of specifier).

### Table notes

To add a note below a table, use `kableExtra::footnote()`:

```r
knitr::kable(...) |>
  footnote(
    general = "Data: NLSY97. Standard errors in parentheses.",
    general_title = "Note:",
    footnote_as_chunk = TRUE
  )
```

---

## 10. Figures

Figures are inserted using standard R Markdown code chunks. Pandoc wraps figure output in `\begin{figure}...\end{figure}` float environments, which the template auto-scales to fit the page.

### R-generated figures

````markdown
```{r}
#| label: fig-wage-dist
#| echo: false
#| fig.cap: "Distribution of log wages by firm size quintile."
#| fig.width: 6
#| fig.height: 4
#| out.width: "85%"

ggplot(df, aes(x = log_wage, fill = firm_quintile)) +
  geom_density(alpha = 0.4) +
  labs(x = "Log wage", y = "Density", fill = "Firm size quintile") +
  theme_minimal()
```
````

Key chunk options:

| Option | What it does |
|---|---|
| `fig.cap` | Caption text (required for cross-referencing) |
| `fig.width`, `fig.height` | Figure dimensions in inches (controls aspect ratio) |
| `out.width` | Output width as a percentage of `\textwidth` |
| `fig.align` | `"center"` (default), `"left"`, `"right"` |

### External image files

```markdown
![Distribution of log wages by firm size quintile.](figures/wage-dist.pdf){width=85%}
```

PDF and EPS figures produce the sharpest output in a LaTeX PDF. PNG and JPEG also work — use at least 300 dpi for print quality.

### Figure placement

By default, LaTeX places figures where they fit best (at the top or bottom of a page, or on a float page). To force a figure to appear at approximately its location in the text, add `fig.pos = "h"` to the chunk options. In `journal_style` mode, placement specifiers are ignored — all figures are deferred.

---

## 11. Preparing for submission

Most journals require some combination of double spacing, line numbers, anonymization, and tables/figures after the references. Each of these is a one-line YAML change.

### Anonymous review

Suppresses author name, date, acknowledgements, and affiliation from the title page. All other content is unchanged.

```yaml
anonymize: true
```

Remove or set to `false` when submitting the final accepted version.

### Double spacing

```yaml
doublespace: true
```

Overrides the preset line spacing. Use this for any journal that requires double-spaced manuscripts. Footnotes and the bibliography remain single-spaced.

### Line numbers

```yaml
linenumbers: true
```

Adds continuous line numbers in the left margin, which many journals require for the review process. **Known issue:** line number positioning may drift slightly at 1.5× or 2× spacing due to a known interaction between the `lineno` and `setspace` packages. The counter itself is correct; only the gutter alignment can drift cosmetically. Using `doublespace: true` (full `\doublespacing`) is more reliable than `1.5×` when line numbers are active.

**Do not combine `linenumbers: true` with `journal_style: true`.** The two modes interact poorly. Enable them separately: use line numbers for the review draft, switch to journal style for the final submission format.

### A typical submission YAML

```yaml
---
title: "The Organizational Basis of Wage Inequality"
subtitle: "Evidence from Linked Employer-Employee Data"
date: "April 2026"
surname: "Cohen"
runningtitle: "Organizational Basis of Wage Inequality"

author:
  - name: "Joseph N. Cohen"

author_dept:  "Department of Sociology"
author_inst:  "Queens College, City University of New York"
author_email: "joseph.cohen@qc.cuny.edu"

abstract: |
  [Your abstract here.]

keywords:
  - wage inequality
  - organizations

bibliography: references.bib
csl: default.csl
template: jnctemplate.tex
fontpath: fonts/

fontset: demography
anonymize: true
doublespace: true
linenumbers: true
numbersections: false
---
```

---

## 12. Journal-style mode

Many journals require that tables and figures appear as separate pages **after the references**, with placeholder text in the manuscript body. Set `journal_style: true` to enable this.

```yaml
journal_style: true
```

With `journal_style` active, every `figure` and `table` float in the document is replaced in the text body by a bold, centered marker:

```
[Insert Table 1 about here]

[Insert Figure 1 about here]
```

The actual floats are collected and printed after the bibliography in this order: tables first (one per page), then figures (one per page).

### Two-pass compilation

`journal_style` mode uses the `endfloat` LaTeX package, which requires **two compilation passes** — the same two-pass requirement as BibTeX. On the first pass, floats are written to auxiliary files (`.ttt` for tables, `.fff` for figures). On the second pass, those files are typeset after the bibliography.

In practice: **knit twice** when you first enable `journal_style`, or after adding or removing floats.

```r
rmarkdown::render("paper.Rmd")   # first pass
rmarkdown::render("paper.Rmd")   # second pass — floats appear correctly
```

RStudio's Knit button runs a single pass. For `journal_style` documents, run `rmarkdown::render()` from the console twice, or use `latexmk` if you have it:

```bash
latexmk -xelatex paper.tex
```

`latexmk` detects when additional passes are needed and runs them automatically.

### Table floats are required

The `journal_style` deferral mechanism works on LaTeX **float environments** — specifically `\begin{figure}...\end{figure}` and `\begin{table}...\end{table}`. It does not affect `longtable`, which is a non-float environment.

Pandoc's default output for markdown table syntax is `longtable`. To get tables deferred in `journal_style` mode, generate them as `table` floats by setting `longtable = FALSE` in `knitr::kable()`:

```r
# This table WILL be deferred in journal_style mode
knitr::kable(
  summary_table,
  format    = "latex",
  booktabs  = TRUE,
  longtable = FALSE,
  caption   = "Descriptive statistics."
)
```

```r
# This table will NOT be deferred (longtable is the default)
knitr::kable(summary_table, format = "latex", booktabs = TRUE)
```

**Markdown table syntax** (`| col | col |`) also produces `longtable` and will not be deferred. For journal-mode tables, always use `knitr::kable(..., longtable = FALSE)` or a raw `\begin{table}...\end{table}` block.

### Journal-style submission YAML

```yaml
---
title: "The Organizational Basis of Wage Inequality"
surname: "Cohen"
runningtitle: "Organizational Basis of Wage Inequality"

author:
  - name: "Joseph N. Cohen"
author_dept:  "Department of Sociology"
author_inst:  "Queens College, City University of New York"
author_email: "joseph.cohen@qc.cuny.edu"

abstract: |
  [Your abstract here.]

bibliography: references.bib
csl: default.csl
template: jnctemplate.tex
fontpath: fonts/

fontset: demography
doublespace: true
journal_style: true
---
```

### Known limitations

- `float [H]` placement specifiers are ignored; `endfloat` defers all floats regardless.
- Do not combine with `linenumbers: true` — the two options conflict.
- Markdown table syntax and `knitr::kable()` without `longtable = FALSE` produce non-deferred `longtable` output.

---

## 13. Quick reference: all YAML variables

### Document metadata

| Variable | Type | Description |
|---|---|---|
| `title` | string | Document title (required) |
| `subtitle` | string | Subtitle, rendered below title |
| `date` | string | Date string, rendered on title page |
| `surname` | string | Author surname for running header |
| `runningtitle` | string | Short title for running header |
| `abstract` | block | Abstract text |
| `keywords` | list | Keyword list, rendered below abstract |
| `acknowledgements` | block | Acknowledgements, rendered on title page |

### Author block

`author:` takes a list of `- name:` entries. Contact details are set as top-level variables and appear once below all author names.

| Variable | Description |
|---|---|
| `author_dept` | Department |
| `author_inst` | Institution |
| `author_addr` | Street address |
| `author_email` | Email (rendered in monospace) |
| `author_web` | Website (Markdown link syntax: `[label](url)`) |
| `author_orcid` | ORCID identifier |

### Typography and layout

| Variable | Values | Description |
|---|---|---|
| `fontset` | `humanities` \| `demography` \| `methods` \| *(unset)* | Font and layout preset |
| `fontpath` | path string | Path to bundled fonts directory |
| `doublespace` | `true` \| `false` | Override preset spacing with full double spacing |
| `numbersections` | `true` \| `false` | Number section headings |
| `maincolumns` | `1` \| `2` | Body column count; bibliography always single-column |

### Submission modes

| Variable | Values | Description |
|---|---|---|
| `anonymize` | `true` \| `false` | Suppress identifying metadata for blind review |
| `linenumbers` | `true` \| `false` | Add continuous line numbers |
| `journal_style` | `true` \| `false` | Defer figures and tables to after bibliography with `[Insert X about here]` markers; requires two compilation passes |

### Bibliography

| Variable | Description |
|---|---|
| `bibliography` | Path to `.bib` file |
| `csl` | Path to CSL style file |

### Complete YAML header

```yaml
---
title: "My Manuscript Title"
subtitle: "An Optional Subtitle"
date: "April 2026"
surname: "Cohen"
runningtitle: "Short Running Title"
fontset: humanities

author:
  - name: "Jane Doe"
  - name: "John Smith"

author_dept:  "Department of Sociology"
author_inst:  "Queens College, City University of New York"
author_addr:  "65-30 Kissena Blvd., Queens, NY 11367"
author_email: "jane@university.edu"
author_web:   "https://jane.example.edu"
author_orcid: "0000-0000-0000-0001"

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
journal_style: false
linenumbers: false
numbersections: false
maincolumns: 1
---
```

---

## 14. Bibliography: supported source types

The bundled `default.csl` handles modern source types that standard styles format poorly. Set the Zotero item type as follows:

| Source | Zotero item type | Notes |
|---|---|---|
| Journal article | Journal Article | DOI shown automatically |
| Book | Book | — |
| Book chapter | Book Section | — |
| Dissertation / thesis | Thesis | Set Type field: PhD, MA, etc. |
| Technical / institutional report | Report | Set Type and Report Number |
| Preprint / working paper | Manuscript | Set Genre: "Working Paper", "Preprint", etc. |
| Research dataset | Dataset | Set Version and Publisher (repository name) |
| R package / software | Software | Set Version; Publisher = CRAN or GitHub |
| Blog post | Blog Post | Set Accessed date |
| Social media post | Forum Post | Set container-title to platform name |
| YouTube video / podcast | Video Recording | Set Genre: [Video] or [Podcast episode] |
| Conference presentation | Presentation | — |
| Web page | Web Page | Set Accessed date |

### R packages in Zotero

Cite R packages using the Software item type. Fill in the fields as follows:

| Zotero field | Value |
|---|---|
| Title | Package name: e.g., `ggplot2` |
| Author | Authors from the `DESCRIPTION` file |
| Version | From CRAN or `packageVersion("ggplot2")` |
| Date | Release date of the version cited |
| Company | `CRAN` or `GitHub` |
| URL | `https://cran.r-project.org/package=...` |
| Accessed | Date retrieved |

Renders as: *Author (Year). Title (Version x.x.x) [Computer software]. Publisher. URL*

---

## 15. Non-R installation

For users without R, two shell scripts are provided.

**From a local clone:**

```bash
bash install.sh                             # installs to ~/Templates/jnc-tex/
JNC_TEMPLATE_DIR=/custom/path bash install.sh
```

**Directly from GitHub:**

```bash
bash fetch-template.sh
JNC_BRANCH=v1.0.0 bash fetch-template.sh   # pin to a release tag
```

After installation, add to your document YAML:

```yaml
template: ~/Templates/jnc-tex/jnctemplate.tex
fontpath: ~/Templates/jnc-tex/fonts/
csl: ~/Templates/jnc-tex/default.csl
```

And compile with Pandoc:

```bash
pandoc paper.md \
  --template=~/Templates/jnc-tex/jnctemplate.tex \
  --csl=~/Templates/jnc-tex/default.csl \
  --bibliography=references.bib \
  --pdf-engine=xelatex \
  -V fontpath=~/Templates/jnc-tex/fonts/ \
  -o paper.pdf
```

---

## Design principles

- Engine-agnostic: pdfLaTeX, XeLaTeX, and LuaLaTeX
- Pandoc-native: no preprocessing scripts required
- All options in YAML — stable single-file template
- Versioned via Git tags; filename never changes
- Intended for empirical articles, working papers, and blind review submissions; not a replacement for journal-specific `.cls` files where those are required
