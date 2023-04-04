from pymongo import MongoClient
import datetime

client = MongoClient("mongodb://localhost")

db = client["test"]

def insert_restaurant():
    result = db.restaurants.insert_one({
                                        "address" : {
                                            "street": "Sportivnaya",
                                            "building": "126",
                                            "zipcode": "420500",
                                            "coord": [-73.9557413, 40.7720266]
                                        },
                                        "borough": "Innopolis",
                                        "cuisine": "Serbian",
                                        "name": "The Best Restaurant",
                                        "restaurant_id": "41712354",
                                        "grades": [
                                            {
                                                "date": datetime.datetime(2023, 4, 4, 0, 0),
                                                "grade": "A",
                                                "score": 11,
                                            }
                                        ]
                                    })
    print(result.inserted_id)

insert_restaurant()

# cursort = db.restaurants.find({"addr.zipcode": "420500"})
# for document in cursort:
#     print(document)