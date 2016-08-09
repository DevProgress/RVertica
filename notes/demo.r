
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
