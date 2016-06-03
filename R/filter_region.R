filter_region <-
function(data, region = 'world', lang = 'en'){

    if (tolower(region) != 'world')
        data <- data[which(!is.na(data$region)), ]

    labs <- list()
    labs[[1]] <- c('AFR', 'AFRIQUE', 'AFRICA')
    names(labs)[1] <- 'Afrique'
    labs[[2]] <- c('EU', 'EUR', 'EUROPE', 'EUROPA')
    names(labs)[2] <- 'Europe'
    labs[[3]] <- c('ASI', 'ASIE', 'ASIA')
    names(labs)[3] <- 'Asie'
    labs[[4]] <- c('NAM', 'AMERIQUE DU NORD', 'AMÉRIQUE DU NORD', 'NORTH AMERICA')
    names(labs)[4] <- 'Amérique du Nord'
    labs[[5]] <- c('SAM', 'AMERIQUE DU SUD', 'AMÉRIQUE DU SUD', 'SOUTH AMERICA')
    names(labs)[5] <- 'Amérique du Sud'
    labs[[6]] <- c('CAM', 'AMERIQUE CENTRALE', 'AMÉRIQUE CENTRALE', 'CENTRAL AMERICA')
    names(labs)[6] <- 'Amérique centrale'
    labs[[7]] <- c('OCE', 'OCÉANIE', 'OCEANIE', 'OCEANIA')
    names(labs)[7] <- 'Océanie'

    # data <- read.xlsx('continent.xlsx', 1)
    # data <- data[data[ , 'include'] == 1, ]
    # data <- data[ , c(1:10, 14:17)]
    # saveRDS(data, './data/countries.rds')

    for (i in 1 : length(labs)){
        if (toupper(region) %in% labs[[i]]){
            data <- data[data[ , 'region'] %in% names(labs)[i], ]
            data <- data[order(as.character(data[ , paste('country', lang, sep = '_')])), ]
        }
    }

    data <- data[sample(1:nrow(data)), ]

    return(data)
}
