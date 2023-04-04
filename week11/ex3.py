from pymongo import MongoClient

client = MongoClient("mongodb://localhost")

db = client["test"]

def delete_single_restaurant():
    result = db.restaurants.delete_one({"borough": "Brooklyn"})
    print(result.deleted_count)

def delete_multiple_restaurants():
    result = db.restaurants.delete_many({"cuisine": "Thai"})
    print(result.deleted_count)

delete_single_restaurant()
delete_multiple_restaurants()