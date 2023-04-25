-- Inserting values for airlines table 
INSERT INTO airlines VALUES
(1, 'Vueling', 400),
(2, 'Iberia', 160),
(3, 'Iberojet', 400),
(4, 'World2Flye', 400),
(5, 'Wamos Air', 300),
(6, 'Swiftair', 600),
(7, 'Volotea', 100),
(8, 'AirEuropa', 600);

-- Inserting values for planes table
INSERT INTO planes VALUES
(1, 'Boeing 747', 416, 1),
(2, 'Airbus A380', 853, 2),
(3, 'Embraer E190', 114, 3),
(4, 'Cessna Citation X', 12, 4);

-- Inserting values for occupations table
INSERT INTO occupations VALUES
('SH_EMP', 'Shop Employee'),
('SH_MAN', 'Shop Manager'),
('PT', 'Pilot'),
('ST','Stewardess'),
('GR','Ground Team');

-- Inserting values for suppliers table
INSERT INTO suppliers VALUES
(1, 'John Smith', 'ABC Company'),
(2, 'Jane Doe', 'XYZ Corporation'),
(3, 'David Lee', '123 Inc.');

-- Inserting values for flights table
INSERT INTO flights VALUES
('FL001', 1, 1, '2023-04-01 10:00:00', 'New York', 'Los Angeles'),
('FL002', 2, 2, '2023-04-02 12:00:00', 'Los Angeles', 'Chicago'),
('FL003', 3, 3, '2023-04-03 14:00:00', 'Chicago', 'San Francisco'),
('FL004', 1, 4, '2023-04-04 16:00:00', 'San Francisco', 'New York');

-- Inserting values for shops table
INSERT INTO shops VALUES
(1, 'ABC Store', 10, 1),
(2, 'XYZ Mart', 20, 2),
(3, '123 Shop', 5, 3),
(4, 'SuperMart', 15, 1);

-- Inserting values for staff table
INSERT INTO staff VALUES
(1, 'John', 'Smith', 'PT', 50000, NULL, 1),
(2, 'Jane', 'Doe', 'ST', 30000, NULL, 2),
(3, 'David', 'Lee', 'SH_EMP', 40000, 1, NULL),
(4, 'Sarah', 'Johnson', 'SH_MAN', 60000, 2, NULL);
