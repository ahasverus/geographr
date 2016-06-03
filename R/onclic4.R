onclic4 <-
function(shp){

    pt  <- locator(1)
    pt <- SpatialPoints(matrix(unlist(pt), ncol = 2))
    proj4string(pt) <- proj4string(shp)
    pos <- over(pt, shp)

    return(ifelse(!is.na(pos[ , 1]), 1, 0))
}
