CREATE TABLE stadiums (
    id SERIAL PRIMARY KEY,
    stadium_name VARCHAR(50),
    city VARCHAR(50),
    capacity INT
);

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    team_name VARCHAR(50),
    city VARCHAR(50),
    stadium_id INT REFERENCES stadiums(id)
);

CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    game_date DATE,
    game_time TIME,
    home_team_id INT REFERENCES teams(id),
    away_team_id INT REFERENCES teams(id),
    home_goals INT,
    away_goals INT
);

CREATE TABLE positions (
    id SERIAL PRIMARY KEY,
    position_name VARCHAR(50)
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    player_name VARCHAR(50),
    team_id INT REFERENCES teams(id),
    position_id INT REFERENCES positions(id),
    goals INT,
    assists INT,
    yellow_cards INT,
    red_cards INT
);

CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    game_id INT REFERENCES games(id),
    player_id INT REFERENCES players(id),
    event_type VARCHAR(20),
    minute_occurrence INT
);