mask_flag <-
function(xy, flag, w){

    sop <- which(xy[ , 'flags'] == flag)
    k <- 1
    for (i in 1 : 3){
        for (j in 1 : 3){
            if (k != sop){
                rect(xy[k, 'xmn'], xy[k, 'ymn'], xy[k, 'xmx'], xy[k, 'ymx'],
                     border = '#969696', col = '#969696ee', lwd = 5)
            } else {
                rect(xy[k, 'xmn'], xy[k, 'ymn'], xy[k, 'xmx'], xy[k, 'ymx'],
                     border = ifelse(w < 4, '#018571', '#a6611a'), lwd = 5)
            }
            k <- k + 1
        }
    }
}
