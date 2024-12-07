-- Create the Department table
CREATE TABLE Department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    head VARCHAR(100) NOT NULL
);

-- Create the Employee table
CREATE TABLE Employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    quarterly_hours_worked INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Create the Wine table
CREATE TABLE Wine (
    wine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    grape_type VARCHAR(100) NOT NULL
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

-- Populate the Department table
INSERT INTO Department (name, head) VALUES
('Finance', 'Usiel Figueroa'),
('Marketing', 'Jose Franco'),
('Production', 'Carmen Mendoza'),
('Distribution', 'Maria Costanza'),
('Quality Assurance', 'John Smith'),
('Human Resources', 'Alisa Steensen');

-- Populate the Employee table
INSERT INTO Employee (name, role, department_id, quarterly_hours_worked) VALUES
('Usiel Figueroa', 'Finance Manager', 1, 520),
('Jose Franco', 'Marketing Manager', 2, 480),
('Alisa Steensen', 'HR Manager', 2, 450),
('Carmen Mendoza', 'Production Manager', 3, 600),
('Maria Costanza', 'Distribution Manager', 4, 550),
('John Smith', 'QA Specialist', 5, 500);

-- Populate the Wine table
INSERT INTO Wine (name, grape_type) VALUES
('Merlot', 'Red'),
('Cabernet Sauvignon', 'Red'),
('Chardonnay', 'White'),
('Pinot Noir', 'Red'),
('Zinfandel', 'Red'),
('Sauvignon Blanc', 'White');

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
