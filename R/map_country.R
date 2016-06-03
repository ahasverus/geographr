map_country <-
function(iso, city = NA, xpt = NA, ypt = NA, xrng = NA, yrng = NA){

    par(family = 'serif', mar = rep(.1, 4))

    shp <- readRDS(system.file(paste('external/gis/', iso, '.rds', sep = ''), package = "geographr"))

    if (!is.na(xrng[1])){
        plot(shp, col = '#045a8d', border = '#969696', axes = FALSE, xlim = xrng, ylim = yrng)
    } else {
        plot(shp, col = '#045a8d', border = '#969696', axes = FALSE)
    }

    par(xpd = TRUE)
        if (!is.na(city)){
            points(xpt, ypt, pch = 19, col = 'black')
            text(xpt, ypt, as.character(city), pos = 1, cex = 1.35, font = 2, col = 'black')
        }
    par(xpd = FALSE)
}
