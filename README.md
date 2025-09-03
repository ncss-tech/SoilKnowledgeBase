## Soil Knowledge Base

[![refresh
inst/extdata](https://github.com/brownag/SoilKnowledgeBase/workflows/refresh-extdata/badge.svg)](https://github.com/brownag/SoilKnowledgeBase/actions?query=workflow%3Arefresh-extdata)
[![R build
status](https://github.com/brownag/SoilKnowledgeBase/workflows/R-CMD-check/badge.svg)](https://github.com/brownag/SoilKnowledgeBase/actions)
[![html-docs](https://img.shields.io/badge/docs-HTML-informational)](https://ncss-tech.github.io/SoilKnowledgeBase/)

A soil “knowledge base” centered around the **National Cooperative Soil
Survey** (NCSS) standards.

These are standards developed and maintained by the United States
Department of Agriculture Natural Resources Conservation Service
(**USDA-NRCS**) Soil and Plant Science Division (**SPSD**). They are
defined in the **National Soil Survey Handbook** (**NSSH**\*)

The contents of this repository are completely reproducible. You can
build an instance of all of the external data from scratch if you
install the package off GitHub and run the `refresh()` command.

This repository is an **R** package that facilitates management of
dependencies, continuous integration, version control of and limited
programmatic access to products from official data sources.

### Get started

    # install.packages("remotes")
    remotes::install_github("ncss-tech/SoilKnowledgeBase")

    # install all remote data to inst/extdata
    SoilKnowledgeBase::refresh()

The repository is *regularly updated* to reflect changes that happen in
a variety of official data sources.

Depending on your application you may be better off simply cloning the
repository and calling `git pull` on a schedule that is convenient for
you.

See the NSSH on [eDirectives](http://directives.sc.egov.usda.gov/) for
details on specific data sources.
