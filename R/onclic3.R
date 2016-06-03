onclic3 <-
function(pts){

    pt  <- locator(1)
    x <- (par()$usr[2]-par()$usr[1])/40
    y <- (par()$usr[4]-par()$usr[3])/40
    return(ifelse(pt$x >= (pts[1, 'long'] - x) && pt$x <= (pts[1, 'long'] + x) &&
                  pt$y >= (pts[1, 'lat']  - y) && pt$y <= (pts[1, 'lat']  + y), 1, 0))
}
