\name{find_cities}
\alias{find_cities}

\title{Locate cities on the map}

\description{Locate cities on the map}

\usage{find_cities(country = NULL, lang = "en", n = 10)}

\arguments{
    \item{country}{A character (i.e. France). See \code{\link{get_country_name}} for the correct spelling. If NULL a random country is displayed.}
    \item{lang}{\emph{en} (english) or \emph{fr} (french)}
    \item{n}{Number of towns to find}
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
