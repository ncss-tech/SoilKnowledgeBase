context("OSD Parsing")


## TODO: abstract as much as possible into helper functions

## TODO: add more tests for known problematic soils / work-arounds

## TODO: add drainage class tests

## TODO: add tests for greedy matches: e.g. 'fine sandy loam'

## NOTE: the first line must be "TYPICAL PEDON"


test_that("neutral hue specified without chroma", {
  
  # https://casoilresource.lawr.ucdavis.edu/sde/?series=zunhall#osd
  lines <- strsplit("TYPICAL PEDON: Zunhall silt loam, grass. (Colors are for dry soil unless otherwise noted.)

Ak1--0 to 2 inches; gray (N 6/) grayish brown 2.5Y 5/2 crushed silt loam, very dark gray (N 3/) moist; weak thin platy structure that parts to strong fine and very fine granular structure; hard, friable, slightly sticky and slightly plastic; root mat; many very fine interstitial pores; very strongly calcareous; strongly alkaline (pH 9.0); abrupt smooth boundary. (0 to 3 inches thick)

Ak2--2 to 6 inches; gray (N 6/) silt loam, very dark gray (N 3/) moist; moderate thin platy structure that parts to moderate very fine subangular angular blocky and weak fine and very fine granular structure; hard, friable, slightly sticky and slightly plastic; many very fine and fine roots; common very fine tubular pores; very strongly calcareous; very strongly alkaline (pH 9.2); clear smooth boundary. (3 to 6 inches thick)

ABk--6 to 17 inches; gray (N 6/) silt loam, dark gray (N 4/) moist; weak medium platy structure that parts to moderate fine and very fine granular structure; slightly hard, very friable, moderately sticky and moderately plastic; many very fine granular structure; slightly hard, very friable, sticky and plastic; many very fine and fine roots; many very fine tubular pores; very strongly calcareous; strongly alkaline (pH 8.9); clear wavy boundary. (2 to 12 inches thick)

Bk1--17 to 23 inches; light gray (N 7/) silty clay loam, gray (N 5/) moist weak very fine and fine granular structure; hard, very friable, moderately sticky and moderately plastic; many very fine and fine roots; many very fine tubular pores; very strongly calcareous; strongly alkaline (pH 8.5); clear wavy boundary. (4 to 10 inches thick)

Bk2--23 to 37 inches; light gray (N 7/) silty clay loam, gray (N 5/) moist; few fine distinct dark yellowish brown (10YR 3/4) moist redox concentrations; massive; hard, friable; moderately sticky and moderately plastic; very strongly calcareous, common 1 mm spots of lime; moderately alkaline (pH 8.4); gradual wavy boundary. (10 to 25 inches thick)

Bk3--37 to 46 inches; pale yellow (2.5Y 8/2) silty clay loam, light brownish gray (2.5Y 6/2) moist; few fine distinct yellowish brown (10YR 5/6) moist redox concentrations; massive; hard, friable, moderately sticky and moderately plastic; common very fine tubular pores; common indurated lime concretions up to 3 inches across; very strongly calcareous; moderately alkaline (pH 8.3); gardual wavy boundary. (0 to 12 inches thick)

Bk4--46 to 55 inches; pale yellow (2.5Y 8/2) silt loam, light brownish gray (2.5Y 6/2) moist; few fine distinct yellowish brown (10YR 5/6) moist redox concentrations; massive; hard, friable, moderately sticky and moderately plastic; common very fine tubular pores; many indurated and strongly cemented lime concretions up to 3 inches across; very strongly calcareous; moderately alkaline (pH 8.3).
", split = '\n')[[1]]
  
  z <- SoilKnowledgeBase:::.extractHzData(lines)
  
  # 7 horizons
  expect_equal(nrow(z), 7)
  
  # moist hue includes N/ style notation
  expect_equal(z$moist_hue, c('N', 'N', 'N', 'N', 'N', '2.5Y', '2.5Y'))
  
  # these have missing chroma
  expect_equal(z$moist_chroma, c(NA_real_, NA_real_, NA_real_, NA_real_, NA_real_, 2, 2))
})



# https://github.com/ncss-tech/SoilKnowledgeBase/issues/64
# anticipate expected / possible changes to OSDs starting May 2023
test_that("May 2023 changes to OSD style", {

  lines <- strsplit("Typical Pedon:
Gamma silt loam with a north-facing, linear, 1 percent slope in an alfalfa field at an elevation of 210 meters. (Colors are for dry soil unless otherwise noted.)

Ap—0 to 15 centimeters; grayish brown (10YR 5/2) silt loam, very dark grayish brown (10YR 3/2) moist; weak fine granular structure; slightly hard, friable; neutral (pH 6.7 in 1:1 water); abrupt smooth boundary. (10 to 23 centimeters thick)

C—15 to 33 centimeters; stratified grayish brown (10YR 5/2) and light brownish gray (10YR 6/2) silt loam, very dark grayish brown (10YR 3/2) and dark grayish brown (10YR 4/2) moist; massive with evident bedding planes; slightly hard, friable; few fine prominent reddish brown (5YR 4/4) masses of oxidized iron in the soil matrix; neutral (pH 6.7 in 1:1 water); abrupt smooth boundary. (15 to 30 centimeters thick)

Cg1—33 to 48 centimeters; stratified dark gray (10YR 4/1) and grayish brown (10YR 5/2) silt loam, very dark gray (10YR 3/1) and dark grayish brown (10YR 4/2) moist; massive with evident bedding planes; slightly hard, friable; few fine prominent reddish brown (5YR 4/4) masses of oxidized iron in the soil matrix; neutral (pH 6.8 in 1:1 water); abrupt smooth boundary. (10 to 25 centimeters thick)

Cg2—48 to 81 centimeters; stratified grayish brown (10YR 5/2) and light brownish gray (10YR 6/2) silt loam, very dark grayish brown (10YR 3/2) and dark grayish brown (10YR 4/2) moist; massive with evident bedding planes; slightly hard, friable; few fine prominent reddish brown (5YR 4/4) masses of oxidized iron in the soil matrix; neutral (pH 6.9 in 1:1 water); abrupt smooth boundary. (25 to 51 centimeters thick)

Agb1—81 to 112 centimeters; dark gray (10YR 4/1) silt loam, very dark gray (10YR 3/1) moist; massive; hard, friable; neutral (pH 6.8 in 1:1 water); gradual wavy boundary. (0 to 38 centimeters thick)

Agb2—112 to 153 centimeters; dark gray (N 4/) silt loam, black (N 2.5/) moist; massive; hard, friable; neutral (pH 6.8 in 1:1 water).
", split = '\n')[[1]]

  z <- SoilKnowledgeBase:::.extractHzData(lines)

  expect_equal(nrow(z), 6)
  expect_equal(z$top, c(0, 15, 33, 48, 81, 112))

})






test_that("horizon depths (with unit conversion) and designation", {

  # MENDEL
  lines <- strsplit("TYPICAL PEDON:
                    A--0 to 13 cm; grayish brown (10YR 5/2) very cobbly coarse sandy loam, very dark grayish brown (10YR 3/2) moist; 76 percent sand; 17 percent silt; 7 percent clay; weak very fine and fine granular structure; slightly hard, friable, slightly sticky, nonplastic; many very fine, and common fine and medium roots throughout; common very fine, fine, and medium interstitial pores; 20 percent subrounded indurated granite gravel, 20 percent subrounded indurated granite cobbles, 5 percent subrounded indurated granite stones; NaF pH 8.9; moderately acid (pH 5.6); abrupt smooth boundary. (9 to 20 cm thick) Lab sample # 16N00926", split = '\n')[[1]]

  z <- SoilKnowledgeBase:::.extractHzData(lines)

  expect_true(
    all(
      z[, 1:3] == c('A', 0, 13)
    )
  )


  # CECIL
  lines <- strsplit("TYPICAL PEDON:
                    Bt2--26 to 42 inches; red (10R 4/8) clay; few fine prominent yellowish red (5YR 5/8) mottles; moderate medium subangular blocky structure; firm; sticky, plastic; common clay films on faces of peds; few fine flakes of mica; very strongly acid; gradual wavy boundary. (Combined thickness of the Bt horizon is 24 to 50 inches)", split = '\n')[[1]]

  z <- SoilKnowledgeBase:::.extractHzData(lines)

  # depths and horizon desgn.
  expect_true(
    all(
      z[, 1:3] == c('Bt2', 66, 107)
    )
  )


  # SYCAMORE: typical OCR errors, now fixed in the OSD but common elsewhere
  # NB: for testing typical pedon color parsing, moisture state statement is required for dry/moist to be ID'd right
  lines <- strsplit("TYPICAL PEDON:
                    Colors are for dry soil unless otherwise specified.
                    C--42 to 60 inches; stratified light brownish gray (lOYR 6/2) and pale brown (lOYR 6/3) loam, fine sandy loam, and loamy fine sand with some silty lenses, dark grayish brown and dark brown (lOYR 4/2 and 4/3) moist; many fine distinct yellowish brown and strong brown mottles; massive; slightly hard, friable; common very fine and fine pores; slightly calcareous, lime mainly disseminated; water table may fluctuate in this horizon depending on the level of the water in the river; moderately alkaline.", split = '\n')[[1]]

  z <- SoilKnowledgeBase:::.extractHzData(lines)

  # colors with OCR errors are parsed
  # lOYR is not valid level of hue, but can be identified as error and fixed downstream
  expect_true(
    all(
      z[, c('dry_hue', 'dry_value', 'dry_chroma')] == c('lOYR', 6, 2)
    )
  )

  # depths and horizon desgn.
  expect_true(
    all(
      z[, 1:3] == c('C', 107, 152)
    )
  )

  # DRUMMER
  lines <- strsplit("TYPICAL PEDON:
                    2Cg--119 to 152 cm (47 to 60 inches); dark gray (10YR 4/1) stratified loam and sandy loam; massive; friable; many medium prominent olive brown (2.5Y 4/4) masses of oxidized iron-manganese in the matrix; many medium distinct gray (N 5/) iron depletions in the matrix; slightly alkaline.", split = '\n')[[1]]

  z <- SoilKnowledgeBase:::.extractHzData(lines)

  expect_true(
    all(
      z[, 1:3] == c('2Cg', 119, 152)
    )
  )


  # IRON MOUNTAIN
  lines <- strsplit("TYPICAL PEDON:
                    R--23 cm ; hard volcanic breccia which is impervious to both roots and water .", split = '\n')[[1]]

  z <- SoilKnowledgeBase:::.extractHzData(lines)

  expect_true(
    all(
      z[, 1:2] == c('R', 23)
    )
  )

  expect_true(is.na(z$bottom))

})


# note: TYPICAL PEDON line must be included for the proper identification of default color moisture state
test_that("entire TYPICAL PEDON section", {

  # LUCY
  lines <- strsplit("TYPICAL PEDON: Lucy loamy sand, on a 2 percent convex slope in a cultivated field (Colors are for moist soil).

Ap--0 to 8 inches; dark grayish brown (10YR 4/2) loamy sand; weak fine granular structure; very friable; strongly acid; abrupt smooth boundary. (4 to 12 inches thick)

E--8 to 24 inches; strong brown (7.5YR 5/6) loamy sand; weak fine granular structure; very friable; strongly acid; abrupt smooth boundary. (12 to 35 inches thick)

Bt1--24 to 35 inches; yellowish red (5YR 4/6) sandy loam; weak medium subangular blocky structure; very friable; sand grains coated and bridged with clay; strongly acid; clear smooth boundary.

Bt2--35 to 70 inches; red (2.5YR 4/8) sandy clay loam; weak medium subangular blocky structure; friable; common faint clay films on faces of peds; strongly acid. (The Bt horizon extends to a depth of 60 inches or more.)", split = '\n')[[1]]


  z <- SoilKnowledgeBase:::.extractHzData(lines)

  # horizon designation
  expect_equal(z$name, c('Ap', 'E', 'Bt1', 'Bt2'))

  # top depth in cm
  expect_equal(z$top, c(0, 20, 61, 89))

  # bottom depth in cm
  expect_equal(z$bottom, c(20, 61, 89, 178))

  # moist colors
  expect_equal(z$moist_hue, c('10YR', '7.5YR', '5YR', '2.5YR'))
  expect_equal(z$moist_value, c(4, 5, 4, 4))
  expect_equal(z$moist_chroma, c(2, 6, 6, 8))

})




test_that("vebose example", {

  lines <- strsplit("TYPICAL PEDON: Mentz fine sandy loam, on a southwest facing, 0.7 percent slope in rangeland; elevation is 79 m (263 ft) (Colors are for moist soil unless otherwise stated.)

A1--0 to 30 cm (0 to 12 in); brown (10YR 4/3) fine sandy loam, brown (10YR 5/3) dry; weak medium subangular blocky structure parting to moderate very fine subangular blocky; soft, friable, slightly sticky and slightly plastic; many very fine and fine roots; common fine pores; common worm casts, common fine faint dark yellowish brown (10YR 3/4) masses of iron accumulation with clear boundaries; many fine and medium faint grayish brown (10YR 5/2) and dark grayish brown (10YR 4/2) iron depletions with diffuse boundaries; slightly acid; clear wavy boundary. (13 to 41 cm [5 to 16 in] thick)

A2--30 to 41 cm (12 to 16 in); 60 percent grayish brown (10YR 5/2) and 40 percent dark grayish brown (10YR 4/2) fine sandy loam, light brownish gray (10YR 6/2) and grayish brown (10YR 5/2) dry; weak medium subangular blocky structure parting to weak very fine subangular blocky; soft, friable, slightly sticky and slightly plastic many very fine and fine roots; common medium pores; common worm casts; few fine brown (10YR 4/3) masses of iron accumulation with diffuse boundaries; few fine and medium distinct dark yellowish brown (10YR 4/4) masses of iron accumulation with clear boundaries; strongly acid; abrupt wavy boundary. (0 to 25 cm [0 to 10 in])

Bt1--41 to 51 cm (16 to 20 in); 60 percent light brownish gray (10YR 6/2) and 40 percent gray (10YR 5/1) sandy clay, light gray (10YR 7/2) and gray (10YR 6/1) dry; moderate medium subangular blocky structure parting to strong fine angular blocky; extremely hard, extremely firm, very sticky and very plastic; common very fine and fine root; few cracks partly filled with material from above; 1 percent grayish brown (10YR 5/2) coatings on vertical ped faces; many distinct clay films on ped faces; 1 percent fine and medium rounded concretions of iron-manganese; many fine and medium distinct yellowish brown (10YR 5/6) and brownish yellow (10YR 6/6) masses of iron accumulation with diffuse boundaries; few fine prominent yellowish red (5YR 5/6) masses of iron accumulation with clear boundaries; 1 percent fine rounded siliceous pebbles; strongly acid; clear smooth boundary.

Bt2--51 to 76 cm (20 to 30 in); 70 percent gray (10YR 6/1) and 30 percent light brownish gray (10YR 6/2) sandy clay, light gray (10YR 7/1) and light gray (10YR 7/2) dry; moderate medium subangular blocky structure parting to strong fine angular block; extremely hard, extremely firm, very sticky and very plastic; few very fine and fine roots; few slickensides; few distinct pressure surfaces; few vertical cracks partly filled with material from above; many distinct clay films on ped faces; 1 percent fine and medium rounded concretions of iron-manganese; many fine and medium distinct yellowish brown (10YR 5/6) and light yellowish brown (10YR 6/4) masses of iron accumulation with diffuse boundaries; few fine and medium prominent yellowish red (5YR 5/6) masses of iron accumulation with clear and diffuse boundaries; 1 percent fine rounded siliceous pebbles; moderately acid- gradual smooth boundary. (combined thickness of the Bt1 and Bt2 horizons is 30 to 711 cm [12 to 28 in])

Bt3--76 to 104 cm (30 to 41 in); gray (10YR 6/1) sandy clay loam, light gray (10YR 7/1) dry; moderate medium subangular blocky structure parting to strong fine and medium angular block; extremely hard, extremely firm, very sticky and very plastic; few very fine and fine roots; few slickensides; few wedge-shaped aggregates; few distinct pressure surface; few vertical cracks partly filled with material from above; many distinct clay films on ped faces; 1 percent fine and medium rounded concretions of manganese; 1 percent very fine and fine barite crystals, common fine and medium prominent yellowish red (5YR 5/6) and few fine prominent red (2.5YR 5/8) masses of iron accumulation with clear boundaries; common fine and medium distinct light yellowish brown (10YR 6/4) and brownish yellow (10YR 6/6), and common fine to coarse distinct strong brown (7.5YR 5/6) masses of iron accumulation with diffuse boundaries; 1 percent fine rounded siliceous pebbles; moderately acid, gradual wavy boundary.

Bt4--104 to 122 cm (41 to 48 in); gray (10YR 6/1) sandy clay loam, light gray (10YR 7/1) dry; moderate medium subangular blocky structure parting to strong fine and medium angular block; extremely hard, extremely firm, very sticky and very plastic; few very fine and fine roots; few slickensides; few wedge-shaped aggregates; common prominent pressure surface; few vertical cracks partly filled with material from above; many distinct clay films on ped faces; 3 percent fine and medium rounded concretions of manganese; 1 percent very fine and fine barite crystals; many fine to coarse distinct light yellowish brown (10YR 6/4) and brownish yellow (10YR 6/6) and yellowish brown (10YR 5/6) masses of iron accumulation with diffuse boundaries; few fine distinct dark yellowish brown (10YR 4/6) masses of iron accumulation with diffuse boundaries; 1 percent fine rounded siliceous pebbles; neutral; gradual wavy boundary. (combined thickness of Bt3 and Bt4 horizons is 35 to 124 cm [14 to 49 in])

Btk--122 to 155 cm (48 to 61 in); 40 percent yellowish brown (10YR 5/6) and 40 percent brownish yellow (10YR 6/6) and 20 percent yellowish brown (10YR 5/4) sandy clay loam, 40 percent brownish yellow (10YR 6/6) and 40 percent yellow (10YR 7/6) and 20 percent light yellowish brown (10YR 6/4) dry; moderate coarse prismatic structure parting to strong fine and medium angular block; extremely hard, extremely firm, very sticky and very plastic; few very fine and fine roots; few slickensides; few wedge-shaped aggregates; few prominent pressure surface; few vertical cracks partly filled material from above; common distinct clay films on ped faces; 3 percent fine and medium rounded concretions of iron-manganese; 4 percent fine to coarse rounded concretions of calcium carbonate; few fine faint gray, light brownish gray and grayish brown iron depletions with diffuse boundaries; neutral; clear smooth boundary. (0 to 51 cm [0 to 20 in])

BCtk--155 to 168 cm (61 to 66 in); 40 percent light yellowish brown (10YR 6/4) and 40 percent yellowish brown (10YR 5/4) and 20 percent light gray (10YR 7/1) clay loam, 40 percent very pale brown (10YR 7/4) and 40 percent light yellowish brown (10YR 6/4) and 20 percent white (10YR 8/1) dry; moderate coarse prismatic structure parting to moderate medium subangular blocky; extremely hard, extremely firm, very sticky and very plastic; few wedge-shaped aggregates; few distinct pressure surfaces; 1 percent brown (10YR 5/3) lenses of very fine sandy loam on vertical ped faces; common distinct clay films on surfaces of ped; 1 percent fine rounded iron-manganese masses; 6 percent fine and medium coarse rounded calcium carbonate concretions and masses; moderately alkaline; gradual wavy boundary. (0 to 28 cm [0 to 11 in])

BCk1--168 to 188 cm (66 to 74 in); light gray (5Y 7/1) clay, white (5Y 8/1) dry; weak coarse prismatic structure parting to weak fine and medium angular blocky, extremely hard, extremely firm, very sticky and very plastic; few prominent pressure surface; 1 percent fine rounded masses of iron-manganese; 12 percent fine to coarse rounded masses and concretions of calcium carbonate; common fine and medium distinct yellowish brown (10YR 5/4) and brownish yellow (10YR 6/6) and light brown (7.5YR 6/4) masses of iron accumulation with diffuse boundaries; moderately alkaline; gradual wavy boundary. (0 to 20 cm [0 to 8 in])

BCk2--188 to 203 cm (74 to 80 in); light gray (5Y 7/1) clay, white (5Y 8/1) dry; weak coarse prismatic structure parting to weak fine and medium angular blocky; extremely hard, extremely firm, very sticky and very plastic; few distinct pressure surfaces; 1 percent fine and medium rounded masses of iron-manganese; 7 percent fine to coarse rounded masses of calcium carbonate; many fine to coarse distinct brownish yellow (10YR 6/6) and yellowish brown (10YR 5/6) and very pale brown (10YR 7/4) masses of iron accumulation with diffuse boundaries, common fine and medium distinct brownish yellow (10YR 6/8) masses of iron accumulation with sharp boundaries; moderately alkaline.", split = '\n')[[1]]


  z <- SoilKnowledgeBase:::.extractHzData(lines)

  # horizon designation
  expect_equal(z$name, c('A1', 'A2', 'Bt1', 'Bt2', 'Bt3', 'Bt4', 'Btk', 'BCtk', 'BCk1', 'BCk2'))

  # top depth in cm
  expect_equal(z$top, c(0, 30, 41, 51, 76, 104, 122, 155, 168, 188))

  # bottom depth in cm
  expect_equal(z$bottom, c(30, 41, 51, 76, 104, 122, 155, 168, 188, 203))

  # moist colors
  expect_equal(z$moist_hue, c('10YR', '10YR', '10YR', '10YR', '10YR', '10YR', '10YR', '10YR', '5Y', '5Y'))
  expect_equal(z$moist_value, c(4, 5, 6, 6, 6, 6, 5, 6, 7, 7))
  expect_equal(z$moist_chroma, c(3, 2, 2, 1, 1, 1, 6, 4, 1, 1))

  # texture class
  expect_equal(
    as.character(z$texture_class),
    c("fine sandy loam", "fine sandy loam", "sandy clay", "sandy clay",
      "sandy clay loam", "sandy clay loam", "sandy clay loam", "very fine sandy loam",
      "clay", "clay")
  )

  # pH class
  expect_equal(
    as.character(z$pH_class),
    c("slightly acid", "strongly acid", "strongly acid", "moderately acid",
      "moderately acid", "neutral", "neutral", "moderately alkaline",
      "moderately alkaline", "moderately alkaline")
  )

  # coarse fragment class: all NA in this case
  expect_true(
    all(
      is.na(z$cf_class)
    )
  )


})

# ensure that spurious horizon found in the TYPICAL PEDON line is filtered
# https://github.com/ncss-tech/SoilKnowledgeBase/issues/34 [resolved]
test_that("spurious horizons filtered from the first line of TYPICAL PEDON section", {

  lines <- strsplit("TYPICAL PEDON: Mendel very cobbly coarse sandy loam on a south facing (165 degree), 4 percent slope under a cover of timber oatgrass, dwarf bilberry, and scattered Sierra lodgepole pine at an elevation of 3221 meters. (Colors are for dry soils unless otherwise noted. When described on August 3, 2015 the soil was moist to 66 cm, wet, non-satiated from 66-105 cm, and wet, satiated from 66-150 cm. A water table was observed at 95 cm.)
A--0 to 13 cm; grayish brown (10YR 5/2) very cobbly coarse sandy loam, very dark grayish brown (10YR 3/2) moist; 76 percent sand; 17 percent silt; 7 percent clay; weak very fine and fine granular structure; slightly hard, friable, slightly sticky, nonplastic; many very fine, and common fine and medium roots throughout; common very fine, fine, and medium interstitial pores; 20 percent subrounded indurated granite gravel, 20 percent subrounded indurated granite cobbles, 5 percent subrounded indurated granite stones; NaF pH 8.9; moderately acid (pH 5.6); abrupt smooth boundary. (9 to 20 cm thick) Lab sample # 16N00926
Bw1--13 to 35 cm; light yellowish brown (10YR 6/4) very cobbly loamy coarse sand, dark yellowish brown (10YR 4/4) moist; 81 percent sand; 13 percent silt; 6 percent clay; weak medium and coarse subangular blocky structure; slightly hard, friable, slightly sticky, nonplastic; common very fine, fine, and medium roots throughout; common very fine, fine, and medium tubular pores; 15 percent subrounded indurated granite gravel, 25 percent subrounded indurated granite cobbles, 10 percent subrounded indurated granite stones; NaF pH 10.3; moderately acid (pH 5.9); clear wavy boundary. Lab sample # 16N00927", split = '\n')[[1]]


  z <- SoilKnowledgeBase:::.extractHzData(lines)
  expect_true(nrow(z) == 2)

})


## TODO add a couple more strange ones, flagstones etc.
test_that("coarse fragment extraction", {

  lines <- strsplit("TYPICAL PEDON: Pardee gravelly loam on a west-facing, 4 percent slope, under annual grasses and forbs with scattered blue oaks at an elevation of 137 meters. (Colors are for dry soil unless otherwise stated. When described on May 3, 1960, the soil was moist throughout.)

A1--0 to 5 cm; brown (7.5YR 5/3) gravelly loam, dark brown (7.5YR 3/4) moist; massive; slightly hard, friable, slightly sticky and slightly plastic; common very fine roots; many very fine interstitial and tubular pores; 10 percent mixed rounded indurated gravel, 5 percent mixed rounded indurated cobbles; slightly acid (pH 6.3); gradual smooth boundary. (5 to 18 cm thick)

A2--5 to 23 cm; brown (7.5YR 5/4) cobbly loam, dark brown (7.5YR 3/4) moist; massive; hard, friable, slightly sticky and plastic; common very fine roots; many very fine interstitial and tubular pores, 15 percent mixed rounded indurated gravel, 15 percent mixed rounded indurated cobbles; slightly acid (pH 6.3); gradual smooth boundary. (10 to 18 cm thick)

Bt1--23 to 36 cm; brown (7.5YR 5/4) very cobbly loam, reddish brown (5YR 4/4) moist; massive; hard, friable, slightly sticky and plastic; few very fine roots; many very fine, common fine, few medium tubular pores; few thin clay films in pores; 10 percent mixed rounded indurated gravel, 35 percent mixed rounded indurated cobbles; moderately acid (pH 6.0); gradual smooth boundary. (5 to 13 cm thick)

Bt2--36 to 43 cm; brown (7.5YR 5/4) extremely cobbly loam, reddish brown (5YR 4/4) moist; massive; hard, friable, slightly sticky and plastic; few very fine roots; many very fine and fine pores; few thin clay films in pores; 20 percent mixed rounded indurated gravel, 60 percent mixed rounded indurated cobbles; moderately acid (pH 5.8); abrupt wavy boundary. (8 to 15 cm thick)

2Bt3--43 to 46 cm; brown (7.5YR 5/3) very cobbly clay with flecks of light gray (10YR 7/2) weathered sand, brown (7.5YR 4/2) moist; massive; very hard, very firm, sticky and plastic; few very fine roots; common very fine tubular pores; thick continuous clay films on peds and lining pores; 5 percent mixed rounded indurated gravel, 35 percent mixed rounded indurated cobbles; strongly acid (pH 5.3); abrupt wavy boundary. (0 to 8 cm thick).", split = '\n')[[1]]


  z <- SoilKnowledgeBase:::.extractHzData(lines)
  expect_true(nrow(z) == 5)

  # coarse fragment class
  expect_equal(
    as.character(z$cf_class),
    c("gravelly", "cobbly", "very cobbly", "extremely cobbly",
      "very cobbly")
  )

})

test_that("parsing of effervescence class", {

  lines <- strsplit("TYPICAL PEDON: Abac loam - grassland. (Colors are for dry soil unless otherwise noted.)

A1--0 to 3 inches; reddish brown (2.5YR 5/4) silt loam, dark reddish brown (2.5YR 3/4) moist; moderate thin platy structure; slightly hard, friable, slightly sticky, slightly plastic; many very fine roots; slightly effervescent; few soft red shale fragments; clear smooth boundary. (2 to 6 inches thick)

Bw--3 to 8 inches; red (2.5YR 5/6) loam, dark red (2.5YR 3/6) moist; weak medium prismatic structure; hard, friable, sticky, plastic; common very fine roots; many fine tubular pores; 15 percent (volume) soft shale parafragments; slightly effervescent; clear wavy boundary.

Bk--8 to 15 inches; red (2.5YR 5/6) loam, dark red (2.5YR 3/6) moist; fine blocky structure; hard, friable, slightly sticky, slightly plastic; common very fine roots and pores; 30 percent (volume) soft shale parafragments; strongly effervescent; common fine lime threads; clear wavy boundary.

BCk--15 to 19 inches; light reddish brown (2.5YR 6/4) loam, red (2.5YR 4/6) moist; massive; hard, friable, slightly sticky, slightly plastic; a few mats of very fine roots follow the bedding planes of the shale; 60 percent shale parafragments; strongly effervescent with few fine threads of lime; abrupt irregular boundary.

Cr--19 to 26 inches; red, platy shale and fine grained sandstone, calcareous.", split = '\n')[[1]]


  z <- SoilKnowledgeBase:::.extractHzData(lines)
  expect_true(nrow(z) == 5)

  expect_true(length(z$eff_class) == 5)


  ## no eff mentioned
  lines <- strsplit("TYPICAL PEDON: Naconiche mucky sandy loam, 0 to 2 percent slopes in a forested flood plain.
(colors are for moist soil conditions)

A1--0 to 12 inches; very dark gray (7.5YR 3/0) mucky sandy loam; many medium white (10YR 8/2) spots of sand; massive; many fine, medium and coarse roots; about 20 percent decomposing leaves, roots, and twigs; extremely acid; abrupt smooth boundary. (6 to 16 inches thick)

A2--12 to 19 inches; black (7.5YR 2/0) mucky fine sandy loam; massive; few fine and medium roots; about 10 percent decomposing leaves, roots, and twigs; extremely acid; abrupt smooth boundary. (0 to 10 inches thick)

A3--19 to 29 inches; very dark gray (7.5YR 3/0) sand; single grained; common fine and medium roots; extremely acid; abrupt smooth boundary. (6 to 16 inches thick)

A4--29 to 32 inches; dark gray (10YR 4/1) sand; single grained; common white (10YR 8/2) spots of loamy fine sand; few fine and medium roots; extremely acid; abrupt smooth boundary.(0 to 8 inches thick)

A5--32 to 36 inches; black (10YR 2/1) loamy sand; massive; few white (10YR 8/2) spots of sand; few fine and medium roots; extremely acid; abrupt smooth boundary. (0 to 8 inches thick)

Cg--36 to 40 inches; light gray (10YR 7/1) sand; single grained; few fine and medium roots; few medium rounded masses of iron-manganese; very strongly acid; abrupt smooth boundary. (0 to 10 inches thick)

Ab1--40 to 45 inches; black (10YR 2/1) sand; single grained; few fine and medium roots; few medium rounded masses of iron-manganese; extremely acid; abrupt smooth boundary. (0 to 10 inches thick)

Ab2--45 to 52 inches; very dark grayish brown (10YR 3/2) mucky fine sandy loam; massive; few streaks and spots of dark brown (10YR 4/3) and black (10YR 2/1); few fine and medium roots; extremely acid; abrupt smooth boundary. (0 to 10 inches thick)

C'g--52 to 57 inches; light gray (10YR 7/1) sand; single grained; few fine and medium roots; moderately acid; abrupt smooth boundary. (0 to 20 inches thick)

A'b--57 to 67 inches; black (N 2/0), very dark gray (10YR 3/1), and white (10YR 8/2) loamy fine sand; massive; few fine and medium roots; extremely acid; abrupt smooth boundary. (0 to 12 inches thick)

C''g--67 to 73 inches; white (10YR 8/2) fine sand; single grained; few fine and medium roots; moderately acid; abrupt smooth boundary.(0 to 10 inches thick)

A''b--73 to 80 inches; dark grayish brown (10YR 4/2) fine sand; single grained; few fine and medium roots; very strongly acid.", split = '\n')[[1]]


  z <- SoilKnowledgeBase:::.extractHzData(lines)
  expect_true(nrow(z) == 12)
  expect_true(all(is.na(z$eff_class)))

})



