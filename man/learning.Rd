\name{learning}
\alias{learning}

\title{Learn the geography of the world countries}

\description{Learn the geography of the world countries}

\usage{
    learning(region = "world", lang = "en")
}

\arguments{
    \item{region}{A character (i.e. Asia). See \code{\link{get_region_name}} for the correct spelling. The default value is world.}
    \item{lang}{\emph{en} (english) or \emph{fr} (french)}
}

\value{A graphical device}

\author{Nicolas Casajus}

\seealso{
    \code{\link{get_region_name}},
    \code{\link{find_cities}},
    \code{\link{find_flag}},
    \code{\link{find_country}}
}

\examples{
### See https://github.com/ahasverus/geographr
}
