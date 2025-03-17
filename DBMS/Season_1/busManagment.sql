CREATE DATABASE BusManagment_db;
use BusManagment_db

CREATE TABLE Route (
    route_id INT PRIMARY KEY IDENTITY(1,1),
    route_number VARCHAR(10) UNIQUE NOT NULL,
    avg_passengers_per_day INT
);

CREATE TABLE Town (
    town_id INT PRIMARY KEY IDENTITY(1,1),
    town_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Garage (
    garage_id INT PRIMARY KEY IDENTITY(1,1),
    town_id INT UNIQUE,
    capacity INT,
    location VARCHAR(255),
	-- town id as fk
    FOREIGN KEY (town_id) REFERENCES Town(town_id) ON DELETE CASCADE
);

CREATE TABLE Bus (
    bus_id INT PRIMARY KEY IDENTITY(1,1),
    registration_number VARCHAR(20) UNIQUE NOT NULL,
    capacity INT NOT NULL,
    type VARCHAR(10) CHECK (type IN ('Single', 'Double')),
    route_id INT,
	-- route_id as fk
    FOREIGN KEY (route_id) REFERENCES Route(route_id) ON DELETE SET NULL
);

CREATE TABLE Stage (
    stage_id INT PRIMARY KEY IDENTITY(1,1),
    route_id INT,
    start_town_id INT,
    end_town_id INT,
    FOREIGN KEY (route_id)	 REFERENCES Route(route_id)   ,
    FOREIGN KEY (start_town_id) REFERENCES Town(town_id),
    FOREIGN KEY (end_town_id) REFERENCES Town(town_id)  
);

CREATE TABLE Driver (
    driver_id INT PRIMARY KEY IDENTITY(1,1),
    employee_number VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(15) NULL
);

CREATE TABLE Route_Town (
    route_id INT,
    town_id INT,
    PRIMARY KEY (route_id, town_id),
    FOREIGN KEY (route_id) REFERENCES Route(route_id) ON DELETE CASCADE,
    FOREIGN KEY (town_id) REFERENCES Town(town_id) ON DELETE CASCADE
);

CREATE TABLE Stage_Town (
    stage_id INT,
    town_id INT,
    PRIMARY KEY (stage_id, town_id),
    FOREIGN KEY (stage_id) REFERENCES Stage(stage_id) ON DELETE CASCADE,
    FOREIGN KEY (town_id) REFERENCES Town(town_id) ON DELETE CASCADE
);

CREATE TABLE Stage_Driver (
    stage_id INT,
    driver_id INT,
    assigned_date DATE,
    PRIMARY KEY (stage_id, driver_id),
    FOREIGN KEY (stage_id) REFERENCES Stage(stage_id) ON DELETE CASCADE,
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id) ON DELETE CASCADE
);

select * from Driver