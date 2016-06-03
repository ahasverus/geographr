find_region <-
function(country = NULL, lang = 'en'){

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

        country <- as.character(countries[pos, paste('country', lang, sep = '_')])
        iso     <- as.character(countries[pos, 'iso3'])
        shp <- readRDS(system.file(paste('external/gis/', iso, '.rds', sep = ''), package = "geographr"))

        xrng    <- c(countries[pos, 'xmn'], countries[pos, 'xmx'])
        yrng    <- c(countries[pos, 'ymn'], countries[pos, 'ymx'])

        if (!is.na(xrng[1])){
            poly <- data.frame(x = c(xrng[1], xrng[1], xrng[2], xrng[2], xrng[1]),
                               y = c(yrng[1], yrng[2], yrng[2], yrng[1], yrng[1]))
            poly <- SpatialPolygons(list(Polygons(list(Polygon(poly)), '0')))
            proj4string(poly) <- proj4string(shp)
            ids <- over(shp, poly)
            shp <- shp[which(!is.na(ids)), ]
        }

        name <- which(colnames(shp@data) %in% c('NAME_1', paste('juri', lang, sep = '_')))

        if (length(name) > 0){

            country <- as.character(countries[pos, paste('country', lang, sep = '_')])
            iso     <- as.character(countries[pos, 'iso3'])

            new_dev(width = 7, height = 6)

            par(bg = '#969696', mar = c(1, 2, 5, 7), family = 'serif', xaxs = 'i', yaxs = 'i')

            if (!is.na(xrng[1])){
                plot(shp, col = '#333333', border = '#969696', axes = FALSE, xlim = xrng, ylim = yrng)
            } else {
                plot(shp, col = '#333333', border = '#969696', axes = FALSE)
            }
            box(col = '#333333')

            reg <- unique(as.character(shp@data[ , name]))
            reg <- sample(reg)

            j <- 1
            while (j <= length(reg)){

                if (j > 1)
                    plot(shp[which(shp@data[ , name] == reg[j-1]), ], col = '#333333', border = '#969696', add = TRUE)

                par(xpd = TRUE)
                rect(par()$usr[2] + (par()$usr[2]-par()$usr[1])/30, par()$usr[3] - (par()$usr[4]-par()$usr[3])/2,
                     par()$usr[2] + (par()$usr[2]-par()$usr[1])/2, par()$usr[4] + (par()$usr[4]-par()$usr[3])/2,
                     col = '#969696', border = NA)
                rect(par()$usr[1] - (par()$usr[2]-par()$usr[1])/2, par()$usr[4] + (par()$usr[4]-par()$usr[3])/45,
                     par()$usr[2] + (par()$usr[2]-par()$usr[1])/2, par()$usr[4] + (par()$usr[4]-par()$usr[3])/2, col = '#969696', border = NA)

                if (lang == 'fr'){
                    text(par()$usr[1] - (par()$usr[2]-par()$usr[1])/20, par()$usr[4] + (par()$usr[4]-par()$usr[3])/10, paste(country, ': où se trouve ', as.character(reg[j]), '?', sep = ''), font = 2, cex = 1, pos = 4)
                    text(par()$usr[1] - (par()$usr[2]-par()$usr[1])/20, par()$usr[4] + (par()$usr[4]-par()$usr[3])/22, 'Cliquez sur la carte (3 essais par région)', font = 2, cex = .65, pos = 4)
                }else{
                    text(par()$usr[1] - (par()$usr[2]-par()$usr[1])/20, par()$usr[4] + (par()$usr[4]-par()$usr[3])/10, paste(country, ': where is ', as.character(reg[j]), '?', sep = ''), font = 2, cex = 1, pos = 4)
                    text(par()$usr[1] - (par()$usr[2]-par()$usr[1])/20, par()$usr[4] + (par()$usr[4]-par()$usr[3])/22, 'Click on the map (3 attempts by region)', font = 2, cex = .65, pos = 4)
                }

                k <- 1
                while (k < 4){
                    if (onclic4(shp[which(shp@data[ , name] == reg[j]), ]) == 0)
                        k <- k + 1
                    else
                        break
                }

                res[j] <- ifelse(k < 4, 1, 0)
                kk[j] <- k

                plot(shp[which(shp@data[ , name] == reg[j]), ], col = ifelse(k < 4, '#018571', '#a6611a'), border = '#969696', add = TRUE)

                if (j < length(reg)){
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
                cat(paste('\n >>> You have completed ', length(kk), ifelse(length(kk) == 1, ' region on ', ' regions on '), length(reg), '\n', sep = ''))
                cat(paste('\n >>> Your final score is........ ', round(100*sum(res)/length(res)), '%', sep = ''))
                cat(paste('\n\t   > 1st attempt........ ', round(100*length(kk[kk == 1])/length(kk)), '%', sep = ''))
                cat(paste('\n\t   > 2nd attempt........ ', round(100*length(kk[kk == 2])/length(kk)), '%', sep = ''))
                cat(paste('\n\t   > 3rd attempt........ ', round(100*length(kk[kk == 3])/length(kk)), '%', sep = '', '\n'))
                cat('\n******************************************\n\n')
            }else{
                cat('\n\n******************************************\n')
                cat('\n >>> Merci d\'avoir joué!\n')
                cat(paste('\n >>> Vous avez cherché ', length(kk), ifelse(length(kk) == 1, ' région sur ', ' régions sur '), length(reg), '\n', sep = ''))
                cat(paste('\n >>> Votre score final est.......... ', round(100*sum(res)/length(res)), '%', sep = ''))
                cat(paste('\n\t   > 1ère tentative......... ', round(100*length(kk[kk == 1])/length(kk)), '%', sep = ''))
                cat(paste('\n\t   > 2nde tentative......... ', round(100*length(kk[kk == 2])/length(kk)), '%', sep = ''))
                cat(paste('\n\t   > 3ème tentative......... ', round(100*length(kk[kk == 3])/length(kk)), '%', sep = '', '\n'))
                cat('\n******************************************\n\n')
            }
        }else{
            cat('\nSorry, regions are not available for this country. Try another country.\n')
        }
    }else{
        cat('\nYou have mispelled the country name. Use get_country_name() to have the correct spelling.\n')
    }
}
