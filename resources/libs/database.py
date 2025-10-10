import bcrypt
from robot.api.deco import  keyword
from pymongo import MongoClient
import os
import json

client = MongoClient('mongodb://localhost:27017')

db = client['cinema-app']

#===USERS===
@keyword('Clean user from database')
def remove_user(user_email):
    users = db['users']

    u = users.find_one({'email': user_email})

    if (u):
        users.delete_many({'email': user_email})

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

#===MOVIES===
@keyword('Insert movie '
         'abase')
def insert_movie(movie):
    movies = db['movies']
    movies.delete_many({'title': movie['title']})
    result = movies.insert_one(movie)
    print(f"Movie inserted: {movie['title']}")
    return str(result.inserted_id)

@keyword('Clean movie from database')
def remove_movie(movie_title):
    movies = db['movies']
    result = movies.delete_many({'title': movie_title})
    print(f"Deleted {result.deleted_count} movie(s): {movie_title}")

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

@keyword('Insert session into database')
def insert_session(session):
    sessions = db['sessions']
    result = sessions.insert_one(session)
    print(f"Session inserted: {session['movieTitle']} - {session['time']}")
    return str(result.inserted_id)

@keyword('Setup test sessions')
def setup_test_sessions():
    from bson import ObjectId
    from datetime import datetime
    import random
    
    # Setup theaters first and get their IDs
    theater_ids = setup_test_theaters()
    
    # Get all movie IDs from database dynamically
    movies = db['movies']
    movie_lookup = {}
    for movie in movies.find():
        movie_lookup[movie['title']] = movie['_id']
    
    # Get theater data for seat generation
    theaters = db['theaters']
    theater_lookup = {}
    for theater in theaters.find():
        theater_lookup[str(theater['_id'])] = theater
    
    sessions = db['sessions']
    sessions.delete_many({})
    
    fixture_path = os.path.join(os.getcwd(), 'resources', 'fixtures', 'sessions.json')
    with open(fixture_path, 'r', encoding='utf-8') as f:
        sessions_data = json.load(f)
    
    def get_standard_seats():
        """Load seats from seats.json fixture"""
        seats_path = os.path.join(os.getcwd(), 'resources', 'fixtures', 'seats.json')
        with open(seats_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    
    session_count = 0
    for session_key, session_list in sessions_data.items():
        for session_data in session_list:
            # Auto-resolve movie references
            movie_ref = session_data['movie']
            if isinstance(movie_ref, str) and movie_ref.endswith('_movie_id'):
                movie_title = movie_ref.replace('_movie_id', '').replace('_', ' ').title()
                if 'interestelar' in movie_ref.lower():
                    movie_title = 'Interestelar'
                elif 'shrek' in movie_ref.lower():
                    movie_title = 'Shrek'
                
                if movie_title in movie_lookup:
                    session_data['movie'] = movie_lookup[movie_title]
            
            # Auto-resolve theater references and generate seats
            theater_ref = session_data['theater']
            if isinstance(theater_ref, str) and theater_ref.endswith('_id'):
                theater_key = theater_ref.replace('_id', '')
                if theater_key in theater_ids:
                    theater_object_id = ObjectId(theater_ids[theater_key])
                    session_data['theater'] = theater_object_id
                
                # Use seats from fixture or load standard seats
                if 'seats' not in session_data:
                    session_data['seats'] = get_standard_seats()
            
            # Add createdAt field as per API spec
            session_data['createdAt'] = datetime.utcnow()
            
            sessions.insert_one(session_data)
            session_count += 1
    
    print(f"Setup {session_count} test sessions with proper ObjectId references and realistic seats")

@keyword('Insert theater into database')
def insert_theater(theater):
    theaters = db['theaters']
    theaters.delete_many({'name': theater['name']})
    result = theaters.insert_one(theater)
    print(f"Theater inserted: {theater['name']}")
    return str(result.inserted_id)

@keyword('Clean reservations from database')
def clean_reservations():
    reservations = db['reservations']
    result = reservations.delete_many({})
    print(f"Cleaned {result.deleted_count} reservations")

@keyword('Setup test theaters')
def setup_test_theaters():
    from datetime import datetime
    
    theaters = db['theaters']
    theaters.delete_many({})
    
    fixture_path = os.path.join(os.getcwd(), 'resources', 'fixtures', 'theaters.json')
    with open(fixture_path, 'r', encoding='utf-8') as f:
        theaters_data = json.load(f)
    
    theater_ids = {}
    for theater_key, theater_data in theaters_data.items():
        # Add createdAt field as per API spec
        theater_data['createdAt'] = datetime.utcnow()
        result = theaters.insert_one(theater_data)
        theater_ids[theater_key] = str(result.inserted_id)
    
    print(f"Setup {len(theaters_data)} test theaters")
    return theater_ids