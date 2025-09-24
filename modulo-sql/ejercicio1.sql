* =========================================================
Ejercicio 1 – SQL (PostgreSQL)
Cada punto del enunciado va comentado y su solución debajo.
========================================================= */

/* --------- Reset para rehacer el ejercicio sin errores --------- */
DROP TABLE IF EXISTS Pedidos;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Clientes;

/* (1) Crear tabla "Clientes" */
CREATE TABLE Clientes (
id INT PRIMARY KEY,
nombre VARCHAR(100),
email VARCHAR(100)
);

/* (2) Insertar cliente id=1, nombre='Juan', email='juan@example.com' */
INSERT INTO Clientes (id, nombre, email)
VALUES (1, 'Juan', 'juan@example.com');

/* (3) Actualizar email del cliente id=1 a 'juan@gmail.com' */
UPDATE Clientes
SET email = 'juan@gmail.com'
WHERE id = 1;

/* (4) Eliminar el cliente con id=1 */
DELETE FROM Clientes
WHERE id = 1;

/* Para poder usar cliente_id=1 como FK en Pedidos (pasos 5–8),
volvemos a insertar el cliente id=1. */
INSERT INTO Clientes (id, nombre, email)
VALUES (1, 'Juan', 'juan@gmail.com');

/* (5) Crear tabla "Pedidos" con FK a Clientes(id) */
CREATE TABLE Pedidos (
id INT PRIMARY KEY,
cliente_id INT REFERENCES Clientes(id),
producto VARCHAR(100),
cantidad INT
);

/* (6) Insertar pedido id=1, cliente_id=1, producto='Camiseta', cantidad=2 */
INSERT INTO Pedidos (id, cliente_id, producto, cantidad)
VALUES (1, 1, 'Camiseta', 2);

/* (7) Actualizar cantidad del pedido id=1 a 3 */
UPDATE Pedidos
SET cantidad = 3
WHERE id = 1;

/* (8) Eliminar el pedido con id=1 */
DELETE FROM Pedidos
WHERE id = 1;

/* (9) Crear tabla "Productos" (id PK, nombre, precio) */
CREATE TABLE Productos (
id INT PRIMARY KEY,
nombre VARCHAR(100),
precio NUMERIC(10,2)
);

/* (10) Insertar varios productos */
INSERT INTO Productos (id, nombre, precio) VALUES
(1, 'Camiseta', 19.90),
(2, 'Pantalón', 49.99),
(3, 'Zapatillas', 89.50),
(4, 'Gorra', 15.00),
(5, 'Chaqueta', 120.00);

/* (11) Consultar todos los clientes */
SELECT * FROM Clientes;

/* (12) Consultar todos los pedidos junto con el nombre del cliente */
SELECT p.id AS pedido_id,
c.nombre AS cliente,
p.producto,
p.cantidad
FROM Pedidos p
JOIN Clientes c ON c.id = p.cliente_id;

/* (13) Productos cuyo precio > 50 */
SELECT * FROM Productos
WHERE precio > 50;

/* (14) Pedidos con cantidad >= 5 */
SELECT * FROM Pedidos
WHERE cantidad >= 5;

/* (15) Clientes cuyo nombre empieza por 'A' */
SELECT * FROM Clientes
WHERE nombre ILIKE 'A%';

/* (16) Nombre del cliente y total de pedidos realizados por cada cliente */
SELECT c.nombre,
COUNT(p.id) AS total_pedidos
FROM Clientes c
LEFT JOIN Pedidos p ON p.cliente_id = c.id
GROUP BY c.nombre
ORDER BY c.nombre;

/* (17) Nombre del producto y cantidad total pedida de ese producto */
SELECT p.producto,
SUM(p.cantidad) AS total_unidades
FROM Pedidos p
GROUP BY p.producto
ORDER BY p.producto;

/* (18) Agregar columna fecha (DATE) a Pedidos */
ALTER TABLE Pedidos
ADD COLUMN IF NOT EXISTS fecha DATE;

/* (19) Agregar FK en Pedidos(producto) -> Productos(nombre)
Para poder referenciar a nombre, debe ser único en Productos. */
ALTER TABLE Productos
ADD CONSTRAINT productos_nombre_unico UNIQUE (nombre);

ALTER TABLE Pedidos
ADD CONSTRAINT pedidos_producto_fk
FOREIGN KEY (producto) REFERENCES Productos(nombre);

/* (20) Consulta con nombres de clientes, nombres de productos
y cantidades, uniendo por las claves externas */
SELECT c.nombre AS cliente,
pr.nombre AS producto,
p.cantidad,
p.fecha
FROM Pedidos p
JOIN Clientes c ON c.id = p.cliente_id
JOIN Productos pr ON pr.nombre = p.producto
ORDER BY cliente, producto;