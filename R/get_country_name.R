get_country_name <-
function(lang = 'en'){
    countries <- readRDS(system.file("external/countries.rds", package = "geographr"))
    return(sort(as.character(countries[ , paste('country', lang, sep = '_'), ])))
}
