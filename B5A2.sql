CREATE DATABASE conservation_db;

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL,
    discovery_date DATE,
    conservation_status VARCHAR(50) NOT NULL
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT NOT NULL REFERENCES species(species_id) ON DELETE CASCADE,
    ranger_id INT NOT NULL REFERENCES rangers(ranger_id) ON DELETE CASCADE,
    location VARCHAR(150) NOT NULL,
    sighting_time TIMESTAMP,
    notes TEXT
);

INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00',  'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

DROP TABLE rangers;
DROP TABLE species;
DROP TABLE sightings;

SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;

--Prob 1: Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

--Prob 2: Count unique species ever sighted.
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

--Prob 3: Find all sightings where the location includes "Pass".
SELECT *
FROM sightings
WHERE location LIKE '%Pass%';

--Prob 4:List each ranger's name and their total number of sightings.
SELECT 
    ra.name AS ranger_name,
    COUNT(si.sighting_id) AS total_sightings
FROM rangers AS ra
LEFT JOIN sightings AS si ON ra.ranger_id = si.ranger_id
GROUP BY ra.name

--Prob 5: List species that have never been sighted.
SELECT 
    sp.common_name
FROM species AS sp
LEFT JOIN sightings AS si ON sp.species_id = si.species_id
WHERE si.sighting_id IS NULL;

--Prob 6: Show the most recent 2 sightings.
SELECT 
    sp.common_name,
    si.sighting_time,
    ra.name
FROM sightings si
JOIN species sp ON si.species_id = sp.species_id
JOIN rangers ra ON si.ranger_id = ra.ranger_id
ORDER BY si.sighting_time DESC
LIMIT 2;

--Prob 7: Update all species discovered before year 1800 to have status 'Historic'.
UPDATE species
SET conservation_status = 'Historic'
WHERE EXTRACT(YEAR FROM discovery_date) < 1800;

--Prob 8: Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT 
    si.sighting_id,
    CASE 
        WHEN EXTRACT(HOUR FROM si.sighting_time) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM si.sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM si.sighting_time) BETWEEN 18 AND 22 THEN 'Evening'
    END AS time_of_day
FROM sightings AS si;

--Prob 9: Delete rangers who have never sighted any species
DELETE FROM rangers AS ra
WHERE NOT EXISTS (
    SELECT *
    FROM sightings AS si
    WHERE si.ranger_id = ra.ranger_id
);