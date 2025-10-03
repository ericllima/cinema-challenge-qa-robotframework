import bcrypt
from robot.api.deco import  keyword
from pymongo import MongoClient
import os
import json

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

@keyword('Insert movie into database')
def insert_movie(movie):
    movies = db['movies']
    movies.delete_many({'title': movie['title']})
    result = movies.insert_one(movie)
    print(f"Movie inserted: {movie['title']}")
    return str(result.inserted_id)

@keyword('Remove movie from database')
def remove_movie(movie_title):
    movies = db['movies']
    result = movies.delete_many({'title': movie_title})
    print(f"Deleted {result.deleted_count} movie(s): {movie_title}")

@keyword('Reset movie from database')
def reset_movie(movie):
    remove_movie(movie['title'])
    return insert_movie(movie)

@keyword('Setup test movies')
def setup_test_movies():
    movies = db['movies']
    movies.delete_many({})
    
    fixture_path = os.path.join(os.getcwd(), 'resources', 'fixtures', 'movies.json')
    with open(fixture_path, 'r', encoding='utf-8') as f:
        movies_data = json.load(f)

    for movie_key, movie_data in movies_data.items():
        movies.insert_one(movie_data)
    
    print(f"Setup {len(movies_data)} test movies")