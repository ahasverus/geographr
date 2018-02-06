add_button3 <-
function(k, resultat, lang){

    xmn <- par()$usr[2] + (par()$usr[2]-par()$usr[1])/13
    xmx <- par()$usr[2] + (par()$usr[2]-par()$usr[1])/4.55

    rect(xmn, par()$usr[3] + (par()$usr[4]-par()$usr[3])/2,
         xmx, par()$usr[4],
         col = ifelse(k < 4, '#018571', '#a6611a'), border = NA)

    if (k < 4){
        text(x = (xmn + xmx)/2, y = par()$usr[4] - (par()$usr[4]-par()$usr[3])/10, labels = ifelse(lang == 'en', 'Nice shot!', 'Bien jou\u00e9!'), font = 2, cex = 1)
    }else{
        text(x = (xmn + xmx)/2, y = par()$usr[4] - (par()$usr[4]-par()$usr[3])/10, labels = ifelse(lang == 'en', 'Too bad!', 'Perdu!'), font = 2, cex = 1)
    }

    text(x = (xmn + xmx)/2, y = par()$usr[4] - (par()$usr[4]-par()$usr[3])/4.25, labels = paste('Score:\n', round(100*sum(resultat)/length(resultat)), '%', sep = ''), font = 2, cex = 1)

    rect(xmn, par()$usr[3] + (par()$usr[4]-par()$usr[3])/10, xmx, par()$usr[3] + (par()$usr[4]-par()$usr[3])/5.5, col = '#045a8d', border = NA)
    text(x = (xmn + xmx)/2, y = (par()$usr[3] + (par()$usr[4]-par()$usr[3])/10 + par()$usr[3] + (par()$usr[4]-par()$usr[3])/5.5)/2, ifelse(lang == 'en', 'Next', 'Suivant'), col = 'black', font = 2, cex = .85)

    rect(xmn, par()$usr[3], xmx, par()$usr[3] + (par()$usr[4]-par()$usr[3])/12, col = '#045a8d', border = NA)
    text(x = (xmn + xmx)/2, y = (par()$usr[3] + par()$usr[3] + (par()$usr[4]-par()$usr[3])/12)/2, ifelse(lang == 'en', 'Exit', 'Quitter'), col = 'black', font = 2, cex = .85)

    clic <- 0
    while (sum(clic) == 0){
        xy <- locator(1)
        clic <- c((xy$x >= xmn && xy$x <= xmx && xy$y >= par()$usr[3] + (par()$usr[4]-par()$usr[3])/10 && xy$y <= par()$usr[3] + (par()$usr[4]-par()$usr[3])/5.5),
                  (xy$x >= xmn && xy$x <= xmx && xy$y >= par()$usr[3] && xy$y <= par()$usr[3] + (par()$usr[4]-par()$usr[3])/12))
    }

    pos <- which(clic == TRUE)
    if (pos == 1) return('next')
    if (pos == 2) return('exit')
}
