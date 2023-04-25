-- -----------------------------------------------------
-- Functions
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Airlines table
-- -----------------------------------------------------
DROP FUNCTION IF EXISTS get_large_airlines_name;

CREATE FUNCTION get_large_airlines_name(min_employees INT)
RETURNS TABLE (large_airline_name VARCHAR(100))
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
SELECT * FROM get_large_airlines_name(400)


DROP FUNCTION IF EXISTS get_larger_airlines_data;

CREATE FUNCTION get_larger_airlines_data(min_employees INT)
RETURNS TABLE (larger_airline VARCHAR(100), total_employees INT)
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
