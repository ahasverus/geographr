get_region_name <-
function(lang = 'en'){
    countries <- readRDS(system.file("external/countries.rds", package = "geographr"))
    if (lang == 'fr')
        return(sort(c('Afrique', 'Asie', 'Europe', 'Am\u00e9rique du Nord', 'Am\u00e9rique du Sud', 'Am\u00e9rique centrale', 'Oc\u00e9anie')))
    if (lang == 'en')
        return(sort(c('Africa', 'Asia', 'Europa', 'North America', 'South America', 'Central america', 'Oceania')))
}
