-- Database: video_club
-- DROP DATABASE IF EXISTS video_club;

-- Creación base de datos
CREATE DATABASE video_club
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'es_AR.UTF-8'
    LC_CTYPE = 'es_AR.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Creación de tablas 
CREATE TABLE socio (
    id_socio SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    domicilio VARCHAR(200) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    actores_fav VARCHAR(200), 	-- Acepta nulos
	directores_fav VARCHAR(200),-- Acepta nulos
	generos_fav VARCHAR(200)	-- Acepta nulos
);	-- Revisada OK

CREATE TABLE genero (
    id_genero SERIAL PRIMARY KEY,
    genero VARCHAR(100) NOT NULL
);	-- Revisada OK

CREATE TABLE director (
    id_director SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);	-- Revisada OK

CREATE TABLE pelicula (
    id_pelicula SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    id_genero INTEGER NOT NULL REFERENCES genero(id_genero),
	id_director INTEGER NOT NULL REFERENCES director(id_director),
	actores VARCHAR(100)	-- Acepta nulos
);	-- Revisada OK

CREATE TABLE cinta (
    id_cinta SERIAL PRIMARY KEY,
    id_pelicula INTEGER NOT NULL REFERENCES pelicula(id_pelicula)
);	-- Revisada OK

CREATE TABLE prestamo (
	id_prestamo SERIAL PRIMARY KEY,
	id_socio INTEGER NOT NULL REFERENCES socio(id_socio),
	id_cinta INTEGER NOT NULL REFERENCES cinta(id_cinta),
	fecha_prestamo DATE NOT NULL,
	fecha_devolucion DATE	-- Acepta nulos. Se ingresa una vez devuelta. Se eligió esta opción para calcular días de demora solicitado por el cliente.
);	-- Revisada OK

CREATE TABLE lista_espera (
    id_espera SERIAL PRIMARY KEY,
    id_pelicula INTEGER NOT NULL REFERENCES pelicula(id_pelicula),
    id_socio INTEGER NOT NULL REFERENCES socio(id_socio),
	fecha_espera DATE NOT NULL	
); 	-- Revisada OK

-- Ingreso de datos en cada tabla, para luego testear el resultado de las querys solicitadas.
INSERT INTO socio (nombre, domicilio, telefono, actores_fav, directores_fav, generos_fav) VALUES
    ('Juan García', 'Avenida de los Robles 123', '555-123-4567', 'Leonardo DiCaprio', 'Steven Spielberg', 'Drama'),
	('María Rodríguez', 'Calle del Sol 456', '555-234-5678', 'Tom Hanks, Julia Roberts', 'Quentin Tarantino', 'Comedia'),
	('Carlos Martínez', 'Paseo de la Luna 789', '555-345-6789', 'Brad Pitt', 'Christopher Nolan', 'Acción'),
	('Ana López', 'Avenida de las Flores 234', '555-456-7890', 'Angelina Jolie, Will Smith, Scarlett Johansson', '', 'Aventura'),
	('Luis Pérez', 'Calle del Río 567', '555-567-8901', 'Denzel Washington', '', ''),
	('Laura González', 'Avenida de los Pájaros 890', '555-678-9012', 'Meryl Streep, Robert De Niro', '', 'Terror'),
	('Javier Sánchez', 'Calle del Bosque 1234', '555-789-0123', 'Johnny Depp', 'Francis Ford Coppola, Christopher Nolan', 'Romance'),
	('Carmen Martín', 'Avenida del Mar 5678', '555-890-1234', 'Jennifer Lawrence, Matt Damon', '', 'Thriller, Animación'),
	('David Hernández', 'Calle de las Estrellas 910', '555-901-2345', '', 'Woody Allen', 'Animación'),
	('Paula Díaz', 'Avenida de la Paz 1112', '555-012-3456', 'Emma Stone, Ryan Gosling, Kate Winslet', 'David Fincher, Christopher Nolan', 'Drama'),
	('Miguel Ruiz', 'Calle del Cielo 1314', '555-123-4567', 'Harrison Ford', '', 'Comedia'),
	('Rosa Fernández', 'Avenida de las Palmeras 1516', '555-234-5678', '', 'Tim Burton', 'Acción'),
	('Alberto Gómez', 'Calle del Viento 1718', '555-345-6789', 'Morgan Freeman', '', ''),
	('Patricia Moreno', 'Avenida de los Almendros 1920', '555-456-7890', 'Anne Hathaway, Hugh Jackman', '', 'Ciencia ficción'),
	('Antonio Jiménez', 'Calle de la Montaña 2122', '555-567-8901', 'Natalie Portman', 'Guillermo del Toro, Woody Allen', 'Terror'),
	('Elena Serrano', 'Avenida del Olivo 2324', '555-678-9012', '', 'Coen Brothers (Joel Coen & Ethan Coen)', 'Romance'),
	('Diego Torres', 'Calle del Campo 2526', '555-789-0123', 'Christian Bale', 'Alejandro González Iñárritu', 'Thriller'),
	('Isabel Ramírez', 'Avenida de las Amapolas 2728', '555-890-1234', 'Nicole Kidman, Brad Pitt', '', ''),
	('Francisco Ruiz', 'Calle del Mariposa 2930', '555-901-2345', 'Liam Neeson', '', 'Drama'),
	('Marta Medina', 'Avenida de los Girasoles 3132', '555-012-3456', 'Julia Roberts, Tom Cruise, Angelina Jolie', 'Steven Spielberg', 'Comedia'),
	('Alejandro Vázquez', 'Calle de la Brisa 3334', '555-123-4567', 'Samuel L. Jackson', 'Quentin Tarantino', 'Acción'),
	('Cristina Castro', 'Avenida de las Rosas 3536', '555-234-5678', 'Kate Winslet, Leonardo DiCaprio', 'Christopher Nolan', 'Aventura, Animación'),
	('Sergio Ortega', 'Calle del Arcoíris 3738', '555-345-6789', 'Scarlett Johansson', 'Alfred Hitchcock', 'Ciencia ficción'),
	('Sonia Morales', 'Avenida de las Piedras 3940', '555-456-7890', 'Mark Wahlberg, Reese Witherspoon', 'Stanley Kubrick', 'Terror'),
	('Jorge Nieto', 'Calle del Colibrí 4142', '555-567-8901', '', '', 'Romance'),
	('Beatriz Navarro', 'Avenida de las Orquídeas 4344', '555-678-9012', 'Charlize Theron, Chris Hemsworth', 'Francis Ford Coppola', 'Thriller'),
	('Víctor Guerrero', 'Calle del Sauce 4546', '555-789-0123', 'Matt Damon', 'Pedro Almodóvar', 'Animación'),
	('Julia Delgado', 'Avenida de las Mariposas 4748', '555-890-1234', 'Jennifer Lawrence, Bradley Cooper', 'Woody Allen', ''),
	('José Santos', 'Calle del Páramo 4950', '555-901-2345', '', 'David Fincher', 'Comedia'),
	('Natalia Iglesias', 'Avenida del Trueno 5152', '555-012-3456', 'Emma Stone, Bradley Cooper, Julia Roberts', 'James Cameron', 'Acción'),
	('Raúl Castro', 'Calle del Lucero 5354', '555-123-4567', 'Tom Cruise', '', 'Aventura'),
	('Andrea Romero', 'Avenida de los Tulipanes 5556', '555-234-5678', 'Angelina Jolie, Johnny Depp', 'Sofia Coppola', 'Ciencia ficción'),
	('Gabriel Molina', 'Calle del Llano 5758', '555-345-6789', 'Dwayne Johnson', '', ''),
	('Laura Herrera', 'Avenida de las Fuentes 5960', '555-456-7890', 'Anne Hathaway, Tom Hanks', 'Guillermo del Toro', 'Romance'),
	('Manuel Arias', 'Calle del Rayo 6162', '555-567-8901', 'Jennifer Aniston', 'Coen Brothers (Joel Coen & Ethan Coen)', 'Thriller'),
	('Martina Bravo', 'Avenida de las Lomas 6364', '555-678-9012', 'Hugh Jackman, Anne Hathaway', 'Alejandro González Iñárritu', 'Animación'),
	('Ramón Álvarez', 'Calle del Ocaso 6566', '555-789-0123', '', 'Wes Anderson', 'Drama'),
	('Lucía Blanco', 'Avenida de los Cerezos 6768', '555-890-1234', 'Gal Gadot, Ryan Reynolds', '', 'Comedia'),
	('Ángel Ramos', 'Calle del Bosquecillo 6970', '555-901-2345', 'Will Smith', 'Steven Spielberg, Quentin Tarantino', 'Acción, Animación'),
	('Eva Muñoz', 'Avenida de las Palmeras 7172', '555-012-3456', 'Scarlett Johansson, Chris Evans, Robert Downey Jr.', 'Quentin Tarantino', ''),
	('Oscar Soto', 'Calle del Valle 7374', '555-123-4567', 'Anne Hathaway', 'Christopher Nolan', 'Ciencia ficción'),
	('Sara Benítez', 'Avenida de las Cascadas 7576', '555-234-5678', 'Brad Pitt, Angelina Jolie', 'Alfred Hitchcock', 'Terror'),
	('Fernando León', 'Calle del Espejo 7778', '555-345-6789', '', '', 'Romance'),
	('Alicia Rivas', 'Avenida de los Álamos 7980', '555-456-7890', 'Reese Witherspoon, Matthew McConaughey', 'Ridley Scott', 'Thriller'),
	('Daniel Moreno', 'Calle del Pinar 8182', '555-567-8901', '', 'Francis Ford Coppola', ''),
	('Laura García', 'Avenida de las Dunas 8384', '555-678-9012', 'Meryl Streep, Morgan Freeman', '', ''),
	('Pedro Jiménez', 'Calle del Bambú 8586', '555-789-0123', '', 'Woody Allen', 'Comedia, Animación'),
	('Marina Flores', 'Avenida de los Robles 8788', '555-890-1234', 'Cate Blanchett, Leonardo DiCaprio', 'David Fincher, Quentin Tarantino', 'Acción'),
	('Javier Medina', 'Calle del Cerezal 8990', '555-901-2345', '', 'James Cameron', ''),
	('Paula González', 'Avenida de la Luna 9192', '555-012-3456', 'Emma Watson, Tom Hanks', 'Tim Burton', 'Ciencia ficción');

INSERT INTO genero (genero) VALUES 
	('Drama'),
	('Comedia'),
	('Acción'),
	('Aventura'),
	('Ciencia ficción'),
	('Terror'),
	('Romance'),
	('Thriller'),
	('Animación');

INSERT INTO director (nombre) VALUES
	('Martin Scorsese'),
	('Steven Spielberg'),
	('Quentin Tarantino'),
	('Christopher Nolan'),
	('Alfred Hitchcock'),
	('Stanley Kubrick'),
	('Ridley Scott'),
	('Francis Ford Coppola'),
	('Pedro Almodóvar'),
	('Woody Allen'),
	('David Fincher'),
	('James Cameron'),
	('Tim Burton'),
	('Sofia Coppola'),
	('Ang Lee'),
	('Guillermo del Toro'),
	('Coen Brothers (Joel Coen & Ethan Coen)'),
	('Alejandro González Iñárritu'),
	('Wes Anderson'),
	('Kathryn Bigelow');

INSERT INTO pelicula (titulo, id_genero, id_director, actores) VALUES
    ('El Padrino', 5, 9, 'Leonardo DiCaprio, Kate Winslet'),
	('Forrest Gump', 4, 10, 'Tom Hanks, Robin Wright'),
	('Pulp Fiction', 8, 11, 'Tim Robbins, Morgan Freeman'),
	('El Señor de los Anillos: La Comunidad del Anillo', 3, 17, 'Marlon Brando, Al Pacino, James Caan'),
	('Titanic', 4, 20, 'Christian Bale, Heath Ledger'),
	('La Lista de Schindler', 8, 13, 'John Travolta, Uma Thurman'),
	('Ciudad de Dios', 7, 5, 'Liam Neeson, Ben Kingsley'),
	('El Rey León', 5, 17, 'Brad Pitt, Edward Norton'),
	('Matrix', 8, 11, 'Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page'),
	('La La Land', 7, 13, 'Keanu Reeves, Laurence Fishburne'),
	('Ciudadano Kane', 1, 20, 'Elijah Wood, Ian McKellen, Viggo Mortensen'),
	('El Gran Dictador', 9, 14, 'Elijah Wood, Ian McKellen, Orlando Bloom'),
	('El Caballero de la Noche', 4, 7, 'Elijah Wood, Ian McKellen, Viggo Mortensen'),
	('Volver al Futuro', 9, 19, 'Sam Neill, Laura Dern, Jeff Goldblum'),
	('Toy Story', 8, 5, 'Tom Hanks, Matt Damon'),
	('El Silencio de los Inocentes', 9, 19, 'Russell Crowe, Joaquin Phoenix'),
	('Intocable', 9, 8, 'Jodie Foster, Anthony Hopkins'),
	('La Vida es Bella', 2, 13, 'Leonardo DiCaprio, Matt Damon, Jack Nicholson'),
	('Los Siete Samuráis', 9, 6, 'Robert De Niro, Ray Liotta, Joe Pesci'),
	('Interstellar', 6, 5, 'Tom Hanks, Michael Clarke Duncan'),
	('La Trilogía de El Padrino', 6, 14, 'Kevin Spacey, Gabriel Byrne, Benicio Del Toro'),
	('La Guerra de las Galaxias: Una Nueva Esperanza', 4, 11, 'Brad Pitt, Morgan Freeman, Kevin Spacey'),
	('Harry Potter y la Piedra Filosofal', 9, 13, 'Liam Neeson, Ralph Fiennes, Ben Kingsley'),
	('E.T., el Extraterrestre', 8, 1, 'Al Pacino, Robert De Niro, Robert Duvall'),
	('Avatar', 9, 15, 'Matthew Broderick, James Earl Jones, Jeremy Irons'),
	('Gladiator', 5, 7, 'Bruce Willis, Haley Joel Osment, Toni Collette'),
	('El Resplandor', 4, 14, 'Mel Gibson, Sophie Marceau'),
	('El Hoyo', 4, 17, 'Jim Carrey, Laura Linney, Ed Harris'),
	('Joker', 3, 17, 'Christian Bale, Hugh Jackman, Scarlett Johansson'),
	('El Exorcista', 5, 8, 'Jack Nicholson, Shelley Duvall, Danny Lloyd'),
	('Amélie', 7, 5, 'Jesse Eisenberg, Andrew Garfield, Justin Timberlake'),
	('El Laberinto del Fauno', 8, 10, 'Leonardo DiCaprio, Kate Winslet, Billy Zane'),
	('El Club de la Pelea', 1, 14, 'Brad Pitt, Christoph Waltz, Mélanie Laurent'),
	('El Rey León (2019)', 1, 2, 'Arnold Schwarzenegger, Linda Hamilton, Michael Biehn'),
	('El Viaje de Chihiro', 8, 9, 'Al Pacino, Andy García, Diane Keaton'),
	('Whiplash', 3, 5, 'Tom Hanks, Tim Allen, Annie Potts'),
	('El Sexto Sentido', 5, 17, 'Judy Garland, Frank Morgan, Ray Bolger'),
	('V de Vendetta', 6, 3, 'Robert Downey Jr., Chris Evans, Scarlett Johansson'),
	('El Planeta de los Simios', 1, 9, 'Matthew McConaughey, Anne Hathaway, Jessica Chastain'),
	('La Sirenita', 3, 10, 'Jamie Foxx, Christoph Waltz, Leonardo DiCaprio'),
	('El Señor de los Anillos: El Retorno del Rey', 5, 1, 'Michael J. Fox, Christopher Lloyd, Lea Thompson'),
	('Mulán', 3, 15, 'Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss'),
	('Matrix Reloaded', 9, 19, 'Clark Gable, Vivien Leigh, Thomas Mitchell'),
	('Kill Bill: Volumen 1', 6, 1, 'Kelly Macdonald, Billy Connolly, Emma Thompson'),
	('Toy Story 3', 7, 2, 'Julie Andrews, Christopher Plummer, Eleanor Parker'),
	('El Golpe', 4, 2, 'Donald Glover, Beyoncé, Chiwetel Ejiofor'),
	('El Último Samurai', 4, 12, 'Christian Bale, Tom Hardy, Anne Hathaway'),
	('La Máscara del Zorro', 5, 12, 'Marlon Brando, Al Pacino, James Caan'),
	('El Rey Arturo', 6, 11, 'Mark Hamill, Harrison Ford, Carrie Fisher'),
	('Cisne Negro', 5, 7, 'Daniel Radcliffe, Rupert Grint, Emma Watson'),
	('Blade Runner', 5, 13, 'Al Pacino, Robert De Niro, Robert Duvall'),
	('El Show de Truman', 8, 4, 'Elijah Wood, Ian McKellen, Viggo Mortensen'),
	('Gran Torino', 7, 10, 'Al Pacino, Andy García, Diane Keaton'),
	('Los Vengadores', 1, 17, 'Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss'),
	('Up', 7, 17, 'Tim Robbins, Morgan Freeman'),
	('El Club de los Poetas Muertos', 8, 14, 'Leonardo DiCaprio, Kate Winslet, Billy Zane'),
	('El Irlandés', 7, 10, 'Liam Neeson, Ben Kingsley, Ralph Fiennes'),
	('La Naranja Mecánica', 4, 20, 'John Travolta, Uma Thurman, Samuel L. Jackson'),
	('Misión Imposible', 7, 11, 'Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page'),
	('El Lobo de Wall Street', 4, 5, 'Elijah Wood, Ian McKellen, Orlando Bloom'),
	('La Pasión de Cristo', 6, 8, 'Christian Bale, Heath Ledger, Aaron Eckhart'),
	('El Gran Hotel Budapest', 8, 7, 'Brad Pitt, Edward Norton, Helena Bonham Carter'),
	('El Show de los Muppets', 8, 13, 'Tom Hanks, Robin Wright, Gary Sinise'),
	('El Gladiador', 1, 13, 'Elijah Wood, Ian McKellen, Viggo Mortensen'),
	('Oceans Eleven', 6, 5, 'Tom Hanks, Michael Clarke Duncan, David Morse'),
	('El Joven Manos de Tijera', 6, 12, 'Jodie Foster, Anthony Hopkins, Scott Glenn'),
	('El Origen', 1, 6, 'Leonardo DiCaprio, Matt Damon, Jack Nicholson'),
	('La Cenicienta', 3, 10, 'Kevin Spacey, Gabriel Byrne, Benicio Del Toro'),
	('Río', 9, 12, 'Brad Pitt, Morgan Freeman, Kevin Spacey'),
	('Buscando a Nemo', 4, 6, 'Liam Neeson, Ralph Fiennes, Ben Kingsley'),
	('La Bella y la Bestia', 4, 3, 'Leonardo DiCaprio, Kate Winslet'),
	('Duro de Matar', 3, 16, 'Tom Hanks, Robin Wright'),
	('La Historia Sin Fin', 6, 12, 'Tim Robbins, Morgan Freeman'),
	('Piratas del Caribe: La Maldición del Perla Negra', 4, 8, 'Marlon Brando, Al Pacino, James Caan'),
	('La Isla Siniestra', 8, 4, 'Christian Bale, Heath Ledger'),
	('La Milla Verde', 2, 12, 'John Travolta, Uma Thurman'),
	('La Princesa Mononoke', 1, 19, 'Liam Neeson, Ben Kingsley'),
	('El Ilusionista', 5, 18, 'Brad Pitt, Edward Norton'),
	('El Patriota', 2, 9, 'Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page'),
	('Los Infiltrados', 5, 3, 'Keanu Reeves, Laurence Fishburne'),
	('La Dama y el Vagabundo', 1, 6, 'Elijah Wood, Ian McKellen, Viggo Mortensen'),
	('La Momia', 8, 14, 'Elijah Wood, Ian McKellen, Orlando Bloom'),
	('El Príncipe de Persia', 3, 6, 'Elijah Wood, Ian McKellen, Viggo Mortensen'),
	('La Terminal', 4, 2, 'Sam Neill, Laura Dern, Jeff Goldblum'),
	('El Sorprendente Hombre Araña', 3, 13, 'Tom Hanks, Matt Damon'),
	('El Bueno, el Malo y el Feo', 6, 13, 'Russell Crowe, Joaquin Phoenix'),
	('La Cabaña en el Bosque', 6, 8, 'Jodie Foster, Anthony Hopkins'),
	('El Llanero Solitario', 5, 3, 'Leonardo DiCaprio, Matt Damon, Jack Nicholson'),
	('La Roca', 6, 19, 'Robert De Niro, Ray Liotta, Joe Pesci'),
	('El Hombre Araña', 8, 11, 'Tom Hanks, Michael Clarke Duncan'),
	('La Guerra de los Mundos', 5, 15, 'Kevin Spacey, Gabriel Byrne, Benicio Del Toro'),
	('El Juego de Ender', 6, 8, 'Brad Pitt, Morgan Freeman, Kevin Spacey'),
	('La Joven de la Perla', 8, 17, 'Liam Neeson, Ralph Fiennes, Ben Kingsley'),
	('El Diario de la Princesa', 4, 19, 'Al Pacino, Robert De Niro, Robert Duvall'),
	('El Día Después de Mañana', 1, 12, 'Matthew Broderick, James Earl Jones, Jeremy Irons'),
	('El Cisne Negro', 9, 15, 'Bruce Willis, Haley Joel Osment, Toni Collette'),
	('La Dama de Honor', 3, 4, 'Mel Gibson, Sophie Marceau'),
	('La Llamada', 9, 14, 'Jim Carrey, Laura Linney, Ed Harris'),
	('La Joven del Agua', 3, 1, 'Christian Bale, Hugh Jackman, Scarlett Johansson'),
	('El Gran Lebowski', 1, 19, 'Bruce Willis, Haley Joel Osment, Toni Collette');
	
-- Insertar cintas para cada película
INSERT INTO cinta (id_pelicula) VALUES
	(53), (15), (99), (66), (21), (68), (81), (100), (54), (40), (85), (88), (26),
	(2), (96), (61), (63), (31), (31), (56), (90), (58), (67), (30), (90), (68),
	(44), (10), (14), (74), (20), (28), (11), (83), (68), (49), (1), (87), (17),
	(96),(43), (35), (19), (93), (79), (17), (96), (20), (23), (17), (11), (75),
	(10), (12), (53), (23), (67), (42), (90), (21), (95), (55), (61), (67), (90),
	(58), (65), (29), (30), (68), (52), (11), (88), (95), (17), (56), (85), (58),
	(34), (13),  (42), (57), (9), (67), (10), (78), (3), (92), (80), (84), (33),
	(7), (82), (20), (71), (67), (95), (73), (70), (9), (50), (48), (32), (49),
	(38), (22), (53), (32), (52), (40), (19), (53), (6), (27), (44), (4), (93),
	(3), (44), (53), (98), (73), (77), (18), (25), (71), (8), (98), (18), (70),
	(26), (90), (56), (8), (27), (66), (46), (37), (4), (92), (85), (75), (24),
	(16), (4), (39), (89), (14), (41), (25), (63), (68), (81), (27), (39), (13),
	(66), (43), (35), (31), (5), (28), (59), (60), (81), (52), (21), (43), (70),
	(98), (7), (93), (10), (25), (96), (100), (65), (32), (56),	(26), (67), (8),
	(44), (90), (46), (77), (66), (94), (25), (20), (97), (64), (58), (22), (20),
	(10), (12), (95), (19);

-- Insertar préstamos
INSERT INTO prestamo (id_socio, id_cinta, fecha_prestamo, fecha_devolucion) VALUES
	(20, 186, '2022-01-01', '2022-01-04'),
	(16, 110, '2022-01-05', '2022-01-09'),
	(37, 82, '2022-01-07', '2022-01-10'),
	(4, 198, '2022-01-08', '2022-01-13'),
	(18, 106, '2022-01-12', '2022-01-15'),
	(24, 49, '2022-01-18', '2022-01-22'),
	(45, 62, '2022-01-19', '2022-01-22'),
	(36, 183, '2022-01-19', '2022-01-24'),
	(8, 52, '2022-01-20', '2022-01-23'),
	(50, 32, '2022-01-22', '2022-01-26'),
	(7, 180, '2022-01-26', '2022-01-29'),
	(15, 34, '2022-02-02', '2022-02-07'),
	(21, 2, '2022-02-04', '2022-02-07'),
	(18, 90, '2022-02-04', '2022-02-08'),
	(34, 65, '2022-02-05', '2022-02-08'),
	(14, 104, '2022-02-06', '2022-02-11'),
	(31, 71, '2022-02-07', '2022-02-10'),
	(35, 149, '2022-02-07', '2022-02-11'),
	(17, 6, '2022-02-09', '2022-02-12'),
	(33, 15, '2022-02-10', '2022-02-15'),
	(21, 110, '2022-02-14', '2022-02-17'),
	(23, 194, '2022-02-14', '2022-02-18'),
	(49, 103, '2022-02-25', '2022-02-28'),
	(28, 127, '2022-02-26', '2022-03-03'),
	(48, 146, '2022-02-28', '2022-03-03'),
	(14, 15, '2022-02-28', '2022-03-04'),
	(44, 40, '2022-03-01', '2022-03-04'),
	(24, 196, '2022-03-04', '2022-03-09'),
	(35, 172, '2022-03-04', '2022-03-07'),
	(28, 170, '2022-03-04', '2022-03-08'),
	(44, 89, '2022-03-06', '2022-03-09'),
	(24, 77, '2022-03-06', '2022-03-11'),
	(30, 118, '2022-03-09', '2022-03-12'),
	(36, 115, '2022-03-11', '2022-03-15'),
	(3, 166, '2022-03-11', '2022-03-14'),
	(36, 81, '2022-03-14', '2022-03-19'),
	(34, 103, '2022-03-21', '2022-03-24'),
	(26, 110, '2022-03-24', '2022-03-28'),
	(4, 122, '2022-04-01', '2022-04-04'),
	(17, 135, '2022-04-03', '2022-04-08'),
	(15, 141, '2022-04-03', '2022-04-06'),
	(35, 101, '2022-04-06', '2022-04-10'),
	(31, 27, '2022-04-08', '2022-04-11'),
	(39, 1, '2022-04-11', '2022-04-16'),
	(6, 47, '2022-04-14', '2022-04-17'),
	(26, 21, '2022-04-14', '2022-04-18'),
	(39, 122, '2022-04-15', '2022-04-18'),
	(31, 194, '2022-04-16', '2022-04-21'),
	(20, 69, '2022-04-20', '2022-04-23'),
	(39, 136, '2022-04-22', '2022-04-26'),
	(18, 115, '2022-04-23', '2022-04-26'),
	(14, 195, '2022-04-24', '2022-04-29'),
	(50, 62, '2022-04-27', '2022-04-30'),
	(1, 169, '2022-05-02', '2022-05-06'),
	(16, 190, '2022-05-04', '2022-05-07'),
	(45, 80, '2022-05-06', '2022-05-11'),
	(16, 113, '2022-05-12', '2022-05-15'),
	(13, 72, '2022-05-13', '2022-05-17'),
	(42, 4, '2022-05-16', '2022-05-19'),
	(35, 83, '2022-05-16', '2022-05-21'),
	(8, 131, '2022-05-20', '2022-05-23'),
	(6, 80, '2022-05-20', '2022-05-24'),
	(30, 110, '2022-05-22', '2022-05-25'),
	(2, 5, '2022-05-25', '2022-05-30'),
	(47, 100, '2022-05-26', '2022-05-29'),
	(26, 11, '2022-05-28', '2022-06-01'),
	(14, 130, '2022-06-04', '2022-06-07'),
	(16, 87, '2022-06-06', '2022-06-11'),
	(47, 52, '2022-06-07', '2022-06-10'),
	(47, 155, '2022-06-08', '2022-06-12'),
	(46, 25, '2022-06-12', '2022-06-15'),
	(37, 41, '2022-06-13', '2022-06-18'),
	(37, 82, '2022-06-17', '2022-06-20'),
	(30, 39, '2022-06-18', '2022-06-22'),
	(11, 11, '2022-06-18', '2022-06-21'),
	(18, 54, '2022-06-19', '2022-06-24'),
	(30, 190, '2022-06-26', '2022-06-29'),
	(2, 141, '2022-06-26', '2022-06-30'),
	(26, 38, '2022-07-04', '2022-07-07'),
	(22, 29, '2022-07-05', '2022-07-10'),
	(37, 148, '2022-07-06', '2022-07-09'),
	(7, 197, '2022-07-10', '2022-07-14'),
	(37, 40, '2022-07-11', '2022-07-14'),
	(35, 93, '2022-07-11', '2022-07-16'),
	(46, 145, '2022-07-14', '2022-07-17'),
	(1, 123, '2022-07-15', '2022-07-19'),
	(43, 45, '2022-07-25', '2022-07-28'),
	(37, 39, '2022-07-26', '2022-07-31'),
	(6, 75, '2022-08-03', '2022-08-06'),
	(45, 176, '2022-08-05', '2022-08-09'),
	(10, 33, '2022-08-06', '2022-08-09'),
	(35, 178, '2022-08-06', '2022-08-11'),
	(27, 27, '2022-08-08', '2022-08-11'),
	(48, 163, '2022-08-10', '2022-08-14'),
	(42, 49, '2022-08-11', '2022-08-14'),
	(47, 99, '2022-08-16', '2022-08-21'),
	(45, 153, '2022-08-17', '2022-08-20'),
	(41, 101, '2022-08-20', '2022-08-24'),
	(38, 160, '2022-08-24', '2022-08-27'),
	(16, 61, '2022-08-27', '2022-09-01'),
	(50, 77, '2022-09-02', '2022-09-05'),
	(9, 173, '2022-09-04', '2022-09-08'),
	(14, 186, '2022-09-04', '2022-09-07'),
	(23, 194, '2022-09-08', '2022-09-13'),
	(39, 162, '2022-09-10', '2022-09-13'),
	(48, 190, '2022-09-10', '2022-09-14'),
	(4, 144, '2022-09-11', '2022-09-14'),
	(10, 109, '2022-09-14', '2022-09-19'),
	(17, 44, '2022-09-17', '2022-09-20'),
	(20, 35, '2022-09-18', '2022-09-22'),
	(9, 176, '2022-09-18', '2022-09-21'),
	(19, 169, '2022-09-18', '2022-09-23'),
	(7, 101, '2022-09-18', '2022-09-21'),
	(41, 156, '2022-09-19', '2022-09-23'),
	(14, 62, '2022-09-19', '2022-09-22'),
	(1, 144, '2022-09-22', '2022-09-27'),
	(32, 142, '2022-09-26', '2022-09-29'),
	(32, 46, '2022-09-27', '2022-10-01'),
	(42, 168, '2022-09-27', '2022-09-30'),
	(45, 18, '2022-10-05', '2022-10-10'),
	(39, 153, '2022-10-05', '2022-10-08'),
	(11, 35, '2022-10-07', '2022-10-11'),
	(31, 122, '2022-10-07', '2022-10-10'),
	(17, 175, '2022-10-07', '2022-10-12'),
	(14, 98, '2022-10-09', '2022-10-12'),
	(9, 24, '2022-10-09', '2022-10-13'),
	(38, 164, '2022-10-11', '2022-10-14'),
	(43, 110, '2022-10-12', '2022-10-17'),
	(6, 1, '2022-10-14', '2022-10-17'),
	(22, 199, '2022-10-14', '2022-10-18'),
	(40, 64, '2022-10-14', '2022-10-17'),
	(44, 9, '2022-10-16', '2022-10-21'),
	(1, 29, '2022-10-20', '2022-10-23'),
	(11, 37, '2022-10-20', '2022-10-24'),
	(46, 104, '2022-10-20', '2022-10-23'),
	(31, 133, '2022-10-21', '2022-10-26'),
	(31, 57, '2022-10-21', '2022-10-24'),
	(6, 170, '2022-11-06', '2022-11-10'),
	(44, 43, '2022-11-08', '2022-11-11'),
	(27, 132, '2022-11-11', '2022-11-16'),
	(44, 139, '2022-11-16', '2022-11-19'),
	(31, 186, '2022-11-17', '2022-11-21'),
	(42, 98, '2022-11-17', '2022-11-20'),
	(32, 189, '2022-11-18', '2022-11-23'),
	(40, 50, '2022-11-21', '2022-11-24'),
	(35, 43, '2022-11-21', '2022-11-25'),
	(34, 150, '2022-11-24', '2022-11-27'),
	(6, 149, '2022-11-25', '2022-11-30'),
	(21, 92, '2022-12-04', '2022-12-07'),
	(15, 130, '2022-12-06', '2022-12-10'),
	(26, 170, '2022-12-11', '2022-12-14'),
	(37, 139, '2022-12-14', '2022-12-19'),
	(10, 199, '2022-12-15', '2022-12-18'),
	(1, 72, '2022-12-18', '2022-12-22'),
	(47, 145, '2022-12-21', '2022-12-24'),
	(47, 66, '2022-12-23', '2022-12-28'),
	(23, 139, '2022-12-26', '2022-12-29'),
	(24, 49, '2022-12-26', '2022-12-30'),
	(7, 132, '2023-01-01', '2023-01-04'),
	(4, 130, '2023-01-04', '2023-01-09'),
	(2, 138, '2023-01-07', '2023-01-10'),
	(6, 133, '2023-01-08', '2023-01-12'),
	(7, 17, '2023-01-13', '2023-01-16'),
	(24, 6, '2023-01-18', '2023-01-23'),
	(1, 162, '2023-01-25', '2023-01-28'),
	(47, 55, '2023-01-26', '2023-01-30'),
	(12, 19, '2023-02-01', '2023-02-04'),
	(49, 93, '2023-02-07', '2023-02-12'),
	(22, 117, '2023-02-08', '2023-02-11'),
	(44, 77, '2023-02-08', '2023-02-12'),
	(33, 82, '2023-02-13', '2023-02-16'),
	(25, 153, '2023-02-20', '2023-02-25'),
	(10, 13, '2023-02-21', '2023-02-24'),
	(25, 57, '2023-02-22', '2023-02-26'),
	(28, 21, '2023-02-26', '2023-03-01'),
	(9, 52, '2023-02-28', '2023-03-05'),
	(17, 143, '2023-02-28', '2023-03-03'),
	(42, 19, '2023-03-04', '2023-03-08'),
	(3, 135, '2023-03-04', '2023-03-07'),
	(6, 197, '2023-03-05', '2023-03-10'),
	(44, 197, '2023-03-08', '2023-03-11'),
	(45, 154, '2023-03-12', '2023-03-16'),
	(44, 47, '2023-03-12', '2023-03-15'),
	(28, 131, '2023-03-14', '2023-03-19'),
	(48, 98, '2023-03-14', '2023-03-17'),
	(12, 77, '2023-03-14', '2023-03-18'),
	(15, 34, '2023-03-16', '2023-03-19'),
	(3, 185, '2023-03-20', '2023-03-25'),
	(2, 16, '2023-03-24', '2023-03-27'),
	(35, 100, '2023-04-02', '2023-04-06'),
	(36, 143, '2023-04-06', '2023-04-09'),
	(44, 195, '2023-04-07', '2023-04-12'),
	(38, 156, '2023-04-08', '2023-04-11'),
	(4, 95, '2023-04-10', '2023-04-14'),
	(24, 156, '2023-04-11', '2023-04-14'),
	(43, 152, '2023-04-13', '2023-04-18'),
	(19, 66, '2023-04-14', '2023-04-17'),
	(26, 185, '2023-04-15', '2023-04-19'),
	(8, 12, '2023-04-15', '2023-04-18'),
	(20, 123, '2023-04-20', '2023-04-25'),
	(31, 99, '2023-04-22', '2023-04-25'),
	(49, 158, '2023-04-27', '2023-05-01'),
	(10, 11, '2023-04-28', '2023-05-01'),
	(41, 137, '2023-05-03', '2023-05-08'),
	(25, 146, '2023-05-04', '2023-05-07'),
	(13, 199, '2023-05-05', '2023-05-09'),
	(45, 141, '2023-05-05', '2023-05-08'),
	(10, 130, '2023-05-06', '2023-05-11'),
	(44, 106, '2023-05-07', '2023-05-10'),
	(50, 157, '2023-05-07', '2023-05-11'),
	(36, 127, '2023-05-11', '2023-05-14'),
	(49, 52, '2023-05-12', '2023-05-17'),
	(34, 174, '2023-05-23', '2023-05-26'),
	(30, 122, '2023-05-25', '2023-05-29'),
	(43, 105, '2023-05-26', '2023-05-29'),
	(48, 58, '2023-05-28', '2023-06-02'),
	(48, 123, '2023-06-02', '2023-06-05'),
	(31, 87, '2023-06-03', '2023-06-07'),
	(21, 19, '2023-06-03', '2023-06-06'),
	(26, 107, '2023-06-04', '2023-06-09'),
	(2, 25, '2023-06-05', '2023-06-08'),
	(17, 69, '2023-06-06', '2023-06-10'),
	(40, 44, '2023-06-10', '2023-06-13'),
	(4, 138, '2023-06-10', '2023-06-15'),
	(7, 111, '2023-06-13', '2023-06-16'),
	(34, 46, '2023-06-13', '2023-06-17'),
	(22, 38, '2023-06-16', '2023-06-19'),
	(4, 179, '2023-06-23', '2023-06-28'),
	(41, 33, '2023-06-25', '2023-06-28'),
	(13, 94, '2023-06-28', '2023-07-02'),
	(17, 165, '2023-07-02', '2023-07-05'),
	(24, 53, '2023-07-09', '2023-07-14'),
	(26, 151, '2023-07-10', '2023-07-13'),
	(48, 130, '2023-07-14', '2023-07-18'),
	(18, 13, '2023-07-14', '2023-07-17'),
	(9, 103, '2023-07-20', '2023-07-25'),
	(44, 160, '2023-07-20', '2023-07-23'),
	(15, 41, '2023-07-21', '2023-07-25'),
	(33, 3, '2023-07-24', '2023-07-27'),
	(43, 88, '2023-07-28', '2023-08-02'),
	(7, 30, '2023-08-02', '2023-08-05'),
	(30, 74, '2023-08-09', '2023-08-13'),
	(8, 197, '2023-08-12', '2023-08-15'),
	(34, 177, '2023-08-16', '2023-08-21'),
	(34, 54, '2023-08-16', '2023-08-19'),
	(31, 139, '2023-08-17', '2023-08-21'),
	(21, 152, '2023-08-20', '2023-08-23'),
	(38, 111, '2023-08-20', '2023-08-25'),
	(10, 152, '2023-08-23', '2023-08-26'),
	(33, 134, '2023-09-03', '2023-09-07'),
	(12, 115, '2023-09-11', '2023-09-14'),
	(34, 188, '2023-09-12', '2023-09-17'),
	(17, 114, '2023-09-13', '2023-09-16'),
	(37, 69, '2023-09-14', '2023-09-18'),
	(10, 126, '2023-09-16', '2023-09-19'),
	(42, 82, '2023-09-16', '2023-09-21'),
	(12, 140, '2023-09-16', '2023-09-19'),
	(19, 171, '2023-09-20', '2023-09-24'),
	(37, 128, '2023-09-21', '2023-09-24'),
	(44, 108, '2023-09-22', '2023-09-27'),
	(30, 94, '2023-09-24', '2023-09-27'),
	(41, 66, '2023-09-28', '2023-10-02'),
	(27, 164, '2023-10-02', '2023-10-05'),
	(23, 96, '2023-10-03', '2023-10-08'),
	(16, 44, '2023-10-05', '2023-10-08'),
	(3, 137, '2023-10-14', '2023-10-18'),
	(40, 17, '2023-10-14', '2023-10-17'),
	(31, 90, '2023-10-15', '2023-10-20'),
	(42, 45, '2023-10-16', '2023-10-19'),
	(15, 93, '2023-10-18', '2023-10-22'),
	(44, 110, '2023-10-21', '2023-10-24'),
	(9, 197, '2023-11-05', '2023-11-10'),
	(7, 19, '2023-11-05', '2023-11-08'),
	(38, 1, '2023-11-06', '2023-11-10'),
	(18, 96, '2023-11-09', '2023-11-12'),
	(33, 25, '2023-11-11', '2023-11-16'),
	(4, 34, '2023-11-18', NULL),
	(19, 155, '2023-11-18', NULL),
	(15, 116, '2023-11-21', '2023-11-26'),
	(46, 48, '2023-11-21', '2023-11-26'),
	(42, 121, '2023-11-23', '2023-11-28'),
	(39, 33, '2023-11-24', NULL),
	(33, 55, '2023-11-24', NULL),
	(7, 158, '2023-11-28', '2023-12-03'),
	(14, 143, '2023-11-28', NULL),
	(3, 82, '2023-12-02', NULL),
	(9, 175, '2023-12-02', NULL),
	(45, 195, '2023-12-03', NULL),
	(45, 141, '2023-12-06', '2023-12-09'),
	(1, 184, '2023-12-06', '2023-12-11'),
	(24, 155, '2023-12-06', '2023-12-09'),
	(16, 151, '2023-12-07', '2023-12-11'),
	(42, 91, '2023-12-09', NULL),
	(14, 160, '2023-12-12', NULL),
	(17, 153, '2023-12-13', '2023-12-16'),
	(19, 123, '2023-12-15', '2023-12-20'),
	(12, 52, '2023-12-17', '2023-12-20'),
	(34, 173, '2023-12-17', '2023-12-21'),
	(47, 59, '2023-12-18', NULL);


-- Insertar lista de espera
INSERT INTO lista_espera (id_pelicula, id_socio, fecha_espera) VALUES
    (74, 2, '2023-12-03'),
	(26, 19, '2023-12-06'),
	(79, 33, '2023-12-06'),
	(81, 24, '2023-12-06'),
	(53, 23, '2023-12-07'),
	(46, 8, '2023-12-09'),
	(26, 14, '2023-12-12'),
	(6, 19, '2023-12-13'),
	(98, 24, '2023-12-15'),
	(46, 11, '2023-12-17'),
	(54, 1, '2023-12-17'),
	(3, 10, '2023-12-18'),
	(96, 13, '2023-12-06'),
	(68, 41, '2023-12-06');


-- Consultas 
--		a. Ranking de películas más alquiladas.
SELECT p.id_pelicula, p.titulo, COUNT(pr.id_prestamo) AS num_alquileres
FROM pelicula p
INNER JOIN cinta c ON p.id_pelicula = c.id_pelicula
INNER JOIN prestamo pr ON c.id_cinta = pr.id_cinta
GROUP BY p.id_pelicula
ORDER BY num_alquileres DESC
LIMIT 10;	-- Revisada OK

--		b. Ranking de clientes que más películas alquilan.
SELECT s.id_socio, s.nombre, COUNT(pr.id_prestamo) AS num_alquileres
FROM socio s
INNER JOIN prestamo pr ON s.id_socio = pr.id_socio
GROUP BY s.id_socio
ORDER BY num_alquileres DESC
LIMIT 10;

--		c. Listado de películas que están en lista de espera y los datos de los socios que las pidieron.
SELECT le.fecha_espera, le.id_pelicula, p.titulo, le.id_socio, s.nombre, s.telefono, (CURRENT_DATE - le.fecha_espera) AS dias_espera
FROM lista_espera le
INNER JOIN pelicula p ON le.id_pelicula = p.id_pelicula
INNER JOIN socio s ON le.id_socio = s.id_socio
ORDER BY dias_espera DESC;	
-- dias_espera no fue solicitado, pero me pareció una buena opción agregarlo y ordenar el listado por este dato.

-- 		d. Clientes que no alquilaron ninguna película los últimos 90 días.
SELECT s.id_socio, s.nombre
FROM socio s
WHERE s.id_socio NOT IN (
	SELECT DISTINCT pr.id_socio
	FROM prestamo pr
	WHERE pr.fecha_prestamo >= CURRENT_DATE - INTERVAL '90 days'
	);

--		e. Mostrar un listado de cantidad de alquileres por día de semana y género.
SELECT to_char(pr.fecha_prestamo, 'Day') AS dia_semana, g.genero, COUNT(pr.id_prestamo) AS num_alquileres
FROM prestamo pr
INNER JOIN cinta c ON pr.id_cinta = c.id_cinta
INNER JOIN pelicula p ON c.id_pelicula = p.id_pelicula
INNER JOIN genero g ON p.id_genero = g.id_genero
GROUP BY dia_semana, g.genero
ORDER BY dia_semana, g.genero;

--		f. Mostrar un listado de clientes que tienen películas sin devolver y clasificar en
-- 	  	   prioridad “baja” (retraso 3 días o menos), “media” (retraso entre 3 y 6 días), “alta” (retraso más de 6 días).
SELECT pr.id_socio, s.nombre, s.domicilio, s.telefono, (CURRENT_DATE - pr.fecha_prestamo) AS dias_retraso,
	CASE WHEN (CURRENT_DATE - pr.fecha_prestamo) <= 3 THEN 'Baja'
		 WHEN (CURRENT_DATE - pr.fecha_prestamo) <= 6 THEN 'Media'
		 WHEN (CURRENT_DATE - pr.fecha_prestamo) > 6 THEN 'Alta'
	END AS prioridad
FROM prestamo pr
INNER JOIN socio s ON pr.id_socio = s.id_socio
WHERE fecha_devolucion IS NULL;
