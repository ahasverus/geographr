add_button2 <-
function(k, resultat, lang){

    par(mar = rep(0, 4), xaxs = 'i', yaxs = 'i')
    plot(0, xlim = c(-1, 1), ylim = c(-1, 1), type = 'n', ann = FALSE, axes = FALSE)
    par(xpd = TRUE)

    rect(-1, 0, 0.5, 0.9365, col = ifelse(k < 4, '#018571', '#a6611a'), border = NA)

    if (k < 4){
        text(x = -.25, y = .75, labels = ifelse(lang == 'en', 'Nice shot!', 'Bien joué!'), font = 2, cex = 1.20)
    }else{
        text(x = -.25, y = .75, labels = ifelse(lang == 'en', 'Too bad!', 'Perdu!'), font = 2, cex = 1.20)
    }

    text(x = -.25, y = .5, labels = paste('Score:\n', round(100*sum(resultat)/length(resultat)), '%', sep = ''), font = 2, cex = 1.20)

    rect(-1, -0.75, 0.5, -0.60, col = '#045a8d', border = NA)
    text(-0.25, -0.675, ifelse(lang == 'en', 'Next', 'Suivant'), col = 'black', font = 2)

    rect(-1, -0.935, 0.5, -0.785, col = '#045a8d', border = NA)
    text(-0.25, -0.86, ifelse(lang == 'en', 'Exit', 'Quitter'), col = 'black', font = 2)

    clic <- 0
    while (sum(clic) == 0){
        xy <- locator(1)
        clic <- c((xy$x >=-1 && xy$x <= .5 && xy$y >=-.750 && xy$y <= -.600),
                  (xy$x >=-1 && xy$x <= .5 && xy$y >=-.935 && xy$y <= -.785))
    }

    pos <- which(clic == TRUE)
    if (pos == 1) return('next')
    if (pos == 2) return('exit')
}
