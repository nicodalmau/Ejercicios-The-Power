/* ================================
Ejercicio 2 - SQL (PostgreSQL)
================================ */

/* ===== Nivel Fácil ===== */

/* 1. Crear tabla Usuarios */
DROP TABLE IF EXISTS Usuarios CASCADE;

CREATE TABLE Usuarios (
id INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
edad INT NOT NULL
);

/* 2. Insertar dos registros en Usuarios */
INSERT INTO Usuarios (id, nombre, edad) VALUES
(1, 'Ana', 28),
(2, 'Bruno', 34);

/* 3. Actualizar la edad de un usuario */
UPDATE Usuarios
SET edad = 40
WHERE id = 2;

/* 4. Eliminar un usuario */
DELETE FROM Usuarios
WHERE id = 1;


/* ===== Nivel Moderado ===== */

/* 1. Crear tabla Ciudades */
DROP TABLE IF EXISTS Ciudades CASCADE;

CREATE TABLE Ciudades (
id INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
pais VARCHAR(100) NOT NULL
);

/* 2. Insertar tres registros en Ciudades */
INSERT INTO Ciudades (id, nombre, pais) VALUES
(1, 'Madrid', 'España'),
(2, 'Buenos Aires', 'Argentina'),
(3, 'Lisboa', 'Portugal');

/* 3. Relacionar Usuarios con Ciudades */
ALTER TABLE Usuarios
ADD COLUMN IF NOT EXISTS ciudad_id INT;

ALTER TABLE Usuarios
ADD CONSTRAINT usuarios_ciudad_fk
FOREIGN KEY (ciudad_id) REFERENCES Ciudades(id);

/* 4. Asignar ciudad a Bruno */
UPDATE Usuarios
SET ciudad_id = 1
WHERE id = 2;

/* 5. Consulta final con JOIN */
SELECT u.nombre AS usuario, c.nombre AS ciudad, c.pais
FROM Usuarios u
JOIN Ciudades c ON u.ciudad_id = c.id
ORDER BY usuario;