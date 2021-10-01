context("OSD Parsing")


## TODO: abstract as much as possible into helper functions

## TODO: add more tests for known problematic soils / work-arounds


test_that("horizon depths (with unit conversion) and designation", {
  
  # MENDEL
  lines <- strsplit("A--0 to 13 cm; grayish brown (10YR 5/2) very cobbly coarse sandy loam, very dark grayish brown (10YR 3/2) moist; 76 percent sand; 17 percent silt; 7 percent clay; weak very fine and fine granular structure; slightly hard, friable, slightly sticky, nonplastic; many very fine, and common fine and medium roots throughout; common very fine, fine, and medium interstitial pores; 20 percent subrounded indurated granite gravel, 20 percent subrounded indurated granite cobbles, 5 percent subrounded indurated granite stones; NaF pH 8.9; moderately acid (pH 5.6); abrupt smooth boundary. (9 to 20 cm thick) Lab sample # 16N00926", split = '\n')[[1]]
  
  z <- SoilKnowledgeBase:::.extractHzData(lines)
  
  expect_true(
    all(
      z[, 1:3] == c('A', 0, 13)
    )
  )
  
  
  # CECIL
  lines <- strsplit("Bt2--26 to 42 inches; red (10R 4/8) clay; few fine prominent yellowish red (5YR 5/8) mottles; moderate medium subangular blocky structure; firm; sticky, plastic; common clay films on faces of peds; few fine flakes of mica; very strongly acid; gradual wavy boundary. (Combined thickness of the Bt horizon is 24 to 50 inches)", split = '\n')[[1]]
  
  z <- SoilKnowledgeBase:::.extractHzData(lines)
  
  expect_true(
    all(
      z[, 1:3] == c('Bt2', 66, 107)
    )
  )
  
  
  # DRUMMER
  lines <- strsplit("2Cg--119 to 152 cm (47 to 60 inches); dark gray (10YR 4/1) stratified loam and sandy loam; massive; friable; many medium prominent olive brown (2.5Y 4/4) masses of oxidized iron-manganese in the matrix; many medium distinct gray (N 5/) iron depletions in the matrix; slightly alkaline.", split = '\n')[[1]]
  
  z <- SoilKnowledgeBase:::.extractHzData(lines)
  
  expect_true(
    all(
      z[, 1:3] == c('2Cg', 119, 152)
    )
  )
  
  
  # IRON MOUNTAIN
  lines <- strsplit("R--23 cm ; hard volcanic breccia which is impervious to both roots and water .", split = '\n')[[1]]
  
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
  
  
})

## TODO: spurious horizon found in the TYPICAL PEDON line
# 
# test_that("example 1", {
# 
#   lines <- strsplit("TYPICAL PEDON: Mendel very cobbly coarse sandy loam on a south facing (165 degree), 4 percent slope under a cover of timber oatgrass, dwarf bilberry, and scattered Sierra lodgepole pine at an elevation of 3221 meters. (Colors are for dry soils unless otherwise noted. When described on August 3, 2015 the soil was moist to 66 cm, wet, non-satiated from 66-105 cm, and wet, satiated from 66-150 cm. A water table was observed at 95 cm.)", split = '\n')[[1]]
# 
# 
#   z <- SoilKnowledgeBase:::.extractHzData(lines)
#   expect_true(nrow(z) < 1)
# 
# })
