map_focus <-
function(country, perl, col = '#416639'){

    x <- map("world", plot = FALSE)$names
    if (perl)
        query <- x[grep(tolower(as.character(country)), tolower(x))]
    else
        query <- country

    map(region = query, wrap = TRUE, fill = TRUE, col = col, border = NA, add = TRUE)
}
