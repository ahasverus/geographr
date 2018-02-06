add_button <-
function(lang){

    par(new = TRUE)
    plot(0, type = 'n', ann = FALSE, axes = FALSE)
    par(xpd = TRUE)

    rect(1.21, -2, 1.43, -1.5, col = '#045a8d', border = NA)
    text(1.32, -1.75, ifelse(lang == 'en', 'Next', 'Suivant'), col = 'black', font = 2)

    rect(0.98, -2, 1.20, -1.5, col = '#045a8d', border = NA)
    text(1.09, -1.75, ifelse(lang == 'en', 'Previous', 'Pr\u00e9c\u00e9dent'), col = 'black', font = 2)

    rect(0.57, -2, 0.79, -1.5, col = '#045a8d', border = NA)
    text(.68, -1.75, ifelse(lang == 'en', 'Exit', 'Quitter'), col = 'black', font = 2)

    clic <- 0
    while (sum(clic) == 0){
        xy <- locator(1)
        clic <- c((xy$x >=1.21 && xy$x <= 1.43 && xy$y >=-2 && xy$y <= -1.5),
                 (xy$x >=0.98 && xy$x <= 1.20 && xy$y >=-2 && xy$y <= -1.5),
                 (xy$x >=0.57 && xy$x <= 0.79 && xy$y >=-2 && xy$y <= -1.5))
    }

    pos <- which(clic == TRUE)
    if (pos == 1) return('next')
    if (pos == 2) return('previous')
    if (pos == 3) return('exit')
}
