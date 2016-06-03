map_guess <-
function(region){

    if (toupper(region) %in% c('EU', 'EUR', 'EUROPE', 'EUROPA')){
        xrng <- c(-24.00, 45.00)
        yrng <- c( 34.00, 71.75)
    }

    if (toupper(region) %in% c('AFR', 'AFRIQUE', 'AFRICA')){
        xrng <- c(-26.00, 58.50)
        yrng <- c(-35.50, 39.90)
    }

    if (toupper(region) %in% c('ASI', 'ASIE', 'ASIA')){
        xrng <- c( 26.50, 144.97)
        yrng <- c(-10.00, 55.56)
    }

    if (toupper(region) %in% c('NAM', 'AMERIQUE DU NORD', 'AMÉRIQUE DU NORD', 'NORTH AMERICA')){
        xrng <- c(-172.00, -42.00)
        yrng <- c(  15.00,  83.55)
    }

    if (toupper(region) %in% c('SAM', 'AMERIQUE DU SUD', 'AMÉRIQUE DU SUD', 'SOUTH AMERICA')){
        xrng <- c(-93.00, -30.00)
        yrng <- c(-58.70,  13.57)
    }

    if (toupper(region) %in% c('CAM', 'AMERIQUE CENTRALE', 'AMÉRIQUE CENTRALE', 'CENTRAL AMERICA')){
        xrng <- c(-93.00, -57.00)
        yrng <- c(  7.00,  28.70)
    }

    if (toupper(region) %in% c('OCE', 'OCÉANIE', 'OCEANIE', 'OCEANIA')){
        xrng <- c(112.00, 182.00)
        yrng <- c(-52.00,  6.30)
    }

    map('world', wrap = TRUE, fill = TRUE, col = '#333333', border = NA, xlim = xrng, ylim = yrng, mar = rep(1, 4))
    map(region = 'Lesotho', wrap = TRUE, fill = TRUE, col = '#333333', border = '#969696', add = TRUE, lwd = .25)
    box(col = '#333333')
}
