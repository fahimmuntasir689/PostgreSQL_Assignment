-- Active: 1748881118326@@127.0.0.1@5432@conservation_db

-- Creating 'rangers' table
CREATE Table rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(30) NOT NULL
);

-- Creating 'species' table
CREATE Table species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(30)
);
-- Creating 'sigtings' table
CREATE Table sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers (ranger_id),
    species_id INT REFERENCES species (species_id),
    sighting_time TIMESTAMP,
    location VARCHAR(30) NOT NULL,
    notes TEXT
);

-- Inserting data to 'rangers'
INSERT INTO
    rangers (name, region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    );

-- Inserting data to 'species'
INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered '
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );
--Inserting data to 'sightings'
INSERT INTO
    sightings (
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
    VALUES
    ( 1   ,  1   , 'Peak Ridge' , '2024-05-10 07:45:00' , 'Camera trap image captured'),
    (2   ,  2  , 'Bankwood Area' , '2024-05-12 16:20:00' ,'Juvenile seen' ),
    ( 3  ,  3  , 'Bamboo Grove East' , '2024-05-15 09:10:00' , 'Feeding observed'),
    (1  ,  2  ,'Snowfall Pass'  , '2024-05-18 18:30:00' , NULL);


 -- problem_One

 INSERT INTO rangers (name , region)
 VALUES ('Derek Fox', 'Coastal Plains');


 -- problem_Two
SELECT count(DISTINCT species_id) as unique_species_count from sightings;

-- problem_Three
SELECT * from sightings
WHERE location LIKE '%Pass%';

-- problem_Four

SELECT rangers.name , count(*) as total_sightings from rangers
JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name;

-- problem_Five

SELECT common_name from species
WHERE species_id NOT IN (
    SELECT species_id FROM sightings
);

-- Problem_Six

SELECT species.common_name , sightings.sighting_time , rangers.name  from species
JOIN sightings on species.species_id = sightings.species_id
JOIN rangers on sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 2;

--problem_Seven

UPDATE species
SET conservation_status = 'Historic'
WHERE extract(YEAR FROM discovery_date) < 1800;


--problem_Eight

SELECT sighting_id , 
CASE 
    WHEN extract(HOUR from sighting_time) < 12 THEN 'Morning'
    WHEN extract(HOUR from sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS time_of_day
from sightings;

--problem_Nine

DELETE from rangers
WHERE ranger_id NOT IN (
    SELECT ranger_id FROM sightings
);




