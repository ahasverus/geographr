draw_flags <-
function(flags){

    par(mar = c(2, 1, 2, 1), family = 'serif', xaxs = 'i', yaxs = 'i')
    plot(0, xlim = c(0, 3), ylim = c(0, 3) , type = 'n', ann = FALSE, axes = FALSE)

    flags <- sample(flags)
    k <- 1
    xmn <- xmx <- ymn <- ymx <- NULL
    for (i in 1 : 3){
        for (j in 1 : 3){
            xmn[k] <- (i-1)+.025 ; xmx[k] <- i-.025
            ymn[k] <- (j-1)+.040 ; ymx[k] <- j-.040
            x <- readPNG(system.file(paste('external/png/', tolower(flags[k]), '.png', sep = ''), package = "geographr"))
            rasterImage(x, xmn[k], ymn[k], xmx[k], ymx[k])
            rect(xmn[k], ymn[k], xmx[k], ymx[k], border = 'white', lwd = 3)
            k <- k + 1
        }
    }
    return(data.frame(flags, xmn, xmx, ymn, ymx))
}
