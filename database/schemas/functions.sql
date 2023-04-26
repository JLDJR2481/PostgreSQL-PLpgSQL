-- -----------------------------------------------------
-- Functions
-- -----------------------------------------------------

-- First, connect to database
\c airport

-- -----------------------------------------------------
-- Airlines table
-- -----------------------------------------------------
DROP FUNCTION IF EXISTS get_large_airlines_name;

CREATE OR REPLACE FUNCTION get_large_airlines_name(
    min_employees INT
)
RETURNS TABLE (
    large_airline_name VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT name
    FROM airlines
    WHERE num_emp >= min_employees;
END;
$$;

-- To prove it --
SELECT * FROM get_large_airlines_name(400);


DROP FUNCTION IF EXISTS get_larger_airlines_data;

CREATE OR REPLACE FUNCTION get_larger_airlines_data(
    min_employees INT
)
RETURNS TABLE (
    larger_airline VARCHAR(100),
    total_employees INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    airline_record record;
BEGIN 
    FOR airline_record IN (SELECT * FROM airlines WHERE num_emp >= min_employees)
    LOOP
        RETURN QUERY SELECT airline_record.name, airline_record.num_emp;
        END LOOP;
    RETURN;
END;
$$;

-- To prove it:
SELECT * FROM get_larger_airlines_data(400);


-- -----------------------------------------------------
-- flights table
-- -----------------------------------------------------

DROP FUNCTION IF EXISTS get_flights_by_airline_id;

CREATE OR REPLACE FUNCTION get_flights_by_airline_id(id INT)
RETURNS INT AS $$
DECLARE
    total_flights INT;
BEGIN
    SELECT COUNT(*) INTO total_flights
    FROM flights
    WHERE id = id_airline;
    RETURN total_flights;
END;
$$ LANGUAGE plpgsql;

-- Prove it
SELECT * FROM get_flights_by_airline_id(1);

-- -----------------------------------------------------
-- staff table
-- -----------------------------------------------------

DROP FUNCTION IF EXISTS get_specific_employees;

CREATE OR REPLACE FUNCTION get_specific_employees(work_place VARCHAR(8)) 
RETURNS TABLE(emp_id INTEGER, emp_name VARCHAR(100),emp_salary INTEGER, emp_occu_code VARCHAR(100),work_place_id INTEGER) AS $$
BEGIN
    work_place := LOWER(work_place);

    IF work_place = 'shop' OR work_place = 'shops' THEN
        RETURN QUERY SELECT id_emp, name, salary, id_occu,id_shop
        FROM staff
        WHERE id_shop IS NOT NULL;

    ELSIF work_place = 'airline' OR work_place = 'airlines' THEN
        RETURN QUERY SELECT id_emp, name, salary, id_occu, id_airline
        FROM staff
        WHERE id_airline IS NOT NULL;

    ELSE
        RAISE EXCEPTION 'Inserted work_place invalid: %', work_place;
    END IF;
END;
$$ LANGUAGE plpgsql;


-- To prove it. We also prove the case insensitive
SELECT * FROM get_specific_employees('AIRLINES');

SELECT * FROM get_specific_employees('airLiNe');

SELECT * FROM get_specific_employees('Shops');

SELECT * FROM get_specific_employees('Security');


-- -----------------------------------------------------
-- planes table
-- -----------------------------------------------------

DROP FUNCTION IF EXISTS get_large_planes;

CREATE OR REPLACE FUNCTION get_large_planes(min_capacity INTEGER)
RETURNS TABLE(id INTEGER, plane_model VARCHAR(100), plane_capacity INTEGER) AS $$
DECLARE
    cur_planes CURSOR FOR SELECT id_plane, model, capacity
                          FROM planes
                          WHERE capacity >= min_capacity
                          ORDER BY capacity ASC;
    plane RECORD;
BEGIN
    OPEN cur_planes;
    LOOP
        FETCH NEXT FROM cur_planes INTO plane;
        EXIT WHEN NOT FOUND;
        
        id := plane.id_plane;
        plane_model := plane.model;
        plane_capacity := plane.capacity;
        RETURN NEXT;
    END LOOP;
    
    CLOSE cur_planes;
END;
$$ LANGUAGE plpgsql;



-- Prove it
SELECT * FROM get_large_planes(400);

-- -----------------------------------------------------
-- shops table
-- -----------------------------------------------------

DROP FUNCTION IF EXISTS get_shops_by_range;

CREATE OR REPLACE FUNCTION get_shops_by_range(start_num INTEGER, end_num INTEGER)
RETURNS TABLE(shop_id INT, shop_name VARCHAR(100), shop_empl INT) AS $$
DECLARE
    result RECORD;
BEGIN
    FOR result IN (SELECT id_shop, name, num_emp
    FROM shops
    WHERE num_emp BETWEEN start_num AND end_num)

    LOOP
        shop_id := result.id_shop;
        shop_name := result.name;
        shop_empl := result.num_emp;
        RETURN NEXT;
    END LOOP;
    RETURN;
END;
$$ LANGUAGE plpgsql;

-- Prove it
SELECT get_shops_by_range(10,40);

-- Table form
SELECT * FROM get_shops_by_range(10,40);

-- -----------------------------------------------------
--  suppliers table
-- -----------------------------------------------------


DROP FUNCTION IF EXISTS get_initial_j_name;

CREATE OR REPLACE FUNCTION get_initial_j_name()
RETURNS TABLE(supplier_id INT, supplier_name VARCHAR(100), supplier_company VARCHAR(100)) AS $$
BEGIN
    RETURN QUERY
    SELECT id_supplier, name, company
    FROM suppliers
    WHERE name LIKE 'J%';
END;
$$ LANGUAGE plpgsql;
    

-- To prove it

SELECT * FROM get_initial_j_name();

SELECT supplier_id, supplier_name FROM get_initial_j_name();

SELECT get_initial_j_name();

-- Get data from tables --
-- Dropping all get_data functions
DROP FUNCTION IF EXISTS get_data_airlines;
DROP FUNCTION IF EXISTS get_data_flights;
DROP FUNCTION IF EXISTS get_data_occupations;
DROP FUNCTION IF EXISTS get_data_planes;
DROP FUNCTION IF EXISTS get_data_shops;
DROP FUNCTION IF EXISTS get_data_staff;
DROP FUNCTION IF EXISTS get_data_suppliers;

-- airlines table --
CREATE OR REPLACE FUNCTION get_data_airlines()
RETURNS TABLE (
    id_airline INT, 
    name VARCHAR(45), 
    num_emp INT
) 
AS $$
BEGIN
    RETURN QUERY EXECUTE 'SELECT * FROM airlines;';
END;
$$ 
LANGUAGE plpgsql;

SELECT get_data_airlines();

SELECT * FROM get_data_airlines();


-- flights table --
CREATE OR REPLACE FUNCTION get_data_flights()
RETURNS TABLE (
    id_flight VARCHAR(10), 
    id_airline INT, 
    id_plane INT, 
    date_time TIMESTAMP WITHOUT TIME ZONE, 
    origin VARCHAR(45), 
    destination VARCHAR(45)
) 
AS $$
BEGIN
    RETURN QUERY EXECUTE 'SELECT * FROM flights;';
END;
$$ 
LANGUAGE plpgsql;

SELECT get_data_flights();

SELECT * FROM get_data_flights();

-- occupations table --
CREATE OR REPLACE FUNCTION get_data_occupations()
RETURNS TABLE (
    id_occu VARCHAR(10), 
    name VARCHAR(45)
) 
AS $$
BEGIN
    RETURN QUERY EXECUTE 'SELECT * FROM occupations;';
END;
$$ 
LANGUAGE plpgsql;

SELECT get_data_occupations();

SELECT * FROM get_data_occupations();

-- planes table --
CREATE OR REPLACE FUNCTION get_data_planes()
RETURNS TABLE (
    id_table INT, 
    model VARCHAR(45), 
    capacity INT, 
    id_airline INT
) 
AS $$
BEGIN
    RETURN QUERY EXECUTE 'SELECT * FROM planes;';
END;
$$ 
LANGUAGE plpgsql;

SELECT get_data_planes();

SELECT * FROM get_data_planes();

-- shops table --
CREATE OR REPLACE FUNCTION get_data_shops()
RETURNS TABLE (
    id_shop INT, 
    name VARCHAR(45), 
    num_emp INT, 
    id_supplier INT
) 
AS $$
BEGIN
    RETURN QUERY EXECUTE 'SELECT * FROM shops;';
END;
$$ 
LANGUAGE plpgsql;

SELECT get_data_shops();

SELECT * FROM get_data_shops();

-- staff table --
CREATE OR REPLACE FUNCTION get_data_staff()
RETURNS TABLE (
    id_emp INT, 
    name VARCHAR(45), 
    surname VARCHAR(45), 
    id_occu VARCHAR(10), 
    salary INT, 
    id_shop INT, 
    id_airline INT
) 
AS $$
BEGIN
    RETURN QUERY EXECUTE 'SELECT * FROM staff;';
END;
$$ 
LANGUAGE plpgsql;

SELECT get_data_staff();

SELECT * FROM get_data_staff();

-- suppliers table --
CREATE OR REPLACE FUNCTION get_data_suppliers()
RETURNS TABLE (
    id_supplier INT, 
    name VARCHAR(45), 
    company VARCHAR(45)
) 
AS $$
BEGIN
    RETURN QUERY EXECUTE 'SELECT * FROM suppliers;';
END;
$$ 
LANGUAGE plpgsql;

SELECT get_data_suppliers();

SELECT * FROM get_data_suppliers();
