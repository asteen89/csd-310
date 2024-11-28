# Alisa Steensen
# Module 7.2

# Make 4 queries, first and second query to select all the fields for the studio and genre tables
# Third query to select the movie names for those movies that have a run time of less than two hours
# Fourth query to get a list of film names, and directors grouped by director

import mysql.connector
from mysql.connector import errorcode

import dotenv
from dotenv import dotenv_values

secrets = dotenv_values(".env")

config = {
    "user": secrets["USER"],
    "password": secrets["PASSWORD"],
    "host": secrets["HOST"],
    "database": secrets["DATABASE"],
    "raise_on_warnings": secrets["RAISE_ON_WARNINGS"] == "True"  # Convert to boolean
}


try:
    db = mysql.connector.connect(**config)
    cursor = db.cursor()
    
    print("\n Database user {} connected to MYSQL on host {} with database {}".format(config["user"], config["host"], config["database"]))
          
    input("\n\n Press any key to continue...")

     # Query 1 studio table
    print("\n-- DISPLAYING Studio RECORDS --")
    query1 = "SELECT * FROM studio"
    cursor.execute(query1)
    for studio_id, studio_name in cursor.fetchall():
        print(f"Studio ID: {studio_id}\nStudio Name: {studio_name}\n")

    # Query 2 genre table
    print("\n-- DISPLAYING Genre RECORDS --")
    query2 = "SELECT * FROM genre"
    cursor.execute(query2)
    for genre_id, genre_name in cursor.fetchall():
        print(f"Genre ID: {genre_id}\nGenre Name: {genre_name}\n")

    # Query 3 movie names with a runtime of less than 2 hours
    print("\n-- DISPLAYING Short Film RECORDS --")
    query3 = "SELECT film_name, film_runtime FROM film WHERE film_runtime < 120"
    cursor.execute(query3)
    for film_name, film_runtime in cursor.fetchall():
        print(f"Film Name: {film_name}\nRuntime: {film_runtime}\n")

    # Query 4 film names and directors group by director
    print("\n-- DISPLAYING Director RECORDS in Order --")
    query4 = """
    SELECT film_name, film_director 
    FROM film
    ORDER BY film_director
    """
    cursor.execute(query4)
    for film_name, director_name in cursor.fetchall():
        print(f"Film Name: {film_name}\nDirector: {director_name}\n")

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")
    
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(" The specified database does not exist")

    else:
        print(err)

finally:
    db.close()
