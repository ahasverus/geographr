map_world <-
function(country, perl){

    x <- map("world", plot = FALSE)$names
    if (perl)
        query <- x[grep(tolower(as.character(country)), tolower(x))]
    else
        query <- country

    xy <- map(regions = query, wrap = TRUE, plot = FALSE)

    proj.orient <- c(mean(na.omit(xy$y)), mean(na.omit(xy$x)), 0)

    par(mar = rep(1, 4), bg = '#969696')
    map("world", projection = 'orthographic', orientation =proj.orient, wrap = TRUE,
        fill = TRUE, border = NA, col = '#333333', add = FALSE)
    map.grid(labels = FALSE, lty = 1, col = 'lightgray', lwd = .25)

    xy <- map(regions = query, projection = 'orthographic', orientation =proj.orient, wrap = TRUE,
               fill = TRUE, col = '#416639', border = NA, add = TRUE)

    xrng <- range(na.omit(xy$x))
    yrng <- range(na.omit(xy$y))
    rect(xrng[1]-.025, yrng[1]-.025, xrng[2]+.025, yrng[2]+.025, border = 'red', lwd = 2)
}
