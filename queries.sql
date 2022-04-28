/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth >= '20160101' AND date_of_birth < '20200101';

SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = TRUE;

SELECT * FROM animals WHERE name <> 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '20220101';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * (-1);
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * (-1) WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT name FROM animals WHERE escape_attempts = (
  SELECT MAX(escape_attempts) FROM animals
);

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '19900101'
 AND date_of_birth < '20010101' GROUP BY species;

SELECT name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT * FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT full_name, animals.name from owners LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(animals.species_id) FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;

SELECT full_name, animals.name FROM animals INNER JOIN owners ON animals.owner_id = owners.id INNER JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT full_name, name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT full_name FROM owners INNER JOIN animals ON owners.id = animals.owner_id GROUP BY owners.id ORDER BY COUNT(animals) DESC LIMIT 1;

SELECT animals.name, visit_date FROM animals INNER JOIN visits ON animals.id = visits.animals_id INNER JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'William Tatcher' ORDER BY visits.visit_date DESC LIMIT 1;

SELECT DISTINCT COUNT(animals.name) FROM animals INNER JOIN visits ON animals.id = visits.animals_id INNER JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species ON specializations.species_id = species.id;

SELECT animals.name FROM animals INNER JOIN visits ON animals.id = visits.animals_id INNER JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'Stephanie Mendez' AND visits.visit_date >= '2020-04-01' AND visits.visit_date <= '2020-08-30';

SELECT animals.name, COUNT(animals.name) FROM animals INNER JOIN visits ON animals.id = visits.animals_id GROUP BY animals.name ORDER BY COUNT DESC LIMIT 1;

SELECT animals.name, visits.visit_date FROM animals INNER JOIN visits ON animals.id = visits.animals_id INNER JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'Maisy Smith' ORDER BY visits.visit_date ASC LIMIT 1;

SELECT animals.*, vets.*, visits.visit_date FROM animals INNER JOIN visits ON animals.id = visits.animals_id INNER JOIN vets ON visits.vets_id = vets.id ORDER BY visits.visit_date DESC LIMIT 1;

SELECT COUNT(visits.visit_date) FROM vets INNER JOIN visits ON visits.vets_id = vets.id INNER JOIN animals ON animals.id = visits.animals_id INNER JOIN specializations ON vets.id = specializations.vets_id INNER JOIN species ON specializations.species_id = species.id WHERE animals.species_id <> specializations.species_id;

SELECT species.name, COUNT(*) FROM animals INNER JOIN visits ON visits.animals_id = animals.id INNER JOIN vets ON vets.id = visits.vets_id INNER JOIN species ON species.id = animals.species_id WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY count DESC LIMIT 1;
