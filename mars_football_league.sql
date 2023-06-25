

CREATE TABLE stadiums (
    id INT, 
    stadium_name VARCHAR(50),
    city VARCHAR(50), 
    capacity VARCHAR(50), 

    PRIMARY KEY (id)
);

CREATE TABLE teams (
    id INT, 
    team_name VARCHAR(50), 
    city VARCHAR(50), 
    stadium_id INT, 

    PRIMARY KEY (id), 
    FOREIGN KEY (stadium_id) REFERENCES stadiums (id)
);

CREATE TABLE games (
    id INT, 
    game_date DATE, 
    game_time TIME, 
    home_team_id INT, 
    away_team_id INT, 
    home_goals INT,
    away_goals INT, 

    PRIMARY KEY (id), 
    FOREIGN KEY (home_team_id) REFERENCES teams (id), 
    FOREIGN KEY (away_team_id) REFERENCES teams (id)
); 

CREATE TABLE positions (
    id INT, 
    position_name VARCHAR(50),

    PRIMARY KEY (id)
);

CREATE TABLE players (
    id INT, 
    player_name VARCHAR(20), 
    team_id INT, 
    position_id INT, 
    goals INT, 
    assists INT, 
    yellow_cards INT, 
    red_cards INT, 

    PRIMARY KEY (id), 
    FOREIGN KEY (team_id) REFERENCES teams (id), 
    FOREIGN KEY (position_id) REFERENCES positions (id)
);

CREATE TABLE events (
    id INT, 
    game_id INT, 
    player_id INT, 
    event_type VARCHAR(20), 
    minute_ocurrence INT, 

    PRIMARY KEY (id), 
    FOREIGN KEY (game_id) REFERENCES games (id), 
    FOREIGN KEY (player_id) REFERENCES players (id)
);



INSERT INTO stadiums (id, stadium_name, capacity, city)
VALUES (1, 'Marte Arena', 50000, 'Olympus Mons'),
       (2, 'Cráter Stadium', 30000, 'Gale'),
       (3, 'Valles Marineris', 40000, 'Melas Chasma'),
       (4, 'Phobos Field', 20000, 'Stickney'),
       (5, 'Deimos Dome', 25000, 'Swift'),
       (6, 'Polaris Park', 35000, 'Planum Boreum'),
       (7, 'Tharsis Tholus', 45000, 'Tharsis'),
       (8, 'Elysium Coliseum', 60000, 'Elysium Planitia'),
       (9, 'Noctis Labyrinthus', 30000, 'Noctis'),
       (10, 'Terra Cimmeria', 40000, 'Cimmeria Planum'),
       (11, 'Arabia Terra', 50000, 'Arabia Planitia'),
       (12, 'Hellás Basin', 55000, 'Hellás Planitia'),
       (13, 'Syrtis Major', 45000, 'Syrtis Planum'),
       (14, 'Utopia Planitia', 35000, 'Utopia'),
       (15, 'Chryse Planitia', 40000, 'Chryse');


INSERT INTO teams (id, team_name, city, stadium_id)
VALUES (1, 'Olympus FC', 'Olympus Mons', 1),
       (2, 'Gale United', 'Gale', 2),
       (3, 'Melas Chasma', 'Melas Chasma', 3),
       (4, 'Stickney Rovers', 'Stickney', 4),
       (5, 'Swift Wanderers', 'Swift', 5),
       (6, 'Planum Boreum', 'Planum Boreum', 6),
       (7, 'Tharsis Tholus', 'Tharsis', 7),
       (8, 'Elysium Planitia', 'Elysium Planitia', 8),
       (9, 'Noctis FC', 'Noctis', 9),
       (10, 'Cimmeria Planum', 'Cimmeria Planum', 10),
       (11, 'Arabia Planitia', 'Arabia Planitia', 11),
       (12, 'Hellás Planitia', 'Hellás Planitia', 12),
       (13, 'Syrtis Planum', 'Syrtis Planum', 13),
       (14, 'Utopia FC', 'Utopia', 14),
       (15, 'Chryse Planitia', 'Chryse Planitia', 15), 
       (16, 'Ares Vallis', 'Olympus Mons', 1),
       (17, 'Gusev Crater', 'Gale', 2),
       (18, 'Terra Meridiani', 'Melas Chasma', 3),
       (19, 'Oxia Planum', 'Stickney', 4),
       (20, 'Jezero Crater', 'Swift', 5);

--Vamos a generar los players de nuestra liga marciana:

--              Declaramos una variable para guardar el id del jugador
DECLARE @id INT = 1;

--              Declaramos una variable para guardar la semilla
DECLARE @semilla INT = 123;

--              Usamos un bucle for para insertar 30 players por cada equipo
FOR @team_id IN (1..20) DO
  FOR @i IN (1..30) DO
    --          Generamos un nombre aleatorio para el jugador usando la semilla y una lista de 30 nombres y 30 apellidos
    DECLARE @player_name VARCHAR(50) = CONCAT(
      CHOOSE(RAND(@semilla) * 30 + 1, 'Juan', 'Pedro', 'Carlos', 'Luis', 'José', 'Miguel', 'David', 'Jorge', 'Daniel', 'Andrés',
             'Mario', 'Alberto', 'Sergio', 'Ricardo', 'Alejandro', 'Fernando', 'Manuel', 'Antonio', 'Francisco', 'Eduardo',
             'Julio', 'Oscar', 'Raúl', 'Pablo', 'Marcos', 'Leonardo', 'Hugo', 'Iván', 'Diego', 'Enrique'),
      CHOOSE(RAND(@semilla) * 30 + 1, 'Pérez', 'Gómez', 'López', 'Sánchez', 'Rodríguez', 'García', 'Martínez', 'Torres',
             'Díaz', 'Ramírez', 'Hernández', 'González', 'Fernández', 'Romero', 'Castro', 'Ortiz', 
             'Vargas','Rojas','Morales','Cruz','Soto','Flores','Reyes','Rivera','Gutiérrez','Ruiz','Medina','Moreno','Domínguez', 'Rojas', 'Núñez')
    );

    --          Generamos una posición aleatoria para el jugador usando la semilla
    DECLARE @position_id INT = RAND(@semilla) * 4 + 1;


    --          Insertamos el jugador en la tabla players
    INSERT INTO players (id, player_name, team_id, position_id)
    VALUES (@id, @player_name, @team_id, @position_id);

    --          Incrementamos el id del jugador en uno
    SET @id = @id + 1;

    --          Incrementamos la semilla en uno
    SET @semilla = @semilla + 1;
  END FOR;
END FOR;


--tabla de events
-- Declaramos una variable para guardar el id del evento
DECLARE @id INT = 1;

-- Declaramos una variable para guardar la semilla
DECLARE @semilla INT = 789;

-- Usamos un bucle for para insertar 10 events por cada partido
FOR @game_id IN (1..200) DO
  FOR @i IN (1..10) DO
    -- Generamos un jugador aleatorio para el evento usando la semilla
    DECLARE @player_id INT = RAND(@semilla) * 600 + 1;

    -- Generamos un tipo de evento aleatorio para el evento usando la semilla
    DECLARE @event_type VARCHAR(50) = CHOOSE(RAND(@semilla) * 4 + 1, 'Goal', 'Assist', 'Yellow Card', 'Red Card');

    -- Generamos un minuto y un segundo aleatorios para el evento usando la semilla
    DECLARE @minute_ocurrence INT = RAND(@semilla) * 90 + 1;

    -- Insertamos el evento en la tabla events
    INSERT INTO events (id, game_id, player_id, event_type, minute_ocurrence)
    VALUES (@id, @game_id, @player_id, @event_type, @minute_ocurrence);

    -- Incrementamos el id del evento en uno
    SET @id = @id + 1;

    -- Incrementamos la semilla en uno
    SET @semilla = @semilla + 1;
  END FOR;
END FOR;

--games
-- Declaramos una variable para guardar el id del partido
DECLARE @id INT = 1;

-- Usamos un bucle for para insertar un partido por cada game_date
FOR @game_date IN ('2023-01-01', '2023-01-15', '2023-02-01', '2023-02-15',
               '2023-03-01', '2023-03-15', '2023-04-01', '2023-04-15',
               '2023-05-01', '2023-05-15', '2023-06-01', '2023-06-15') DO
  -- Usamos una subconsulta para obtener los equipos que jugaron en esa game_date
  SELECT DISTINCT home_team_id, away_team_id
  FROM (
    -- Obtenemos los equipos que participaron en algún evento en esa game_date
    SELECT DISTINCT e.player_id, j.team_id
    FROM events e
    JOIN players j ON e.players_id = j.id
    WHERE e.game_date = @game_date
  ) t
  PIVOT (
    -- Agrupamos los equipos por local y visitante según el orden de los events
    MIN(team_id)
    FOR player_id IN (home_team_id, away_team_id)
  ) p;

  -- Usamos una subconsulta para obtener la game_time del primer evento del partido
  SELECT MIN(game_time) AS game_time
  FROM events
  WHERE game_date = @game_date;

  -- Usamos subconsultas para obtener los Goales y las tarjetas de cada equipo
  SELECT 
    (SELECT COUNT(*) FROM events WHERE event_type = 'Goal' AND player_id IN (SELECT id FROM players WHERE team_id = home_team_id)) AS home_goals,
    (SELECT COUNT(*) FROM events WHERE event_type = 'Goal' AND player_id IN (SELECT id FROM players WHERE team_id = away_team_id)) AS away_goals,
    (SELECT COUNT(*) FROM events WHERE event_type = 'Yellow Card' AND player_id IN (SELECT id FROM players WHERE team_id = home_team_id)) AS home_yellow_cards,
    (SELECT COUNT(*) FROM events WHERE event_type = 'Yellow Card' AND player_id IN (SELECT id FROM players WHERE team_id = away_team_id)) AS away_yellow_cards,
    (SELECT COUNT(*) FROM events WHERE event_type = 'Red Card' AND player_id IN (SELECT id FROM players WHERE team_id = home_team_id)) AS home_red_cards,
    (SELECT COUNT(*) FROM events WHERE event_type = 'Red Card' AND player_id IN (SELECT id FROM players WHERE team_id = away_team_id)) AS away_red_cards;

  -- Insertamos el partido en la tabla games usando los resultados de las subconsultas
  INSERT INTO games (id, game_date, game_time, home_team_id, away_team_id, home_goals, away_goals, home_yellow_cards, away_yellow_cards, home_red_cards, away_red_cards)
  VALUES (@id, @game_date, game_time, home_team_id, away_team_id, home_goals, away_goals, home_yellow_cards, away_yellow_cards, home_red_cards, away_red_cards);

  -- Incrementamos el id del partido en uno
  SET @id = @id + 1;
END FOR;
