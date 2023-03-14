# create db
# psql -d template1
import psycopg2
from faker import Faker
# https://stackabuse.com/working-with-postgresql-in-python/
con = psycopg2.connect(database="dbcourse", user="postgres",
                       password="itoqiakamatia", host="localhost", port="5432")

print("Database opened successfully")
cur = con.cursor()
cur.execute('''CREATE TABLE CUSTOMER
       (ID INT PRIMARY KEY     NOT NULL,
       Name           TEXT    NOT NULL,
       Address            TEXT     NOT NULL,
       review        TEXT);''')
print("Table created successfully")
fake = Faker()
for i in range(1000000):
    print(i)
    cur.execute("INSERT INTO CUSTOMER (ID,Name,Address,review) VALUES ('"+ str(i)+"','"+fake.name()+"','"+fake.address()+"','"+fake.text()+"')")
    con.commit()