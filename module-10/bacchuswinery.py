# Alisa Steensen
# Carmen Mendoza
# Jose Franco
# Usiel Figueroa

# Module 10.1

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



try:
    # Connect to the database
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    print("\n Database user {} connected to MySQL on host {} with database {}".format(config["user"], config["host"], config["database"]))
    input("\n\n Press any key to continue...")

    # Query 1 display Employee records
    print("\n-- DISPLAYING Employee RECORDS --")
    query1 = "SELECT employee_id, name, role, department_id FROM Employee"
    cursor.execute(query1)
    for employee_id, name, role, department_id in cursor.fetchall():
        print(f"Employee ID: {employee_id}\nName: {name}\nRole: {role}\nDepartment ID: {department_id}\n")

    # Query 2 display Department records
    print("\n-- DISPLAYING Department RECORDS --")
    query2 = "SELECT * FROM Department"
    cursor.execute(query2)
    for department_id, name, head in cursor.fetchall():
        print(f"Department ID: {department_id}\nName: {name}\nHead: {head}\n")

    # Query 3 display Wine records
    print("\n-- DISPLAYING Wine RECORDS --")
    query3 = "SELECT * FROM Wine"
    cursor.execute(query3)
    for wine_id, name, grape_type in cursor.fetchall():
        print(f"Wine ID: {wine_id}\nName: {name}\nGrape Type: {grape_type}\n")

    # Query 4 display Supplier records
    print("\n-- DISPLAYING Supplier RECORDS --")
    query4 = "SELECT * FROM Supplier"
    cursor.execute(query4)
    for supplier_id, name, contact_details, component_type in cursor.fetchall():
        print(f"Supplier ID: {supplier_id}\nName: {name}\nContact Details: {contact_details}\nComponent Type: {component_type}\n")

    # Query 5 display Supply records
    print("\n-- DISPLAYING Supply RECORDS --")
    query5 = "SELECT * FROM Supply"
    cursor.execute(query5)
    for supply_id, component_type, quantity_shipped, reorder_level, supplier_id in cursor.fetchall():
        print(f"Supply ID: {supply_id}\nComponent Type: {component_type}\nQuantity Shipped: {quantity_shipped}\nReorder Level: {reorder_level}\nSupplier ID: {supplier_id}\n")

    # Query 6 display Distributer records
    print("\n-- DISPLAYING Distributor RECORDS --")
    query6 = "SELECT * FROM Distributor"
    cursor.execute(query6)
    for distributor_id, name, contact_details in cursor.fetchall():
        print(f"Distributor ID: {distributor_id}\nName: {name}\nContact Details: {contact_details}\n")

    # Query 7 display WineDistributer
    print("\n-- DISPLAYING WineDistributor RECORDS --")
    query7 = "SELECT * FROM WineDistributor"
    cursor.execute(query7)
    for distributor_id, wine_id, quantity_shipped, shipment_date in cursor.fetchall():
        print(f"Distributor ID: {distributor_id}\nWine ID: {wine_id}\nQuantity Shipped: {quantity_shipped}\nShipment Date: {shipment_date}\n")

   # Query 8: Display Order records
    print("\n-- DISPLAYING Order RECORDS --")
    query8 = "SELECT * FROM `Order`"  
    cursor.execute(query8)
    for order_id, distributor_id, wine_id, quantity_ordered, order_date, shipment_date, status in cursor.fetchall():
        print(f"Order ID: {order_id}\nDistributor ID: {distributor_id}\nWine ID: {wine_id}\nQuantity Ordered: {quantity_ordered}\nOrder Date: {order_date}\nShipment Date: {shipment_date}\nStatus: {status}\n")


    # Query 9 display Sales records
    print("\n-- DISPLAYING Sales RECORDS --")
    query9 = "SELECT * FROM Sales"
    cursor.execute(query9)
    for sales_id, wine_id, month, quantity_sold in cursor.fetchall():
        print(f"Sales ID: {sales_id}\nWine ID: {wine_id}\nMonth: {month}\nQuantity Sold: {quantity_sold}\n")

# Exception error if no connection to database
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("The specified database does not exist")
    else:
        print(err)

finally:
        db.close()

