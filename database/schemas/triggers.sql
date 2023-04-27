-- -----------------------------------------------------
-- Triggers
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Connection to database
-- -----------------------------------------------------

\c airport;

-- -----------------------------------------------------
-- airlines table
-- -----------------------------------------------------
DROP FUNCTION IF EXISTS airlines_audit CASCADE;

CREATE OR REPLACE FUNCTION airlines_audit()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS airlines_audit_temp (
        id_audit SERIAL PRIMARY KEY,
        id_airline INTEGER,
        old_name VARCHAR(45),
        new_name VARCHAR(45),
        old_num_emp INTEGER,
        new_num_emp INTEGER,
        num_emp_diff VARCHAR(45)
    );

    INSERT INTO airlines_audit_temp (id_airline, old_name, new_name, old_num_emp, new_num_emp, num_emp_diff)
    VALUES (NEW.id_airline, OLD.name, NEW.name, OLD.num_emp, NEW.num_emp, (NEW.num_emp - OLD.num_emp)::VARCHAR);

    RETURN NEW;
END;
$$;

CREATE TRIGGER audit_airlines_trigger
AFTER UPDATE ON airlines
FOR EACH ROW
EXECUTE FUNCTION airlines_audit();

-- To test it

-- CALL update_airline(1, 'Vuela alto', 777);

-- SELECT * FROM airlines_audit_temp;

