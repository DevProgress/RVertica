
getDataPSQL <- function(sqlquery) {

    ## build a command string a la
    ##   psql -Pfooter=off -A -F, -c '...sqlquery...'
    ## where no footer, -A and F, make for csv reading in R
    cmd <- sprintf("%s -Pfooter=off -A -F, -c '%s'", .pkgenv$psqlpath, sqlquery)

    dat <- read.csv(file=pipe(cmd))

    invisible(dat)
}


getDataJDBC <- function(sqlquery) {

    if (requireNamespace("RJDBC", quietly=TRUE)) {
        library(RJDBC)
        vDriver <- JDBC(driverClass="com.vertica.jdbc.Driver", classPath=.pkgenv$vjar)
        vertica <- dbConnect(vDriver, paste0("jdbc:vertica://",
                                             .pkgenv$vhost, ":",
                                             .pkgenv$vport, "/",
                                             .pkgenv$vdb),
                             .pkgenv$vuser,
                             .pkgenv$vpasswd)
        dat <- dbGetQuery(vertica, sqlquery)
        invisible(dat)
    } else {
        warning("Need RJDBC")
        invisible(NULL)
    }

}
