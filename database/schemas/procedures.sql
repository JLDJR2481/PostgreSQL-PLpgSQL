-- Connecting to database
\c airport

-- -----------------------------------------------------
-- Table "airlines"
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table "planes"
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table "suppliers"
-- -----------------------------------------------------
CREATE OR REPLACE PROCEDURE insert_supplier (
    p_id INTEGER,
    p_name VARCHAR(45),
    p_company VARCHAR(45)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO suppliers (id_supplier, name, company)
    VALUES (p_id, p_name, p_company);
END;$$;

-- -----------------------------------------------------
-- Table "shops"
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table "occupations"
-- -----------------------------------------------------
CREATE OR REPLACE PROCEDURE insert_occupation(
    p_id_occu VARCHAR(10),
    p_name VARCHAR(45)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO occupations (id_occu, name)
    VALUES (p_id_occu, p_name);
END;$$;

-- -----------------------------------------------------
-- Table "staff"
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table "flights"
-- -----------------------------------------------------
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
