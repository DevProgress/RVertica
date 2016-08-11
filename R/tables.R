
##' Simple convenience wrapper to run a single command
##'
##' The \code{psql} binary is required.
##' @title Run Simple SQL Command via \code{psql}
##' @param sqlcmd A SQL cmd as character string
##' @return The result of running the command.
##' @author Dirk Eddelbuettel
psqlCommand <- function(sqlcmd) {

    cmd <- sprintf("%s -c '%s'", .pkgenv$psqlpath, sqlcmd)

    res <- readLines(con=pipe(cmd))

    invisible(res)
}

# Rscript -e 'library(RVertica); print(psqlCommand("create table sqltest (a numeric, b int, c varchar(20));"))'

##' Write a data object to a table using \code{psql}
##'
##' Data is written via pipe into \code{psql} which reads the data and
##' inserts it into the give table.  There is no error checking. Proof
##' of concept.
##' @title Write Data to a Table
##' @param data A matrix or data.frame which is to be written
##' @param table The name of existing table
##' @return Nothing
##' @author Dirk Eddelbuettel
psqlCopy <- function(data, table) {
    cmd <- sprintf("%s -c \"COPY %s FROM STDIN USING DELIMITERS ',';\"", .pkgenv$psqlpath, table)
    write.table(data, file=pipe(cmd), row.names = FALSE, col.names = FALSE, sep=",")
    invisible(NULL)
}
