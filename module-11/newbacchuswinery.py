import mysql.connector
from mysql.connector import errorcode

# Database connection configuration
config = {
    "user": 'wineuser',
    "password": 'winelover',
    "host": '127.0.0.1',
    "database": 'bacchuswinery',
    "raise_on_warnings": True
}

try:
    # Connect to the database
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    print("\n Database user {} connected to MySQL on host {} with database {}".format(config["user"], config["host"], config["database"]))
    input("\n\n Press any key to continue...")

    # Query to fetch last 4 quarters of data
    query = """
    SELECT 
        employee_id,
        SUM(HoursWorked) AS TotalHoursWorked,
        GROUP_CONCAT(CONCAT('Q', Quarter, ' ', Year)) AS Last4Quarters
    FROM 
        QuarterlyHours
    WHERE 
        (Year = 2023 AND Quarter IN (4)) OR
        (Year = 2024 AND Quarter IN (1, 2, 3))
    GROUP BY 
        employee_id
    ORDER BY 
        employee_id;

    """

    cursor.execute(query)

    
    results = cursor.fetchall()

    # Iterate through and print results
    for row in results:
        print(f"Employee ID: {row[0]}")
        print(f"Total Hours Worked: {row[1]}")
        print(f"Last 4 Quarters: {row[2]}")
        print("-" * 20)

# Error handling
except mysql.connector.Error as err:
    
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("The specified database does not exist")
    else:
        print(err)

finally:
        db.close()
