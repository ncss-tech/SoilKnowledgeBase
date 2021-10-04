# library(SoilKnowledgeBase)
library(soilDB)

# get latest version via HTML interface
# latest soilDB contains a fix to properly launder the result
o <- get_OSD('AMADOR', result = 'html')

# use throw-away files as place-holders
logfile <- tempfile()
OSDtext <- tempfile()

# dump HTML -> TEXT -> FILE
cat(o, file = OSDtext, sep = '\n')

# split into sections + check
x <- validateOSD(logfile, filepath = OSDtext)

# parse site/horizon data
# note: missing series name in hz data
parsed.OSD <- SoilKnowledgeBase:::.doParseOSD(x)

# check:
s <- parsed.OSD$`hz-data`
s[, 1:9]

s

## testing / checking REGEX

lines <- strsplit(x$`TYPICAL PEDON`$content, split = '\n')[[1]]


lines <- strsplit("TYPICAL PEDON: Mendel very cobbly coarse sandy loam on a south facing (165 degree), 4 percent slope under a cover of timber oatgrass, dwarf bilberry, and scattered Sierra lodgepole pine at an elevation of 3221 meters. (Colors are for dry soils unless otherwise noted. When described on August 3, 2015 the soil was moist to 66 cm, wet, non-satiated from 66-105 cm, and wet, satiated from 66-150 cm. A water table was observed at 95 cm.)

A--0 to 13 cm; grayish brown (10YR 5/2) very cobbly coarse sandy loam, very dark grayish brown (10YR 3/2) moist; 76 percent sand; 17 percent silt; 7 percent clay; weak very fine and fine granular structure; slightly hard, friable, slightly sticky, nonplastic; many very fine, and common fine and medium roots throughout; common very fine, fine, and medium interstitial pores; 20 percent subrounded indurated granite gravel, 20 percent subrounded indurated granite cobbles, 5 percent subrounded indurated granite stones; NaF pH 8.9; moderately acid (pH 5.6); abrupt smooth boundary. (9 to 20 cm thick) Lab sample # 16N00926

Bw1--13 to 35 cm; light yellowish brown (10YR 6/4) very cobbly loamy coarse sand, dark yellowish brown (10YR 4/4) moist; 81 percent sand; 13 percent silt; 6 percent clay; weak medium and coarse subangular blocky structure; slightly hard, friable, slightly sticky, nonplastic; common very fine, fine, and medium roots throughout; common very fine, fine, and medium tubular pores; 15 percent subrounded indurated granite gravel, 25 percent subrounded indurated granite cobbles, 10 percent subrounded indurated granite stones; NaF pH 10.3; moderately acid (pH 5.9); clear wavy boundary. Lab sample # 16N00927

Bw2--35 to 52 cm; brownish yellow (10YR 6/6) very cobbly loamy coarse sand, dark yellowish brown (10YR 4/6) moist; 83 percent sand; 11 percent silt; 6 percent clay; weak fine and medium subangular blocky structure; slightly hard, friable, slightly sticky, nonplastic; common very fine, fine, and medium roots throughout; common very fine, fine, and medium tubular pores; 5 percent fine faint irregular dark yellowish brown (10YR 3/6) moist, iron-manganese masses with diffuse boundaries in matrix; 20 percent subrounded indurated granite gravel, 25 percent subrounded indurated granite cobbles, 10 percent subrounded indurated granite stones; NaF pH 10.6; moderately acid (pH 6.0); clear wavy boundary. Lab sample # 16N00928

Bw3--52 to 66 cm; brownish yellow (10YR 6/6) very cobbly loamy coarse sand, dark yellowish brown (10YR 4/6) moist; 86 percent sand; 8 percent silt; 6 percent clay; weak medium subangular blocky structure; slightly hard, friable, slightly sticky, nonplastic; common very fine and medium, and few fine roots throughout; common very fine, fine, and medium tubular pores; 1 percent fine prominent irregular light olive brown (2.5Y 5/3) moist, iron depletions with diffuse boundaries on surfaces along root channels, and 7 percent very coarse prominent irregular light olive brown (2.5Y 5/3) moist, iron depletions and 30 percent coarse distinct irregular dark brown (7.5YR 3/4) moist, iron-manganese masses with diffuse boundaries in matrix; 15 percent subrounded indurated granite gravel, 25 percent subrounded indurated granite cobbles, 10 percent subrounded indurated granite stones; NaF pH 10.1; moderately acid (pH 6.0); clear wavy boundary. (combined thickness of Bw horizons is 0 to 75 cm) Lab sample # 16N00929

BC--66 to 105 cm; light yellowish brown (2.5Y 6/4) very cobbly coarse sand, olive brown (2.5Y 4/4) moist; 88 percent sand; 7 percent silt; 6 percent clay; weak fine and weak medium subangular blocky structure; slightly hard, friable, nonsticky, nonplastic; common very fine and few fine roots throughout; common very fine and fine, and many medium interstitial pores; 1 percent medium faint irregular light olive brown (2.5Y 5/3) moist, iron depletions, 3 percent medium distinct irregular dark brown (7.5YR 3/4) moist, iron-manganese masses, and 7 percent very coarse prominent irregular strong brown (7.5YR 4/6) moist, iron-manganese masses with diffuse boundaries in matrix; 30 percent subrounded indurated granite gravel, 20 percent subrounded indurated granite cobbles, 5 percent subrounded indurated granite stones; NaF pH 9.9; slightly acid (pH 6.1); clear wavy boundary. (0 to 50 cm thick) Lab sample # 16N00930

C1--105 to 135 cm; pale yellow (2.5Y 7/3) very gravelly coarse sand, light olive brown (2.5Y 5/4) moist; 92 percent sand; 6 percent silt; 3 percent clay; structureless single grain; slightly hard, very friable, nonsticky, nonplastic; few very fine roots throughout; common very fine and fine, and many medium interstitial pores; 1 percent fine faint irregular grayish brown (2.5Y 5/2) moist, iron depletions with diffuse boundaries on surfaces along root channels; 35 percent subrounded indurated granite gravel, 3 percent subrounded indurated granite cobbles; NaF pH 9.6; slightly acid (pH 6.3); gradual smooth boundary. Lab sample # 16N00931

C2--135 to 150 cm; light gray (2.5Y 7/2) very gravelly coarse sand, light olive brown (2.5Y 5/3) moist; 92 percent sand; 8 percent silt; structureless single grain; slightly hard, very friable, nonsticky, nonplastic; common very fine and fine, and many medium interstitial pores; 1 percent medium faint irregular grayish brown (2.5Y 5/2) moist, iron depletions with diffuse boundaries in matrix; 35 percent subrounded indurated granite gravel, 5 percent subrounded indurated granite cobbles; NaF pH 9.5; slightly acid (pH 6.3).", split = '\n')[[1]]


z <- SoilKnowledgeBase:::.extractHzData(lines)
z[, 1:9]
