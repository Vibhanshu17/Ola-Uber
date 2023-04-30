--Search for a particular song and get all artists who have that song--
\set song '\'Smells Like Teen Spirit\''
CREATE INDEX Composition1 ON Composition(song,artist);
CREATE INDEX Songs1 ON Songs(name,artist_names);
DROP INDEX Composition1;
DROP INDEX Songs1;
SELECT artist, artist_names FROM
	(SELECT * FROM Composition WHERE song = :song) AS t1
    LEFT JOIN 
	(SELECT * FROM Songs WHERE name = :song) AS t2
    ON E'\''||t1.artist||E'\'' = ANY(t2.artist_names);

--Search for a particular artist and get all songs by that artist--
\set artist '\'Johnny Cash\''
CREATE INDEX Composition2 ON Composition(song,artist);
CREATE INDEX Songs2 ON Songs(name,artist_names);
SELECT song FROM
	(SELECT * FROM Composition WHERE artist = :artist) AS t1
    LEFT JOIN
	(SELECT * FROM Songs WHERE E'\''||:artist||E'\'' = ANY(artist_names)) AS t2
    ON t1.song = t2.name;
    
SELECT * FROM Artist WHERE name = :artist;

--Choose one of the displayed options on screen after searching for some results, i.e., specify both artist and song--
\set song '\'Black Hole Sun\''
\set artist '\'Soundgarden\''
CREATE INDEX Composition3 ON Composition(song,artist);
CREATE INDEX Songs3 ON Songs(name,artist_names);
CREATE INDEX Artist1 ON Artist(name);
SELECT * FROM
	(SELECT * FROM
	       	(SELECT * FROM Composition WHERE artist = :artist AND song = :song) AS t1
	    LEFT JOIN
       		(SELECT * FROM Songs WHERE name = :song AND E'\''||:artist||E'\'' = ANY(artist_names)) AS t2
	    ON 1=1
	) AS t3
    JOIN
	(SELECT * FROM Artist Where name = :artist) AS t4
    ON 1=1;

CREATE INDEX Composition4 ON Composition(song,artist);
CREATE INDEX Chords1 ON Chords(name);
SELECT name, barre, position FROM
	Chords
   JOIN
	(SELECT chordlist FROM Composition WHERE song = :song AND artist = :artist) AS t1
   ON E'\''||Chords.name||E'\'' = ANY(t1.chordlist);
   
UPDATE Artist                                                      
SET popularity_nirvana = popularity_nirvana + 1
WHERE name = :artist;

UPDATE Songs                                       
SET popularity_nirvana = popularity_nirvana + 1
WHERE name = :song AND E'\''||:artist||E'\'' = ANY(artist_names);

UPDATE Composition                                      
SET popularity_nirvana = popularity_nirvana + 1
WHERE name = :song AND artist = :artist;

--Choose a genre and get artists that fit--
\set genre '\'blues\''
CREATE INDEX Artist2 ON Artist(genres_and_tags);
SELECT name FROM Artist WHERE genres_and_tags LIKE '%'||:genre||'%';

--Choose a category of awards and get the songs that have won it--
\set category '\'Video of the Year\''
CREATE INDEX Awards1 ON Awards(category,nominee);
CREATE INDEX Composition5 ON Composition(artist);
SELECT t1.artist, song, year, association FROM
	(SELECT * FROM Awards WHERE category = :category) AS t1
    JOIN
	Composition
    ON t1.nominee = Composition.song AND t1.artist = Composition.artist;

--Inspire Me (Random Song Generator)--
SELECT artist, song FROM
	Composition
    ORDER BY RANDOM()
    LIMIT 1;
    
--Top 5 Trending Artists--
SELECT name, popularity_lastfm FROM Artist WHERE popularity_lastfm IS NOT NULL ORDER BY popularity_lastfm DESC LIMIT 5;

--Top 5 Trending Songs--
SELECT name, artist_names, popularity FROM Songs WHERE popularity IS NOT NULL ORDER BY popularity DESC LIMIT 5;

--Top 5 Nirvana Trending Artists--
SELECT name, popularity_nirvana FROM Artist WHERE popularity_nirvana IS NOT NULL ORDER BY popularity_nirvana DESC LIMIT 5;

--Top 5 Nirvana Trending Songs--
SELECT song, artist, popularity_nirvana FROM Composition WHERE popularity_nirvana IS NOT NULL ORDER BY popularity_nirvana DESC LIMIT 5;

--Complexity of Songs--
--Easy: 0&70, 0&3, 0--
--Intermediate: 70&120, 3&5, 1--
--Easy: 120&500, 5&50, 1--
select name
from songs
where tempo between x and y
union
select song
from (
        select song, unnest(chordlist) as chordlist
        from composition
        where array_length(chordlist, 1) between x and y
) as t1
inner join (
        select *
        from chords
        where barre= p
) as t2
on t1.chordlist like '%' || t2.name || '%';

--Moods--
SELECT DISTINCT song, artist
FROM ( 
SELECT song, artist, unnest(chordlist) as chordlist FROM composition 
WHERE tags LIKE ANY(ARRAY[ '%club%', '%samba%', '%funk%', '%house%', '%disco%' ])
) as t1
INNER JOIN chords 
ON t1.chordlist LIKE '%'|| chords.name || '%';
