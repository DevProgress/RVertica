
##' Run benchmarks against Vertica using three different access methods:
##' the \code{psql} binary, the RJDBC package and the RPostgreSQL package.
##'
##' @title Run Simple Vertica Benchmark Query
##' @param query A SQL query, default uses the example data set.
##' @return A data.frame with the first for columns returned by
##'  \code{benchmark}.
##' @author Dirk Eddelbuettel
runBenchmarks <- function(query="SELECT * FROM product_dimension LIMIT 10000;") {
    res <- benchmark(getDataPSQL(query),
                     getDataJDBC(query),
                     getDataRPostgreSQL(query))
    res[,1:4]
}
