onclic2 <-
function(xy, flag){

    pt  <- locator(1)
    sop <- which(xy[ , 'flags'] == flag)
    return(ifelse(pt$x >= xy[sop, 'xmn'] && pt$x <= xy[sop, 'xmx'] &&
                  pt$y >= xy[sop, 'ymn'] && pt$y <= xy[sop, 'ymx'], 1, 0))
}
