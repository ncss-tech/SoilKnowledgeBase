## Soil Knowledge Base

[![refresh
inst/extdata](https://github.com/brownag/SoilKnowledgeBase/workflows/refresh-extdata/badge.svg)](https://github.com/brownag/SoilKnowledgeBase/actions?query=workflow%3Arefresh-extdata)
[![R build
status](https://github.com/brownag/SoilKnowledgeBase/workflows/R-CMD-check/badge.svg)](https://github.com/brownag/SoilKnowledgeBase/actions)
[![html-docs](https://camo.githubusercontent.com/f7ba98e46ecd14313e0e8a05bec3f92ca125b8f36302a5b1679d4a949bccbe31/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f646f63732d48544d4c2d696e666f726d6174696f6e616c)](https://ncss-tech.github.io/SoilKnowledgeBase/)

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

### The Structure of the National Soil Survey Handbook (NSSH)

The materials provided in this repository are generally defined
somewhere within the NSSH. For now, only top-level links to whole
sections of the handbook are available.

These links connect to
[eDirectives](http://directives.sc.egov.usda.gov/) which are the
official sources of standards of this nature.

<table>
<colgroup>
<col style="width: 14%" />
<col style="width: 50%" />
<col style="width: 30%" />
<col style="width: 4%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Part &amp; Subpart</th>
<th style="text-align: left;">Part Name</th>
<th style="text-align: left;">Section</th>
<th style="text-align: left;">Link</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">600 A</td>
<td style="text-align: left;">Introduction, Subpart A</td>
<td style="text-align: left;">General</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44200.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">600 B</td>
<td style="text-align: left;">Introduction, Subpart B</td>
<td style="text-align: left;">General</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44201.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">601 A</td>
<td style="text-align: left;">NCSS Organization, Subpart A</td>
<td style="text-align: left;">General</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44202.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">601 B</td>
<td style="text-align: left;">NCSS Organization, Subpart B</td>
<td style="text-align: left;">General</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44203.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">602 B</td>
<td style="text-align: left;">Conferences of the NCSS, Subpart B</td>
<td style="text-align: left;">General</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/45970.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">606 A</td>
<td style="text-align: left;">Working Agreements, Subpart A</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/46327.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">606 B</td>
<td style="text-align: left;">Working Agreements, Subpart B</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/46328.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">607 A</td>
<td style="text-align: left;">Initial Soil Survey Preparation, Subpart
A</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44209.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">607 B</td>
<td style="text-align: left;">Initial Soil Survey Preparation, Subpart
B</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44216.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">608 A</td>
<td style="text-align: left;">Program Management, Subpart A</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44210.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">608 B</td>
<td style="text-align: left;">Program Management, Subpart B</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44211.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">609 A</td>
<td style="text-align: left;">QC/QA* and Soil Correlation, Subpart
A</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44212.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">609 B</td>
<td style="text-align: left;">QC/QA* and Soil Correlation, Subpart
B</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44213.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">610 A</td>
<td style="text-align: left;">Updating Soil Surveys, Subpart A</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44214.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">610 B</td>
<td style="text-align: left;">Updating Soil Surveys, Subpart B</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44215.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">614 A</td>
<td style="text-align: left;">Applying Soil Taxonomy, Subpart A</td>
<td style="text-align: left;">Soil Classification</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44230.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">614 B</td>
<td style="text-align: left;">Applying Soil Taxonomy, Subpart B</td>
<td style="text-align: left;">Soil Classification</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44231.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">617 A</td>
<td style="text-align: left;">Soil Survey Interpretations, Subpart
A</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44232.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">617 B</td>
<td style="text-align: left;">Soil Survey Interpretations, Subpart
B</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44234.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">618 A</td>
<td style="text-align: left;">Soil Properties and Qualities, Subpart
A</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/46752.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">618 B</td>
<td style="text-align: left;">Soil Properties and Qualities, Subpart
B</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44385.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">621 A</td>
<td style="text-align: left;">Soil Potential Ratings, Subpart A</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44251.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">621 B</td>
<td style="text-align: left;">Soil Potential Ratings, Subpart B</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44252.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">622 A</td>
<td style="text-align: left;">Interpretive Groups, Subpart A</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/45381.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">622 B</td>
<td style="text-align: left;">Interpretive Groups, Subpart B</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44254.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">624 A</td>
<td style="text-align: left;">Soil Quality, Subpart A</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44255.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">624 B</td>
<td style="text-align: left;">Soil Quality, Subpart B</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44256.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">627 A</td>
<td style="text-align: left;">Legend Development and Data Collection,
Subpart A</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/45136.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">627 B</td>
<td style="text-align: left;">Legend Development and Data Collection,
Subpart B</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44259.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">629 A</td>
<td style="text-align: left;">Glossary of Landform and Geologic Terms,
Subpart A</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44260.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">629 B</td>
<td style="text-align: left;">Glossary of Landform and Geologic Terms,
Subpart B</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44261.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">630 A</td>
<td style="text-align: left;">Benchmark Soils, Subpart A</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44262.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">630 B</td>
<td style="text-align: left;">Benchmark Soils, Subpart B</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44263.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">631 A</td>
<td style="text-align: left;">Soil Survey Investigations, Subpart A</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44264.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">631 B</td>
<td style="text-align: left;">Soil Survey Investigations, Subpart B</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44265.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">638</td>
<td style="text-align: left;">Soil Data Systems</td>
<td style="text-align: left;">Soil Survey Information Systems</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44266.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">639 A</td>
<td style="text-align: left;">National Soil Information System (NASIS),
Subpart A</td>
<td style="text-align: left;">Soil Survey Information Systems</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44267.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">639 B</td>
<td style="text-align: left;">National Soil Information System (NASIS),
Subpart B</td>
<td style="text-align: left;">Soil Survey Information Systems</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44268.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">644 A</td>
<td style="text-align: left;">Delivering Soil Survey Information,
Subpart A</td>
<td style="text-align: left;">Soil Survey Publications</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44276.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">644 B</td>
<td style="text-align: left;">Delivering Soil Survey Information,
Subpart B</td>
<td style="text-align: left;">Soil Survey Publications</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44277.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">647 A</td>
<td style="text-align: left;">Soil Map Development, Subpart A</td>
<td style="text-align: left;">Soil Maps</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44278.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">647 B</td>
<td style="text-align: left;">Soil Map Development, Subpart B</td>
<td style="text-align: left;">Soil Maps</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/48547.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">648 A</td>
<td style="text-align: left;">Digital Soil Mapping</td>
<td style="text-align: left;">Soil Maps</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44280.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">648 B</td>
<td style="text-align: left;">Digital Soil Mapping</td>
<td style="text-align: left;">Soil Maps</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44281.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">649 A</td>
<td style="text-align: left;">Land Resource Areas, Subpart A</td>
<td style="text-align: left;">Soil Maps</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44282.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">649 B</td>
<td style="text-align: left;">Land Resource Areas, Subpart B</td>
<td style="text-align: left;">Soil Maps</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44286.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">651</td>
<td style="text-align: left;">Advance Soil Survey Information</td>
<td style="text-align: left;">Information Delivery</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44283.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">655</td>
<td style="text-align: left;">Technical Soil Services</td>
<td style="text-align: left;">Information Delivery</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/44284.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">656 A</td>
<td style="text-align: left;">Coastal Zone Soil Survey, Subpart A</td>
<td style="text-align: left;">Information Delivery</td>
<td style="text-align: left;"><a
href="https://directives.sc.egov.usda.gov/48590.wba">LINK</a></td>
</tr>
</tbody>
</table>

-   \* QC/QA = Quality Control, Quality Assurance

### The following are headers within individual handbook parts

<table>
<colgroup>
<col style="width: 3%" />
<col style="width: 5%" />
<col style="width: 91%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">Part</th>
<th style="text-align: left;">Subpart</th>
<th style="text-align: left;">Header</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">600</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">600.0 The Mission of the Soil Science
Division, Natural Resources Conservation Service</td>
</tr>
<tr class="even">
<td style="text-align: right;">600</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">600.1 Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">600</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">600.2 National Cooperative Soil Survey
(NCSS) Standards</td>
</tr>
<tr class="even">
<td style="text-align: right;">600</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">600.3 Principal References and Their
Maintenance</td>
</tr>
<tr class="odd">
<td style="text-align: right;">600</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">600.4 Conventions and Terminology</td>
</tr>
<tr class="even">
<td style="text-align: right;">600</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">600.5 Standards of the National
Cooperative Soil Survey</td>
</tr>
<tr class="odd">
<td style="text-align: right;">600</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">600.10 List of Technical References</td>
</tr>
<tr class="even">
<td style="text-align: right;">600</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">600.11 Tracking Flowchart for NSSH
Amendments (After Figure 503-D2: Workflow</td>
</tr>
<tr class="odd">
<td style="text-align: right;">601</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">601.0 Definition</td>
</tr>
<tr class="even">
<td style="text-align: right;">601</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">601.1 NRCS Organization and
Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">601</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">601.10 Primary Federal Partners</td>
</tr>
<tr class="even">
<td style="text-align: right;">602</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">602.10 Bylaws of the National Cooperative
Soil Survey Conference</td>
</tr>
<tr class="odd">
<td style="text-align: right;">602</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">602.11 Bylaws of the Western Regional
Cooperative Soil Survey Conference</td>
</tr>
<tr class="even">
<td style="text-align: right;">602</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">602.12 Bylaws of the Northeast Cooperative
Soil Survey Conference (Revised</td>
</tr>
<tr class="odd">
<td style="text-align: right;">602</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">602.13 Bylaws of the North Central
Regional Soil Survey Conference (Revised</td>
</tr>
<tr class="even">
<td style="text-align: right;">602</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">602.14 Bylaws of the Southern Regional
Cooperative Soil Survey Conference</td>
</tr>
<tr class="odd">
<td style="text-align: right;">602</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">602.15 Conducting NCSS Conferences</td>
</tr>
<tr class="even">
<td style="text-align: right;">606</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">606.0 Definition</td>
</tr>
<tr class="odd">
<td style="text-align: right;">606</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">606.0 Policy and Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">606</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">606.10 Template Statement of Commitment
for Soil Survey and Ecological Site Inventory Projects</td>
</tr>
<tr class="odd">
<td style="text-align: right;">607</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">607.0 Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">607</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">607.1 Policy and Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">607</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">607.2 Preliminary Survey Activities</td>
</tr>
<tr class="even">
<td style="text-align: right;">607</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">607.10 Reference Materials for Soil
Surveys</td>
</tr>
<tr class="odd">
<td style="text-align: right;">607</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">607.11 Example of a Procedure for
Geodatabase Development, File Naming, Archiving, and Quality
Assurance</td>
</tr>
<tr class="even">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.1 Responsibilities and
Organization</td>
</tr>
<tr class="even">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.2 Soil Survey Area Designation</td>
</tr>
<tr class="odd">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.3 Areas of Limited Access, Denied
Access Areas, and Areas Not Completed</td>
</tr>
<tr class="even">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.4 Determining Workloads</td>
</tr>
<tr class="odd">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.5 Priorities for Soil Survey
Activities</td>
</tr>
<tr class="even">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.6 Planning Workflow</td>
</tr>
<tr class="odd">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.7 Goals and Progress</td>
</tr>
<tr class="even">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.8 Developing Other Schedules for Soil
Survey Operations</td>
</tr>
<tr class="odd">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.9 Status Maps</td>
</tr>
<tr class="even">
<td style="text-align: right;">608</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">608.10 Long-Range Plan for Initial Soil
Surveys</td>
</tr>
<tr class="odd">
<td style="text-align: right;">608</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">608.11 Annual Plan of Operations for
Initial Soil Surveys</td>
</tr>
<tr class="even">
<td style="text-align: right;">608</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">608.12 Goal and Progress Guidelines</td>
</tr>
<tr class="odd">
<td style="text-align: right;">608</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">608.13 Business Area Responsibilities for
Goals and Progress</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.0 Definition and Purpose of Quality
Control and Quality Assurance</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.1 Policy and Responsibilities for
Quality Control and Quality Assurance</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.2 Soil Correlation</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.3 Seamless Soil Survey</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.4 Quality Control Reviews</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.5 Quality Assurance Reviews</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.6 Field Assistance Visits</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.7 Final Soil Survey Field Activities
for Initial Soil Survey Projects</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.8 General Soil Maps, Index Maps, and
Location Maps</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.10 Format for Correlation
Document</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.11 List of Soil Property or Quality
Attributes for Joining</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.12 Quality Control Template for
Initial Soil Surveys (subject to change to</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.13 Outline of Items Considered in an
Operations Management Review or</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.14 Initial Field Review Checklist for
Initial Soil Surveys</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.15 Quality Assurance Worksheet for
Initial Soil Surveys (subject to change</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.16 Progress Field Review Checklist for
Initial Soil Surveys</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.17 Final Field Review Checklist for
Initial Soil Surveys</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.18 Project Review Checklist for MLRA
Soil Surveys</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.19 Quality Assurance Worksheet for
MLRA Soil Surveys (subject to change</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.0 Definition and Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.1 Policy and Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.2 Inventory and Assessment</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.3 Update Strategies</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.4 Project Plan</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.5 Prioritizing and Ranking</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.6 Long-Range Plan</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.7 Annual Plan of Operation (APO)</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.8 Certification of Soils Data</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.9 Publication of Soils Data</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">610.10 Agency Resources Concerns</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">610.11 Information Items for the Inventory
and Assessment</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">610.12 Resources for the Inventory and
Assessment</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">610.13 Sample Project Evaluation
Worksheet</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">610.14 Project Plan Checklist</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">610.15 Example of a Project Evaluation
Ranking Procedure</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">610.16 Project Description Examples</td>
</tr>
<tr class="even">
<td style="text-align: right;">614</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">614.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">614</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">614.1 Policy and Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">614</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">614.2 National Soil Classification
System</td>
</tr>
<tr class="odd">
<td style="text-align: right;">614</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">614.3 Use of the National Soil
Classification System in Soil Surveys</td>
</tr>
<tr class="even">
<td style="text-align: right;">614</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">614.4 Soil Taxonomy Committees, Work
Groups, and Referees</td>
</tr>
<tr class="odd">
<td style="text-align: right;">614</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">614.5 Procedures for Amending Soil
Taxonomy</td>
</tr>
<tr class="even">
<td style="text-align: right;">614</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">614.6 The Soil Series</td>
</tr>
<tr class="odd">
<td style="text-align: right;">614</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">614.10 Flow Chart of Amendment
Process</td>
</tr>
<tr class="even">
<td style="text-align: right;">614</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">614.11 Example of an Official Soil Series
Description in HTML</td>
</tr>
<tr class="odd">
<td style="text-align: right;">614</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">614.12 Explanation and Content of a Soil
Series Description</td>
</tr>
<tr class="even">
<td style="text-align: right;">614</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">614.13 Rounding Numbers from Laboratory
Data</td>
</tr>
<tr class="odd">
<td style="text-align: right;">614</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">614.14 Significant Digits for Soil
Property or Quality Measurements Used as Criteria</td>
</tr>
<tr class="even">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.0 Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.1 Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.2 Interpretations for Map Unit
Components and Map Units</td>
</tr>
<tr class="odd">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.3 Developing and Maintaining
Interpretation Guides and Ratings</td>
</tr>
<tr class="even">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.4 Reviewing and Implementing Soil
Interpretative Technologies</td>
</tr>
<tr class="odd">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.5 The National Soil Information
System</td>
</tr>
<tr class="even">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.6 Presenting Soil Interpretations</td>
</tr>
<tr class="odd">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.7 Updating Soil Interpretations</td>
</tr>
<tr class="even">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.8 Coordinating Soil Survey
Interpretations</td>
</tr>
<tr class="odd">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.9 Writing Soil Interpretation
Criteria</td>
</tr>
<tr class="even">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.10 Documenting Soil Interpretation
Criteria</td>
</tr>
<tr class="odd">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.11 Requirements for Naming Reports and
Interpretations</td>
</tr>
<tr class="even">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.12 Interpretation Overrides</td>
</tr>
<tr class="odd">
<td style="text-align: right;">617</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">617.20 Example of Descriptions for
Documenting Interpretations Example Documentation of
Interpretations</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.1 Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.2 Collecting, Testing, and Populating
Soil Property Data</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.3 Soil Properties and Soil
Qualities</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.4 Albedo, Dry</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.5 Artifacts in the Soil</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.6 Available Water Capacity</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.7 Bulk Density, One-Third Bar</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.8 Bulk Density, Oven Dry</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.9 Bulk Density, Satiated</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.10 Calcium Carbonate Equivalent</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.11 Cation-Exchange Capacity NH4OAc pH
7</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.12 Climatic Setting</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.13 Continuous Inundation Class, Depth,
and Month</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.14 Corrosion</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.15 Crop Name and Yield</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.16 Diagnostic Horizon Feature - Depth
to Bottom</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.17 Diagnostic Horizon Feature - Depth
to Top</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.18 Diagnostic Horizon Feature -
Kind</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.19 Drainage Class</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.20 Effective Cation-Exchange
Capacity</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.21 Electrical Conductivity</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">648.22 Electrical Conductivity 1:5
(volume)</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.23 Elevation</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.24 Engineering Classification</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.25 Erosion Accelerated, Kind</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.26 Erosion Class</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.27 Excavation Difficulty Classes</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.28 Exchangeable Sodium</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.29 Extractable Acidity</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.30 Extractable Aluminum</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.31 Flooding Frequency Class, Duration
Class, Inundation Type, and Month</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.32 Fragments in the Soil</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.33 Free Iron Oxides</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.34 Frost Action, Potential</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.35 Gypsum</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.36 Horizon Depth to Bottom</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.37 Horizon Depth to Top</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.38 Horizon Designation</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.39 Horizon Thickness</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.40 Hydrologic Group</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.41 Landscape, Landform, Microfeature,
Anthroscape, Anthropogenic Landform, and Anthropogenic Microfeature</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.42 Linear Extensibility Percent</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.43 Liquid Limit</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.44 Organic Matter</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.45 Parent Material, Kind, Modifier,
and Origin</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.46 Particle Density</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.47 Particle Size</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.48 Percent Passing Sieves</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.49 Plasticity Index</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.50 Ponding Depth, Duration Class,
Frequency Class, and Month</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.51 Pores</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.52 Reaction</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.53 Restriction Kind, Depth, Thickness,
and Hardness</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.54 Saturated Hydraulic
Conductivity</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.55 Slope Aspect</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.56 Slope Gradient</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.57 Slope Length, USLE</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.58 Sodium Adsorption Ratio</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.59 Soil Erodibility Factors, USLE,
RUSLE2</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.60 Soil Erodibility Factors for
WEPP</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.61 Soil Moisture Status</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.62 Soil Slippage Potential</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.63 Soil Temperature</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.64 Subsidence, Initial and Total</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.65 Sum of Bases</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.66 Surface Fragments</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.67 T Factor</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.68 Taxonomic Family Temperature
Class</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.69 Taxonomic Moisture Class</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.70 Taxonomic Moisture Subclass
(Subclasses of Soil Moisture Regimes)</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.71 Taxonomic Temperature Regime (Soil
Temperature Regimes)</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.72 Texture Class, Texture Modifier,
and Terms Used in Lieu of Texture</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.73 Von Post Humification Scale</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.74 Water, One-Tenth Bar</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.75 Water, One-Third Bar</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.76 Water, 15 Bar</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.77 Water, Satiated</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.78 Water Temperature</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.79 Wind Erodibility Group and
Index</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.80 Guides for Estimating Risk of
Corrosion Potential for Uncoated Steel</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.81 Guide for Estimating Risk of
Corrosion Potential for Concrete</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.82 Crop Names and Units of Measure
Refer to the NASIS-related metadata at</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.83 Classification of Soils and
Soil-Aggregate Mixtures for the AASHTO System</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.84 Potential Frost Action</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.85 Distribution of Design Freezing
Index Values in the Continental United States</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.86 Estimating LL and PI from Percent
and Type of Clay</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.87 Texture Triangle and Particle-Size
Limits of AASHTO, USDA, and Unified Classification Systems</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.88 Guide for Estimating Ksat from Soil
Properties</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.89 Guide to Estimating Water Movement
Through Bedrock for Layers Designated as R and Cr</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.90 Rock Fragment Modifier of
Texture</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.91 Soil Erodibility Nomograph</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.92 Kw Value Associated With Various
Fragment Contents</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.93 General Guidelines for Assigning
Soil Loss Tolerance "T"</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.94 Texture Class, Texture Modifier,
and Terms Used in Lieu of Texture</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.95 Wind Erodibility Groups (WEG) and
Index</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.96 Key Landforms and Their
Susceptibility to Slippage</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.97 Example Worksheets for Soil
Moisture State by Month and Depth</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.98 NASIS Calculation for Estimating
AASHTO Group Index</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.99 NASIS Calculation for Estimating
Cation-Exchange Capacity</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.1 Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.2 General</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.3 Developing Soil Potential
Ratings</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.4 Steps in Preparing Soil Potential
Ratings</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.5 Collecting Data</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.6 Definition of Soil Potential
Classes</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.7 Soil Potential Index Concept</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.8 Procedures for Preparing Soil
Potential Ratings</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.9 Defining Soil Use, Performance
Standards, and Criteria for Evaluation</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.10 Terminology for Limitations and
Corrective Measures</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.11 Format for Presenting Soil
Potential Ratings</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">621.12 Analysis of Preparations and
Procedures for Soil Potential Ratings</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.0 Definition and Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.1 Procedures and Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.2 Land Capability Classification</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.3 Farmland Classification</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.4 Highly Erodible Land - Highly
Erodible Soil Map Unit List</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.5 Hydric Soils</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.6 Ecological Sites</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.7 Windbreaks</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.8 Wildlife Habitat</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.9 Plant Name, Common</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.10 Plant Name, Scientific</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.11 Ecological Site ID</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.12 Ecological Site Name</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.13 Earth Cover, Kind</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">622.20 Prime and Unique Farmlands</td>
</tr>
<tr class="even">
<td style="text-align: right;">624</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">624.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">624</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">624.1 Quality Concepts</td>
</tr>
<tr class="even">
<td style="text-align: right;">624</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">624.10 Soil Quality Test Kit (Instruction
Manual)</td>
</tr>
<tr class="odd">
<td style="text-align: right;">624</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">624.11 References</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.1 Policy and Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.2 Field Studies for Legend
Development</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.3 Map Units of Soil Surveys</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.4 Map Unit Components</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.5 Terms Used in Naming Map Units</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.6 Phases Used to Name Soil Map
Units</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.7 Soil Performance Data
Collection</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.8 Documentation</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.9 Ecological Site and Soil Correlation
Procedures</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.10 Miscellaneous Areas</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.11 Example of Form NRCS-SOI-1,
"Soil-Crop Yield Data"</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.12 Instructions for Completing Form
NRCS-SOI-1, "Soil-Crop Yield Data"</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.13 Identification Legend of Map Unit
Symbols and Names</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.14 Form NRCS-SOI-37A, "Feature and
Symbol Legend for Soil Survey"</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.15 Ecological Site and Soil
Correlation Checklist</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.16 Ecological Site Checklist</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.17 Matrix of Investigation Intensity
of Soil Surveys and Documentation</td>
</tr>
<tr class="even">
<td style="text-align: right;">629</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">629.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">629</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">629.1 Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">629</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">629.2 Definitions</td>
</tr>
<tr class="odd">
<td style="text-align: right;">629</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">629.3 References</td>
</tr>
<tr class="even">
<td style="text-align: right;">629</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">629.10 Lists of Landscape, Landform,
Microfeature, and Anthropogenic Feature Terms Contained in the
Glossary</td>
</tr>
<tr class="odd">
<td style="text-align: right;">629</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">629.11 List of Materials or
Material-Related, Structure, or Morphological-Feature Terms Contained in
the Glossary</td>
</tr>
<tr class="even">
<td style="text-align: right;">629</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">629.12 Genesis-Process Terms and Geologic
Time Terms Contained in the Glossary</td>
</tr>
<tr class="odd">
<td style="text-align: right;">629</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">629.13 North American Glacial Episodes and
General Geologic Time Scale 1, 2</td>
</tr>
<tr class="even">
<td style="text-align: right;">629</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">629.14 Till Terms</td>
</tr>
<tr class="odd">
<td style="text-align: right;">630</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">630.0 Definition and Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">630</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">630.1 Policy and Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">630</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">630.2 Criteria for Selecting or Revising
Benchmark Soils</td>
</tr>
<tr class="even">
<td style="text-align: right;">630</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">630.3 Maintaining a Record of Benchmark
Soil Data Needs</td>
</tr>
<tr class="odd">
<td style="text-align: right;">630</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">630.10 Sample Narrative Record for
Benchmark Soils</td>
</tr>
<tr class="even">
<td style="text-align: right;">631</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">631.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">631</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">631.1 Policy and Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">631</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">631.2 Kinds of Projects</td>
</tr>
<tr class="odd">
<td style="text-align: right;">631</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">631.3 Laboratory Investigation
Methods</td>
</tr>
<tr class="even">
<td style="text-align: right;">631</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">631.4 Field Investigation Methods</td>
</tr>
<tr class="odd">
<td style="text-align: right;">631</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">631.5 Investigations Planning</td>
</tr>
<tr class="even">
<td style="text-align: right;">631</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">631.6 Requesting Assistance</td>
</tr>
<tr class="odd">
<td style="text-align: right;">631</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">631.7 Laboratory Databases</td>
</tr>
<tr class="even">
<td style="text-align: right;">631</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">631.10 Research Work Plan Checklist</td>
</tr>
<tr class="odd">
<td style="text-align: right;">631</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">631.11 Example Research Work Plan</td>
</tr>
<tr class="even">
<td style="text-align: right;">631</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">631.12 Example of a Soil Characterization
Work Plan</td>
</tr>
<tr class="odd">
<td style="text-align: right;">638</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">638.0 Definition and Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">638</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">638.1 Procedures and Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">638</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">638.2 Components of the National Soil
Information System</td>
</tr>
<tr class="even">
<td style="text-align: right;">638</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">638.3 Managing Soil Spatial and Tabular
Databases</td>
</tr>
<tr class="odd">
<td style="text-align: right;">638</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">638.4 Soil Survey Goals and Progress</td>
</tr>
<tr class="even">
<td style="text-align: right;">638</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">638.5 Distribution of Soils Data</td>
</tr>
<tr class="odd">
<td style="text-align: right;">639</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">639.0 Definition and Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">639</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">639.1 Policy and Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">639</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">639.2 Soil Survey Application Security
Policy</td>
</tr>
<tr class="even">
<td style="text-align: right;">639</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">639.3 NASIS Organization and Database
Objects</td>
</tr>
<tr class="odd">
<td style="text-align: right;">639</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">639.4 Guidelines for Changing, Adding, or
Deleting Soil Property Data Elements</td>
</tr>
<tr class="even">
<td style="text-align: right;">639</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">639.10 Proposed Amendment to Soil Data
Dictionary</td>
</tr>
<tr class="odd">
<td style="text-align: right;">644</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">644.0 Definition and Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">644</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">644.1 Types of Soil Survey Delivery</td>
</tr>
<tr class="odd">
<td style="text-align: right;">644</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">644.2 Policy and Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">644</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">644.3 Soil Survey Products</td>
</tr>
<tr class="odd">
<td style="text-align: right;">644</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">644.4 Development of Point Data</td>
</tr>
<tr class="even">
<td style="text-align: right;">644</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">644.5 Development of Detailed Soil Survey
Information</td>
</tr>
<tr class="odd">
<td style="text-align: right;">644</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">644.6 Development of a Complete Soil
Survey Publication</td>
</tr>
<tr class="even">
<td style="text-align: right;">644</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">644.7 Development of the U.S. General Soil
Map</td>
</tr>
<tr class="odd">
<td style="text-align: right;">644</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">644.10 Sections of a Soil Survey
Publication</td>
</tr>
<tr class="even">
<td style="text-align: right;">644</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">644.11 Record Sheet for Collating State
Orders for Published Soil Surveys</td>
</tr>
<tr class="odd">
<td style="text-align: right;">644</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">644.12 Example of Letter to Senator -
Notification of Availability of Soil Survey</td>
</tr>
<tr class="even">
<td style="text-align: right;">647</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">647.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">647</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">647.1 Procedures and Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">647</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">647.2 Imagery</td>
</tr>
<tr class="odd">
<td style="text-align: right;">647</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">647.3 SSURGO Characteristics</td>
</tr>
<tr class="even">
<td style="text-align: right;">647</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">647.4 Data Capture Specifications</td>
</tr>
<tr class="odd">
<td style="text-align: right;">647</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">647.5 Archiving</td>
</tr>
<tr class="even">
<td style="text-align: right;">647</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">647.6 Digital Map Finishing and
Print-on-Demand Maps</td>
</tr>
<tr class="odd">
<td style="text-align: right;">647</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">647.07 Soil Survey Geographic Data
Certification</td>
</tr>
<tr class="even">
<td style="text-align: right;">647</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">647.8 Digital Map Finishing and
Print-on-Demand Maps Flowchart</td>
</tr>
<tr class="odd">
<td style="text-align: right;">647</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">647.9 Digital Map Finishing and
Print-on-Demand Maps Specifications</td>
</tr>
<tr class="even">
<td style="text-align: right;">647</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">647.10 Digital Map Finishing
Checklist</td>
</tr>
<tr class="odd">
<td style="text-align: right;">647</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">647.11 Digital Map Finishing
Certification</td>
</tr>
<tr class="even">
<td style="text-align: right;">647</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">647.12 Glossary</td>
</tr>
<tr class="odd">
<td style="text-align: right;">647</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">647.13 SSURGO Metadata Template</td>
</tr>
<tr class="even">
<td style="text-align: right;">648</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">648.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">648</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">648.1 Accuracy and Uncertainty</td>
</tr>
<tr class="even">
<td style="text-align: right;">648</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">648.2 References</td>
</tr>
<tr class="odd">
<td style="text-align: right;">648</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">648.10 Glossary</td>
</tr>
<tr class="even">
<td style="text-align: right;">648</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">648.11 Digital Soil Mapping Workflow</td>
</tr>
<tr class="odd">
<td style="text-align: right;">648</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">648.12 Raster Soil Survey Areas</td>
</tr>
<tr class="even">
<td style="text-align: right;">648</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">648.13 Metadata</td>
</tr>
<tr class="odd">
<td style="text-align: right;">648</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">648.14 References</td>
</tr>
<tr class="even">
<td style="text-align: right;">649</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">649.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">649</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">649.1 Policy and Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">649</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">649.2 Descriptions</td>
</tr>
<tr class="odd">
<td style="text-align: right;">649</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">649.3 Land Resource Area Attributes</td>
</tr>
<tr class="even">
<td style="text-align: right;">649</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">649.4 Cartographic Standards</td>
</tr>
<tr class="odd">
<td style="text-align: right;">649</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">649.5 Names and Symbols</td>
</tr>
<tr class="even">
<td style="text-align: right;">649</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">649.6 Coding System for Hierarchical Land
Resource Areas for Ecological Sites</td>
</tr>
<tr class="odd">
<td style="text-align: right;">649</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">649.7 Establishing or Revising Land
Resource Areas</td>
</tr>
<tr class="even">
<td style="text-align: right;">649</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">649.8 Publication</td>
</tr>
<tr class="odd">
<td style="text-align: right;">649</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">649.10 References</td>
</tr>
<tr class="even">
<td style="text-align: right;">651</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">651.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">651</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">651.1 Policy and Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">651</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">651.2 General</td>
</tr>
<tr class="odd">
<td style="text-align: right;">651</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">651.3 Restrictions</td>
</tr>
<tr class="even">
<td style="text-align: right;">651</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">651.4 Providing Quality Assurance, Quality
Control, and Review</td>
</tr>
<tr class="odd">
<td style="text-align: right;">651</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">651.5 Labeling of Advance Soil Survey
Information</td>
</tr>
<tr class="even">
<td style="text-align: right;">655</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">655.0 Definition</td>
</tr>
<tr class="odd">
<td style="text-align: right;">655</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">655.1 Types of Service</td>
</tr>
<tr class="even">
<td style="text-align: right;">655</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">655.2 Policy</td>
</tr>
<tr class="odd">
<td style="text-align: right;">655</td>
<td style="text-align: left;"></td>
<td style="text-align: left;">655.3 Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">656</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">656.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">656</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">656.1 Boating Safety</td>
</tr>
</tbody>
</table>
