/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' and '2019-12-31';
SELECT name from animals WHERE escape_attempts<3 and neutered=true;
SELECT date_of_birth from animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts from animals WHERE weight_kg>10.5;
SELECT * from animals WHERE neutered=true;
SELECT * from animals WHERE name!='Gabumon';
SELECT * from animals WHERE weight_kg BETWEEN 10.4 and 17.3;

BEGIN;
UPDATE animals SET species = 'unidentified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;


BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT check1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT check1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '1999-12-31' GROUP BY species;

SELECT name, full_name 
FROM animals INNER JOIN owners ON owner_id = owners.id WHERE full_name = 'Melody Pond'

SELECT species.name, animals.name
FROM animals 
INNER JOIN species 
ON animals.species_id = species.id 
WHERE species.name= 'Pokemon'

SELECT name, full_name 
FROM animals
RIGHT JOIN owners
ON animals.owner_id= owners.id 

SELECT species.name, COUNT (*)
FROM animals
INNER JOIN species
ON animals.species_id=species.id
GROUP BY species.name

SELECT full_name, animals.name, species.name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id 
INNER JOIN species 
ON species_id= species.id 
WHERE owners.full_name= 'Jennifer Orwell'
and species.name= 'Digimon'

SELECT owners.full_name, animals.name 
FROM animals 
INNER JOIN owners ON owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' 
and escape_attempts = 0;

SELECT owners.full_name, COUNT (animals.name)
FROM animals 
INNER JOIN owners 
ON animals.owner_id = owners.id 
GROUP BY owners.full_name
ORDER BY COUNT (owners.full_name) DESC

SELECT vets.name, animals.name, date_of_visit
FROM visits 
INNER JOIN animals ON animals.id = animals_id 
JOIN vets ON vets.id = vets_id 
WHERE date_of_visit BETWEEN '2020-04-01' AND '2020-08-30' AND vets.name = 'Stephanie Mendez';

SELECT animals.name, COUNT(date_of_visit)
FROM visits
INNER JOIN animals
ON animals.id=animals_id
GROUP BY animals.name 
ORDER BY COUNT (animals.name) DESC
LIMIT 1

SELECT animals.name, vets.name, date_of_visit 
FROM visits
INNER JOIN animals
ON animals.id=animals_id
JOIN vets
ON vets.id=vets_id
WHERE vets.name= 'Maisy Smith'
ORDER BY date_of_visit ASC
LIMIT 1

SELECT animals.name, vets.name, date_of_visit
FROM visits
INNER JOIN animals
ON animals.id=animals_id
JOIN vets
ON vets.id= vets_id
ORDER by date_of_visit DESC
LIMIT 1

SELECT COUNT(date_of_visit)
FROM visits
JOIN vets 
ON visits.vets_id = vets.id
LEFT JOIN specializations 
ON specializations.vets_id = vets.id
JOIN animals 
ON animals.id = animals_id
WHERE animals.species_id != specializations.species_id OR specializations.species_id IS NULL;

SELECT species.name, COUNT(species.name)
FROM visits
JOIN vets 
ON visits.vets_id = vets.id
JOIN animals
ON animals_id=animals.id
JOIN species
ON species_id=species.id
WHERE vets.name='Maisy Smith'
GROUP by species.name
ORDER BY COUNT (species.name) DESC
LIMIT 1
