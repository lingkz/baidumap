% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/getPlace.R
\name{getPlace}
\alias{getPlace}
\title{Get place from query
Take in query and city, return the informations}
\usage{
getPlace(place = NULL, city = "北京")
}
\arguments{
\item{place}{the place you want to search}

\item{city}{define the city}
}
\value{
a data frame contains name, longtitude, latitude and address, as well as teleplhone number, if exist.
}
\description{
Get place from query
Take in query and city, return the informations
}
\examples{
\dontrun{
## colleges in beijing
bj_college = getPlace('大学', '北京')
## Mcdonald's in shanghai
sh_mcdonald = getPlace('麦当劳', '上海')
}
}

