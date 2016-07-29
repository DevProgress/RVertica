
### Psql can connect to Vertica

- It [appears to be known](https://wiki.postgresql.org/wiki/PostgreSQL_derived_databases) that at
least `psql`, the Postgresql command-line client, can connect to Vertica

- Why do we care because `vsql` exists?  Well for once `psql` is likely easier to install via
`apt-get` or `yum`, and does require a full Vertica installation

- Preliminaries: Environment variables

In order to not have to retype user, host, database, port, and of course password we suggest a
simple shellscript, say `setEnv.sh`, containing

```bash
#!/bin/bash

export PGHOST=some.server.some.where
export PGPORT=5433
export PGDATABASE=dbname
export PGUSER=dbuser
export PGPASSWORD=somepassword
```

Set your appropriate values and then source it: `. setEnv.sh`.

- First example: connect and count

```bash
$ psql -c 'select count(*) from product_dimension;'
 count 
-------
 60000
(1 row)

$
```

This provides an existence proof.

- Second example: Show data

Similar to what we did via Python


$ psql -c 'select product_key, product_version, product_description from product_dimension limit 5' 
 product_key | product_version |     product_description      
-------------+-----------------+------------------------------
 1           | 1               | Brand #2 bagels
 1           | 2               | Brand #1 butter
 2           | 1               | Brand #6 chicken noodle soup
 2           | 2               | Brand #5 golf clubs
 2           | 3               | Brand #4 brandy
(5 rows)

$ 

- Third example: Create table, insert data, commit

Create a simple SQL script:

```sql
create table sqltest (x numeric, y numeric, z numeric);
insert into sqltest values (1,2,3);
insert into sqltest values (4,5,6);
commit;
```

Run it:

```bash
$ psql -f ex3.sql 
CREATE TABLE
 OUTPUT 
--------
 1
(1 row)

INSERT
 OUTPUT 
--------
 1
(1 row)

INSERT
COMMIT
$ 

Check it:

$ psql -c 'select * from sqltest;'
         x         |         y         |         z         
-------------------+-------------------+-------------------
 1.000000000000000 | 2.000000000000000 | 3.000000000000000
 4.000000000000000 | 5.000000000000000 | 6.000000000000000
(2 rows)

$ 
