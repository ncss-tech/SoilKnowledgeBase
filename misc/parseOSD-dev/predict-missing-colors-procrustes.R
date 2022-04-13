##
## TODO: is this approach as accurate as 4x OLS models with RCS terms? 
##  ---> likely more accurate
##
 

library(vegan)
library(aqp)
library(farver)
library(lattice)
library(tactile)
library(grid)


## from OSDs
d <- read.csv('parsed-data.csv.gz', stringsAsFactors=FALSE)

## build training data

# no missing data
x <- na.omit(d[, c('dry_hue', 'dry_value', 'dry_chroma', 'moist_hue', 'moist_value', 'moist_chroma')])

# split, convert to CIELAB

# not all can be converted: invalid hues
lab.dry <- munsell2rgb(x$dry_hue, x$dry_value, x$dry_chroma, returnLAB = TRUE)
lab.moist <- munsell2rgb(x$moist_hue, x$moist_value, x$moist_chroma, returnLAB = TRUE)

names(lab.dry) <- sprintf("dry.%s", names(lab.dry))
names(lab.moist) <- sprintf("moist.%s", names(lab.moist))

# combine
z <- data.frame(lab.dry, lab.moist, x)
head(z)
summary(z)

# missing CIELAB due to bogus hues
z <- na.omit(z)

moist.vars <- c('moist.L', 'moist.A', 'moist.B')
dry.vars <- c('dry.L', 'dry.A', 'dry.B')

# compute dE00: dry -- moist
z$dE00.o <- NA
for(i in 1:nrow(z)) {
  z$dE00.o[i] <- compare_colour(from = z[i, moist.vars], to = z[i, dry.vars], from_space = 'lab', to_space = 'lab', white_from = 'd65', white_to = 'd65', method = 'CIE2000')
}

# expected range + likely mistakes
histogram(
  z$dE00.o[z$dE00.o < 35], 
  breaks = 50, 
  par.settings = tactile.theme(), 
  scales = list(x = list(tick.number = 16)), 
  xlab = 'CIE2000 Color Contrast Metric', 
  main = 'Perceptual Differences: Moist / Dry Soil Colors', 
  sub = 'Official Series Descriptions, ~78k horizons',
  panel = function(...) {
    panel.grid(-1, -1)
    panel.histogram(...)
    grid.text('approximately\n1-unit change\nMunsell value', x = unit(7, units = 'native'), y = unit(0.85, 'npc'), hjust = 0.5, gp = gpar(cex = 0.75))
    grid.text('approximately\n2-unit change\nMunsell value', x = unit(17, units = 'native'), y = unit(0.85, 'npc'), hjust = 0.5, gp = gpar(cex = 0.75))
})


colorContrast('10YR 2/3', '10YR 4/3')

quantile(z$dE00.o)

# what is the expected rate of shift in hue?
prop.table(table(z$moist_hue != z$dry_hue))
boxplot(dE00.o ~ moist_hue != dry_hue, data = z, horizontal = TRUE)


# quick viz
z$dry.col <- munsell2rgb(z$dry_hue, z$dry_value, z$dry_chroma)
z$moist.col <- munsell2rgb(z$moist_hue, z$moist_value, z$moist_chroma)

z.sub <- z[sample(1:nrow(z), size = 500), ]

plot(moist.L ~ moist.A, data = z.sub, las = 1, pch = 16, col = z.sub$moist.col, cex = 2, ylim = c(0, 95), xlim = c(-5, 25))
points(dry.L ~ dry.A, data = z.sub, las = 1, pch = 15, col = z.sub$dry.col, cex = 2)

points(mean(z.sub$moist.A), mean(z.sub$moist.L), pch = 16, cex = 1.5)
points(mean(z.sub$dry.A), mean(z.sub$dry.L), pch = 15, cex = 1.5)




## fit rotation, translation, scale
# dry -> moist
# likely mistakes removed
keep.idx <- which(z$dE00.o < 30)

d2m <- procrustes(X = z[keep.idx, moist.vars], Y = z[keep.idx, dry.vars], scale = TRUE)
m2d <- procrustes(X = z[keep.idx, dry.vars], Y = z[keep.idx, moist.vars], scale = TRUE)

## optionally save


# export for aqp::estimateSoilColor()



dput(d2m$scale)
dput(d2m$rotation)
dput(d2m$translation)

dput(m2d$scale)
dput(m2d$rotation)
dput(m2d$translation)



# eval
summary(d2m)
summary(m2d)

## eval residuals
r <- residuals(d2m)
hist(r, las = 1)
quantile(r)

# probably mistakes or bad parsing
head(z[r > 30, ])

# investigate resid ~ L,A,B | hue,value,chroma


## predictions
p.d2m <- predict(d2m, z[, dry.vars])
p.m2d <- predict(m2d, z[, moist.vars])

head(z)
head(p.d2m)
head(p.m2d)


## manual predictions
Y <- as.matrix(z[, dry.vars])
Y <- d2m$scale * Y %*% d2m$rotation
Y <- sweep(Y, MARGIN = 2, STATS = d2m$translation, FUN = "+")

# same? YES
all.equal(Y, p.d2m)


## evaluate predictions

## TODO: generalize to moist + dry


z$dE00.moist <- NA
z$dE00.dry <- NA

for(i in 1:nrow(z)) {
  z$dE00.moist[i] <- compare_colour(from = z[i, moist.vars], to = rbind(p.d2m[i, ]), from_space = 'lab', to_space = 'lab', white_from = 'd65', white_to = 'd65', method = 'CIE2000')
  
  z$dE00.dry[i] <- compare_colour(from = z[i, dry.vars], to = rbind(p.m2d[i, ]), from_space = 'lab', to_space = 'lab', white_from = 'd65', white_to = 'd65', method = 'CIE2000')
  }


quantile(z$dE00.moist / z$dE00.o)
boxplot(list(source = z$dE00.o[keep.idx], estimate = z$dE00.moist[keep.idx]), horizontal = TRUE, xlab = 'dE00')

p1 <- histogram(
  z$dE00.moist[z$dE00.moist < 30], 
  breaks = 50, 
  xlim = c(-1, 31),
  par.settings = tactile.theme(), 
  scales = list(x = list(tick.number = 16)), 
  xlab = 'CIE2000 Color Contrast Metric', 
  main = 'Actual vs. Predicted Moist Colors', 
  panel = function(...) {
    panel.grid(-1, -1)
    panel.histogram(...)
  })


p2 <- histogram(
  z$dE00.dry[z$dE00.dry < 30], 
  breaks = 50, 
  xlim = c(-1, 31),
  par.settings = tactile.theme(), 
  scales = list(x = list(tick.number = 16)), 
  xlab = 'CIE2000 Color Contrast Metric', 
  main = 'Actual vs. Predicted Dry Colors', 
  panel = function(...) {
    panel.grid(-1, -1)
    panel.histogram(...)
  })



print(p1, more = TRUE, split = c(1, 1, 1, 2))
print(p2, more = FALSE, split = c(1, 2, 1, 2))



# chip accuracy
z$m.dry.o <- sprintf("%s %s/%s", z$dry_hue, z$dry_value, z$dry_chroma)
z$m.moist.o <- sprintf("%s %s/%s", z$moist_hue, z$moist_value, z$moist_chroma)


# m <- rgb2munsell(convert_colour(p.d2m, from = 'lab', to = 'rgb', white_from = 'd65', white_to = 'd65') / 255)
# 
# m$m <- sprintf("%s %s/%s", m$hue, m$value, m$chroma)
# 
# table(z$m.moist.o, m$m)


## eval a couple examples
idx <- sample(1:nrow(z), size = 10, replace = FALSE)
rgb2munsell(convert_colour(p.d2m[idx, ], from = 'lab', to = 'rgb', white_from = 'd65', white_to = 'd65') / 255)

z[idx, ]


p.m <- rgb2munsell(convert_colour(p.d2m[idx, ], from = 'lab', to = 'rgb', white_from = 'd65', white_to = 'd65') / 255)

# ~ 1000 random samples: 88% correct
prop.table(table(p.m$hue == z$moist_hue[idx]))


m1 <- sprintf("%s %s/%s", z$moist_hue[idx], z$moist_value[idx], z$moist_chroma[idx])
m2 <- sprintf("%s %s/%s", p.m$hue, p.m$value, p.m$chroma)

colorContrastPlot(m1, m2, labels = c('source', 'estimate'), col.cex = 0.75)



