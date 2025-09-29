/* ===============================================================
Ejercicio 5 — SQL (PostgreSQL)
=============================================================== */

/* RESET OPCIONAL */
DROP TABLE IF EXISTS DetallesPedido;
DROP TABLE IF EXISTS Pedidos;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Clientes;

/* ---------------- 1) Crear tabla Clientes ---------------------- */
CREATE TABLE Clientes (
id INT PRIMARY KEY,
nombre VARCHAR(100)
);

/* ---------------- 2) Insertar cliente id=1 --------------------- */
INSERT INTO Clientes (id, nombre)
VALUES (1, 'John');

/* ---------------- 3) Actualizar nombre id=1 -------------------- */
UPDATE Clientes
SET nombre = 'John Doe'
WHERE id = 1;

/* ---------------- 4) Eliminar cliente id=1 --------------------- */
DELETE FROM Clientes
WHERE id = 1;

/* ---------------- 5) Leer todos los clientes ------------------ */
SELECT * FROM Clientes;

/* ---------------- 6) Crear tabla Pedidos ----------------------- */
CREATE TABLE Pedidos (
id INT PRIMARY KEY,
cliente_id INT REFERENCES Clientes(id)
);

/* ---------------- 7) Insertar pedido id=1 ---------------------- */
INSERT INTO Pedidos (id, cliente_id)
VALUES (1, 1);

/* ---------------- 8) Actualizar cliente_id --------------------- */
UPDATE Pedidos
SET cliente_id = 2
WHERE id = 1;

/* ---------------- 9) Eliminar pedido id=1 ---------------------- */
DELETE FROM Pedidos
WHERE id = 1;

/* ---------------- 10) Leer todos los pedidos ------------------- */
SELECT * FROM Pedidos;

/* ---------------- 11) Crear tabla Productos -------------------- */
CREATE TABLE Productos (
id INT PRIMARY KEY,
nombre VARCHAR(100)
);

/* ---------------- 12) Insertar producto id=1 ------------------- */
INSERT INTO Productos (id, nombre)
VALUES (1, 'Camisa');

/* ---------------- 13) Actualizar producto id=1 ----------------- */
UPDATE Productos
SET nombre = 'Pantalón'
WHERE id = 1;

/* ---------------- 14) Eliminar producto id=1 ------------------- */
DELETE FROM Productos
WHERE id = 1;

/* ---------------- 15) Leer todos los productos ----------------- */
SELECT * FROM Productos;

/* ---------------- 16) Crear tabla DetallesPedido --------------- */
CREATE TABLE DetallesPedido (
pedido_id INT REFERENCES Pedidos(id),
producto_id INT REFERENCES Productos(id)
);

/* ---------------- 17) Insertar detalle pedido id=1 ------------- */
INSERT INTO DetallesPedido (pedido_id, producto_id)
VALUES (1, 1);

/* ---------------- 18) Actualizar producto_id ------------------- */
UPDATE DetallesPedido
SET producto_id = 2
WHERE pedido_id = 1 AND producto_id = 1;

/* ---------------- 19) Eliminar detalle id=1 -------------------- */
DELETE FROM DetallesPedido
WHERE pedido_id = 1;

/* ---------------- 20) Leer todos los detalles ------------------ */
SELECT * FROM DetallesPedido;

/* ---------------- 21) INNER JOIN clientes con pedidos ---------- */
SELECT c.id, c.nombre, p.id AS pedido_id
FROM Clientes c
INNER JOIN Pedidos p ON c.id = p.cliente_id;

/* ---------------- 22) LEFT JOIN clientes con pedidos ----------- */
SELECT c.id, c.nombre, p.id AS pedido_id
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id;

/* ---------------- 23) INNER JOIN productos con detalles -------- */
SELECT pr.id, pr.nombre, dp.pedido_id
FROM Productos pr
INNER JOIN DetallesPedido dp ON pr.id = dp.producto_id;

/* ---------------- 24) LEFT JOIN productos con detalles --------- */
SELECT pr.id, pr.nombre, dp.pedido_id
FROM Productos pr
LEFT JOIN DetallesPedido dp ON pr.id = dp.producto_id;

/* ---------------- 25) Nueva columna telefono ------------------ */
ALTER TABLE Clientes
ADD COLUMN telefono VARCHAR(20);

/* ---------------- 26) Modificar tipo de telefono a INT --------- */
ALTER TABLE Clientes
ALTER COLUMN telefono TYPE INT
USING telefono::INT;

/* ---------------- 27) Eliminar columna telefono ---------------- */
ALTER TABLE Clientes
DROP COLUMN telefono;

/* ---------------- 28) Renombrar tabla Clientes -> Usuarios ----- */
ALTER TABLE Clientes
RENAME TO Usuarios;

/* ---------------- 29) Renombrar columna nombre ----------------- */
ALTER TABLE Usuarios
RENAME COLUMN nombre TO nombre_completo;

/* ---------------- 30) Agregar PK a id -------------------------- */
ALTER TABLE Usuarios
ADD PRIMARY KEY (id);
