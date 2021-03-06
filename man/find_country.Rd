\name{find_country}
\alias{find_country}

\title{Identify countries on the map}

\description{Identify countries on the map}

\usage{
    find_country(region = "Europa", lang = "en")
}

\arguments{
    \item{region}{A character (i.e. Asia). See \code{\link{get_region_name}} for the correct spelling. The default value is Europa.}
    \item{lang}{\emph{en} (english) or \emph{fr} (french)}
}

\value{A graphical device}

\author{Nicolas Casajus}

\seealso{
    \code{\link{get_region_name}},
    \code{\link{find_cities}},
    \code{\link{find_flag}},
    \code{\link{learning}}
}

\examples{
### See https://github.com/ahasverus/geographr
}
