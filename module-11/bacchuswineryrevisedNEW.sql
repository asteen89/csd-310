-- Create the Department table
CREATE TABLE Department (
    department_id INT AUTO_INCREMENT PRIMARY KEY
);

-- Create the Employee table
CREATE TABLE Employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    role_id INT NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Create the Role Table
CREATE TABLE Role (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL
);

-- Create the Grape Table
CREATE TABLE GRAPE (
    grape_id INT AUTO_INCREMENT PRIMARY KEY,
    grape_type VARCHAR(100) NOT NULL
);

-- Create the Wine table
CREATE TABLE Wine (
    wine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    grape_id INT NOT NULL
);

-- Create the Distributor table
CREATE TABLE Distributor (
    distributer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_details VARCHAR(255) NOT NULL
);

-- Create the Sales table
CREATE TABLE Sales (
    sales_id INT AUTO_INCREMENT PRIMARY KEY,
    wine_id INT NOT NULL,
    month VARCHAR(20) NOT NULL,
    quantity_sold INT NOT NULL,
    FOREIGN KEY (wine_id) REFERENCES Wine(wine_id)
);

-- Create the WineDistributor table
CREATE TABLE WineDistributor (
    distributer_id INT NOT NULL,
    wine_id INT NOT NULL,
    quantity_shipped INT NOT NULL,
    shipment_date DATE NOT NULL,
    PRIMARY KEY (distributer_id, wine_id),
    FOREIGN KEY (distributer_id) REFERENCES Distributor(distributer_id),
    FOREIGN KEY (wine_id) REFERENCES Wine(wine_id)
);

-- Create the Supplier table
CREATE TABLE Supplier (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_details VARCHAR(255) NOT NULL,
    component_type VARCHAR(100) NOT NULL
);

-- Create the Supply table
CREATE TABLE Supply (
    supply_id INT AUTO_INCREMENT PRIMARY KEY,
    component_type VARCHAR(100) NOT NULL,
    quantity_shipped INT NOT NULL,
    reorder_level INT NOT NULL,
    supplier_id INT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

-- Create the Order table
CREATE TABLE `Order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    distributer_id INT NOT NULL,
    wine_id INT NOT NULL,
    quantity_ordered INT NOT NULL,
    order_date DATE NOT NULL,
    shipment_date DATE,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (distributer_id) REFERENCES Distributor(distributer_id),
    FOREIGN KEY (wine_id) REFERENCES Wine(wine_id)
);

-- Quarterly Hours Table
CREATE TABLE QuarterlyHours (
    quarterlyhoursid INT AUTO_INCREMENT,
    employee_id INT,
    quarter INT,
    hoursworked DECIMAL(5, 2),
    year INT,
    PRIMARY KEY (quarterlyhoursid)
);

-- Populate the Department table
INSERT INTO Department () VALUES
(), (), (), (), (), (), (), (), (), (), (), (), (), (), (), (), (), (), (), (), (), (), (), (), (), (), ();


-- Populate the Employee table
INSERT INTO Employee (first_name, last_name, role_id, department_id) VALUES
('Janet', 'Collins', 1, 1),
('Roz', 'Murphy', 2, 2),
('Bob', 'Urlich', 3, 3),
('Harry', 'Doyle', 4, 4),
('Joe', 'Smith', 4, 5),
('Sally', 'Johnson', 4, 6),
('Spencer', 'Christian', 4, 7),
('Sarah', 'Rhodes', 4, 8),
('Ben', 'Burden', 4, 9),
('Jeffery', 'James', 4, 10),
('Yolanda', 'Perez', 4, 11),
('Kiki', 'Williams', 4, 12),
('Melissa', 'Brown', 4, 13),
('Amanda', 'Dole', 4, 14),
('Jasmine', 'Fitzgerald', 4, 15),
('Jose', 'Dominguez', 4, 16),
('Maria', 'Costanza', 4, 17),
('Isaac', 'Mayes', 4, 18),
('Kyle', 'Bernard', 4, 19),
('Sienna', 'Rios', 4, 20),
('Mary', 'Hendersen', 4, 21),
('Alyssa', 'Mayo', 4, 22),
('Ryker', 'Cantu', 4, 23),
('Owen', 'Espinoza', 4, 24),
('Maria', 'Costanza', 5, 25),
('Stan', 'Bacchus', 6, 26),
('Davis', 'Bacchus', 6, 27);


INSERT INTO Role (role_id, role_name) VALUES
(1, 'Finances'),
(2, 'Marketing'),
(3, 'Assistant'),
(4, 'Production'),
(5, 'Distribution'),
(6, 'Owner');

-- Populate into the grape table
INSERT INTO Grape (grape_type) VALUES
('Bordeaux'), 
('Cabernet Franc'), 
('Gouais Blanc'), 
('Vitis Vinifera'), 
('Primitivo'), 
('Sauvignon Blanc');

-- Populate the Wine table
INSERT INTO Wine (name, grape_id) VALUES
('Merlot', 1),
('Cabernet', 2),
('Chardonnay', 3),
('Pinot Noir', 4),
('Zinfandel', 5),
('Chabalis', 6);

-- Populate the Supplier table
INSERT INTO Supplier (name, contact_details, component_type) VALUES
('Bottle and Cork Supplier', 'bottles_corks@email1.com', 'Bottles and Corks'),
('Label and Box Supplier', 'labels_boxes@email2.com', 'Labels and Boxes'),
('Vat and Tubing Supplier', 'vats_tubing@email3.com', 'Vats and Tubing');

-- Populate the Supply table
INSERT INTO Supply (component_type, quantity_shipped, reorder_level, supplier_id) VALUES
('Bottles and Corks', 2000, 400, 1),
('Labels and Boxes', 1000, 200, 2),
('Vats and Tubing', 50, 10, 3),
('Caps', 3000, 500, 1),
('Packaging Materials', 700, 100, 2),
('Cleaning Supplies', 100, 50, 3);

-- Populate the Distributor table
INSERT INTO Distributor (name, contact_details) VALUES
('North Valley Distributors', 'contact@northvalley.com'),
('South Ridge Distributors', 'contact@southridge.com'),
('East Coast Distributors', 'contact@eastcoast.com'),
('West Side Distributors', 'contact@westside.com'),
('Central Plains Distributors', 'contact@centralplains.com'),
('Mountain Region Distributors', 'contact@mountainregion.com');

-- Populate the WineDistributor table
INSERT INTO WineDistributor (distributer_id, wine_id, quantity_shipped, shipment_date) VALUES
(1, 1, 300, '2024-11-01'),
(1, 2, 250, '2024-11-15'),
(2, 3, 200, '2024-11-10'),
(3, 4, 150, '2024-11-20'),
(4, 5, 180, '2024-11-25'),
(5, 6, 210, '2024-11-30');

-- Populate the Order table
INSERT INTO `Order` (distributer_id, wine_id, quantity_ordered, order_date, shipment_date, status) VALUES
(1, 1, 300, '2024-11-01', '2024-11-05', 'Shipped'),
(2, 2, 200, '2024-11-02', '2024-11-07', 'Shipped'),
(3, 3, 150, '2024-11-03', '2024-11-08', 'Delivered'),
(4, 4, 180, '2024-11-04', '2024-11-09', 'Pending'),
(5, 5, 210, '2024-11-05', '2024-11-10', 'Shipped'),
(6, 6, 190, '2024-11-06', '2024-11-11', 'Delivered');

-- Populate the Sales table
INSERT INTO Sales (wine_id, month, quantity_sold) VALUES
(1, 'January', 100),
(2, 'January', 150),
(3, 'February', 200),
(4, 'February', 120),
(5, 'March', 180),
(6, 'March', 170);

-- Insert data into QuarterlyHours table
INSERT INTO QuarterlyHours (Employee_ID, year, quarter, hoursworked) VALUES
-- Data for 2023
(1, 2023, 1, 150.0), (1, 2023, 2, 160.0), (1, 2023, 3, 145.0), (1, 2023, 4, 155.0),
(2, 2023, 1, 140.0), (2, 2023, 2, 150.0), (2, 2023, 3, 140.0), (2, 2023, 4, 160.0),
(3, 2023, 1, 130.0), (3, 2023, 2, 140.0), (3, 2023, 3, 135.0), (3, 2023, 4, 145.0),
(4, 2023, 1, 155.0), (4, 2023, 2, 165.0), (4, 2023, 3, 160.0), (4, 2023, 4, 170.0),
(5, 2023, 1, 120.0), (5, 2023, 2, 130.0), (5, 2023, 3, 125.0), (5, 2023, 4, 135.0),
(6, 2023, 1, 100.0), (6, 2023, 2, 110.0), (6, 2023, 3, 120.0), (6, 2023, 4, 115.0),
(7, 2023, 1, 155.0), (7, 2023, 2, 165.0), (7, 2023, 3, 150.0), (7, 2023, 4, 160.0),
(8, 2023, 1, 145.0), (8, 2023, 2, 155.0), (8, 2023, 3, 140.0), (8, 2023, 4, 150.0),
(9, 2023, 1, 135.0), (9, 2023, 2, 145.0), (9, 2023, 3, 130.0), (9, 2023, 4, 140.0),
(10, 2023, 1, 125.0), (10, 2023, 2, 135.0), (10, 2023, 3, 120.0), (10, 2023, 4, 130.0),
(11, 2023, 1, 130.0), (11, 2023, 2, 140.0), (11, 2023, 3, 125.0), (11, 2023, 4, 135.0),
(12, 2023, 1, 140.0), (12, 2023, 2, 150.0), (12, 2023, 3, 135.0), (12, 2023, 4, 145.0),
(13, 2023, 1, 150.0), (13, 2023, 2, 160.0), (13, 2023, 3, 145.0), (13, 2023, 4, 155.0),
(14, 2023, 1, 160.0), (14, 2023, 2, 170.0), (14, 2023, 3, 155.0), (14, 2023, 4, 165.0),
(15, 2023, 1, 120.0), (15, 2023, 2, 130.0), (15, 2023, 3, 125.0), (15, 2023, 4, 135.0),
(16, 2023, 1, 110.0), (16, 2023, 2, 120.0), (16, 2023, 3, 115.0), (16, 2023, 4, 125.0),
(17, 2023, 1, 140.0), (17, 2023, 2, 150.0), (17, 2023, 3, 135.0), (17, 2023, 4, 145.0),
(18, 2023, 1, 125.0), (18, 2023, 2, 135.0), (18, 2023, 3, 120.0), (18, 2023, 4, 130.0),
(19, 2023, 1, 115.0), (19, 2023, 2, 125.0), (19, 2023, 3, 110.0), (19, 2023, 4, 120.0),
(20, 2023, 1, 105.0), (20, 2023, 2, 115.0), (20, 2023, 3, 100.0), (20, 2023, 4, 110.0),
(21, 2023, 1, 95.0), (21, 2023, 2, 105.0), (21, 2023, 3, 90.0), (21, 2023, 4, 100.0),
(22, 2023, 1, 85.0), (22, 2023, 2, 95.0), (22, 2023, 3, 80.0), (22, 2023, 4, 90.0),
(23, 2023, 1, 75.0), (23, 2023, 2, 85.0), (23, 2023, 3, 70.0), (23, 2023, 4, 80.0),
(24, 2023, 1, 65.0), (24, 2023, 2, 75.0), (24, 2023, 3, 60.0), (24, 2023, 4, 70.0),
(25, 2023, 1, 55.0), (25, 2023, 2, 65.0), (25, 2023, 3, 50.0), (25, 2023, 4, 60.0),
(26, 2023, 1, 45.0), (26, 2023, 2, 55.0), (26, 2023, 3, 40.0), (26, 2023, 4, 50.0),
(27, 2023, 1, 35.0), (27, 2023, 2, 45.0), (27, 2023, 3, 30.0), (27, 2023, 4, 40.0),

-- Data for 2024
(1, 2024, 1, 120.5), (1, 2024, 2, 130.0), (1, 2024, 3, 140.2), (1, 2024, 4, 150.3),
(2, 2024, 1, 110.5), (2, 2024, 2, 120.0), (2, 2024, 3, 135.4), (2, 2024, 4, 145.6),
(3, 2024, 1, 100.0), (3, 2024, 2, 115.0), (3, 2024, 3, 125.3), (3, 2024, 4, 130.0),
(4, 2024, 1, 95.0), (4, 2024, 2, 110.0), (4, 2024, 3, 120.2), (4, 2024, 4, 125.4),
(5, 2024, 1, 105.0), (5, 2024, 2, 115.5), (5, 2024, 3, 125.0), (5, 2024, 4, 135.0),
(6, 2024, 1, 98.5), (6, 2024, 2, 108.5), (6, 2024, 3, 118.5), (6, 2024, 4, 128.5),
(7, 2024, 1, 125.0), (7, 2024, 2, 135.0), (7, 2024, 3, 145.0), (7, 2024, 4, 155.0),
(8, 2024, 1, 115.0), (8, 2024, 2, 125.0), (8, 2024, 3, 135.0), (8, 2024, 4, 145.0),
(9, 2024, 1, 105.0), (9, 2024, 2, 115.0), (9, 2024, 3, 125.0), (9, 2024, 4, 135.0),
(10, 2024, 1, 135.5), (10, 2024, 2, 145.0), (10, 2024, 3, 155.0), (10, 2024, 4, 165.0),
(11, 2024, 1, 130.0), (11, 2024, 2, 140.0), (11, 2024, 3, 150.0), (11, 2024, 4, 160.0),
(12, 2024, 1, 140.0), (12, 2024, 2, 150.0), (12, 2024, 3, 160.0), (12, 2024, 4, 170.0),
(13, 2024, 1, 150.0), (13, 2024, 2, 160.0), (13, 2024, 3, 170.0), (13, 2024, 4, 180.0),
(14, 2024, 1, 160.0), (14, 2024, 2, 170.0), (14, 2024, 3, 180.0), (14, 2024, 4, 190.0),
(15, 2024, 1, 120.0), (15, 2024, 2, 130.0), (15, 2024, 3, 140.0), (15, 2024, 4, 150.0),
(16, 2024, 1, 110.0), (16, 2024, 2, 120.0), (16, 2024, 3, 130.0), (16, 2024, 4, 140.0),
(17, 2024, 1, 140.0), (17, 2024, 2, 150.0), (17, 2024, 3, 160.0), (17, 2024, 4, 170.0),
(18, 2024, 1, 125.0), (18, 2024, 2, 135.0), (18, 2024, 3, 145.0), (18, 2024, 4, 155.0),
(19, 2024, 1, 115.0), (19, 2024, 2, 125.0), (19, 2024, 3, 135.0), (19, 2024, 4, 145.0),
(20, 2024, 1, 105.0), (20, 2024, 2, 115.0), (20, 2024, 3, 125.0), (20, 2024, 4, 135.0),
(21, 2024, 1, 95.0), (21, 2024, 2, 105.0), (21, 2024, 3, 115.0), (21, 2024, 4, 125.0),
(22, 2024, 1, 85.0), (22, 2024, 2, 95.0), (22, 2024, 3, 105.0), (22, 2024, 4, 115.0),
(23, 2024, 1, 75.0), (23, 2024, 2, 85.0), (23, 2024, 3, 95.0), (23, 2024, 4, 105.0),
(24, 2024, 1, 65.0), (24, 2024, 2, 75.0), (24, 2024, 3, 85.0), (24, 2024, 4, 95.0),
(25, 2024, 1, 55.0), (25, 2024, 2, 65.0), (25, 2024, 3, 75.0), (25, 2024, 4, 85.0),
(26, 2024, 1, 45.0), (26, 2024, 2, 55.0), (26, 2024, 3, 65.0), (26, 2024, 4, 75.0),
(27, 2024, 1, 35.0), (27, 2024, 2, 45.0), (27, 2024, 3, 55.0), (27, 2024, 4, 65.0);

ALTER TABLE Department
ADD COLUMN employee_id INT,
ADD FOREIGN KEY (employee_id) REFERENCES Employee(employee_id);

INSERT INTO Department (employee_id) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15), (16), (17), (18), (19), (20), (21), (22), (23), (24), (25), (26), (27); 