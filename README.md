# RVertica


## Libraries to consider:

https://github.com/google/rfmt
- a formatter which uses Python internally (to get a lexer/yaccer) and they just bundle the Python package.

https://github.com/johnmchambers/XRPython
- There is one other thing to look at. John Chambers, R's creator, just had another book out (for which I read a draft).  Entitled "Extending R" it is largely about R, its design and then going from R to Julia, Python, C++.  He uses this package for the Python interface and has a working package then using Python text processing to mine Shakespeare's collected works. So I am more than "pretty certain" that this will get us proper data sets back.

- https://cran.r-project.org/web/packages/rPython/index.html

```
R> library(rPython)
Loading required package: RJSONIO
R> python.exec( "import math" )
R> python.get( "math.pi" )
[1] 3.14159
```

https://github.com/vertica/vertica.dplyr
- That connect R via dplyr to Vertica ... yet talks about JDBC | ODBC as requirements



https://github.com/uber/vertica-python/
- So in general taking a C(++)-based SDK and building a client is not "that" hard. A decade ago I mentored a Google Summer of Code student for the first Postgres connection to R -- RPostgreSQL.  And that was even in plain C.   There we just build one source package, and given postgresql libraries on Linux, OS X and Windows get binaries on all OSs.  And basically the same thing happens with MySQL, SQLite, ...  So I guess I need to look at exactly what Vertica provides in terms of an SDK.  Now something like this (by them) is doing exactly that



https://github.com/vertica/r-dataconnector/blob/master/dataconnector/DESCRIPTION
