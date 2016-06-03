find_country <-
function(region = 'Europa', lang = 'fr'){

    if (!(tolower(substr(lang, 1, 2)) %in% c('en', 'fr')))
        stop('Possible values for lang: fr or en')

    options(warn = -1)

    countries <- readRDS(system.file("external/countries.rds", package = "geographr"))
    countries <- filter_region(countries, region, lang)

    i <- 1 ; res <- kk <- 0

    while (i <= nrow(countries)){

        country <- as.character(countries[i, paste('country', lang, sep = '_')])
        iso     <- as.character(countries[i, 'iso3'])

        city    <- as.character(countries[i, paste('capital', lang, sep = '_')])
        xpt     <- countries[i, 'long']
        ypt     <- countries[i, 'lat']

        xrng    <- c(countries[i, 'xmn'], countries[i, 'xmx'])
        yrng    <- c(countries[i, 'ymn'], countries[i, 'ymx'])

        if (!is.null(dev.list()) && i == 1)
            dev.off()
        if (i == 1){
            new_dev(width = 7, height = 6)
        }
        layout(matrix(c(1, 1, 2, 3), byrow = TRUE, ncol = 2), heights = c(1, 6), widths = c(6, 1))

        par(bg = '#969696', mar = c(.1, 1, 1, 1), family = 'serif', xaxs = 'i', yaxs = 'i')
        plot(0, type = 'n', axes = FALSE, ann = FALSE)
        par(xpd = TRUE)
        if (lang == 'en'){
            if (substr(country, nchar(country), nchar(country)) == 's' &&
                length(grep('Cyprus|Belarus', country)) == 0){
                text(.6, 0, paste('Where are ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
            }else{
                text(.6, 0, paste('Where is ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
            }
            text(.6, -0.85, 'Click on the map (3 attempts)', font = 2, cex = .75, pos = 4)
        }

        if (lang == 'fr'){
            if (length(grep('Israël|Chypre|Guyana|Haïti|Cuba|Tobago|Antigua|Vincent|Porto|Aruba|Lucie|Curaçao|Taïwan', country)) == 0){
                if (length(grep('Géorgie|Corée', country)) == 0){
                    if (length(grep('Etats|États|Émirat', country)) == 0){
                        if (length(grep('Mexique|Belize|Honduras|Cambodge|Laos', country)) == 0){
                            if (substr(tolower(country), 1, 1) %in% c('a', 'e', 'é', 'è', 'i', 'î', 'o', 'u')){
                                if (length(grep('îles|iles', tolower(country))) == 0){
                                    text(.6, 0, paste('Où se trouve l\'', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                                }else{
                                    text(.6, 0, paste('Où se trouvent les ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                                }
                            }else{
                                if (substr(tolower(country), nchar(tolower(country)), nchar(tolower(country))) %in% c('e') &&
                                    length(grep('suriname', tolower(country))) == 0){
                                    text(.6, 0, paste('Où se trouve la ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                                }else{
                                    if (substr(tolower(country), nchar(tolower(country)), nchar(tolower(country))) %in% c('s')){
                                        text(.6, 0, paste('Où se trouvent les ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                                    }else{
                                        text(.6, 0, paste('Où se trouve le ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                                    }
                                }
                            }
                        }else{
                            text(.6, 0, paste('Où se trouve le ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                        }
                    }else{
                        text(.6, 0, paste('Où se trouvent les ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                    }
                }else{
                    text(.6, 0, paste('Où se trouve la ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
                }
            }else{
                text(.6, 0, paste('Où se trouve ', country, '?', sep = ''), font = 2, cex = 1.25, pos = 4)
            }
            text(.6, -0.85, 'Cliquez sur la carte (3 essais)', font = 2, cex = .75, pos = 4)
        }

        par(xpd = FALSE)

        map_guess(region)

        k <- 1
        while (k < 4){
            if (onclic(as.character(countries[i, 'country_en'])) == 0)
                k <- k + 1
            else
                break
        }

        name <- ifelse(is.na(countries[i, 'map']), as.character(countries[i, 'country_en']), as.character(countries[i, 'map']))
        rgxp <- ifelse(is.na(countries[i, 'map']), TRUE, FALSE)

        map_focus(name, perl = rgxp, col = ifelse(k < 4, '#018571', '#a6611a'))

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
        cat('\n >>> Merci d\'avoir joué!\n')
        cat(paste('\n >>> Vous avez joué avec ', length(kk), ' pays sur ', nrow(countries), '\n', sep = ''))
        cat(paste('\n >>> Votre score final est.......... ', round(100*sum(res)/length(res)), '%', sep = ''))
        cat(paste('\n\t   > 1ère tentative......... ', round(100*length(kk[kk == 1])/length(kk)), '%', sep = ''))
        cat(paste('\n\t   > 2nde tentative......... ', round(100*length(kk[kk == 2])/length(kk)), '%', sep = ''))
        cat(paste('\n\t   > 3ème tentative......... ', round(100*length(kk[kk == 3])/length(kk)), '%', sep = '', '\n'))
        cat('\n******************************************\n\n')
    }
}
