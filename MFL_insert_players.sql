DO $$
DECLARE
  id INT := 1;
  team_id INT;
  player_name VARCHAR(50);
  position_id INT;
  player_count INT;
  goalkeepers_count INT := 0;
  defenders_count INT := 0;
  midfielders_count INT := 0;
  forwards_count INT := 0;
BEGIN
  -- Generamos jugadores para cada equipo
  FOR team_id IN 1..20 LOOP
    -- Generamos una cantidad aleatoria de jugadores para cada equipo entre 23 y 30
    player_count := FLOOR(RANDOM() * 8 + 23);

    -- Insertamos jugadores hasta alcanzar la cantidad deseada
    WHILE player_count > 0 LOOP
      -- Generamos un nombre aleatorio para el jugador
      player_name := 'Marciano ' || id;

      -- Generamos una posición aleatoria para el jugador
      position_id := FLOOR(RANDOM() * 4 + 1);

      -- Verificamos la posición del jugador y actualizamos los contadores correspondientes
      CASE position_id
        WHEN 1 THEN goalkeepers_count := goalkeepers_count + 1;
        WHEN 2 THEN defenders_count := defenders_count + 1;
        WHEN 3 THEN midfielders_count := midfielders_count + 1;
        WHEN 4 THEN forwards_count := forwards_count + 1;
      END CASE;

      -- Insertamos el jugador en la tabla players
      INSERT INTO players (id, player_name, team_id, position_id)
      VALUES (id, player_name, team_id, position_id);

      -- Incrementamos el valor de id para el siguiente jugador
      id := id + 1;
      player_count := player_count - 1;
    END LOOP;

    -- Completamos las posiciones faltantes con jugadores adicionales
    WHILE goalkeepers_count < 2 LOOP
      -- Generamos un nuevo jugador arquero y lo insertamos en la tabla players
      player_name := 'Nuevo Arquero ' || id;
      position_id := 1;
      INSERT INTO players (id, player_name, team_id, position_id)
      VALUES (id, player_name, team_id, position_id);
      
      goalkeepers_count := goalkeepers_count + 1;
      id := id + 1;
    END LOOP;

    WHILE defenders_count < 8 LOOP
      -- Generamos un nuevo jugador defensor y lo insertamos en la tabla players
      player_name := 'Nuevo Defensor ' || id;
      position_id := 2;
      INSERT INTO players (id, player_name, team_id, position_id)
      VALUES (id, player_name, team_id, position_id);

      defenders_count := defenders_count + 1;
      id := id + 1;
    END LOOP;

    WHILE midfielders_count < 8 LOOP
      -- Generamos un nuevo jugador mediocampista y lo insertamos en la tabla players
      player_name := 'Nuevo Mediocampista ' || id;
      position_id := 3;
      INSERT INTO players (id, player_name, team_id, position_id)
      VALUES (id, player_name, team_id, position_id);

      midfielders_count := midfielders_count + 1;
      id := id + 1;
    END LOOP;

    WHILE forwards_count < 4 LOOP
      -- Generamos un nuevo jugador delantero y lo insertamos en la tabla players
      player_name := 'Nuevo Delantero ' || id;
      position_id := 4;
      INSERT INTO players (id, player_name, team_id, position_id)
      VALUES (id, player_name, team_id, position_id);

      forwards_count := forwards_count + 1;
      id := id + 1;
    END LOOP;
  END LOOP;
END $$;
