/* Populate database with sample data. */

INSERT INTO animals  (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
OVERRIDING SYSTEM VALUE
VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23), (2, 'Gabumon', '2018-11-15', 2, true, 8), (3, 'Pikachu', '2021-01-07', 1, false, 15.04), (4, 'Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals  (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
OVERRIDING SYSTEM VALUE
  VALUES (5, 'Charmander', '2020-02-08', 0, false, -11), 
  (6, 'Plantmon', '2021-11-15', 2, true, -5.7), 
  (7, 'Squirtle', '1993-04-02', 3, false, -12.13),
  (8, 'Angemon', '2005-06-12', 1, true, -45),
  (9, 'Boarmon', '2005-06-07', 7, true, 20.4),
  (10, 'Blossom', '1998-10-13', 3, true, 17),
  (11, 'Ditto', '2022-05-14', 4, true, 22);

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES ('Pokemon'), ('Digimon');

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 species_id IS NULL;

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id)
VALUES 
((SELECT id FROM vets v WHERE v.name = 'William Tatcher'), (SELECT id FROM species s WHERE s.name ='Pokemon')),
((SELECT id FROM vets v WHERE v.name = 'Stephanie Mendez'), (SELECT id FROM species s WHERE s.name ='Pokemon')),
((SELECT id FROM vets v WHERE v.name = 'Stephanie Mendez'), (SELECT id FROM species s WHERE s.name ='Digimon')),
((SELECT id FROM vets v WHERE v.name = 'Jack Harkness'), (SELECT id FROM species s WHERE s.name ='Digimon'));
-- VALUES (1, 1), (3, 1), (3, 2), (4, 2);

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES
((SELECT id FROM vets v WHERE v.name = 'William Tatcher'), (SELECT id FROM animals a WHERE a.name = 'Agumon'), ('2020-05-24')),
((SELECT id FROM vets v WHERE v.name = 'Stephanie Mendez'), (SELECT id FROM animals a WHERE a.name = 'Agumon'), ('2020-07-22')),
((SELECT id FROM vets v WHERE v.name = 'Jack Harkness'), (SELECT id FROM animals a WHERE a.name = 'Gabumon'), ('2021-02-02')),
((SELECT id FROM vets v WHERE v.name = 'Maisy Smith'), (SELECT id FROM animals a WHERE a.name = 'Pikachu'), ('2020-01-05')),
((SELECT id FROM vets v WHERE v.name = 'Maisy Smith'), (SELECT id FROM animals a WHERE a.name = 'Pikachu'), ('2020-03-08')),
((SELECT id FROM vets v WHERE v.name = 'Maisy Smith'), (SELECT id FROM animals a WHERE a.name = 'Pikachu'), ('2020-05-14')),
((SELECT id FROM vets v WHERE v.name = 'Stephanie Mendez'), (SELECT id FROM animals a WHERE a.name = 'Devimon'), ('2021-05-04')),
((SELECT id FROM vets v WHERE v.name = 'Jack Harkness'), (SELECT id FROM animals a WHERE a.name = 'Charmander'), ('2021-02-24')),
((SELECT id FROM vets v WHERE v.name = 'Maisy Smith'), (SELECT id FROM animals a WHERE a.name = 'Plantmon'), ('2019-12-21')),
((SELECT id FROM vets v WHERE v.name = 'William Tatcher'), (SELECT id FROM animals a WHERE a.name = 'Plantmon'), ('2020-08-10')),
((SELECT id FROM vets v WHERE v.name = 'Maisy Smith'), (SELECT id FROM animals a WHERE a.name = 'Plantmon'), ('2021-04-07')),
((SELECT id FROM vets v WHERE v.name = 'Stephanie Mendez'), (SELECT id FROM animals a WHERE a.name = 'Squirtle'), ('2019-09-29')),
((SELECT id FROM vets v WHERE v.name = 'Jack Harkness'), (SELECT id FROM animals a WHERE a.name = 'Angemon'), ('2020-10-03')),
((SELECT id FROM vets v WHERE v.name = 'Jack Harkness'), (SELECT id FROM animals a WHERE a.name = 'Angemon'), ('2020-11-04')),
((SELECT id FROM vets v WHERE v.name = 'Maisy Smith'), (SELECT id FROM animals a WHERE a.name = 'Boarmon'), ('2019-01-24')),
((SELECT id FROM vets v WHERE v.name = 'Maisy Smith'), (SELECT id FROM animals a WHERE a.name = 'Boarmon'), ('2019-05-15')),
((SELECT id FROM vets v WHERE v.name = 'Maisy Smith'), (SELECT id FROM animals a WHERE a.name = 'Boarmon'), ('2020-02-27')),
((SELECT id FROM vets v WHERE v.name = 'Maisy Smith'), (SELECT id FROM animals a WHERE a.name = 'Boarmon'), ('2020-08-03')),
((SELECT id FROM vets v WHERE v.name = 'Stephanie Mendez'), (SELECT id FROM animals a WHERE a.name = 'Blossom'), ('2020-05-24')),
((SELECT id FROM vets v WHERE v.name = 'William Tatcher'), (SELECT id FROM animals a WHERE a.name = 'Blossom'), ('2021-01-11'));

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
