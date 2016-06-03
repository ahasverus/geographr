add_close <-
function(lang){

    par(new = TRUE)
    plot(0, type = 'n', ann = FALSE, axes = FALSE)
    par(xpd = TRUE)

    rect(0.57, -2, 0.79, -1.5, col = '#045a8d', border = NA)
    text(.68, -1.75, ifelse(lang == 'en', 'Exit', 'Quitter'), col = 'black', font = 2)

    clic <- 0
    while (sum(clic) == 0){
        xy <- locator(1)
        clic <- c((xy$x >=0.57 && xy$x <= 0.79 && xy$y >=-2 && xy$y <= -1.5))
    }
}
