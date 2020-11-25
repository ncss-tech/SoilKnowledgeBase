Soil Knowledge Base
-------------------

[![R build
status](https://github.com/brownag/SoilKnowledgeBase/workflows/R-CMD-check/badge.svg)](https://github.com/brownag/SoilKnowledgeBase/actions)

A soil “knowledge base” centered around the **National Cooperative Soil
Survey** (NCSS) standards as used by the **USDA-NRCS** and defined in
the **National Soil Survey Handbook** (NSSH). This repository is also an
**R** package that facilitates the version control of products from
various data sources in compressed `.rda` format, … \[ and more? \]

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
