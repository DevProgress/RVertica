
### Repo

Start from the official code base at https://github.com/tomoakin/RPostgreSQL
The R package is one level down as that is how the SVN repos used to be laid out...

### Minimal Diff

Dirk's binary has this diff:

```
diff --git a/RPostgreSQL/DESCRIPTION b/RPostgreSQL/DESCRIPTION
index c39b6f0..1ae3d2a 100644
--- a/RPostgreSQL/DESCRIPTION
+++ b/RPostgreSQL/DESCRIPTION
@@ -1,6 +1,6 @@
 Package: RPostgreSQL
-Version: 0.5-2
-Date: $Date$
+Version: 0.5-2.1
+Date: 2016-07-27
 Title: R interface to the PostgreSQL database system
 Author: Joe Conway, Dirk Eddelbuettel, Tomoaki Nishiyama, Sameer Kumar Prayaga (during 2008), Neil Tiffin
 Maintainer: Tomoaki Nishiyama <tomoakin@staff.kanazawa-u.ac.jp>
diff --git a/RPostgreSQL/R/PostgreSQL.R b/RPostgreSQL/R/PostgreSQL.R
index 0c2f093..37344fe 100644
--- a/RPostgreSQL/R/PostgreSQL.R
+++ b/RPostgreSQL/R/PostgreSQL.R
@@ -10,6 +10,8 @@
 ## Constants
 ##
 
+useVertica <- TRUE
+
 ##.PostgreSQLRCS <- "$Id: PostgreSQL.R,v 0.1 2008/06/10 14:00:00$"
 .PostgreSQLPkgName <- "RPostgreSQL"
 .PostgreSQLVersion <- "0.5-2"       ##package.description(.PostgreSQLPkgName, fields = "Version")
@@ -128,6 +130,7 @@ setMethod("summary", "PostgreSQLConnection",
 ## convenience methods
 setMethod("dbListTables", "PostgreSQLConnection",
           def = function(conn, ...){
+              if (useVerica) return(character())
               out <- dbGetQuery(conn,
                                 paste("select tablename from pg_tables where schemaname !='information_schema'",
                                       "and schemaname !='pg_catalog'", ...))
@@ -165,6 +168,7 @@ setMethod("dbWriteTable",
 setMethod("dbExistsTable",
           signature(conn="PostgreSQLConnection", name="character"),
           def = function(conn, name, ...){
+              if (useVertica) return(FALSE)
               qlength <- length(name)
               if(qlength == 1){
               currentschema <- dbGetQuery(conn, "SELECT current_schema()")
@@ -229,6 +233,7 @@ setMethod("dbRollback",
 setMethod("dbListFields",
           signature(conn="PostgreSQLConnection", name="character"),
           def = function(conn, name, ...){
+              if (useVertica) return(character())
               qlength <- length(name)
               if(qlength == 1){
               currentschema <- dbGetQuery(conn, "SELECT current_schema()")
```

The first just sets a different package number to differentiate.

The others just use (global) boolean to return from functions
accessing the `pg_tables` schema we do not have in Vertice.

**No other changes were made**

Install this via the standard

```bash
R CMD INSTALL .
```

from the source directory, or else

```bash
cd ..
R CMD build rpostgresql
R CMD INSTALL RPostgreSQL_0.5-2.1.tar.gz
```
