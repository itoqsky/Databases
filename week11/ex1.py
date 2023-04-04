from pymongo import MongoClient

client = MongoClient("mongodb://localhost")

db = client["test"]

def query_irish_cuisines():
    cursor = db.restaurants.find({"cuisine": "Irish"})
    for document in cursor:
        print(document)

query_irish_cuisines()

def query_irish_russian_cuisines():
    cursor = db.restaurants.find({"$or": [{"cuisine": "Irish"}, {"cuisine": "Russian"}]})
    for document in cursor:
        print(document)

query_irish_russian_cuisines()

def find_restaurants_by_addr(addr, building, zipcode):
    cursor = db.restaurants.find({"address.street": addr, "address.building": building, "address.zipcode": zipcode})
    for document in cursor:
        print(document)
        
find_restaurants_by_addr("Prospect Park West", "284", "11215")

