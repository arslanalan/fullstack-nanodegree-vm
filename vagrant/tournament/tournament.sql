-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
--CREATE TABLE posts ( content TEXT,
--                     time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--                     id SERIAL );
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament;
CREATE TABLE players (  name TEXT,
                        id SERIAL PRIMARY KEY );

CREATE TABLE matches (  winner_id INTEGER REFERENCES players ( id ),
                        looser_id INTEGER REFERENCES players ( id ),
                        time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        PRIMARY KEY (winner_id, looser_id, time) );

CREATE VIEW standings AS
    SELECT players.id AS id, players.name AS name,
        (SELECT count(*) AS wins FROM matches WHERE winner_id = players.id),
        (SELECT count(*) AS matches FROM matches WHERE winner_id = players.id OR looser_id = players.id)
    FROM players
    ORDER BY wins DESC;

/*
CREATE VIEW pairings AS
    SELECT id AS id1, name AS name1 FROM standings LIMIT 1 OFFSET 0
*/