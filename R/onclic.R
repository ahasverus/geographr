onclic <-
function(country){

    xy  <- locator(1)
    if (country == 'United Kingdom') country = 'UK'
    if (country == 'United States') country = 'USA'
    if (country == 'Trinidad and Tobago') country = 'Trinidad|Tobago'
    if (country == 'Saint Vincent and the Grenadines') country = 'Saint Vincent|Grenadines'
    if (country == 'South Georgia and the South Sandwich Islands') country = 'South Georgia|South Sandwich Islands'
    pos <- grep(tolower(country), tolower(map.where(x = xy$x, y = xy$y)))
    return(ifelse(length(pos) == 1, 1, 0))
}
