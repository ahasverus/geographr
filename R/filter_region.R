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
    labs[[4]] <- c('NAM', 'AMERIQUE DU NORD', 'AM\u00e9RIQUE DU NORD', 'NORTH AMERICA')
    names(labs)[4] <- 'Am\u00e9rique du Nord'
    labs[[5]] <- c('SAM', 'AMERIQUE DU SUD', 'AM\u00e9RIQUE DU SUD', 'SOUTH AMERICA')
    names(labs)[5] <- 'Am\u00e9rique du Sud'
    labs[[6]] <- c('CAM', 'AMERIQUE CENTRALE', 'AM\u00e9RIQUE CENTRALE', 'CENTRAL AMERICA')
    names(labs)[6] <- 'Am\u00e9rique centrale'
    labs[[7]] <- c('OCE', 'OC\u00e9ANIE', 'OCEANIE', 'OCEANIA')
    names(labs)[7] <- 'Oc\u00e9anie'

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
