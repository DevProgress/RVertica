
### Lighter-weight Vertica access from R

- We use the (as we understand it, unofficial) Python client for Vertica from
Uber at  https://github.com/uber/vertica-python

- We also use the lightweight Python client for R from CRAN at
https://cloud.r-project.org/web/packages/rPython/index.html

- Three simple examples follow

- First example: Connect

```python
import vertica_python

conn_info = {'host': '127.0.0.1',
             'port': 5433,
             'user': 'youruser',
             'password': 'yourpass',
             'database': 'testdb',
             # 10 minutes timeout on queries
             'read_timeout': 600,
             # default throw error on invalid UTF-8 results
             'unicode_error': 'strict',
             # SSL is disabled by default
             'ssl': False}

# simple connection, with manual close
connection = vertica_python.connect(**conn_info)
# do things
connection.close()
```

Running `python ex1.py` should execute without error, demonstrating that we
can access the database.

- Second example: Show data

```python
import vertica_python

conn_info = {'host': '127.0.0.1',
             'port': 5433,
             'user': 'youruser',
             'password': 'yourpass',
             'database': 'testdb',
             # 10 minutes timeout on queries
             'read_timeout': 600,
             # default throw error on invalid UTF-8 results
             'unicode_error': 'strict',
             # SSL is disabled by default
             'ssl': False}

# simple connection, with manual close
connection = vertica_python.connect(**conn_info)

# do things

cur = connection.cursor()
cur.execute("SELECT product_key, product_version, product_description FROM product_dimension LIMIT 5")

for row in cur.iterate():
    print(row)

connection.close()
```

This shows the following output:

```python
python ex2.py
[1, 1, 'Brand #2 bagels']
[1, 2, 'Brand #1 butter']
[2, 1, 'Brand #6 chicken noodle soup']
[2, 2, 'Brand #5 golf clubs']
[2, 3, 'Brand #4 brandy']
$
```

We can also call it from R thanks to rPython:

```r
R> library(rPython)
R> python.load("ex2.py")
[1, 1, 'Brand #2 bagels']
[1, 2, 'Brand #1 butter']
[2, 1, 'Brand #6 chicken noodle soup']
[2, 2, 'Brand #5 golf clubs']
[2, 3, 'Brand #4 brandy']
R> 
```

- Third example: Getting data to R

We can build on the previous example by assigning in Python, and then
querying the variable from R.

```python
import vertica_python

conn_info = {'host': '127.0.0.1',
             'port': 5433,
             'user': 'youruser',
             'password': 'yourpass',
             'database': 'testdb',
             # 10 minutes timeout on queries
             'read_timeout': 600,
             # default throw error on invalid UTF-8 results
             'unicode_error': 'strict',
             # SSL is disabled by default
             'ssl': False}

# simple connection, with manual close
connection = vertica_python.connect(**conn_info)

# do things

cur = connection.cursor()
#cur.execute("SELECT * FROM product_dimension LIMIT 5")
cur.execute("SELECT product_key, product_version, product_description FROM product_dimension LIMIT 5")
res = cur.fetchall()
connection.close()
```

We won't show the output as there is none -- nothing is printed.  From R,
however, we now can:

```r
R> library(rPython)
R> python.load("ex3.py")    # run Python script
R> str(python.get("res"))   # fetch Python result
List of 5
 $ :List of 3
  ..$ : num 1
  ..$ : num 1
  ..$ : chr "Brand #2 bagels"
 $ :List of 3
  ..$ : num 1
  ..$ : num 2
  ..$ : chr "Brand #1 butter"
 $ :List of 3
  ..$ : num 2
  ..$ : num 1
  ..$ : chr "Brand #6 chicken noodle soup"
 $ :List of 3
  ..$ : num 2
  ..$ : num 2
  ..$ : chr "Brand #5 golf clubs"
 $ :List of 3
  ..$ : num 2
  ..$ : num 3
  ..$ : chr "Brand #4 brandy"
R> 
```

- More to come, hopefully
