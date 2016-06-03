get_region_name <-
function(lang = 'en'){
    countries <- readRDS(system.file("external/countries.rds", package = "geographr"))
    if (lang == 'fr')
        return(sort(c('Afrique', 'Asie', 'Europe', 'Amérique du Nord', 'Amérique du Sud', 'Amérique centrale', 'Océanie')))
    if (lang == 'en')
        return(sort(c('Africa', 'Asia', 'Europa', 'North America', 'South America', 'Central america', 'Oceania')))
}
