/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
	id INT PRIMARY KEY,
	name VARCHAR(240) NOT NULL,
	date_of_birth DATE,
	escape_attempts INT,
	neutered BOOLEAN,
	weight_kg decimal
	);
