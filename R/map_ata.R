map_ata <-
function(){

    x = map('world', plot = FALSE)$names
    query <- x[grep('antarctica', tolower(x))]
    xy <- map(region = query, wrap = TRUE, plot = FALSE)
    proj.orient <- c(mean(na.omit(xy$y)), mean(na.omit(xy$x)), 0)

    par(family = 'serif', mar = rep(.1, 4))
    map(region = query, proj = 'orthographic', orient = proj.orient, wrap = TRUE,
        fill = TRUE, col = '#045a8d', border = NA)
}
