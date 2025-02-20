-- 2. Display the different types of Pokémon (unique values only)
SELECT DISTINCT type 
FROM pokemon;


--3. List all Pokémon whose attack stat is between 50 and 80 (inclusive).
SELECT name, attack 
FROM pokemon 
WHERE attack BETWEEN 50 AND 80;


--4. Find all Pokémon whose names start with the letter ‘C’.
SELECT name 
FROM pokemon 
WHERE name LIKE 'C%';


--5. Find all Pokémon whose names contain ‘saur’ anywhere in their names.
SELECT name 
FROM pokemon 
WHERE name LIKE '%saur%';


--6. Find all Pokémon whose names have exactly 9 characters and the fifth character is ‘e’.
SELECT name 
FROM pokemon 
WHERE LENGTH(name) = 9 AND SUBSTRING(name, 5, 1) = 'e';


--7. Display the full names of all trainers along with their city.
SELECT CONCAT(first_name, ' ', last_name) AS Full_Name, city 
FROM trainer;


--8. List all Pokémon sorted first by type (ascending) and then by attack stat (descending).
SELECT name, type, attack 
FROM pokemon 
ORDER BY type ASC, attack DESC;


--9. Create the trainer_pokemon Table
CREATE TABLE trainer_pokemon (
    trainer_id INT,
    pokemon_id INT,
    PRIMARY KEY (trainer_id, pokemon_id)
);

--10. Add Foreign Key Constraints
ALTER TABLE trainer_pokemon 
ADD CONSTRAINT fk_trainer FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id);

ALTER TABLE trainer_pokemon 
ADD CONSTRAINT fk_pokemon FOREIGN KEY (pokemon_id) REFERENCES pokemon(pokemon_id);



