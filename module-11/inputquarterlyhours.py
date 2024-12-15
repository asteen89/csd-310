import mysql.connector
from mysql.connector import errorcode

# Database connection information
config = {
    "user": 'wineuser',
    "password": 'winelover',
    "host": '127.0.0.1',
    "database": 'bacchuswinery',
    "raise_on_warnings": True
}

# Quarterly hours data for 2024 (example data for each employee)
employee_data_2024 = [
    {"EmployeeID": 1, "Year": 2024, "Quarters": [120.5, 130.0, 140.2, 150.3]},
    {"EmployeeID": 2, "Year": 2024, "Quarters": [110.5, 120.0, 135.4, 145.6]},
    {"EmployeeID": 3, "Year": 2024, "Quarters": [100.0, 115.0, 125.3, 130.0]},
    {"EmployeeID": 4, "Year": 2024, "Quarters": [95.0, 110.0, 120.2, 125.4]},
    {"EmployeeID": 5, "Year": 2024, "Quarters": [105.0, 115.5, 125.0, 135.0]},
    {"EmployeeID": 6, "Year": 2024, "Quarters": [98.5, 108.5, 118.5, 128.5]},
]

employee_data_2023 = [
    {"EmployeeID": 1, "Year": 2023, "Quarters": [150.0, 160.0, 145.0, 155.0]},
    {"EmployeeID": 2, "Year": 2023, "Quarters": [140.0, 150.0, 140.0, 160.0]},
    {"EmployeeID": 3, "Year": 2023, "Quarters": [130.0, 140.0, 135.0, 145.0]},
    {"EmployeeID": 4, "Year": 2023, "Quarters": [155.0, 165.0, 160.0, 170.0]},
    {"EmployeeID": 5, "Year": 2023, "Quarters": [120.0, 130.0, 125.0, 135.0]},
    {"EmployeeID": 6, "Year": 2023, "Quarters": [100.0, 110.0, 120.0, 115.0]},
]
try:
    # Connect to the database
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    # Insert quarterly hours for 2024
    for employee in employee_data_2024:
        employee_id = employee["EmployeeID"]
        year = employee["Year"]
        quarters = employee["Quarters"]
        for quarter, hours in enumerate(quarters, start=1):
            query = """
                INSERT INTO QuarterlyHours (EmployeeID, Year, Quarter, HoursWorked)
                VALUES (%s, %s, %s, %s)
            """
            values = (employee_id, year, quarter, hours)
            cursor.execute(query, values)

    # Commit changes
    db.commit()

    print("Quarterly hours for 2024 inserted successfully!")

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("The specified database does not exist")
    else:
        print(f"Error: {err}")

finally:
    # Close the cursor and database connection
    if db.is_connected():
        cursor.close()
        db.close()
