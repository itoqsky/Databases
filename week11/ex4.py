# -*- coding: utf-8 -*-
from pymongo import MongoClient
import datetime

client = MongoClient("mongodb://localhost")

db = client["test"]

def query_restaurants_on_prospect_park_west():
    cursor = db.restaurants.find({"address.street": "Prospect Park West"})
    for document in cursor:
        if document["grades"].count({"grade": "A"}) > 1:
            db.restaurants.delete_one(document)
        else:
            # db.restaurants.delete_one(document)
            document["grades"].append({"date" : datetime.datetime(2023, 4, 4, 0, 0), 'grade':'A', 'score': 100})
            db.restaurants.update_one({"_id": document["_id"]}, {"$set": document}, upsert=False)
            # db.restaurants.insert_one(document)
query_restaurants_on_prospect_park_west()

