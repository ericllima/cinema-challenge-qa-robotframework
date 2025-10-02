import bcrypt
from robot.api.deco import keyword
from pymongo import MongoClient
import os

client = MongoClient('mongodb://localhost:27017')

db = client['cinema-app']

@keyword('Clean user from database')
def reset_user(user_email):
    users = db['users']

    u = users.find_one({'email': user_email})

    if (u):
        users.delete_many({'email': user_email})

@keyword('Remove user from database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email': email})
    print('removing user by ' + email)

@keyword('Insert user into database')
def insert_user(user):
    hash_pass = bcrypt.hashpw(user['password'].encode('utf-8'), bcrypt.gensalt(8))

    doc = {
        'name': user['name'],
        'email': user['email'],
        'password': hash_pass,
        'role': user.get('role', 'user')
    }

    users = db['users']
    users.insert_one(doc)
    print(user)