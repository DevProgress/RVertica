##' Run a sample query against Vertica using \code{psql}.
##'
##' The \code{psql} binary is required.
##' @title Run Sample Query via \code{psql}
##' @param sqlquery A SQL query as character string
##' @return The dataset corresponding to the query.
##' @author Dirk Eddelbuettel
getDataPSQL <- function(sqlquery) {

    ## build a command string a la
    ##   psql -Pfooter=off -A -F, -c '...sqlquery...'
    ## where no footer, -A and F, make for csv reading in R
    cmd <- sprintf("%s -Pfooter=off -A -F, -c '%s'", .pkgenv$psqlpath, sqlquery)

    dat <- read.csv(file=pipe(cmd))

    invisible(dat)
}

##' Run a sample query against Vertica using RJDBC.
##'
##' The RJDBC package is required, and has to be configured via
##' environment variables.
##' @title Run Sample Query via RJDBC
##' @param sqlquery A SQL query as character string
##' @return The dataset corresponding to the query.
##' @author Dirk Eddelbuettel
getDataJDBC <- function(sqlquery) {

    if (requireNamespace("RJDBC", quietly=TRUE)) {
        vDriver <- RJDBC::JDBC(driverClass="com.vertica.jdbc.Driver", classPath=.pkgenv$vjar)
        vertica <- RJDBC::dbConnect(vDriver, paste0("jdbc:vertica://",
                                                    .pkgenv$vhost, ":",
                                                    .pkgenv$vport, "/",
                                                    .pkgenv$vdb),
                                    .pkgenv$vuser,
                                    .pkgenv$vpasswd)
        dat <- RJDBC::dbGetQuery(vertica, sqlquery)
        RJDBC::dbDisconnect(vertica)
        invisible(dat)
    } else {
        warning("Need RJDBC")
        invisible(NULL)
    }

}

##' Run a sample query against Vertica using RPostgreSQL.
##'
##' The RPostgreSQL package is used, and has to be configured via
##' environment variables.
##' @title Run Sample Query via RPostgreSQL
##' @param sqlquery A SQL query as character string
##' @return The dataset corresponding to the query.
##' @author Dirk Eddelbuettel
getDataRPostgreSQL <- function(sqlquery) {

    ow <- getOption("warn")
    options(warn=-1)

    ## load the PostgresSQL driver
    drv <- dbDriver("PostgreSQL")

    ## connect to the default db
    con <- dbConnect(drv,
                      user=.pkgenv$vuser,
                      password=.pkgenv$vpasswd,
                      host=.pkgenv$vhost,
                      dbname=.pkgenv$vdb,
                      port=.pkgenv$vport)

    dat <- dbGetQuery(con, sqlquery)

    dbDisconnect(con)

    options(warn=ow)
    invisible(dat)
}

##' Run a sample query against Vertica using the Python-Vertica
##' package.
##'
##' The Python installation must have the Python-Vertica package
##' contributed by Uber. There is essentially no error handling. This
##' function is really only here for completeness and not recommended.
##' The rPython package could be used as well.
##' @title Run Sample Query via Python
##' @param sqlquery A SQL query as character string
##' @return The dataset corresponding to the query.
##' @author Dirk Eddelbuettel
getDataPython <- function(sqlquery) {

    ## the script is part of this package
    script <- system.file("scripts", "runSQLviaPython.py", package="RVertica")

    ## python is assumed in the path, and also assumed to have the
    ## proper Vertica package
    cmd <- sprintf("python %s '%s'", script, sqlquery)

    dat <- read.csv(file=pipe(cmd))

    invisible(dat)
}
