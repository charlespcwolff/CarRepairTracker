-- Check for existing copy of database and junk/rebuild if so
USE master;
GO
DROP DATABASE IF EXISTS CarRepairTracker;
GO
CREATE DATABASE CarRepairTracker;
GO
USE CarRepairTracker
GO

-- Set structure/default data for database
BEGIN TRANSACTION;

CREATE TABLE [role] (
	id integer identity,
	name varchar(32) NOT NULL,

	CONSTRAINT pk_role PRIMARY KEY (id)
);

CREATE TABLE [user] (
	id integer identity,
	role_id integer NOT NULL,
	username varchar(32) NOT NULL UNIQUE,
	first_name varchar(64) NOT NULL,
	last_name varchar(64) NOT NULL,
	email varchar(64) NOT NULL UNIQUE,
	phone_number varchar(14) NOT NULL,
	hash varchar(64) NOT NULL,
	salt varchar(64) NOT NULL,

	CONSTRAINT pk_user PRIMARY KEY (id),
	CONSTRAINT fk_user_role FOREIGN KEY (role_id) REFERENCES [role] (id)
);

CREATE TABLE [vehicle] (
	id integer identity,
	vin varchar(17) NOT NULL,
	user_id integer NOT NULL,
	make varchar(32) NOT NULL,
	model varchar(32) NOT NULL,
	year integer NOT NULL,
	color varchar(32) NOT NULL,

	CONSTRAINT pk_vehicle PRIMARY KEY (id),
	CONSTRAINT fk_vehicle_user FOREIGN KEY (user_id) REFERENCES [user] (id),
	CONSTRAINT chk_year CHECK (year >= 1885)
);

CREATE TABLE [incident] (
	id integer identity,
	vehicle_id integer NOT NULL,
	description varchar(1000) NOT NULL,
	submitted_date Date NOT NULL,
	pickup_date Date,
	paid bit NOT NULL,
	completed bit NOT NULL,

	CONSTRAINT pk_incident PRIMARY KEY (id),
	CONSTRAINT fk_incident_vehicle FOREIGN KEY (vehicle_id) REFERENCES [vehicle] (id)
);

CREATE TABLE [incident_itemizated] (
	id integer identity,
	incident_id integer NOT NULL,
	description varchar(200) NOT NULL,
	cost decimal NOT NULL,
	time_hours integer NOT NULL,
	approved bit NOT NULL,
	declined bit NOT NULL,

	CONSTRAINT pk_incident_itemizated PRIMARY KEY (id),
	CONSTRAINT fk_incident_itemizated_incident FOREIGN KEY (incident_id) REFERENCES [incident] (id)
);

-- Default roles for the database
INSERT INTO [role] (name) VALUES ('Administrator');
INSERT INTO [role] (name) VALUES ('Employee');
INSERT INTO [role] (name) VALUES ('Customer');

-- Default admin for the system
INSERT INTO [user] (username, role_id, first_name, last_name, email, phone_number, hash, salt)
VALUES ('Admin', 1, 'White Hats', 'Only Please', 'admin@techelevator.com', '999-999-9999', 'Rv1z7cWmGETlcSU1eG58NrR9f9Q=', 'a+g3+0EAjHCXpcdSgC6vaw==');
COMMIT TRANSACTION;