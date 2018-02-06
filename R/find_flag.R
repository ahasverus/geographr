find_flag <-
function(region = 'Europa', lang = 'en'){

    if (!(tolower(substr(lang, 1, 2)) %in% c('en', 'fr')))
        stop('Possible values for lang: fr or en')

    options(warn = -1)

    countries <- readRDS(system.file("external/countries.rds", package = "geographr"))
    countries <- filter_region(countries, region, lang)

    i <- 1 ; res <- 0 ; kk <- 0

    while (i <= nrow(countries)){

        country <- as.character(countries[i, paste('country', lang, sep = '_')])
        iso     <- as.character(countries[i, 'iso2'])

        if (!is.null(dev.list()) && i == 1)
            dev.off()
        if (i == 1){
            new_dev(width = 9, height = 6)
        }
        layout(matrix(c(1, 1, 2, 3), byrow = TRUE, ncol = 2), heights = c(1, 6), widths = c(6, 1))

        par(bg = '#969696', mar = c(.1, 1, 1, 1), family = 'serif', xaxs = 'i', yaxs = 'i')
        plot(0, type = 'n', axes = FALSE, ann = FALSE)
        par(xpd = TRUE)
        if (lang == 'en'){
            text(.6, 0, paste('What is the flag of ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
            text(.6, -0.85, 'Click on the map (3 attempts)', font = 2, cex = .75, pos = 4)
        }

        if (lang == 'fr'){
            if (length(grep('Isra\u00ebl|Ha\u00efti|Antigua|Aruba', country)) == 0){
                if (length(grep('Chypre|Guyana|Cuba|Tobago|Vincent|Porto|Lucie|Cura\u00e7ao|Ta\u00efwan', country)) == 0){
                    if (length(grep('G\u00e9orgie|Cor\u00e9e', country)) == 0){
                        if (length(grep('Etats|\u00e9tats|\u00e9mirat', country)) == 0){
                            if (length(grep('Mexique|Belize|Honduras|Cambodge|Laos', country)) == 0){
                                if (substr(tolower(country), 1, 1) %in% c('a', 'e', '\u00e9', '\u00e8', 'i', '\u00ee', 'o', 'u')){
                                    if (length(grep('\u00eeles|iles', tolower(country))) == 0){
                                        text(.6, 0, paste('Quel est le drapeau de l\'', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                                    }else{
                                        text(.6, 0, paste('Quel est le drapeau des ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                                    }
                                }else{
                                    if (substr(tolower(country), nchar(tolower(country)), nchar(tolower(country))) %in% c('e') &&
                                        length(grep('suriname', tolower(country))) == 0){
                                        text(.6, 0, paste('Quel est le drapeau de la ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                                    }else{
                                        if (substr(tolower(country), nchar(tolower(country)), nchar(tolower(country))) %in% c('s')){
                                            text(.6, 0, paste('Quel est le drapeau des ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                                        }else{
                                            text(.6, 0, paste('Quel est le drapeau du ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                                        }
                                    }
                                }
                            }else{
                                text(.6, 0, paste('Quel est le drapeau du ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                            }
                        }else{
                            text(.6, 0, paste('Quel est le drapeau des ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                        }
                    }else{
                        text(.6, 0, paste('Quel est le drapeau de la ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                    }
                }else{
                    text(.6, 0, paste('Quel est le drapeau de ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                }
            }else{
                text(.6, 0, paste('Quel est le drapeau d\'', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
            }
            text(.6, -0.85, 'Cliquez sur le bon drapeau (3 essais)', font = 2, cex = .75, pos = 4)
        }

        par(xpd = FALSE)

        flags <- c(tolower(iso), sample(tolower(countries[-i, 'iso2']), 8))

        coords <- draw_flags(flags)

        k <- 1
        while (k < 4){
            if (onclic2(coords, flag = flags[1]) == 0)
                k <- k + 1
            else
                break
        }

        mask_flag(coords, flag = flags[1], w = k)

        res[i] <- ifelse(k < 4, 1, 0)
        kk[i] <- k

        if (i < nrow(countries)){
            clic <- add_button2(k, res, lang)
            par(xpd = FALSE)
            if (clic == 'next'){
                i <- i + 1
            }
            if (clic == 'exit'){
                i <- 100000
            }
        } else {
            add_close2(k, res, lang)
            i <- 100000
        }
    }
    invisible(dev.off())

    if (lang == 'en'){
        cat('\n\n******************************************\n')
        cat('\n >>> Thanks for playing!\n')
        cat(paste('\n >>> You have completed ', length(kk), ifelse(length(kk) == 1, ' country on ', ' countries on '), nrow(countries), '\n', sep = ''))
        cat(paste('\n >>> Your final score is........ ', round(100*sum(res)/length(res)), '%', sep = ''))
        cat(paste('\n\t   > 1st attempt........ ', round(100*length(kk[kk == 1])/length(kk)), '%', sep = ''))
        cat(paste('\n\t   > 2nd attempt........ ', round(100*length(kk[kk == 2])/length(kk)), '%', sep = ''))
        cat(paste('\n\t   > 3rd attempt........ ', round(100*length(kk[kk == 3])/length(kk)), '%', sep = '', '\n'))
        cat('\n******************************************\n\n')
    }else{
        cat('\n\n******************************************\n')
        cat('\n >>> Merci d\'avoir jou\u00e9!\n')
        cat(paste('\n >>> Vous avez jou\u00e9 avec ', length(kk), ' pays sur ', nrow(countries), '\n', sep = ''))
        cat(paste('\n >>> Votre score final est.......... ', round(100*sum(res)/length(res)), '%', sep = ''))
        cat(paste('\n\t   > 1\u00e8re tentative......... ', round(100*length(kk[kk == 1])/length(kk)), '%', sep = ''))
        cat(paste('\n\t   > 2nde tentative......... ', round(100*length(kk[kk == 2])/length(kk)), '%', sep = ''))
        cat(paste('\n\t   > 3\u00e8me tentative......... ', round(100*length(kk[kk == 3])/length(kk)), '%', sep = '', '\n'))
        cat('\n******************************************\n\n')
    }
}
