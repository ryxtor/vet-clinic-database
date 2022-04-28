/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

ALTER TABLE animals ADD species VARCHAR(20);

CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    PRIMARY KEY(id)
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD species_id INT REFERENCES species(id);

ALTER TABLE animals
ADD owner_id INT REFERENCES owners(id);

CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations(
    vets_id INT REFERENCES vets(id),
    species_id INT REFERENCES species(id),
    PRIMARY KEY(vets_id, species_id )
);

CREATE TABLE visits(
    id INT GENERATED ALWAYS AS IDENTITY,
    vets_id INT REFERENCES vets(id),
    animals_id INT REFERENCES animals(id),
    visit_date DATE,
    PRIMARY KEY(id, vets_id, animals_id)
);
