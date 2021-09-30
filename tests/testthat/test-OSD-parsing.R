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
