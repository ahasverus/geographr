new_dev <-
function(width = 6, height = 6){

    graphoutcome <- try(windows(width = width, height = height), silent = TRUE)
    if(length(graphoutcome) > 0) graphoutcome <- try(dev.new(width = width, height = height), silent = TRUE)
    if(length(graphoutcome) > 0) graphoutcome <- try(dev.new(width = width, height = height, noRStudioGD = TRUE), silent = TRUE)
    if(length(graphoutcome) > 0) graphoutcome <- try(x11(width = width, height = height), silent = TRUE)
    if(length(graphoutcome) > 0) graphoutcome <- try(quartz(width = width, height = height), silent = TRUE)
    if(length(graphoutcome) > 0) print("Graphics unavailable on this workstation")
}
