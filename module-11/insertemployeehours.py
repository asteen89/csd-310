import mysql.connector

# Connect to the database
config = {
    "user": 'wineuser',
    "password": 'winelover',
    "host": '127.0.0.1',
    "database": 'bacchuswinery',
    "raise_on_warnings": True
}

# Establish database connection
db = mysql.connector.connect(**config)
cursor = db.cursor()

# Define quarterly hours for 6 employees
employee_data = [
    {"EmployeeID": 1, "Year": 2023, "Quarters": [120.5, 130.0, 140.2, 150.3]},
    {"EmployeeID": 2, "Year": 2023, "Quarters": [110.5, 120.0, 135.4, 145.6]},
    {"EmployeeID": 3, "Year": 2023, "Quarters": [100.0, 115.0, 125.3, 130.0]},
    {"EmployeeID": 4, "Year": 2023, "Quarters": [95.0, 110.0, 120.2, 125.4]},
    {"EmployeeID": 5, "Year": 2023, "Quarters": [105.0, 115.5, 125.0, 135.0]},
    {"EmployeeID": 6, "Year": 2023, "Quarters": [98.5, 108.5, 118.5, 128.5]},
]

# Insert data into QuarterlyHours
try:
    for employee in employee_data:
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
    
    # Commit the changes
    db.commit()
    print("Data inserted successfully!")

except mysql.connector.Error as err:
    print(f"Error: {err}")
    db.rollback()  # Rollback if any error occurs

finally:
    # Close the cursor and database connection
    cursor.close()
    db.close()
