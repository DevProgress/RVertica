### RVertica

To access Vertica from R with more ease and/or oomph

### Status

In Progress, see _e.g._ the
[notes/](https://github.com/eddelbuettel/RVertica/tree/master/notes/) directory

Currently, a basic R package is available, and can be installed. It
tests cleanly against `R CMD check`.

### Demo

#### Code

```r
library(RVertica)

## sample query using Vertica sample data set and table
demoquery <- "SELECT * FROM product_dimension LIMIT 100;"

r1 <- getDataPSQL(demoquery)
r2 <- getDataJDBC(demoquery)
r3 <- getDataRPostgreSQL(demoquery)
r4 <- getDataPython(demoquery)

## we cannot do 'identical' comparison because some drivers
## return colums as int, others numeric; r4 has no column headers etc

## but dimension is fine
cat("\nDimension:\n")
print(rbind(dim(r1), dim(r2), dim(r3), dim(r4)))

cat("\nOne column:\n")
print(all.equal(r1[, "product_price"],
                r2[, "product_price"],
                as.numeric(r3[, "product_price"]),
                as.numeric(r4[, "V16"])
                ))

## simple benchmark
cat("Simple benchmark:\n")
runBenchmarks()
```

#### Output

Note the output is verbose on purpose. You need to set all these
environment variables which are then checked for. Use
`suppressMessages(library(RVertica))` for a more silent load.


```r
RVertica starting up. Note that we're still alpha at this point.
Good. We found 'psql' at '/usr/bin/psql'.
Good. We found 'VERTICAHOST' as an environment variable.
Good. We found 'VERTICAPORT' as an environment variable.
Good. We found 'VERTICADATABASE' as an environment variable.
Good. We found 'VERTICAUSER' as an environment variable.
Good. We found 'VERTICAPASSWORD' as an environment variable.
Good. We found 'VERTICAJARPATH' as an environment variable.
Good. 'VERTICAJARPATH' points a an existing file.

Dimension:
     [,1] [,2]
[1,]  100   21
[2,]  100   21
[3,]  100   21
[4,]  100   21

One column:
[1] TRUE
Simple benchmark:
                       test replications elapsed relative
2        getDataJDBC(query)          100  10.791    1.000
3 getDataRPostgreSQL(query)          100  11.977    1.110
1        getDataPSQL(query)          100  34.562    3.203
4      getDataPython(query)          100 118.543   10.985
```

### Questions

For questions, comments, suggestions, ... use the issue tickets or the Slack channel.


