
import psycopg2
from geopy.geocoders import Nominatim

conn = psycopg2.connect(database="dvdrental", user="postgres",
                       password="itoqiakamatia", host="localhost", port="5432")
print("Database opened successfully")
cur = conn.cursor()

cur.execute('''CREATE TABLE IF NOT EXISTS Location(
                address             TEXT  PRIMARY KEY   NOT NULL,
                latitude            TEXT                NOT NULL,
                longitude           TEXT                NOT NULL);''')

print("Table is created successfully")

cur.execute("SELECT * FROM ex1();")
raw = cur.fetchall()

for row in raw:
    print(row)

geolocator = Nominatim(user_agent="dvdrental")

for row in raw:
    address = str(row[0])
    longitude = ""
    latitude = ""
    try:
        location = geolocator.geocode(address)
        longitude = str(location.longitude)
        latitude = str(location.latitude)
    except:
        print("Error: geocode failed to find address %s"%(address))
        latitude = "0"
        longitude = "0"
    cur.execute("INSERT INTO Location (address,latitude,longitude) VALUES ('"+ address+"','"+latitude+"','"+longitude+"')")
    conn.commit()

cur.close()
conn.close()

print("Table updated successfully")
