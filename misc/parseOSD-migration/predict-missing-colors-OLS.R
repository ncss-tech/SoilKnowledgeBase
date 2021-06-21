library(hexbin)
library(viridis)
library(aqp)
library(sharpshootR)
library(rms)
library(farver)
library(visreg)

## dE00 observed vs. predicted
##
# ## static hue, dry value / chroma model
# 0%        5%       25%       50%       75%       95%      100% 
# 0.000000  0.000000  0.000000  5.422945  9.359900 11.346863 61.787944 
# 
# ## dry LAB model, before Munsell transform
# 0%         5%        25%        50%        75%        95%       100% 
# 0.4382391  2.0232773  3.1119406  4.6279521  6.9709616 12.7304094 56.9446613 
# 
# ## dry LAB model, after Munsell transform
# 0%        5%       25%       50%       75%       95%      100% 
# 0.000000  0.000000  0.000000  3.931853  9.359900 11.318566 61.923273
# 


# from OSDs
d <- read.csv('parsed-data.csv.gz', stringsAsFactors=FALSE)

# check initial conditions
str(d)


## estimation via value / chroma only
x <- na.omit(d[, c('dry_hue', 'dry_value', 'dry_chroma', 'moist_hue', 'moist_value', 'moist_chroma')])

# check assumption: moist/dry hues are the same
round(prop.table(table(x$dry_hue == x$moist_hue)), 3)

# model
dd <- datadist(x)
options(datadist="dd")

# dry from moist
(m.value.dry <- ols(dry_value ~ rcs(moist_value) + moist_chroma, data = x))
(m.chroma.dry <- ols(dry_chroma ~ rcs(moist_chroma) + moist_value, data = x))

plot(Predict(m.value.dry), xlab='', ylab='dry value', asp=1)
plot(Predict(m.chroma.dry))

anova(m.value.dry)
anova(m.chroma.dry)

# moist from dry
(m.value.moist <- ols(moist_value ~ rcs(dry_value) + dry_chroma, data=x))
(m.chroma.moist <- ols(moist_chroma ~ rcs(dry_chroma) + dry_value, data=x))

plot(Predict(m.value.moist))
plot(Predict(m.chroma.moist))

anova(m.value.moist)
anova(m.chroma.moist)

## finish this
# plot(summary(m.value.moist, dry_value=c(3,4), dry_chroma=c(3,4)))
# plot(summary(m.value.dry, moist_value=c(3,4)))

# 
## partial effects via visreg: not all that interesting

# visreg(m.value.dry)
# visreg(m.value.moist)
# 
# visreg(m.chroma.dry)
# visreg(m.chroma.moist)



## save a record of model accuracy
sink(file = 'QC/ols-model-accuracy.txt')
# moist colors
print(m.value.moist)
print(m.chroma.moist)
# dry colors
print(m.value.dry)
print(m.chroma.dry)
sink()

# save model objects
save(m.value.dry, m.value.moist, m.chroma.dry, m.chroma.moist, file='models/missing-color-models.rda')


## predictions from full set

# dry
pp.value.dry <- predict(m.value.dry)
pp.chroma.dry <- predict(m.chroma.dry)

# moist
pp.value.moist <- predict(m.value.moist)
pp.chroma.moist <- predict(m.chroma.moist)

# combine
pp.dry <- data.frame(pp.value.dry, pp.chroma.dry)
pp.moist <- data.frame(pp.value.moist, pp.chroma.moist)
z <- cbind(x, pp.dry, pp.moist)

# check: OK
# head(z)


## note: must print() lattice graphics when code is source()-ed

## graphical eval: seems reasonable
png(filename = 'figures/dv-model.png', width=800, height=800, res=90)

print(
  hexbinplot(pp.value.dry ~ dry_value, data=x, trans = log, inv=exp, colramp=viridis, asp=1, xbins=10, xlab='Observed Dry Value', ylab='Predicted Dry Value', colorkey=FALSE)
)

dev.off()


png(filename = 'figures/dc-model.png', width=800, height=800, res=90)

print(
  hexbinplot(pp.chroma.dry ~ dry_chroma, data=x, trans = log, inv=exp, colramp=viridis, asp=1, xbins=10, xlab='Observed Dry Chroma', ylab='Predicted Dry Chroma', colorkey=FALSE)
)

dev.off()


png(filename = 'figures/mv-model.png', width=800, height=800, res=90)

print(
  hexbinplot(pp.value.moist ~ moist_value, data=x, trans = log, inv=exp, colramp=viridis, asp=1, xbins=10, xlab='Observed Moist Value', ylab='Predicted Moist Value', colorkey=FALSE)
)

dev.off()


png(filename = 'figures/mc-model.png', width=800, height=800, res=90)

print(
  hexbinplot(pp.chroma.moist ~ moist_chroma, data=x, trans = log, inv=exp, colramp=viridis, asp=1, xbins=10, xlab='Observed Moist Chroma', ylab='Predicted Moist Chroma', colorkey=FALSE)
)

dev.off()





## make a copy of some of the data,  
x.original <- subset(d, subset = seriesname %in% c('AMADOR', 'DRUMMER', 'CECIL', 'REDDING', 'AVA', 'MIAMI', 'FRISCO'))

# promote to SPC and convert colors
depths(x.original) <- seriesname ~ top + bottom
x.original$dry_soil_color <- munsell2rgb(x.original$dry_hue, x.original$dry_value, x.original$dry_chroma)
x.original$moist_soil_color <- munsell2rgb(x.original$moist_hue, x.original$moist_value, x.original$moist_chroma)

# label
x.original$group <- rep('Original', times=length(x.original))


## add a flags for estimated colors
d$dry_color_estimated <- FALSE
d$moist_color_estimated <- FALSE

## fill missing color components via models

# flag based on missing hue
d$dry_color_estimated[which(is.na(d$dry_hue))] <- TRUE
d$moist_color_estimated[which(is.na(d$moist_hue))] <- TRUE

# copy vs. prediction of hue, use moist / dry hue
d$moist_hue[which(is.na(d$moist_hue))] <- d$dry_hue[which(is.na(d$moist_hue))]
d$dry_hue[which(is.na(d$dry_hue))] <- d$moist_hue[which(is.na(d$dry_hue))]

# moist value
idx <- which(is.na(d$moist_value))
d$moist_value[idx] <- round(predict(m.value.moist, d[idx, ]))

# dry value
idx <- which(is.na(d$dry_value))
d$dry_value[idx] <- round(predict(m.value.dry, d[idx, ]))

# moist chroma
idx <- which(is.na(d$moist_chroma))
d$moist_chroma[idx] <- round(predict(m.chroma.moist, d[idx, ]))

# dry chroma
idx <- which(is.na(d$dry_chroma))
d$dry_chroma[idx] <- round(predict(m.chroma.dry, d[idx, ]))


# estimated proportions
prop.table(table(d$dry_color_estimated))
prop.table(table(d$moist_color_estimated))


## filling missing O horizon colors requires fixing 0->O OCR errors
idx <- grep('^0', d$name)
sort(table(d$name[idx]), decreasing = TRUE)

# replace 0 with O
d$name[idx] <- gsub('0', 'O', d$name[idx])


## O horizon colors: moist and dry colors missing

# find some to eval
x.o <- d[grep('^O', d$name), ]
nrow(x.o)
head(x.o)
sort(table(x.o$name), decreasing = TRUE)

# generalize into a 3 classes + everything else
x.o$genhz <- generalize.hz(x.o$name, new=c('Oi', 'Oe', 'Oa'), pat = c('Oi', 'Oe', 'Oa'))

# convert colors
x.o$dry_color <- munsell2rgb(x.o$dry_hue, x.o$dry_value, x.o$dry_chroma)
x.o$moist_color <- munsell2rgb(x.o$moist_hue, x.o$moist_value, x.o$moist_chroma)

# split and upgrade to SPC
x.o.d <- subset(x.o, subset=! is.na(dry_color) & !is.na(top) & !is.na(bottom))
x.o.m <- subset(x.o, subset=! is.na(moist_color) & !is.na(top) & !is.na(bottom))

depths(x.o.d) <- seriesname ~ top + bottom
depths(x.o.m) <- seriesname ~ top + bottom

# aggregate colors
a.d <- aggregateColor(x.o.d, groups='genhz', col='dry_color', k=10)
a.m <- aggregateColor(x.o.d, groups='genhz', col='moist_color', k=10)


png(file='figures/O-hz-colors-dry.png', width = 900, height=550, res=90)
aggregateColorPlot(a.d, main='Dry Colors')
dev.off()


png(file='figures/O-hz-colors-moist.png', width = 900, height=550, res=90)
aggregateColorPlot(a.m, main='Moist Colors')
dev.off()

knitr::kable(a.d$aggregate.data, row.names = FALSE)
knitr::kable(a.m$aggregate.data, row.names = FALSE)


## find O horizons that are missing colors, and use these ones

# Oi / dry
idx <- which(grepl('Oi', d$name) & is.na(d$dry_hue))
d$dry_hue[idx] <- '7.5YR'
d$dry_value[idx] <- 4
d$dry_chroma[idx] <- 2

# Oi / moist
idx <- which(grepl('Oi', d$name) & is.na(d$moist_hue))
d$moist_hue[idx] <- '7.5YR'
d$moist_value[idx] <- 2
d$moist_chroma[idx] <- 2

# Oe / dry
idx <- which(grepl('Oe', d$name) & is.na(d$dry_hue))
d$dry_hue[idx] <- '7.5YR'
d$dry_value[idx] <- 4
d$dry_chroma[idx] <- 2

# Oe / moist
idx <- which(grepl('Oe', d$name) & is.na(d$moist_hue))
d$moist_hue[idx] <- '7.5YR'
d$moist_value[idx] <- 2
d$moist_chroma[idx] <- 2

# Oa / dry
idx <- which(grepl('Oa', d$name) & is.na(d$dry_hue))
d$dry_hue[idx] <- '5YR'
d$dry_value[idx] <- 4
d$dry_chroma[idx] <- 1

# Oa / moist
idx <- which(grepl('Oa', d$name) & is.na(d$moist_hue))
d$moist_hue[idx] <- '7.5YR'
d$moist_value[idx] <- 2
d$moist_chroma[idx] <- 1

# everything else, dry
idx <- which(grepl('O', d$name) & is.na(d$dry_hue))
d$dry_hue[idx] <- '10YR'
d$dry_value[idx] <- 4
d$dry_chroma[idx] <- 1

# everything else, moist
idx <- which(grepl('O', d$name) & is.na(d$moist_hue))
d$moist_hue[idx] <- '10YR'
d$moist_value[idx] <- 2
d$moist_chroma[idx] <- 1


##
## extract same series and compare original vs. filled colors
##
x <- subset(d, subset = seriesname %in% c('AMADOR', 'DRUMMER', 'CECIL', 'REDDING', 'AVA', 'MIAMI', 'FRISCO'))
x$seriesname <- paste0(x$seriesname, '-filled')
depths(x) <- seriesname ~ top + bottom
x$dry_soil_color <- munsell2rgb(x$dry_hue, x$dry_value, x$dry_chroma)
x$moist_soil_color <- munsell2rgb(x$moist_hue, x$moist_value, x$moist_chroma)

# label
x$group <- rep('Filled', times=length(x))

# stack
g <- combine(x.original, x)

# convert to factor for groupedProfilePlot
g$group <- factor(g$group)

# new group with original series name
g$original.name <- site(g)[[idname(g)]]
# trim 'filled'
g$original.name <- gsub('-filled', '', g$original.name)

## graphical comparison... still needs some work

png(file='figures/dry-original-vs-filled-example.png', width = 900, height=800, res=90)

par(mar=c(1,1,3,1), mfrow=c(2,1))
groupedProfilePlot(g, name='', groups='original.name', color='dry_soil_color', id.style='side', label='group') ; title('Dry Colors')
groupedProfilePlot(g, name='', groups='original.name', color='moist_soil_color', id.style='side', label='group') ; title('Moist Colors')

dev.off()






png(file='figures/original-dry-vs-moist.png', width = 900, height=800, res=90)

par(mar=c(2,1,3,1), mfrow=c(2,1))
plot(x.original, color='dry_soil_color', max.depth=165, name='')
title('Original Dry Colors')
plot(x.original, color='moist_soil_color', max.depth=165, name='')
title('Original Moist Colors')

dev.off()


png(file='figures/filled-dry-vs-moist.png', width = 900, height=800, res=90)

par(mar=c(2,1,3,1), mfrow=c(2,1))
plot(x, color='dry_soil_color', max.depth=165, name='')
title('Filled Dry Colors')
plot(x, color='moist_soil_color', max.depth=165, name='')
title('Filled Moist Colors')

dev.off()



## alternative display with colorspace::swatchplot()

png(file='figures/original-vs-filled-swatch.png', width=700, height=400, res=90)

colorspace::swatchplot(
  'dry missing'=x.original$dry_soil_color,
  'moist missing'=x.original$moist_soil_color,
  'dry filled'=x$dry_soil_color,
  'moist filled'=x$moist_soil_color
)

dev.off()

# convert logical -> character for portability
d$dry_color_estimated <- as.character(d$dry_color_estimated)
d$moist_color_estimated <- as.character(d$moist_color_estimated)

## save results
write.csv(d, file=gzfile('parsed-data-est-colors.csv.gz'), row.names=FALSE)








