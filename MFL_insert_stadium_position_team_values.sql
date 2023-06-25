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

INSERT INTO positions (position_name)
VALUES 
    ('Goalkeeper'),
    ('Defender'),
    ('Midfielder'),
    ('Forward');
