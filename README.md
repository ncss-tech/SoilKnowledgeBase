Soil Knowledge Base
-------------------

[![R build
status](https://github.com/brownag/SoilKnowledgeBase/workflows/R-CMD-check/badge.svg)](https://github.com/brownag/SoilKnowledgeBase/actions)

A soil “knowledge base” centered around the **National Cooperative Soil
Survey** (NCSS) standards as used by the **USDA-NRCS** and defined in
the **National Soil Survey Handbook** (NSSH). This repository is also an
**R** package that facilitates the version control of and programmatic
access to products from official data sources.

### Get started

    # install.packages("remotes")
    remotes::install_github("brownag/SoilKnowledgeBase")

    SoilKnowledgeBase::parse_nssh_structure()

### The Structure of the National Soil Survey Handbook (NSSH)

<table>
<colgroup>
<col style="width: 10%" />
<col style="width: 28%" />
<col style="width: 22%" />
<col style="width: 38%" />
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
<td style="text-align: left;">Introduction</td>
<td style="text-align: left;">General</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41511.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">600 B</td>
<td style="text-align: left;">Introduction</td>
<td style="text-align: left;">General</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41512.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">601 A</td>
<td style="text-align: left;">NCSS Organization</td>
<td style="text-align: left;">General</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41513.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">601 B</td>
<td style="text-align: left;">NCSS Organization</td>
<td style="text-align: left;">General</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41514.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">602 A</td>
<td style="text-align: left;">Conferences of the NCSS</td>
<td style="text-align: left;">General</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/44090.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">602 B</td>
<td style="text-align: left;">Conferences of the NCSS</td>
<td style="text-align: left;">General</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/44092.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">606 A</td>
<td style="text-align: left;">Working Agreements</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41517.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">606 B</td>
<td style="text-align: left;">Working Agreements</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41518.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">607 A</td>
<td style="text-align: left;">Initial Survey Preparation</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41519.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">607 B</td>
<td style="text-align: left;">Initial Survey Preparation</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41520.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">608 A</td>
<td style="text-align: left;">Program Management</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41521.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">608 B</td>
<td style="text-align: left;">Program Management</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41522.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">609 A</td>
<td style="text-align: left;">QC/QA* and Soil Correlation</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41523.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">609 B</td>
<td style="text-align: left;">QC/QA* and Soil Correlation</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41640.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">610 A</td>
<td style="text-align: left;">Updating Soil Surveys</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41595.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">610 B</td>
<td style="text-align: left;">Updating Soil Surveys</td>
<td style="text-align: left;">Operations And Management</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41596.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">614 A</td>
<td style="text-align: left;">Applying Soil Taxonomy</td>
<td style="text-align: left;">Soil Classification</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41524.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">614 B</td>
<td style="text-align: left;">Applying Soil Taxonomy</td>
<td style="text-align: left;">Soil Classification</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41525.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">617 A</td>
<td style="text-align: left;">Soil Survey Interpretations</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41979.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">617 B</td>
<td style="text-align: left;">Soil Survey Interpretations</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41980.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">618 A</td>
<td style="text-align: left;">Soil Properties and Qualities</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/44371.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">618 B</td>
<td style="text-align: left;">Soil Properties and Qualities</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/44089.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">621 A</td>
<td style="text-align: left;">Soil Potential Ratings</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41983.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">621 B</td>
<td style="text-align: left;">Soil Potential Ratings</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41984.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">622 A</td>
<td style="text-align: left;">Interpretative Groups</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41985.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">622 B</td>
<td style="text-align: left;">Interpretative Groups</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41986.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">624 A</td>
<td style="text-align: left;">Soil Quality</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41987.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">624 B</td>
<td style="text-align: left;">Soil Quality</td>
<td style="text-align: left;">Soil Interpretations</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41988.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">627 A</td>
<td style="text-align: left;">Legend Development and Data Collection</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/44091.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">627 B</td>
<td style="text-align: left;">Legend Development and Data Collection</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41991.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">629 A</td>
<td style="text-align: left;">Glossary Of Landform and Geologic Terms</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41992.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">629 B</td>
<td style="text-align: left;">Glossary Of Landform and Geologic Terms</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41993.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">630 A</td>
<td style="text-align: left;">Benchmark Soils</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41994.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">630 B</td>
<td style="text-align: left;">Benchmark Soils</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41990.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">631 A</td>
<td style="text-align: left;">Soil Survey Investigations</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41995.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">631 B</td>
<td style="text-align: left;">Soil Survey Investigations</td>
<td style="text-align: left;">Soil Survey Field Procedures</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41996.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">638 A</td>
<td style="text-align: left;">Soil Data Systems</td>
<td style="text-align: left;">Soil Survey Information Systems</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41997.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">639 A</td>
<td style="text-align: left;">National Soil Information System (NASIS)</td>
<td style="text-align: left;">Soil Survey Information Systems</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41998.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">639 B</td>
<td style="text-align: left;">National Soil Information System (NASIS)</td>
<td style="text-align: left;">Soil Survey Information Systems</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/41999.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">644 A</td>
<td style="text-align: left;">Delivering Soil Survey Information</td>
<td style="text-align: left;">Soil Survey Publications</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/42000.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">644 B</td>
<td style="text-align: left;">Delivering Soil Survey Information</td>
<td style="text-align: left;">Soil Survey Publications</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/42001.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">647 A</td>
<td style="text-align: left;">Soil Map Development</td>
<td style="text-align: left;">Soil Maps</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/42002.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">647 B</td>
<td style="text-align: left;">Soil Map Development</td>
<td style="text-align: left;">Soil Maps</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/42003.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">648 A</td>
<td style="text-align: left;">Digital Soil Mapping - Raster Products</td>
<td style="text-align: left;">Soil Maps</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/42414.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">648 B</td>
<td style="text-align: left;">Digital Soil Mapping - Raster Products</td>
<td style="text-align: left;">Soil Maps</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/42415.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">649 A</td>
<td style="text-align: left;">Land Resource Areas</td>
<td style="text-align: left;">Soil Maps</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/42004.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">649 B</td>
<td style="text-align: left;">Land Resource Areas</td>
<td style="text-align: left;">Soil Maps</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/42005.wba">LINK</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">651 A</td>
<td style="text-align: left;">Advance Soil Survey Information</td>
<td style="text-align: left;">Information Delivery</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/42006.wba">LINK</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">655 A</td>
<td style="text-align: left;">Technical Soil Services</td>
<td style="text-align: left;">Information Delivery</td>
<td style="text-align: left;"><a href="https://directives.sc.egov.usda.gov/42024.wba">LINK</a></td>
</tr>
</tbody>
</table>

-   \* QC/QA = Quality Control, Quality Assurance

### Coming Soon: Links to headers

<table>
<colgroup>
<col style="width: 4%" />
<col style="width: 6%" />
<col style="width: 89%" />
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
<td style="text-align: left;">600.0 The Mission of the Soil Science Division, Natural Resources Conservation</td>
</tr>
<tr class="even">
<td style="text-align: right;">600</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">600.1 Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">600</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">600.2 National Cooperative Soil Survey (NCSS) Standards</td>
</tr>
<tr class="even">
<td style="text-align: right;">600</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">600.3 Principal References and Their Maintenance</td>
</tr>
<tr class="odd">
<td style="text-align: right;">600</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">600.4 Conventions and Terminology</td>
</tr>
<tr class="even">
<td style="text-align: right;">600</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">600.5 Standards of the National Cooperative Soil Survey</td>
</tr>
<tr class="odd">
<td style="text-align: right;">600</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">600.10 List of Technical References</td>
</tr>
<tr class="even">
<td style="text-align: right;">600</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">600.11 Tracking Flowchart for NSSH Amendments (After Figure 503-D2: Workflow</td>
</tr>
<tr class="odd">
<td style="text-align: right;">601</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">601.0 Definition</td>
</tr>
<tr class="even">
<td style="text-align: right;">601</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">601.1 NRCS Organization and Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">601</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">601.10 Primary Federal Partners</td>
</tr>
<tr class="even">
<td style="text-align: right;">602</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">602.0 Definition</td>
</tr>
<tr class="odd">
<td style="text-align: right;">602</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">602.10 Bylaws of the National Cooperative Soil Survey Conference</td>
</tr>
<tr class="even">
<td style="text-align: right;">602</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">602.11 Bylaws of the Western Regional Cooperative Soil Survey Conference</td>
</tr>
<tr class="odd">
<td style="text-align: right;">602</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">602.12 Bylaws of the Northeast Cooperative Soil Survey Conference (Revised</td>
</tr>
<tr class="even">
<td style="text-align: right;">602</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">602.13 Bylaws of the North Central Regional Soil Survey Conference (Revised</td>
</tr>
<tr class="odd">
<td style="text-align: right;">602</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">602.14 Bylaws of the Southern Regional Cooperative Soil Survey Conference</td>
</tr>
<tr class="even">
<td style="text-align: right;">602</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">602.15 Conducting NCSS Conferences</td>
</tr>
<tr class="odd">
<td style="text-align: right;">606</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">606.0 Definition</td>
</tr>
<tr class="even">
<td style="text-align: right;">606</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">606.1 Policy and Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">606</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">606.10 Template for an MLRA Regionwide Memorandum of Understanding</td>
</tr>
<tr class="even">
<td style="text-align: right;">607</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">607.0 Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">607</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">607.1 Policy and Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">607</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">607.2 Preliminary Survey Activities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">607</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">607.10 Reference Materials for Soil Surveys</td>
</tr>
<tr class="even">
<td style="text-align: right;">607</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">607.11 Example of a Procedure for Geodatabase Development, File Naming,</td>
</tr>
<tr class="odd">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.0 Definition and Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.1 Responsibilities and Organization</td>
</tr>
<tr class="odd">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.2 Soil Survey Area Designation</td>
</tr>
<tr class="even">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.3 Areas of Limited Access, Denied Access Areas, and Areas Not Completed</td>
</tr>
<tr class="odd">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.4 Determining Workloads</td>
</tr>
<tr class="even">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.5 Priorities for Soil Survey Activities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.6 Planning Workflow</td>
</tr>
<tr class="even">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.7 Goals and Progress</td>
</tr>
<tr class="odd">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.8 Developing Other Schedules for Soil Survey Operations</td>
</tr>
<tr class="even">
<td style="text-align: right;">608</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">608.9 Status Maps</td>
</tr>
<tr class="odd">
<td style="text-align: right;">608</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">608.10 Long-Range Plan for Initial Soil Surveys</td>
</tr>
<tr class="even">
<td style="text-align: right;">608</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">608.11 Annual Plan of Operations for Initial Soil Surveys</td>
</tr>
<tr class="odd">
<td style="text-align: right;">608</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">608.12 Goal and Progress Guidelines</td>
</tr>
<tr class="even">
<td style="text-align: right;">608</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">608.13 Business Area Responsibilities for Goals and Progress</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.0 Definition and Purpose of Quality Control and Quality Assurance</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.1 Policy and Responsibilities for Quality Control and Quality Assurance</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.2 Soil Correlation</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.3 Seamless Soil Survey</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.4 Quality Control Reviews</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.5 Quality Assurance Reviews</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.6 Field Assistance Visits</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.7 Final Soil Survey Field Activities for Initial Soil Survey Projects</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">609.8 General Soil Maps, Index Maps, and Location Maps</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.10 Format for Correlation Document</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.11 List of Soil Property or Quality Attributes for Joining</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.12 Quality Control Template for Initial Soil Surveys (subject to change to</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.13 Outline of Items Considered in an Operations Management Review or</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.14 Initial Field Review Checklist for Initial Soil Surveys</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.15 Quality Assurance Worksheet for Initial Soil Surveys (subject to change</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.16 Progress Field Review Checklist for Initial Soil Surveys</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.17 Final Field Review Checklist for Initial Soil Surveys</td>
</tr>
<tr class="even">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.18 Project Review Checklist for MLRA Soil Surveys</td>
</tr>
<tr class="odd">
<td style="text-align: right;">609</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">609.19 Quality Assurance Worksheet for MLRA Soil Surveys (subject to change</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.1 Policy and Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.2 Inventory and Assessment</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.3 Update Strategies</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.4 Project Plan</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.5 Prioritizing and Ranking</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.6 Long-Range Plan</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.7 Annual Plan of Operation (APO)</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.8 Certification of Soils Data</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">610.9 Publication of Soils Data</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">610.10 Agency Resources Concerns</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">610.11 Information Items for the Inventory and Assessment</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">610.12 Resources for the Inventory and Assessment</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">610.13 Sample Project Evaluation Worksheet</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">610.14 Project Plan Checklist</td>
</tr>
<tr class="odd">
<td style="text-align: right;">610</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">610.15 Example of a Project Evaluation Ranking Procedure</td>
</tr>
<tr class="even">
<td style="text-align: right;">610</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">610.16 Project Description Examples</td>
</tr>
<tr class="odd">
<td style="text-align: right;">614</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">614.0 Definition and Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">614</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">614.1 Policy and Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">614</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">614.2 National Soil Classification System</td>
</tr>
<tr class="even">
<td style="text-align: right;">614</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">614.3 Use of the National Soil Classification System in Soil Surveys</td>
</tr>
<tr class="odd">
<td style="text-align: right;">614</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">614.4 Soil Taxonomy Committees, Work Groups, and Referees</td>
</tr>
<tr class="even">
<td style="text-align: right;">614</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">614.5 Procedures for Amending Soil Taxonomy</td>
</tr>
<tr class="odd">
<td style="text-align: right;">614</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">614.6 The Soil Series</td>
</tr>
<tr class="even">
<td style="text-align: right;">614</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">614.10 Flow Chart of Amendment Process</td>
</tr>
<tr class="odd">
<td style="text-align: right;">614</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">614.11 Example of an Official Soil Series Description in HTML</td>
</tr>
<tr class="even">
<td style="text-align: right;">614</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">614.12 Explanation and Content of a Soil Series Description</td>
</tr>
<tr class="odd">
<td style="text-align: right;">614</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">614.13 Rounding Numbers from Laboratory Data</td>
</tr>
<tr class="even">
<td style="text-align: right;">614</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">614.14 Significant Digits for Soil Property or Quality Measurements Used as Criteria</td>
</tr>
<tr class="odd">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.0 Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.1 Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.2 Interpretations for Map Unit Components and Map Units</td>
</tr>
<tr class="even">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.3 Developing and Maintaining Interpretation Guides and Ratings</td>
</tr>
<tr class="odd">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.4 Reviewing and Implementing Soil Interpretative Technologies</td>
</tr>
<tr class="even">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.5 The National Soil Information System</td>
</tr>
<tr class="odd">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.6 Presenting Soil Interpretations</td>
</tr>
<tr class="even">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.7 Updating Soil Interpretations</td>
</tr>
<tr class="odd">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.8 Coordinating Soil Survey Interpretations</td>
</tr>
<tr class="even">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.9 Writing Soil Interpretation Criteria</td>
</tr>
<tr class="odd">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.10 Documenting Soil Interpretation Criteria</td>
</tr>
<tr class="even">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.11 Requirements for Naming Reports and Interpretations</td>
</tr>
<tr class="odd">
<td style="text-align: right;">617</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">617.12 Interpretation Overrides</td>
</tr>
<tr class="even">
<td style="text-align: right;">617</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">617.20 Example of Descriptions for Documenting Interpretations</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.0 Definition and Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.1 Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.2 Collecting, Testing, and Populating Soil Property Data</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.3 Soil Properties and Soil Qualities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.4 Albedo, Dry</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.5 Artifacts in the Soil</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.6 Available Water Capacity</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.7 Bulk Density, One-Third Bar</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.8 Bulk Density, Oven Dry</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.9 Bulk Density, Satiated</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.10 Calcium Carbonate Equivalent</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.11 Cation-Exchange Capacity NH4OAc pH 7</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.12 Climatic Setting</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.13 Continuous Inundation Class, Depth, and Month</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.14 Corrosion</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.15 Crop Name and Yield</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.16 Diagnostic Horizon Feature – Depth to Bottom</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.17 Diagnostic Horizon Feature – Depth to Top</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.18 Diagnostic Horizon Feature – Kind</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.19 Drainage Class</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.20 Effective Cation-Exchange Capacity</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.21 Electrical Conductivity</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">648.22 Electrical Conductivity 1:5 (volume)</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.23 Elevation</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.24 Engineering Classification</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.25 Erosion Accelerated, Kind</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.26 Erosion Class</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.27 Excavation Difficulty Classes</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.28 Exchangeable Sodium</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.29 Extractable Acidity</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.30 Extractable Aluminum</td>
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
<td style="text-align: left;">618.41 Landscape, Landform, Microfeature, Anthroscape, Anthropogenic</td>
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
<td style="text-align: left;">618.45 Parent Material, Kind, Modifier, and Origin</td>
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
<td style="text-align: left;">618.50 Ponding Depth, Duration Class, Frequency Class, and Month</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.51 Pores</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.52 Reaction, Soil (pH)</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.53 Restriction Kind, Depth, Thickness, and Hardness</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.54 Saturated Hydraulic Conductivity</td>
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
<td style="text-align: left;">618.59 Soil Erodibility Factors, USLE, RUSLE2</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.60 Soil Erodibility Factors for WEPP</td>
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
<td style="text-align: left;">618.68 Taxonomic Family Temperature Class</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.69 Taxonomic Moisture Class</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.70 Taxonomic Moisture Subclass (Subclasses of Soil Moisture Regimes)</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.71 Taxonomic Temperature Regime (Soil Temperature Regimes)</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">618.72 Texture Class, Texture Modifier, and Terms Used in Lieu of Texture</td>
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
<td style="text-align: left;">618.79 Wind Erodibility Group and Index</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.80 Guides for Estimating Risk of Corrosion Potential for Uncoated Steel</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.81 Guide for Estimating Risk of Corrosion Potential for Concrete</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.82 Crop Names and Units of Measure</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.83 Classification of Soils and Soil-Aggregate Mixtures for the AASHTO System</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.84 Potential Frost Action</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.85 Distribution of Design Freezing Index Values in the Continental United</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.86 Estimating LL and PI from Percent and Type of Clay</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.87 Texture Triangle and Particle-Size Limits of AASHTO, USDA, and Unified</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.88 Guide for Estimating Ksat from Soil Properties</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.89 Guide to Estimating Water Movement Through Bedrock for Layers</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.90 Rock Fragment Modifier of Texture</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.91 Soil Erodibility Nomograph</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.92 Kw Value Associated With Various Fragment Contents</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.93 General Guidelines for Assigning Soil Loss Tolerance “T”</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.94 Texture Class, Texture Modifier, and Terms Used in Lieu of Texture</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.95 Wind Erodibility Groups (WEG) and Index</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.96 Key Landforms and Their Susceptibility to Slippage</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.97 Example Worksheets for Soil Moisture State by Month and Depth</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.98 NASIS Calculation for Estimating AASHTO Group Index</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.99 NASIS Calculation for Estimating Cation-Exchange Capacity</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.100 NASIS Calculation for Estimating Effective Cation-Exchange Capacity</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.101 NASIS Calculation for Estimating Extractable Acidity</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.102 NASIS Calculation for Estimating Liquid Limit and Plasticity Index</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.103 NASIS Calculation for Estimating Particle Size</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.104 NASIS Calculation for Estimating Rock Fragments and Percent Passing</td>
</tr>
<tr class="odd">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.105 NASIS Calculation for Estimating Water Content Data</td>
</tr>
<tr class="even">
<td style="text-align: right;">618</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">618.106 References</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.0 Definition and Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.1 Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.2 General</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.3 Developing Soil Potential Ratings</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.4 Steps in Preparing Soil Potential Ratings</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.5 Collecting Data</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.6 Definition of Soil Potential Classes</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.7 Soil Potential Index Concept</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.8 Procedures for Preparing Soil Potential Ratings</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.9 Defining Soil Use, Performance Standards, and Criteria for Evaluation</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.10 Terminology for Limitations and Corrective Measures</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">621.11 Format for Presenting Soil Potential Ratings</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">621.12 Analysis of Preparations and Procedures for Soil Potential Ratings</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">621.13 Soil Potential Ratings for Forest Land (Beta County)</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">621.14 Soil Potential for Dwellings Without Basements</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">621.15 List of Corrective Measures and Cost</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">621.16 Reserved (Worksheet for Preparing Soil Potential Ratings)</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">621.17 Explanation of Worksheets for Preparing Soil Potential Ratings for Forest</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">621.18 Reserved (Worksheet for Preparing Soil Potential Ratings for Forest Land</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">621.19 Reserved (Worksheet for Preparing Soil Potential Ratings for Septic Tank</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">621.20 Reserved (Worksheet for Preparing Soil Potential Ratings for Dwellings</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">621.21 Explanation of Soil Potential Ratings for Maps or Reports</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">621.22 Soil Potential Ratings for Septic Tank Absorption Fields</td>
</tr>
<tr class="even">
<td style="text-align: right;">621</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">621.23 Soil Potential Ratings for Cropland</td>
</tr>
<tr class="odd">
<td style="text-align: right;">621</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">621.24 Soil Potential Ratings and Corrective Measures for Cropland, Pastureland, Forest Land, and Residential</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.1 Procedures and Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.2 Land Capability Classification</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.3 Farmland Classification</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.4 Highly Erodible Land – Highly Erodible Soil Map Unit List</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.5 Hydric Soils</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.6 Ecological Sites</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.7 Windbreaks</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.8 Wildlife Habitat</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.9 Plant Name, Common</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.10 Plant Name, Scientific</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.11 Ecological Site ID</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.12 Ecological Site Name</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">622.13 Earth Cover, Kind</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">622.20 Prime and Unique Farmlands</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">622.21 Example of Soil Properties and Qualities Used to Assign Land Capability</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">622.22 Guide for Assigning Land Capability Classes to All Map Unit Components in California</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">622.23 Guides for Assigning Land Capability Subclasses to Soil Map Unit Components in California</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">622.24 Guide for Assigning Land Capability Units to Soil Map Unit Components in</td>
</tr>
<tr class="odd">
<td style="text-align: right;">622</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">622.25 Guide for Assigning Land Capability Classes to All Map Unit Components in Indiana</td>
</tr>
<tr class="even">
<td style="text-align: right;">622</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">622.26 Guide for Assigning Land Capability Subclasses to Soil Map Unit</td>
</tr>
<tr class="odd">
<td style="text-align: right;">624</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">624.0 Definition and Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">624</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">624.1 Quality Concepts</td>
</tr>
<tr class="odd">
<td style="text-align: right;">624</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">624.10 Soil Quality Test Kit (Instruction Manual)</td>
</tr>
<tr class="even">
<td style="text-align: right;">624</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">624.11 References</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.0 Definition and Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.1 Policy and Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.2 Field Studies for Legend Development</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.3 Map Units of Soil Surveys</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.4 Map Unit Components</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">727.5 Terms Used in Naming Map Units</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.6 Phases Used to Name Soil Map Units</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.7 Soil Performance Data Collection</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.8 Documentation</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">627.9 Ecological Site and Soil Correlation Procedures</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.10 Miscellaneous Areas</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.11 Example of Form NRCS-SOI-1, “Soil-Crop Yield Data”</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.12 Instructions for Completing Form NRCS-SOI-1, “Soil-Crop Yield Data”</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.13 Identification Legend of Map Unit Symbols and Names</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.14 Form NRCS-SOI-37A, “Feature and Symbol Legend for Soil Survey”</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.15 Ecological Site and Soil Correlation Checklist</td>
</tr>
<tr class="odd">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.16 Ecological Site Checklist</td>
</tr>
<tr class="even">
<td style="text-align: right;">627</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">627.17 Matrix of Investigation Intensity of Soil Surveys and Documentation</td>
</tr>
<tr class="odd">
<td style="text-align: right;">629</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">629.0 Definition and Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">629</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">629.1 Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">629</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">629.2 Definitions</td>
</tr>
<tr class="even">
<td style="text-align: right;">629</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">629.3 References</td>
</tr>
<tr class="odd">
<td style="text-align: right;">629</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">629.10 Lists of Landscape, Landform, Microfeature, and Anthropogenic Feature</td>
</tr>
<tr class="even">
<td style="text-align: right;">629</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">629.11 List of Materials or Material-Related, Structure, or Morphological-Feature</td>
</tr>
<tr class="odd">
<td style="text-align: right;">629</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">629.12 Genesis-Process Terms and Geologic Time Terms Contained in the</td>
</tr>
<tr class="even">
<td style="text-align: right;">629</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">629.13 North American Glacial Episodes and General Geologic Time Scale 1, 2</td>
</tr>
<tr class="odd">
<td style="text-align: right;">629</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">629.14 Till Terms</td>
</tr>
<tr class="even">
<td style="text-align: right;">629</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">629.15 Pyroclastic Terms</td>
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
<td style="text-align: left;">630.2 Criteria for Selecting or Revising Benchmark Soils</td>
</tr>
<tr class="even">
<td style="text-align: right;">630</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">630.3 Maintaining a Record of Benchmark Soil Data Needs</td>
</tr>
<tr class="odd">
<td style="text-align: right;">630</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">630.10 Sample Narrative Record for Benchmark Soils</td>
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
<td style="text-align: left;">631.3 Laboratory Investigation Methods</td>
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
<td style="text-align: left;">631.12 Example of a Soil Characterization Work Plan</td>
</tr>
<tr class="odd">
<td style="text-align: right;">638</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">638.0 Definition and Purpose</td>
</tr>
<tr class="even">
<td style="text-align: right;">638</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">638.1 Procedures and Responsibilities</td>
</tr>
<tr class="odd">
<td style="text-align: right;">638</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">638.2 Components of the National Soil Information System</td>
</tr>
<tr class="even">
<td style="text-align: right;">638</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">638.3 Managing Soil Spatial and Tabular Databases</td>
</tr>
<tr class="odd">
<td style="text-align: right;">638</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">638.4 Soil Survey Goals and Progress</td>
</tr>
<tr class="even">
<td style="text-align: right;">638</td>
<td style="text-align: left;">A</td>
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
<td style="text-align: left;">639.2 Soil Survey Application Security Policy</td>
</tr>
<tr class="even">
<td style="text-align: right;">639</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">639.3 NASIS Organization and Database Objects</td>
</tr>
<tr class="odd">
<td style="text-align: right;">639</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">639.4 Guidelines for Changing, Adding, or Deleting Soil Property Data Elements</td>
</tr>
<tr class="even">
<td style="text-align: right;">639</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">639.10 Proposed Amendment to Soil Data Dictionary</td>
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
<td style="text-align: left;">644.5 Development of Detailed Soil Survey Information</td>
</tr>
<tr class="odd">
<td style="text-align: right;">644</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">644.6 Development of a Complete Soil Survey Publication</td>
</tr>
<tr class="even">
<td style="text-align: right;">644</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">644.7 Development of the U.S. General Soil Map</td>
</tr>
<tr class="odd">
<td style="text-align: right;">644</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">644.10 Sections of a Soil Survey Publication</td>
</tr>
<tr class="even">
<td style="text-align: right;">644</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">644.11 Record Sheet for Collating State Orders for Published Soil Surveys</td>
</tr>
<tr class="odd">
<td style="text-align: right;">644</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">644.12 Example of Letter to Senator – Notification of Availability of Soil Survey</td>
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
<td style="text-align: left;">647.6 Digital Map Finishing and Print-on-Demand Maps</td>
</tr>
<tr class="odd">
<td style="text-align: right;">647</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">647.10 Soil Survey Geographic Data Certification</td>
</tr>
<tr class="even">
<td style="text-align: right;">647</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">647.11 Digital Map Finishing and Print-on-Demand Maps Flowchart</td>
</tr>
<tr class="odd">
<td style="text-align: right;">647</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">647.12 Digital Map Finishing and Print-on-Demand Maps Specifications</td>
</tr>
<tr class="even">
<td style="text-align: right;">647</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">647.13 Digital Map Finishing Checklist</td>
</tr>
<tr class="odd">
<td style="text-align: right;">647</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">647.14 Digital Map Finishing Certification</td>
</tr>
<tr class="even">
<td style="text-align: right;">647</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">647.15 Glossary</td>
</tr>
<tr class="odd">
<td style="text-align: right;">647</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">647.16 SSURGO Metadata Template</td>
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
<td style="text-align: left;">649.6 Coding System for Hierarchical Land Resource Areas for Ecological Sites</td>
</tr>
<tr class="odd">
<td style="text-align: right;">649</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">649.7 Establishing or Revising Land Resource Areas</td>
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
<td style="text-align: left;">A</td>
<td style="text-align: left;">651.0 Definition and Purpose</td>
</tr>
<tr class="odd">
<td style="text-align: right;">651</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">651.1 Policy and Responsibilities</td>
</tr>
<tr class="even">
<td style="text-align: right;">651</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">651.2 General</td>
</tr>
<tr class="odd">
<td style="text-align: right;">651</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">651.3 Restrictions</td>
</tr>
<tr class="even">
<td style="text-align: right;">651</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">651.4 Providing Quality Assurance, Quality Control, and Review</td>
</tr>
<tr class="odd">
<td style="text-align: right;">651</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">651.5 Labeling of Advance Soil Survey Information</td>
</tr>
<tr class="even">
<td style="text-align: right;">655</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">655.0 Definition</td>
</tr>
<tr class="odd">
<td style="text-align: right;">655</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">655.1 Types of Service</td>
</tr>
<tr class="even">
<td style="text-align: right;">655</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">655.2 Policy</td>
</tr>
<tr class="odd">
<td style="text-align: right;">655</td>
<td style="text-align: left;">A</td>
<td style="text-align: left;">655.3 Responsibilities</td>
</tr>
</tbody>
</table>
