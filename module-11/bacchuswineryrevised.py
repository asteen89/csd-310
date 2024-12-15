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

# Queries
query_supplier_performance = """
SELECT 
    Supplier.name AS SupplierName,
    Supply.component_type AS ComponentType,
    Order.order_date AS ExpectedDeliveryDate,
    Order.shipment_date AS ActualDeliveryDate,
    DATEDIFF(Order.shipment_date, Order.order_date) AS DeliveryGap
FROM 
    Supply
JOIN 
    Supplier ON Supply.supplier_id = Supplier.supplier_id
JOIN 
    `Order` ON Supply.supplier_id = `Order`.distributer_id
WHERE 
    DATEDIFF(Order.shipment_date, Order.order_date) > 0
ORDER BY 
    Supplier.name, DeliveryGap DESC;
"""

query_monthly_gaps = """
SELECT 
    MONTHNAME(Order.order_date) AS Month,
    Supplier.name AS SupplierName,
    COUNT(CASE WHEN DATEDIFF(Order.shipment_date, Order.order_date) > 0 THEN 1 ELSE NULL END) AS DelayedOrders,
    COUNT(Order.order_id) AS TotalOrders
FROM 
    `Order`
JOIN 
    Supply ON `Order`.distributer_id = Supply.supplier_id
JOIN 
    Supplier ON Supply.supplier_id = Supplier.supplier_id
GROUP BY 
    Month, Supplier.name
ORDER BY 
    Month, DelayedOrders DESC;
"""

query_wine_performance = """
SELECT 
    Wine.name AS WineName,
    Distributor.name AS DistributorName,
    SUM(WineDistributor.quantity_shipped) AS TotalQuantityShipped,
    COALESCE(SUM(Sales.quantity_sold), 0) AS TotalQuantitySold
FROM 
    Wine
LEFT JOIN 
    WineDistributor ON Wine.wine_id = WineDistributor.wine_id
LEFT JOIN 
    Distributor ON WineDistributor.distributer_id = Distributor.distributer_id
LEFT JOIN 
    Sales ON Wine.wine_id = Sales.wine_id
GROUP BY 
    Wine.name, Distributor.name
ORDER BY 
    TotalQuantitySold ASC;
"""

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

try:
    # Connect to the database
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    print(f"Connected to MySQL on host {config['host']} with database {config['database']}")

    # Supplier Delivery Performance Report
    print("\nSupplier Delivery Performance:")
    print("=" * 30)
    cursor.execute(query_supplier_performance)
    for row in cursor.fetchall():
        print(f"-Supplier: {row[0]}")
        print(f"-Component Type: {row[1]}")
        print(f"-Expected Delivery: {row[2]}")
        print(f"-Actual Delivery: {row[3]}")
        print(f"-Delivery Gap (days): {row[4]}")
        print("-" * 20)

    # Monthly Delivery Gaps Report
    print("\nMonthly Delivery Gaps:")
    print("=" * 22)
    cursor.execute(query_monthly_gaps)
    for row in cursor.fetchall():
        print(f"-Month: {row[0]}")
        print(f"-Supplier: {row[1]}")
        print(f"-Delayed Orders: {row[2]}")
        print(f"-Total Orders: {row[3]}")
        print("-" * 20)

    # Wine Sales Performance Report
    print("\nWine Sales Performance:")
    print("=" * 23)
    cursor.execute(query_wine_performance)
    for row in cursor.fetchall():
        print(f"-Wine: {row[0]}")
        print(f"-Distributor: {row[1]}")
        print(f"-Total Shipped: {row[2]}")
        print(f"-Total Sold: {row[3]}")
        print("-" * 20)

    cursor.execute(query)
    results = cursor.fetchall()
    print("\nEmployee Hours Worked Last 4 Quarters:")
    print("=" * 23)
    # Iterate through and print results
    for row in results:
        print(f"Employee ID: {row[0]}")
        print(f"Total Hours Worked: {row[1]}")
        print(f"Last 4 Quarters: {row[2]}")
        print("-" * 20)

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("Invalid username or password")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("Database does not exist")
    else:
        print(err)

finally:
    if db.is_connected():
        cursor.close()
        db.close()
