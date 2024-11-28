# Alisa Steensen
# Module 8.2

# Create a python file containing all the queries under the module-8 directory
# Connect to movies database, add record to film table of my choice (I chose Ice Age)
# Display Movies after adding new record
# Change Alien to Horror Film
# Display Movies after updating
# Delete the movie Gladiator
# Display Movies after removing

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

def show_films(cursor, title):
    # method to execute an inner join on all tables,
    # iterate over the dataset and output the results to the terminal window

    # inner join query
        cursor.execute("SELECT film_name AS Name, film_director AS Director, genre_name AS Genre, studio_name AS 'Studio Name' FROM film INNER JOIN genre ON film.genre_id=genre.genre_id INNER JOIN studio ON film.studio_id=studio.studio_id")
                   
    
    # get the results from the cursor object
        films = cursor.fetchall()

        print("\n -- {} --".format(title))

    # iterate over the film data set and display the results
        for film in films:
            print("Film Name: {}\nDirector: {}\nGenre Name: {}\nStudio Name: {}\n".format(film[0], film[1], film[2], film[3]))


try:
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    print("\n Database user {} connected to MYSQL on host {} with database {}".format(config["user"], config["host"], config["database"]))
          
    input("\n\n Press any key to continue...")
    
    # Task 5 Calling show_films function to display selected fields
    show_films(cursor, "-- DISPLAYING FILMS --")

    # Task 6 Insert a new record into the film table (already updated the query for genre 4 animation prior to this so that it don't give an error)
    film_name = 'Ice Age'
    film_releaseDate = '2002'
    film_director = 'Chris Wedge'
    film_runtime = 81
    genre_id = 4
    studio_id = 1

    insert_query = "INSERT INTO film (film_name, film_releaseDate, film_director, film_runtime, genre_id, studio_id) VALUES (%s, %s, %s, %s, %s, %s) "
    
    cursor.execute(insert_query, (film_name, film_releaseDate, film_director, film_runtime, genre_id, studio_id))
    db.commit() 

    show_films(cursor, "-- DISPLAYING FILMS AFTER INSERT --")

    # Task 8 Update the film Alien to be a Horror film
    update_query = " UPDATE film INNER JOIN genre ON film.genre_id = genre.genre_id SET genre.genre_name = 'Horror' WHERE film.film_name = 'Alien'"

    cursor.execute(update_query)
    db.commit()

    # Task 9 The films after updating Alien
    show_films(cursor, "-- DISPLAYING FILMS AFTER UPDATE- Changed Alien to Horror --")

    # Task 10 Delete the movie Gladiator
    delete_query = "DELETE FROM film WHERE film_name = 'Gladiator'"
    cursor.execute(delete_query)
    db.commit()

    # Task 11 The films after deleting Gladiator
    show_films(cursor, "-- DISPLAYING FILMS AFTER DELETE --")



except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")
    
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(" The specified database does not exist")

    else:
        print(err)

finally:
    db.close()