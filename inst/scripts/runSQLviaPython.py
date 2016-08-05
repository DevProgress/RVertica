
## Minimal, and I mean _minimal_ script to send a query via python and get csv back on stdin

import vertica_python
import csv, sys, os

conn_info = {'host': os.environ['PGHOST'],
             'port': int(os.environ['PGPORT']),
             'user': os.environ['PGUSER'],
             'password': os.environ['PGPASSWORD'],
             'database': os.environ['PGDATABASE'],
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
#cur.execute("SELECT product_key, product_version, product_description FROM product_dimension LIMIT 5")
cur.execute(sys.argv[1])
res = cur.fetchall()
connection.close()

writer = csv.writer(sys.stdout, delimiter=',')
writer.writerows(res)
