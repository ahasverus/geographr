\name{find_region}
\alias{find_region}

\title{Locate regions on the map}

\description{Locate regions on the map}

\usage{find_region(country = NULL, lang = "en")}

\arguments{
    \item{country}{A character (i.e. France). See \code{\link{get_country_name}} for the correct spelling. If NULL a random country is displayed.}
    \item{lang}{\emph{en} (english) or \emph{fr} (french)}
}

\value{A graphical device}

\author{Nicolas Casajus}

\seealso{
    \code{\link{get_country_name}},
    \code{\link{learning}},
    \code{\link{find_flag}},
    \code{\link{find_country}}
}

\examples{
### See https://github.com/ahasverus/geographr
}
