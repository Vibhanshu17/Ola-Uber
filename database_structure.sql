DROP TABLE IF EXISTS Artist;

CREATE TABLE Artist (
	id varchar PRIMARY KEY,
	name varchar NOT NULL,
	artist_lastfm varchar,
	country varchar DEFAULT NULL,
	country_lastfm varchar DEFAULT NULL,
	genres_and_tags varchar DEFAULT NULL,
	tags_lastfm varchar DEFAULT NULL,
	popularity_lastfm bigint DEFAULT NULL,
	scrobbles_lastfm bigint DEFAULT NULL,
	ambiguous_artist boolean DEFAULT NULL
);

DROP TABLE IF EXISTS Awards;

CREATE TABLE Awards (
	sno bigint,
	year int NOT NULL,
	category varchar NOT NULL,
	artist varchar DEFAULT NULL,
	nominee varchar DEFAULT NULL,
	association varchar NOT NULL
);

DROP TABLE IF EXISTS Songs;

CREATE TABLE Songs (
	id varchar PRIMARY KEY,
	name varchar DEFAULT NULL,
	artist_ids varchar[] NOT NULL,
	artist_names varchar[] NOT NULL,
	popularity bigint NOT NULL,
	explicit boolean NOT NULL,
	song_type varchar NOT NULL,
	track_number int NOT NULL,
	num_artists int NOT NULL,
	num_available_markets int NOT NULL,
	release_date varchar NOT NULL,
	duration_ms bigint NOT NULL,
	key varchar NOT NULL,
	mode varchar NOT NULL,
	time_signature varchar NOT NULL,
	acousticness decimal NOT NULL,
	danceability decimal NOT NULL,
	energy decimal NOT NULL,
	instrumentalness decimal NOT NULL,
	liveness decimal NOT NULL,
	loudness decimal NOT NULL,
	speechiness decimal NOT NULL,
	valence decimal NOT NULL,
	tempo decimal NOT NULL
);

DROP TABLE IF EXISTS Composition;

CREATE TABLE Composition (
	artist varchar DEFAULT NULL,
	song varchar DEFAULT NULL,
	chords_and_lyrics text DEFAULT NULL,
	chords text DEFAULT NULL,
	lyrics text DEFAULT NULL,
	tabs text DEFAULT NULL,
	language varchar DEFAULT NULL,
	tags varchar DEFAULT NULL,
	chordlist varchar[] DEFAULT NULL
);

DROP TABLE IF EXISTS Chords;

CREATE TABLE Chords (
	sno int,
	name varchar NOT NULL,
	barre int NOT NULL,
	position varchar NOT NULL,
	PRIMARY KEY (name,barre,position)
);
