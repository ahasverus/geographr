map_flag <-
function(iso){

    x <- readPNG(system.file(paste('external/png/', tolower(iso), '.png', sep = ), package = "geographr"))
    par(mar = c(6, 2, 6, 2))
    plot(0, type = 'n', ann = FALSE, axes = FALSE)
    rasterImage(x, par()$usr[1], par()$usr[3], par()$usr[2], par()$usr[4])
}
