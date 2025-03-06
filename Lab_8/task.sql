DBMS_OUTPUT
BEGIN
  DBMS_OUTPUT.PUT_LINE('RAYAN IDRISS');
  DBMS_OUTPUT.PUT_LINE('ID STUDENT : 220041257');
END
/

DECLARE
  NUM1 NUMBER;
  NUM2 NUMBER;
  PRODUCT NUMBER;
BEGIN
  NUM1 := 2;
  NUM2 := 5;
  PRODUCT := NUM1 * NUM2;
  DBMS_OUTPUT.PUT_LINE('THE PRODUCT OF ' || NUM1 || ' AND ' || NUM2 || ' IS: ' || PRODUCT);
END
/ 

DECLARE
  num NUMBER;
BEGIN
  IF num = (num) THEN -- I don't know ...
    DBMS_OUTPUT.PUT_LINE(num || ' is a whole number.');
  ELSE
    DBMS_OUTPUT.PUT_LINE(num || ' is a fraction.');
  END IF;
END;
/


--- TASK 3

CREATE PROCEDURE GETMOVIES (N IN NUMBER) 
IS
    movie_count NUMBER;
BEGIN

    SELECT COUNT(*) INTO movie_count FROM MOVIE;
    
    -- Check if N is greater than the total number of movies
    IF N > movie_count THEN
        DBMS_OUTPUT.PUT_LINE('Error: N is greater than the total number of movies ('|| movie_count ').');
        RETURN;
    END IF;

    -- Retrieve N (top movies)
    FOR movie_rec IN (
        SELECT M.MOV_ID, M.MOV_TITLE, M.MOV_YEAR, M.MOV_LANGUAGE, 
               M.MOV_RELEASEDATE, M.MOV_COUNTRY, AVG(R.REV_STARS) AS AVG_RATING
        FROM MOVIE M
        JOIN RATING R ON M.MOV_ID = R.MOV_ID
        GROUP BY M.MOV_ID, M.MOV_TITLE, M.MOV_YEAR, M.MOV_LANGUAGE, 
                 M.MOV_RELEASEDATE, M.MOV_COUNTRY
        ORDER BY AVG(R.REV_STARS) DESC
        FETCH FIRST N ROWS ONLY
    ) LOOP
        -- Print
        DBMS_OUTPUT.PUT_LINE('Movie ID: ' || movie_rec.MOV_ID);
        DBMS_OUTPUT.PUT_LINE('Title: ' || movie_rec.MOV_TITLE);
        DBMS_OUTPUT.PUT_LINE('Year: ' || movie_rec.MOV_YEAR);
        DBMS_OUTPUT.PUT_LINE('Language: ' || movie_rec.MOV_LANGUAGE);
        DBMS_OUTPUT.PUT_LINE('Release Date: ' || TO_CHAR(movie_rec.MOV_RELEASEDATE, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Country: ' || movie_rec.MOV_COUNTRY);
        DBMS_OUTPUT.PUT_LINE('Average Rating: ' || movie_rec.AVG_RATING);
        DBMS_OUTPUT.PUT_LINE('-----------------------------');
    END LOOP;
END;
/

-- Function to Find the Movie Status (“Solo” or “Ensemble”)
CREATE FUNCTION GetMovieStatus(movie_title VARCHAR(255)) RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE actor_count INT;
    
    SELECT COUNT(*) INTO actor_count
    FROM CASTS C
    JOIN MOVIE M ON C.MOV_ID = M.MOV_ID
    WHERE M.MOV_TITLE = movie_title;
    
    IF actor_count = 1 THEN
        RETURN 'Solo';
    ELSE
        RETURN 'Ensemble';
    END IF;
END //

DELIMITER ;