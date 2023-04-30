COPY Artist from '/home/arush/arush/VIth_Sem/COL362/Project/Data/artists.csv' DELIMITER ',' CSV HEADER;
ALTER TABLE Artist
DROP COLUMN artist_lastfm, DROP COLUMN country_lastfm, DROP COLUMN tags_lastfm, DROP COLUMN scrobbles_lastfm, DROP COLUMN ambiguous_artist,
ADD COLUMN popularity_nirvana bigint DEFAULT 0;
DELETE FROM Artist dup_artist
USING Artist dist_artist
WHERE dup_artist.id < dist_artist.id AND dup_artist.name = dist_artist.name AND dup_artist.country = dist_artist.country AND dup_artist.genres_and_tags = dist_artist.genres_and_tags AND dup_artist.popularity_lastfm = dist_artist.popularity_lastfm AND dup_artist.popularity_nirvana = dist_artist.popularity_nirvana;
DELETE FROM Artist dup_artist
USING Artist dist_artist
WHERE dup_artist.popularity_lastfm < dist_artist.popularity_lastfm AND dup_artist.name = dist_artist.name;
DELETE FROM Artist dup_artist
USING Artist dist_artist
WHERE dup_artist.id < dist_artist.id AND dup_artist.name = dist_artist.name;


COPY Awards from '/home/arush/arush/VIth_Sem/COL362/Project/Github/Ola-Uber-main/brit.csv' DELIMITER ',' CSV HEADER;
COPY Awards from '/home/arush/arush/VIth_Sem/COL362/Project/Github/Ola-Uber-main/grammy.csv' DELIMITER ',' CSV HEADER;
COPY Awards from '/home/arush/arush/VIth_Sem/COL362/Project/Github/Ola-Uber-main/vma.csv' DELIMITER ',' CSV HEADER;
DELETE FROM Awards dup_awards
USING Awards dist_awards
WHERE dup_awards.sno < dist_awards.sno AND dup_awards.year = dist_awards.year AND dup_awards.category = dist_awards.category AND dup_awards.association = dist_awards.association AND dup_awards.artist = dist_awards.artist AND dup_awards.nominee = dist_awards.nominee;
ALTER TABLE Awards
DROP COLUMN sno;
DELETE FROM Awards
WHERE artist IS NULL AND nominee IS NULL;
--ADD PRIMARY KEY (year, category, association, artist, nominee);


COPY Songs from '/home/arush/arush/VIth_Sem/COL362/Project/Github/Ola-Uber-main/songs_mod.csv' DELIMITER ',' CSV HEADER;
ALTER TABLE Songs
DROP COLUMN artist_ids,
ADD COLUMN popularity_nirvana bigint DEFAULT 0;
DELETE FROM Songs
WHERE name IS NULL OR artist_names = '{}';
DELETE FROM Songs dup_songs
USING Songs dist_songs
WHERE dup_songs.id < dist_songs.id AND dup_songs.name = dist_songs.name AND dup_songs.artist_names = dist_songs.artist_names AND dup_songs.popularity = dist_songs.popularity AND dup_songs.explicit = dist_songs.explicit AND dup_songs.song_type = dist_songs.song_type AND dup_songs.track_number = dist_songs.track_number AND dup_songs.num_artists = dist_songs.num_artists AND dup_songs.num_available_markets = dist_songs.num_available_markets AND dup_songs.release_date = dist_songs.release_date AND dup_songs.duration_ms = dist_songs.duration_ms AND dup_songs.key = dist_songs.key AND dup_songs.mode = dist_songs.mode AND dup_songs.time_signature = dist_songs.time_signature AND dup_songs.acousticness = dist_songs.acousticness AND dup_songs.danceability = dist_songs.danceability AND dup_songs.energy = dist_songs.energy AND dup_songs.instrumentalness = dist_songs.instrumentalness AND dup_songs.liveness = dist_songs.liveness AND dup_songs.loudness = dist_songs.loudness AND dup_songs.speechiness = dist_songs.speechiness AND dup_songs.valence = dist_songs.valence AND dup_songs.tempo = dist_songs.tempo AND dup_songs.popularity_nirvana = dist_songs.popularity_nirvana;
DELETE FROM Songs dup_songs
USING Songs dist_songs
WHERE dup_songs.popularity < dist_songs.popularity AND dup_songs.name = dist_songs.name AND dup_songs.artist_names = dist_songs.artist_names AND dup_songs.popularity = dist_songs.popularity AND dup_songs.explicit = dist_songs.explicit AND dup_songs.song_type = dist_songs.song_type AND dup_songs.track_number = dist_songs.track_number AND dup_songs.num_artists = dist_songs.num_artists AND dup_songs.num_available_markets = dist_songs.num_available_markets AND dup_songs.release_date = dist_songs.release_date AND dup_songs.duration_ms = dist_songs.duration_ms AND dup_songs.key = dist_songs.key AND dup_songs.mode = dist_songs.mode AND dup_songs.time_signature = dist_songs.time_signature AND dup_songs.acousticness = dist_songs.acousticness AND dup_songs.danceability = dist_songs.danceability AND dup_songs.energy = dist_songs.energy AND dup_songs.instrumentalness = dist_songs.instrumentalness AND dup_songs.liveness = dist_songs.liveness AND dup_songs.loudness = dist_songs.loudness AND dup_songs.speechiness = dist_songs.speechiness AND dup_songs.valence = dist_songs.valence AND dup_songs.tempo = dist_songs.tempo AND dup_songs.popularity_nirvana = dist_songs.popularity_nirvana;
DELETE FROM Songs dup_songs
USING Songs dist_songs
WHERE dup_songs.popularity < dist_songs.popularity AND dup_songs.name = dist_songs.name AND dup_songs.artist_names = dist_songs.artist_names;
DELETE FROM Songs dup_songs
USING Songs dist_songs
WHERE dup_songs.id < dist_songs.id AND dup_songs.name = dist_songs.name AND dup_songs.artist_names = dist_songs.artist_names;


COPY Composition from '/home/arush/arush/VIth_Sem/COL362/Project/Github/Ola-Uber-main/chords_and_lyrics_mod.csv' DELIMITER ',' CSV HEADER;
DELETE FROM Composition
WHERE song IS NULL OR artist IS NULL;
ALTER TABLE Composition
ADD COLUMN popularity_nirvana bigint DEFAULT 0;


COPY Chords from '/home/arush/arush/VIth_Sem/COL362/Project/Github/Ola-Uber-main/chords.csv' DELIMITER ',' CSV HEADER;
ALTER TABLE Chords
DROP COLUMN sno;


SELECT table_name, column_name, data_type 
FROM information_schema.columns
WHERE table_name = 'artist' OR table_name = 'awards' OR table_name = 'chords' OR table_name = 'composition' OR table_name = 'songs';
