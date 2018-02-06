learning <-
function(region = 'world', lang = 'en'){

    ### Implementer region

    if (!(tolower(substr(lang, 1, 2)) %in% c('en', 'fr')))
        stop('Possible values for lang: fr or en')

    options(warn = -1)

    countries <- readRDS(system.file("external/countries.rds", package = "geographr"))
    countries <- filter_region(countries, region, lang)

    i <- 1

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
            new_dev(width = 9, height = 6)
        }
        layout(matrix(c(2, 2, 1, 2, 2, 3), byrow = TRUE, ncol = 3))

        name <- ifelse(is.na(countries[i, 'map']), as.character(countries[i, 'country_en']), as.character(countries[i, 'map']))
        rgxp <- ifelse(is.na(countries[i, 'map']), TRUE, FALSE)
        map_world(name, perl = rgxp)
        if (as.character(countries[i, 'iso3']) != 'ATA')
            map_country(iso = iso, city = city, xpt = xpt, ypt = ypt, xrng = xrng, yrng = yrng)
        else
            map_ata()
        map_flag(iso = tolower(as.character(countries[i, 'iso2'])))
        par(new = TRUE, xpd = TRUE)
        plot(0, type = 'n', ann = FALSE, axes = FALSE)
        text(1, 1.60, country, font = 2, cex = 1.5)


        if (i < nrow(countries)){
            clic <- add_button(lang)
            par(xpd = FALSE)
            if (clic == 'next'){
                i <- i + 1
            }
            if (clic == 'previous'){
                i <- i - 1
                if (i < 1) i <- 1
            }
            if (clic == 'exit'){
                i <- 100000
            }
        } else {
            add_close(lang)
            i <- 100000
        }


    }
    invisible(dev.off())

    if (lang == 'en'){
        cat('\n\n*******************************************************************************\n')
        cat('\n >>> Ready to test your skills?\n')
        cat('\n    > Try find_country() and identify countries on the map')
        cat('\n    > Try find_flag() and identify national flags')
        cat('\n    > Try find_cities() and locate cities on the map\n')
        cat('\n*******************************************************************************\n\n')
    }else{
        cat('\n\n*******************************************************************************\n')
        cat('\n >>> Pr\u00eat \u00e0 tester vos connaissances?\n')
        cat('\n    > Essayez find_country() et identifiez les pays sur la carte')
        cat('\n    > Essayez find_flag() et identifiez les drapeaux nationaux')
        cat('\n    > Essayez find_cities() et situez sur la carte les principales villes\n')
        cat('\n*******************************************************************************\n\n')
    }

}
