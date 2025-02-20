--1. Count how many anime each character appears in
SELECT c.first_name, c.last_name, COUNT(ca.anime_id) AS Anime_Count
FROM character c
JOIN character_anime ca ON c.character_id = ca.character_id
GROUP BY c.character_id, c.first_name, c.last_name;
--2. Show which genre of anime has the least number of episodes on average.
SELECT genre, AVG(episodes) AS Avg_Episodes
FROM anime
GROUP BY genre
ORDER BY Avg_Episodes ASC
LIMIT 1;
--3  Find the anime with the lowest number of episodes starting with “D” in their titles
SELECT title, episodes
FROM anime
WHERE title LIKE 'D%'
ORDER BY episodes ASC
LIMIT 1;
--4 Show which character appears in the anime with the fewest episodes.
SELECT c.first_name, c.last_name, a.title, a.episodes
FROM character c
JOIN character_anime ca ON c.character_id = ca.character_id
JOIN anime a ON ca.anime_id = a.anime_id
ORDER BY a.episodes ASC
LIMIT 1;
--5 Find the total number of episodes for anime produced by studios from “Japan”
SELECT SUM(episodes) AS Total_Episodes
FROM anime
WHERE country = 'Japan';
--6 Find the average number of episodes for anime in which “Naruto Uzumaki” appears.
SELECT AVG(a.episodes) AS Avg_Episodes
FROM anime a
JOIN character_anime ca ON a.anime_id = ca.anime_id
JOIN character c ON ca.character_id = c.character_id
WHERE c.first_name = 'Naruto' AND c.last_name = 'Uzumaki';
--7 Sort the list of anime produced by “Toei Animation” by their episodes in descending order
SELECT title, episodes
FROM anime
WHERE studio = 'Toei Animation'
ORDER BY episodes DESC;
--8 Find the average number of episodes for the “Shounen” genre.
SELECT AVG(episodes) AS Avg_Episodes
FROM anime
WHERE genre = 'Shounen';
--9 Show the first name of the character who plays a “Supporting” role in an anime.
SELECT c.first_name
FROM character c
JOIN character_anime ca ON c.character_id = ca.character_id
WHERE ca.role = 'Supporting';
--10. Display the names of characters and the titles of their anime, separated by a dash (‘-’).
SELECT CONCAT(c.first_name, ' ', c.last_name, ' - ', a.title) AS Character_Anime
FROM character c
JOIN character_anime ca ON c.character_id = ca.character_id
JOIN anime a ON ca.anime_id = a.anime_id;
--11. Which country has the most number of anime productions.
SELECT country, COUNT(*) AS Anime_Count
FROM anime
GROUP BY country
ORDER BY Anime_Count DESC
LIMIT 1;
--12. Find the list of characters who have appeared in anime produced by studios located in “Japan”.
SELECT DISTINCT c.first_name, c.last_name
FROM character c
JOIN character_anime ca ON c.character_id = ca.character_id
JOIN anime a ON ca.anime_id = a.anime_id
WHERE a.country = 'Japan';
--13. List the anime whose episodes are higher than the average.
SELECT title, episodes
FROM anime
WHERE episodes > (SELECT AVG(episodes) FROM anime);
--14. Bonus:
--a)  Write the names of the characters who share a last name and are from the same country.
SELECT c1.first_name, c1.last_name, c1.country
FROM character c1
JOIN character c2 ON c1.last_name = c2.last_name 
AND c1.country = c2.country 
AND c1.character_id <> c2.character_id;
--b) Find the total number of episodes produced by each studio.
SELECT studio, SUM(episodes) AS Total_Episodes
FROM anime
GROUP BY studio
ORDER BY Total_Episodes DESC;
