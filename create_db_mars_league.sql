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


INSERT INTO stadiums (stadium_name, capacity, city)
VALUES 
    ('Marte Arena', 50000, 'Olympus Mons'),
    ('Cráter Stadium', 30000, 'Gale'),
    ('Valles Marineris', 40000, 'Melas Chasma'),
    ('Phobos Field', 20000, 'Stickney'),
    ('Deimos Dome', 25000, 'Swift'),
    ('Polaris Park', 35000, 'Planum Boreum'),
    ('Tharsis Tholus', 45000, 'Tharsis'),
    ('Elysium Coliseum', 60000, 'Elysium Planitia'),
    ('Noctis Labyrinthus', 30000, 'Noctis'),
    ('Terra Cimmeria', 40000, 'Cimmeria Planum'),
    ('Arabia Terra', 50000, 'Arabia Planitia'),
    ('Hellás Basin', 55000, 'Hellás Planitia'),
    ('Syrtis Major', 45000, 'Syrtis Planum'),
    ('Utopia Planitia', 35000, 'Utopia'),
    ('Chryse Planitia', 40000, 'Chryse');

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

INSERT INTO positions (position_name)
VALUES 
    ('Goalkeeper'),
    ('Defender'),
    ('Midfielder'),
    ('Forward');

---------------------------------------------------------------------

-- Vamos a generar los jugadores de nuestra liga marciana:
DO $$
DECLARE
    id INT := 1;
    semilla INT := 123;
    nombres VARCHAR[] := ARRAY['Juan', 'Pedro', 'Carlos', 'Luis', 'José', 'Miguel', 'David', 'Jorge', 'Daniel', 'Andrés', 'Mario', 'Alberto', 'Sergio', 'Ricardo', 'Alejandro', 'Fernando', 'Manuel', 'Antonio', 'Francisco', 'Eduardo', 'Julio', 'Oscar', 'Raúl', 'Pablo', 'Marcos', 'Leonardo', 'Hugo', 'Iván', 'Diego', 'Enrique'];
    apellidos VARCHAR[] := ARRAY['Pérez', 'Gómez', 'López', 'Sánchez', 'Rodríguez', 'García', 'Martínez', 'Torres', 'Díaz', 'Ramírez', 'Hernández', 'González', 'Fernández', 'Romero', 'Castro', 'Ortiz', 'Vargas', 'Rojas', 'Morales', 'Cruz', 'Soto', 'Flores', 'Reyes', 'Rivera', 'Gutiérrez', 'Ruiz', 'Medina', 'Moreno', 'Domínguez', 'Núñez'];
    team_id INT;
    i INT;
    player_name VARCHAR(50);
    position_id INT;
BEGIN
  -- Usamos un bucle FOR para insertar 30 jugadores por cada equipo
  FOR team_id IN 1..20 LOOP
    FOR i IN 1..30 LOOP
      -- Generamos un nombre aleatorio para el jugador usando la semilla y el arreglo de nombres
      player_name := nombres[1 + FLOOR(RANDOM() * 30)];

      -- Generamos un apellido aleatorio para el jugador usando la semilla y el arreglo de apellidos
      player_name := player_name || ' ' || apellidos[1 + FLOOR(RANDOM() * 30)];

      -- Generamos una posición aleatoria para el jugador usando la semilla
      position_id := FLOOR(RANDOM() * 4 + 1);

      -- Insertamos el jugador en la tabla players
      INSERT INTO players (id, player_name, position_id)
      VALUES (id, player_name, position_id);

      -- Incrementamos el valor de id para el siguiente jugador
      id := id + 1;
    END LOOP;

    -- Insertamos los eventos para cada equipo en la tabla events
    FOR i IN 1..50 LOOP
      -- Generamos un game_id aleatorio para el evento
      DECLARE
          game_id INT := FLOOR(RANDOM() * 100 + 1);
      BEGIN
          -- Generamos un player_id aleatorio para el evento
          DECLARE
              player_id INT := FLOOR(RANDOM() * 600 + 1);
          BEGIN
              -- Generamos un event_type aleatorio para el evento
              DECLARE
                  event_type VARCHAR(20) := CASE FLOOR(RANDOM() * 3 + 1)
                      WHEN 1 THEN 'Gol'
                      WHEN 2 THEN 'Asistencia'
                      WHEN 3 THEN 'Tarjeta Amarilla'
                      ELSE 'Tarjeta Roja'
                  END;
              BEGIN
                  -- Generamos un minute_occurrence aleatorio para el evento
                  DECLARE
                      minute_occurrence INT := FLOOR(RANDOM() * 90 + 1);
                  BEGIN
                      -- Insertamos el evento en la tabla events
                      INSERT INTO events (game_id, player_id, event_type, minute_occurrence)
                      VALUES (game_id, player_id, event_type, minute_occurrence);
                  END;
              END;
          END;
      END;
    END LOOP;
  END LOOP;
END $$;
-------------------------------------------------------------------

-- Declaramos una variable para guardar el id del partido
DECLARE id INT := 1;

-- Usamos un bucle FOR para insertar un partido por cada game_date
DO $$
DECLARE
    game_date DATE;
    home_team_id INT;
    away_team_id INT;
    game_time TIME;
    home_goals INT;
    away_goals INT;
    home_yellow_cards INT;
    away_yellow_cards INT;
    home_red_cards INT;
    away_red_cards INT;
BEGIN
FOR game_date IN ('2023-01-01', '2023-01-15', '2023-02-01', '2023-02-15',
               '2023-03-01', '2023-03-15', '2023-04-01', '2023-04-15',
               '2023-05-01', '2023-05-15', '2023-06-01', '2023-06-15') LOOP
  -- Usamos una subconsulta para obtener los equipos que jugaron en esa game_date
  WITH team_data AS (
    -- Obtenemos los equipos que participaron en algún evento en esa game_date
    SELECT DISTINCT e.player_id, j.team_id
    FROM events e
    JOIN players j ON e.player_id = j.id
    WHERE e.game_date = game_date
  )
  SELECT home_team_id, away_team_id INTO home_team_id, away_team_id
  FROM (
    -- Agrupamos los equipos por local y visitante según el orden de los events
    SELECT player_id, team_id
    FROM team_data
    ORDER BY player_id
  ) AS sub
  PIVOT (
    MIN(team_id)
    FOR player_id IN (1 AS home_team_id, 2 AS away_team_id)
  ) AS p;

  -- Usamos una subconsulta para obtener la game_time del primer evento del partido
  SELECT MIN(minute_occurrence) INTO game_time
  FROM events
  WHERE game_date = game_date;

  -- Usamos subconsultas para obtener los Goales y las tarjetas de cada equipo
  SELECT 
    (SELECT COUNT(*) FROM events WHERE event_type = 'Goal' AND player_id IN (SELECT id FROM players WHERE team_id = home_team_id)) INTO home_goals,
    (SELECT COUNT(*) FROM events WHERE event_type = 'Goal' AND player_id IN (SELECT id FROM players WHERE team_id = away_team_id)) INTO away_goals,
    (SELECT COUNT(*) FROM events WHERE event_type = 'Yellow Card' AND player_id IN (SELECT id FROM players WHERE team_id = home_team_id)) INTO home_yellow_cards,
    (SELECT COUNT(*) FROM events WHERE event_type = 'Yellow Card' AND player_id IN (SELECT id FROM players WHERE team_id = away_team_id)) INTO away_yellow_cards,
    (SELECT COUNT(*) FROM events WHERE event_type = 'Red Card' AND player_id IN (SELECT id FROM players WHERE team_id = home_team_id)) INTO home_red_cards,
    (SELECT COUNT(*) FROM events WHERE event_type = 'Red Card' AND player_id IN (SELECT id FROM players WHERE team_id = away_team_id)) INTO away_red_cards;

  -- Insertamos el partido en la tabla games usando los resultados de las subconsultas
  INSERT INTO games (id, game_date, game_time, home_team_id, away_team_id, home_goals, away_goals, home_yellow_cards, away_yellow_cards, home_red_cards, away_red_cards)
  VALUES (id, game_date, game_time, home_team_id, away_team_id, home_goals, away_goals, home_yellow_cards, away_yellow_cards, home_red_cards, away_red_cards);

  -- Incrementamos el id del partido en uno
  id := id + 1;
END LOOP;
END $$;



