\name{RVertica-package}
\alias{RVertica-package}
\alias{RVertica}
\docType{package}
\title{
  This Package Provides Access to Vertica from R
}
\description{
  Work in progress. We aim to be faster than the Python-based package
  released by Uber, and less cumbersome to use than the official
  RJDBC-based access.
}
\details{
  We use the following environment variable when the package is
  attached: \code{VERTICAHOST}, \code{VERTICAPORT},
  \code{VERTICADATABASE}, \code{VERTICAUSER}, \code{VERTICAPASSWORD} and
  \code{VERTICAJARPATH}. 
}
\author{
Dirk Eddelbuettel

Maintainer: Dirk Eddelbuettel <edd@debian.org>
}
\keyword{ package }
\examples{
\dontrun{
    getDataRPostgreSQL("select * from product_dimension limit 5;")
}
}
