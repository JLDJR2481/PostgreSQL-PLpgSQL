-- Connecting to database
\c airport

-- -----------------------------------------------------
-- Table "airlines"
-- -----------------------------------------------------

-- Insert
CREATE OR REPLACE PROCEDURE insert_airline (
    p_id_airline INTEGER,
    p_name VARCHAR(45),
    p_num_emp INTEGER
)
LANGUAGE plpgsql    
AS $$
BEGIN
    INSERT INTO airlines (id_airline, name, num_emp)
    VALUES (p_id_airline, p_name, p_num_emp);
    COMMIT;
END;$$;

-- Update
CREATE OR REPLACE PROCEDURE update_airline (
    p_id_airline INTEGER,
    p_name VARCHAR(45),
    p_num_emp INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE airlines SET
        name = p_name,
        num_emp = p_num_emp
    WHERE id_airline = p_id_airline;
END;$$;

-- Delete
CREATE OR REPLACE PROCEDURE delete_airline(
    p_id_airline INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM airlines
  WHERE id_airline = p_id_airline;
END;$$;

-- -----------------------------------------------------
-- Table "planes"
-- -----------------------------------------------------

-- Insert
CREATE OR REPLACE PROCEDURE insert_plane (
    p_id_plane INTEGER,
    p_model VARCHAR(45),
    p_capacity INTEGER,
    p_id_airline INTEGER
)
LANGUAGE plpgsql    
AS $$
BEGIN
    INSERT INTO planes (id_plane, model, capacity, id_airline)
    VALUES (p_id_plane, p_model, p_capacity, p_id_airline);
    COMMIT;
END;$$;

-- Update
CREATE OR REPLACE PROCEDURE update_plane (
    p_id_plane INTEGER,
    p_model VARCHAR(45),
    p_capacity INTEGER,
    p_id_airline INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE planes SET
        model = p_model,
        capacity = p_capacity,
        id_airline = p_id_airline
    WHERE id_plane = p_id_plane;
END;$$;

-- Delete
CREATE OR REPLACE PROCEDURE delete_plane(
    p_id_plane INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM planes
  WHERE id_plane = p_id_plane;
END;$$;

-- -----------------------------------------------------
-- Table "suppliers"
-- -----------------------------------------------------

-- Insert
CREATE OR REPLACE PROCEDURE insert_supplier (
    p_id_supplier INTEGER,
    p_name VARCHAR(45),
    p_company VARCHAR(45)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO suppliers (id_supplier, name, company)
    VALUES (p_id_supplier, p_name, p_company);
END;$$;

-- Update
CREATE OR REPLACE PROCEDURE update_supplier (
    p_id_supplier INTEGER,
    p_name VARCHAR(45),
    p_company VARCHAR(45)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE suppliers SET
        name = p_name,
        company = p_company
    WHERE id_supplier = p_id_supplier;
END;$$;

-- Delete
CREATE OR REPLACE PROCEDURE delete_supplier(
    p_id_supplier INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM suppliers
  WHERE id_supplier = p_id_supplier;
END;$$;

-- -----------------------------------------------------
-- Table "shops"
-- -----------------------------------------------------

-- Insert
CREATE OR REPLACE PROCEDURE insert_shop (
    p_id_shop INTEGER,
    p_name VARCHAR(45),
    p_num_emp INTEGER,
    p_id_supplier INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO shops (id_shop, name, num_emp, id_supplier)
    VALUES (p_id_shop, p_name, p_num_emp, p_id_supplier);
END;$$;

-- Update
CREATE OR REPLACE PROCEDURE update_shop (
    p_id_shop INTEGER,
    p_name VARCHAR(45),
    p_num_emp INTEGER,
    p_id_supplier INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE shops SET
        name = p_name,
        num_emp = p_num_emp,
        id_supplier = p_id_supplier
    WHERE id_shop = p_id_shop;
END;$$;

-- Delete
CREATE OR REPLACE PROCEDURE delete_shop(
    p_id_shop INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM shops
  WHERE id_shop = p_id_shop;
END;$$;

-- -----------------------------------------------------
-- Table "occupations"
-- -----------------------------------------------------

-- Insert
CREATE OR REPLACE PROCEDURE insert_occupation (
    p_id_occu VARCHAR(10),
    p_name VARCHAR(45)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO occupations (id_occu, name)
    VALUES (p_id_occu, p_name);
END;$$;

-- Update
CREATE OR REPLACE PROCEDURE update_occupation (
    p_id_occu VARCHAR(10),
    p_name VARCHAR(45)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE occupations SET
        name = p_name
    WHERE id_occu = p_id_occu;
END;$$;

-- Delete
CREATE OR REPLACE PROCEDURE delete_occupation(
    p_id_occu VARCHAR(10)
)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM occupations
  WHERE id_occu = p_id_occu;
END;$$;

-- -----------------------------------------------------
-- Table "staff"
-- -----------------------------------------------------

-- Insert
CREATE OR REPLACE PROCEDURE insert_staff (
    p_id_emp INTEGER,
    p_name VARCHAR(45),
    p_surname VARCHAR(45),
    p_id_occu VARCHAR(10),
    p_salary INTEGER,
    p_id_shop INTEGER,
    p_id_airline INTEGER
)
LANGUAGE plpgsql    
AS $$
BEGIN
    INSERT INTO staff (id_emp, name, surname, id_occu, salary, id_shop, id_airline)
    VALUES (p_id_emp, p_name, p_surname, p_id_occu, p_salary, p_id_shop, p_id_airline);
    COMMIT;
END;$$;

-- Update
CREATE OR REPLACE PROCEDURE update_staff (
    p_id_emp INTEGER,
    p_name VARCHAR(45),
    p_surname VARCHAR(45),
    p_id_occu VARCHAR(10),
    p_salary INTEGER,
    p_id_shop INTEGER,
    p_id_airline INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE staff SET 
        name = p_name,
        surname = p_surname,
        id_occu = p_id_occu,
        salary = p_salary,
        id_shop = p_id_shop,
        id_airline = p_id_airline
    WHERE id_emp = p_id_emp;
END;$$;

-- Delete
CREATE OR REPLACE PROCEDURE delete_staff(
    p_id_emp INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM staff
  WHERE id_emp = p_id_emp;
END;$$;

-- -----------------------------------------------------
-- Table "flights"
-- -----------------------------------------------------

-- Insert
CREATE OR REPLACE PROCEDURE insert_flight (
    p_id_flight VARCHAR(10),
    p_id_airline INT,
    p_id_plane INT,
    p_date_time TIMESTAMP,
    p_origin VARCHAR(45),
    p_destination VARCHAR(45)
)
LANGUAGE plpgsql    
AS $$
BEGIN
    INSERT INTO flights (id_flight, id_airline, id_plane, date_time, origin, destination)
    VALUES (p_id_flight, p_id_airline, p_id_plane, p_date_time, p_origin, p_destination);
    COMMIT;
END;$$;

-- Update
CREATE OR REPLACE PROCEDURE update_flight (
    p_id_flight VARCHAR(10),
    p_id_airline INT,
    p_id_plane INT,
    p_date_time TIMESTAMP,
    p_origin VARCHAR(45),
    p_destination VARCHAR(45)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE flights SET
        id_airline = p_id_airline,
        id_plane = p_id_plane,
        date_time = p_date_time,
        origin = p_origin,
        destination = p_destination
    WHERE id_flight = p_id_flight;
END;$$;

-- Delete
CREATE OR REPLACE PROCEDURE delete_flight(
    p_id_flight VARCHAR(10)
)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM flights
  WHERE id_flight = p_id_flight;
END;$$;
