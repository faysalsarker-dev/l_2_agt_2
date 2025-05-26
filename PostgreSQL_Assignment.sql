

-- 1️ rangers table 
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region TEXT NOT NULL
);



-- 2️ species table 
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name TEXT NOT NULL,
    scientific_name TEXT NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status TEXT NOT NULL
);



-- 3️ sightings table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INTEGER NOT NULL REFERENCES rangers(ranger_id),
    species_id INTEGER NOT NULL REFERENCES species(species_id),
    sighting_time TIMESTAMP NOT NULL,
    location TEXT NOT NULL,
    notes TEXT DEFAULT NULL
);



-- 1️ rangers Table data insert
INSERT INTO rangers (ranger_id, name, region) VALUES
  (1, 'Alice Green', 'Northern Hills'),
  (2, 'Bob White', 'River Delta'),
  (3, 'Carol King', 'Mountain Range'),
  (4, 'Faysal Sarker', 'Coastal Plains'),
  (5, 'Elon Mask', 'Desert Edge');



-- 2️ species Table data insert  
INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
  (1, 'Snow Leopard', 'Panthera uncia','1775-01-01', 'Endangered'),
  (2, 'Bengal Tiger', 'Panthera tigris tigris','1758-01-01', 'Endangered'),
  (3, 'Red Panda', 'Ailurus fulgens','1825-01-01', 'Vulnerable'),
  (4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01','Endangered');





-- 3️ sightings Table data insert
INSERT INTO sightings (ranger_id, species_id, location, sighting_time, notes) VALUES
  (1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
  (2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
  (3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
  (1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


-- Problem 1
INSERT INTO rangers (ranger_id ,name, region) VALUES (6, 'Derek Fox', 'Coastal Plains');

-- Problem 2
SELECT count(DISTINCT species_id) as unique_species_count
FROM sightings;

-- Problem 3
SELECT * FROM sightings
WHERE location LIKE '%Pass%';


-- Problem 4
SELECT rangers.name, count(sightings.sighting_id) AS total_sightings
FROM rangers
JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name
ORDER BY total_sightings DESC;

-- Problem 5
SELECT common_name FROM species
LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE sightings.species_id IS NULL;



-- Problem 6
SELECT species.common_name, sightings.sighting_time, rangers.name
FROM sightings
JOIN species ON sightings.species_id = species.species_id
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 2;


-- Problem 7
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';


-- Problem 8
SELECT
  sighting_id,
  CASE
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) < 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;


-- Problem 9
DELETE FROM rangers
WHERE ranger_id NOT IN (
  SELECT DISTINCT ranger_id FROM sightings
);


