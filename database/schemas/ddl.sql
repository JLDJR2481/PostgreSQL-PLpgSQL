-- -----------------------------------------------------
-- Database "airport"
-- -----------------------------------------------------
DROP DATABASE IF EXISTS "airport";

CREATE DATABASE "airport";

\c "airport";

-- -----------------------------------------------------
-- Table "airlines"
-- -----------------------------------------------------
DROP TABLE IF EXISTS airlines;

CREATE TABLE IF NOT EXISTS airlines (
  id_airline INTEGER NOT NULL,
  name VARCHAR(45) NOT NULL,
  num_emp INTEGER NULL,
  PRIMARY KEY (id_airline)
);

-- -----------------------------------------------------
-- Table "planes"
-- -----------------------------------------------------
DROP TABLE IF EXISTS planes;

CREATE TABLE IF NOT EXISTS planes (
  id_plane INTEGER NOT NULL,
  model VARCHAR(45) NULL,
  capacity INTEGER NULL,
  id_airline INTEGER NULL,
  PRIMARY KEY (id_plane),
  CONSTRAINT planes_id_airline
    FOREIGN KEY (id_airline)
    REFERENCES airlines (id_airline)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE INDEX id_airline_idx_planes ON planes (id_airline ASC);

-- -----------------------------------------------------
-- Table "suppliers"
-- -----------------------------------------------------
DROP TABLE IF EXISTS suppliers;

CREATE TABLE IF NOT EXISTS suppliers (
  id_supplier INTEGER NOT NULL,
  name VARCHAR(45) NOT NULL,
  company VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_supplier)
);

-- -----------------------------------------------------
-- Table "shops"
-- -----------------------------------------------------
DROP TABLE IF EXISTS shops;

CREATE TABLE IF NOT EXISTS shops (
  id_shop INTEGER NOT NULL,
  name VARCHAR(45) NOT NULL,
  num_emp INTEGER NULL,
  id_supplier INTEGER NULL,
  PRIMARY KEY (id_shop),
  CONSTRAINT shops_id_supplier
    FOREIGN KEY (id_supplier)
    REFERENCES suppliers (id_supplier)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE INDEX id_supplier_idx_shops ON shops (id_supplier ASC);

-- -----------------------------------------------------
-- Table "occupations"
-- -----------------------------------------------------
DROP TABLE IF EXISTS occupations;

CREATE TABLE IF NOT EXISTS occupations (
  id_occu VARCHAR(10) NOT NULL,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_occu)
);

CREATE UNIQUE INDEX id_occu_idx_occupations ON occupations (name ASC);

-- -----------------------------------------------------
-- Table "staff"
-- -----------------------------------------------------
DROP TABLE IF EXISTS staff;

CREATE TABLE IF NOT EXISTS staff (
  id_emp INTEGER NOT NULL,
  name VARCHAR(45) NOT NULL,
  surname VARCHAR(45) NOT NULL,
  id_occu VARCHAR(10) NOT NULL,
  salary INTEGER NOT NULL,
  id_shop INTEGER NULL,
  id_airline INTEGER NULL,
  PRIMARY KEY (id_emp),
  CONSTRAINT staff_id_occu
    FOREIGN KEY (id_occu)
    REFERENCES occupations (id_occu)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT staff_id_shop
    FOREIGN KEY (id_shop)
    REFERENCES shops (id_shop)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT staff_id_airline
    FOREIGN KEY (id_airline)
    REFERENCES airlines (id_airline)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

ALTER TABLE staff ADD CONSTRAINT salary_check CHECK (salary >= 12000);

CREATE INDEX id_occu_idx_staff ON staff (id_occu ASC);

CREATE INDEX id_shop_idx_staff ON staff (id_shop ASC);

CREATE INDEX id_airline_idx_staff ON staff (id_airline ASC);

-- -----------------------------------------------------
-- Table "flights"
-- -----------------------------------------------------
DROP TABLE IF EXISTS flights;

CREATE TABLE IF NOT EXISTS flights (
  id_flight VARCHAR(10) NOT NULL,
  id_airline INT NOT NULL,
  id_plane INT NOT NULL,
  date_time TIMESTAMP NOT NULL,
  origin VARCHAR(45) NOT NULL,
  destination VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_flight),
  CONSTRAINT flights_id_airline
    FOREIGN KEY (id_airline)
    REFERENCES airlines (id_airline)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT flights_id_plane
    FOREIGN KEY (id_plane)
    REFERENCES planes (id_plane)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE INDEX id_airline_idx_flights ON flights (id_airline);
CREATE INDEX id_plane_idx_flights ON flights (id_plane);
