##
## TODO: is this approach as accurate as 4x OLS models with RCS terms? 
##
 

library(vegan)
library(aqp)
library(farver)

## from OSDs
d <- read.csv('parsed-data.csv.gz', stringsAsFactors=FALSE)

## build training data

# no missing data
x <- na.omit(d[, c('dry_hue', 'dry_value', 'dry_chroma', 'moist_hue', 'moist_value', 'moist_chroma')])

# split, convert to CIELAB

# not all can be converted: invalue hues
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
hist(z$dE00.o, las = 1)
quantile(z$dE00.o)

# what is the expected rate of shift in hue?
prop.table(table(z$moist_hue != z$dry_hue))
boxplot(dE00.o ~ moist_hue != dry_hue, data = z, horizontal = TRUE)


# quick viz
z$dry.col <- munsell2rgb(z$dry_hue, z$dry_value, z$dry_chroma)
z$moist.col <- munsell2rgb(z$moist_hue, z$moist_value, z$moist_chroma)

z.sub <- z[1:100, ]

plot(moist.L ~ moist.A, data = z.sub, las = 1, pch = 16, col = z.sub$moist.col, cex = 2, ylim = c(0, 95), xlim = c(-5, 25))
points(dry.L ~ dry.A, data = z.sub, las = 1, pch = 15, col = z.sub$dry.col, cex = 2)



## fit rotation, translation, scale
# dry -> moist
# likely mistakes removed
keep.idx <- which(z$dE00.o < 30)

d2m <- procrustes(X = z[keep.idx, moist.vars], Y = z[keep.idx, dry.vars], scale = TRUE)
m2d <- procrustes(X = z[keep.idx, dry.vars], Y = z[keep.idx, moist.vars], scale = TRUE)

## save to ...??


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

head(z)
head(p.d2m)


## manual predictions
Y <- as.matrix(z[, dry.vars])
Y <- d2m$scale * Y %*% d2m$rotation
Y <- sweep(Y, MARGIN = 2, STATS = d2m$translation, FUN = "+")

# same? YES
all.equal(Y, p.d2m)


## evaluate predictions
z$dE00.f <- NA
for(i in 1:nrow(z)) {
  z$dE00.f[i] <- compare_colour(from = z[i, 4:6], to = rbind(p.d2m[i, ]), from_space = 'lab', to_space = 'lab', white_from = 'd65', white_to = 'd65', method = 'CIE2000')
  }

hist(z$dE00.f, las = 1)

quantile(z$dE00.f / z$dE00.o)

boxplot(list(source = z$dE00.o[keep.idx], estimate = z$dE00.f[keep.idx]), horizontal = TRUE, xlab = 'dE00')


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


m1 <- sprintf("%s %s/%s", z$moist_hue[idx], z$moist_value[idx], z$moist_chroma[idx])
m2 <- sprintf("%s %s/%s", p.m$hue, p.m$value, p.m$chroma)

colorContrastPlot(m1, m2, labels = c('source', 'estimate'), col.cex = 0.75)



