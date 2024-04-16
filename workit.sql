/*
Diana Carolina Camejo Mateo
22-SIIT-1-010
*/


-- Creación de la tabla 'areas'
CREATE TABLE areas (
	id INT NOT NULL,
	name VARCHAR(75) NOT NULL,
	description VARCHAR(120) NOT NULL,
	PRIMARY KEY (id)
);

-- Creación de la tabla 'clients'
CREATE TABLE clients (
	id INT NOT NULL,
	name VARCHAR(75) NOT NULL,
	lastname VARCHAR(75) NOT NULL,
	email VARCHAR(75) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY (email)
);
-- Creación de la tabla 'employees'
CREATE TABLE employees (
	id INT NOT NULL,
	name VARCHAR(75) NOT NULL,
	lastname VARCHAR(75) NOT NULL,
	email VARCHAR(75) NOT NULL,
	area_id INT NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY (email),
	FOREIGN KEY (area_id) REFERENCES areas (id) ON UPDATE CASCADE
);

-- Creación de la tabla 'managers'
CREATE TABLE managers (
	id INT NOT NULL,
	name VARCHAR(75) NOT NULL,
	lastname VARCHAR(75) NOT NULL,
	email VARCHAR(75) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY (email)
);

-- Creación de la tabla 'jobs'
CREATE TABLE jobs (
	id INT NOT NULL,
	title VARCHAR(75) NOT NULL,
	description VARCHAR(150) NOT NULL,
	starts_at DATETIME NOT NULL,
	ends_at DATETIME NOT NULL,
	status INT NOT NULL DEFAULT 1,
	client_id INT NOT NULL,
	manager_id INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (client_id) REFERENCES clients (id) ON UPDATE CASCADE,
	FOREIGN KEY (manager_id) REFERENCES managers (id) ON UPDATE CASCADE
);

-- Creación de la tabla 'employee_job'
CREATE TABLE employee_job (
	id INT NOT NULL,
	employee_id INT NOT NULL,
	job_id INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (employee_id) REFERENCES employees (id) ON UPDATE CASCADE,
	FOREIGN KEY (job_id) REFERENCES jobs (id) ON UPDATE CASCADE
);




-- Trigger para la tabla 'jobs'
DELIMITER //
CREATE TRIGGER addJob2 AFTER INSERT ON jobs
FOR EACH ROW
BEGIN
	SET @addDay = FLOOR(1 + RAND() * 4);
	SET @addDay2 = FLOOR(5 + RAND() * 5);
	SET @Date = NOW();
	SET @start = DATE_ADD(@Date, INTERVAL @addDay DAY);
	SET @end = DATE_ADD(@Date, INTERVAL @addDay2 DAY);

	UPDATE jobs SET starts_at = @start, ends_at = @end WHERE id = NEW.id;
END;
//
DELIMITER ;


-- INSERTART DATOS --

-- Inserts para la tabla 'areas'
INSERT INTO areas (id, name, description) VALUES
(1, 'Diseño', 'Diseño gráfico y publicitario'),
(2, 'Copywriting', 'Redacción y edición de textos'),
(3, 'Programación', 'Creación de programas y aplicaciones'),
(4, 'Desarrollo', 'Desarrollo de páginas web'),
(5, 'Maquetación', 'Diseño y planeación de páginas'),
(6, 'Marketing', 'Publicidad y gestión de marca'),
(7, 'Community Manager', 'Gestión y manejo de redes sociales'),
(8, 'Traducción', 'Traducción de textos legales y otros'),
(9, 'Video y fotos', 'Edición de videos y fotos'),
(10, 'Música y Audio', 'Composición y edición de sonido');


-- Inserts para la tabla 'managers'
INSERT INTO managers (id, name, lastname, email) VALUES
(1, 'Josías', 'Amarante', 'amarante@gmail.com'),
(2, 'César', 'Caamaño', 'caamano@gmail.com'),
(3, 'Toribio', 'Palacios', 'palacios@gmail.com'),
(4, 'Nicacia', 'Del Monte', 'delmonte@gmail.com'),
(5, 'Silvio', 'Rodríguez', 'rodriguez@gmail.com'),
(6, 'Nancy', 'Reynoso', 'reynoso@gmail.com'),
(7, 'Carmen', 'Pimentel', 'pimentel@gmail.com'),
(8, 'Camila', 'Santana', 'santana@gmail.com'),
(9, 'Alexandra', 'García', 'garcia@gmail.com'),
(10, 'Keyla', 'Monción', 'moncion@gmail.com');

-- Inserts para la tabla 'clients'
INSERT INTO clients (id, name, lastname, email) VALUES
(1, 'Carlos', 'Santana', 'santana@gmail.com'),
(2, 'Moises', 'Tavarez', 'tavarez@gmail.com'),
(3, 'Clodomiro', 'Nuñez', 'nunez@gmail.com'),
(4, 'Santa', 'Trinidad', 'trinidad@gmail.com'),
(5, 'Lucía', 'Arnaud', 'arnaud@gmail.com'),
(6, 'Cristina', 'Martínez', 'martinez@gmail.com'),
(7, 'Joaquín', 'Sabina', 'sabina@gmail.com'),
(8, 'Pedro', 'Páramo', 'paramo@gmail.com'),
(9, 'Argentina', 'García', 'garcia@gmail.com'),
(10, 'Nicolás', 'Almonte', 'almonte@gmail.com');


-- Inserts para la tabla 'employees'
INSERT INTO employees (id, name, lastname, email, area_id) VALUES
(1, 'Juan Antonio', 'Casas Marchena', 'marchena@gmail.com', 3),
(2, 'Miguel', 'Almonte Castro', 'almonte@gmail.com', 2),
(3, 'Luisa', 'Mejía Salas', 'mejia@gmail.com', 1),
(4, 'Sofía', 'Vergara Vásquez', 'vergara@gmail.com', 4),
(5, 'Aurelina', 'Frías Rosario', 'frias@gmail.com', 7),
(6, 'Nurbi', 'Del Orbe Ruiz', 'delorbe@gmail.com', 5),
(7, 'Esteban', 'De Los Santos Páez', 'delossantos@gmail.com', 9),
(8, 'Moisés', 'Ventura Castro', 'ventura@gmail.com', 8),
(9, 'Loisse', 'Pierre Vaudert', 'pierre@gmail.com', 6),
(10, 'Nicolás', 'Castillo Aponte', 'castillo@gmail.com', 10);

-- Inserts para la tabla 'jobs'
INSERT INTO jobs (id, title, description, starts_at, ends_at, status, client_id, manager_id) VALUES
(1, 'Traducir Acta', 'Traducción de acta de matrimonio', '2021-08-19 09:18:54', '2021-08-25 09:18:54', 1, 8, 1),
(2, 'Diseñar logo', 'Crear logotipo e imagen de marca de startup', '2021-08-19 09:19:39', '2021-08-23 09:19:39', 1, 3, 4),
(3, 'Post para blog', 'Redactar un post para un blog, de 500 palabras', '2021-08-20 09:21:13', '2021-08-26 09:21:13', 1, 2, 3),
(4, 'Página Responsive', 'Desarrollar landpage responsive para abogado', '2021-08-20 09:25:38', '2021-08-25 09:25:38', 1, 1, 2),
(5, '30 Post', 'Publicar 30 post en Facebook e Instagram', '2021-08-20 09:26:21', '2021-08-23 09:26:21', 1, 5, 8),
(6, 'Campaña publicitaria', 'Crear campaña publicitaria para un político', '2021-08-19 09:27:02', '2021-08-23 09:27:02', 1, 9, 6),
(7, 'Video blog', 'Editar 10 videos de un bloguero', '2021-08-20 09:27:33', '2021-08-23 09:27:33', 1, 6, 7),
(8, 'Crear pista', 'Crear pista de audio para rapero', '2021-08-19 09:28:02', '2021-08-26 09:28:02', 1, 4, 5),
(9, 'Maquetar ecommerce', 'Maquetar sitio para una tienda virtual', '2021-08-20 09:28:41', '2021-08-23 09:28:41', 1, 7, 9),
(10, 'Aplicación tipo UBER', 'Crear aplicación para taxistas y motoconchos tipo UBER', '2021-08-22 09:29:53', '2021-08-24 09:29:53', 1, 10, 10);

-- Inserts para la tabla 'employee_job'
INSERT INTO employee_job (id, employee_id, job_id) VALUES
(1, 8, 1),
(2, 3, 2),
(3, 2, 3),
(4, 3, 4),
(5, 4, 4),
(6, 6, 4),
(7, 5, 5),
(8, 5, 6),
(9, 9, 6),
(10, 7, 7),
(11, 10, 8),
(12, 6, 9),
(13, 3, 9),
(14, 1, 10),
(15, 3, 10),
(16, 6, 10);


-- LEER DATOS --


-- Empleados con sus encargos activos y su área --
SELECT 
    e.name AS Nombre, 
    e.email AS Correo, 
    COUNT(j.id) AS Encargos, 
    a.name AS Departamento
FROM 
    employees e
    LEFT JOIN employee_job ej ON ej.employee_id = e.id
    LEFT JOIN jobs j ON j.id = ej.job_id
    LEFT JOIN areas a ON a.id = e.area_id
WHERE j.status=1
GROUP BY 
    e.name, e.email, a.name
ORDER BY COUNT(j.id) DESC;


-- Clientes con sus encargos activos --
SELECT 
    c.name AS Nombre, 
    c.email AS Correo, 
    COUNT(j.id) AS Encargos
FROM 
    clients c
    LEFT JOIN jobs j ON c.id = j.client_id
WHERE j.status=1
GROUP BY 
    c.name, c.email
ORDER BY COUNT(j.id) DESC;


--Gerentes con sus encargos activos --
SELECT 
    m.name AS Nombre, 
    m.email AS Correo, 
    COUNT(j.id) AS Encargos
FROM 
    managers m
    LEFT JOIN jobs j ON m.id = j.manager_id
WHERE j.status=1
GROUP BY 
    m.name, m.email
ORDER BY COUNT(j.id) DESC;

