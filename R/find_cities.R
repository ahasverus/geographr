find_cities <-
function(country = NULL, lang = 'en', n = 10){

    if (!(tolower(substr(lang, 1, 2)) %in% c('en', 'fr')))
        stop('Possible values for lang: fr or en')

    options(warn = -1)

    countries <- readRDS(system.file("external/countries.rds", package = "geographr"))

    res <- kk <- 0

    if (is.null(country))
        country <- countries[sample(1:nrow(countries), 1), 'country_en']

    pos <- which(tolower(countries[ , 'country_en']) == tolower(country) |
                 tolower(countries[ , 'country_fr']) == tolower(country))

    if (length(pos) > 0){

        if (!is.null(dev.list()))
            dev.off()

        if (countries[pos, 'iso3'] == 'USA'){
            pts <- world.cities[world.cities$country.etc == 'USA', ]
        }

        if (countries[pos, 'iso3'] == 'GBR'){
            pts <- world.cities[world.cities$country.etc == 'UK', ]
        }

        if (!(countries[pos, 'iso3'] %in% c('USA', 'GBR'))){
            pts <- world.cities[world.cities$country.etc == countries[pos, 'country_en'], ]
        }

        pts <- pts[order(pts$pop, decreasing = TRUE), ]
        pts <- pts[which(!is.na(pts[ , 'name'])), ]

        if (nrow(pts) > 0){

            country <- as.character(countries[pos, paste('country', lang, sep = '_')])
            iso     <- as.character(countries[pos, 'iso3'])

            xrng    <- c(countries[pos, 'xmn'], countries[pos, 'xmx'])
            yrng    <- c(countries[pos, 'ymn'], countries[pos, 'ymx'])

            pts <- pts[1:n, ]
            pts <- pts[sample(1:nrow(pts)), ]

            new_dev(width = 7, height = 6)

            par(bg = '#969696', mar = c(1, 2, 5, 7), family = 'serif', xaxs = 'i', yaxs = 'i')

            shp <- readRDS(system.file(paste('external/gis/', iso, '.rds', sep = ''), package = "geographr"))

            if (!is.na(xrng[1])){
                plot(shp, col = '#333333', border = '#969696', axes = FALSE, xlim = xrng, ylim = yrng)
            } else {
                plot(shp, col = '#333333', border = '#969696', axes = FALSE)
            }
            box(col = '#333333')

            j <- 1
            while (j <= nrow(pts)){

                par(xpd = TRUE)
                rect(par()$usr[2] + (par()$usr[2]-par()$usr[1])/30, par()$usr[3] - (par()$usr[4]-par()$usr[3])/2,
                     par()$usr[2] + (par()$usr[2]-par()$usr[1])/2, par()$usr[4] + (par()$usr[4]-par()$usr[3])/2,
                     col = '#969696', border = NA)
                rect(par()$usr[1] - (par()$usr[2]-par()$usr[1])/2, par()$usr[4] + (par()$usr[4]-par()$usr[3])/45,
                     par()$usr[2] + (par()$usr[2]-par()$usr[1])/2, par()$usr[4] + (par()$usr[4]-par()$usr[3])/2, col = '#969696', border = NA)

                if (lang == 'fr'){
                    text(par()$usr[1] - (par()$usr[2]-par()$usr[1])/20, par()$usr[4] + (par()$usr[4]-par()$usr[3])/10, paste(country, ': où se trouve ', as.character(pts[j, 'name']), '?', sep = ''), font = 2, cex = 1, pos = 4)
                    text(par()$usr[1] - (par()$usr[2]-par()$usr[1])/20, par()$usr[4] + (par()$usr[4]-par()$usr[3])/22, 'Cliquez sur la carte (3 essais par ville)', font = 2, cex = .65, pos = 4)
                }else{
                    text(par()$usr[1] - (par()$usr[2]-par()$usr[1])/20, par()$usr[4] + (par()$usr[4]-par()$usr[3])/10, paste(country, ': where is ', as.character(pts[j, 'name']), '?', sep = ''), font = 2, cex = 1, pos = 4)
                    text(par()$usr[1] - (par()$usr[2]-par()$usr[1])/20, par()$usr[4] + (par()$usr[4]-par()$usr[3])/22, 'Click on the map (3 attempts by city)', font = 2, cex = .65, pos = 4)
                }

                points(pts[ , 'long'], pts[ , 'lat'], cex = 2.5, pch = 21, bg = '#045a8d', col = 'white')

                k <- 1
                while (k < 4){
                    if (onclic3(pts[j, c('long', 'lat')]) == 0)
                        k <- k + 1
                    else
                        break
                }

                res[j] <- ifelse(k < 4, 1, 0)
                kk[j] <- k

                points(pts[j, 'long'], pts[j, 'lat'], cex = 2.5, pch = 21, bg = ifelse(k < 4, '#018571', '#a6611a'), col = ifelse(k < 4, '#018571', '#a6611a'))

                if (j < nrow(pts)){
                    clic <- add_button3(k, res, lang)
                    par(xpd = FALSE)
                    if (clic == 'next'){
                        j <- j + 1
                    }
                    if (clic == 'exit'){
                        j <- 100000
                    }
                } else {
                    add_close3(k, res, lang)
                    j <- 100000
                }
            }
            invisible(dev.off())

            if (lang == 'en'){
                cat('\n\n******************************************\n')
                cat('\n >>> Thanks for playing!\n')
                cat(paste('\n >>> You have completed ', length(kk), ifelse(length(kk) == 1, ' city on ', ' cities on '), nrow(pts), '\n', sep = ''))
                cat(paste('\n >>> Your final score is........ ', round(100*sum(res)/length(res)), '%', sep = ''))
                cat(paste('\n\t   > 1st attempt........ ', round(100*length(kk[kk == 1])/length(kk)), '%', sep = ''))
                cat(paste('\n\t   > 2nd attempt........ ', round(100*length(kk[kk == 2])/length(kk)), '%', sep = ''))
                cat(paste('\n\t   > 3rd attempt........ ', round(100*length(kk[kk == 3])/length(kk)), '%', sep = '', '\n'))
                cat('\n******************************************\n\n')
            }else{
                cat('\n\n******************************************\n')
                cat('\n >>> Merci d\'avoir joué!\n')
                cat(paste('\n >>> Vous avez cherché ', length(kk), ifelse(length(kk) == 1, ' ville sur ', ' villes sur '), nrow(pts), '\n', sep = ''))
                cat(paste('\n >>> Votre score final est.......... ', round(100*sum(res)/length(res)), '%', sep = ''))
                cat(paste('\n\t   > 1ère tentative......... ', round(100*length(kk[kk == 1])/length(kk)), '%', sep = ''))
                cat(paste('\n\t   > 2nde tentative......... ', round(100*length(kk[kk == 2])/length(kk)), '%', sep = ''))
                cat(paste('\n\t   > 3ème tentative......... ', round(100*length(kk[kk == 3])/length(kk)), '%', sep = '', '\n'))
                cat('\n******************************************\n\n')
            }
        }else{
            cat('\nSorry, cities are not available for this country. Try another country.\n')
        }
    }else{
        cat('\nYou have mispelled the country name. Use get_country_name() to have the correct spelling.\n')
    }
}
