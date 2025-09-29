/* ===============================================================
Ejercicio 3 — SQL (PostgreSQL)
Objetivo: tabla Productos + inserts + update + delete + JOIN
=============================================================== */

/* --- Reset opcional para rehacer el ejercicio sin errores --- */
DROP TABLE IF EXISTS Pedidos;
DROP TABLE IF EXISTS Productos;
/* (Mantenemos Clientes si ya existe del ejercicio 1) */

/* --- Asegurar tabla Clientes y un cliente de prueba (id=1) --- */
CREATE TABLE IF NOT EXISTS Clientes (
id INT PRIMARY KEY,
nombre VARCHAR(100),
email VARCHAR(100)
);

INSERT INTO Clientes (id, nombre, email)
VALUES (1, 'Juan', 'juan@example.com')
ON CONFLICT (id) DO NOTHING;

/* ------------------- 1) Crear tabla Productos ----------------- */
CREATE TABLE Productos (
id INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
precio DECIMAL(10,2) NOT NULL
);

/* ------------------- 2) Insertar 5 productos ------------------ */
INSERT INTO Productos (id, nombre, precio) VALUES
(1, 'Laptop', 1200.00),
(2, 'Teléfono', 800.00),
(3, 'Auriculares', 150.00),
(4, 'Monitor', 300.00),
(5, 'Teclado', 50.00);

/* ---------------- 3) Actualizar precio de un producto --------- */
UPDATE Productos
SET precio = 1300.00
WHERE id = 1; -- Laptop

/* -------------------- 4) Eliminar un producto ----------------- */
DELETE FROM Productos
WHERE id = 5; -- Teclado

/* -------- 5) JOIN: Clientes que compraron qué productos --------
Creamos tabla Pedidos para relacionar clientes y productos
------------------------------------------------------------------ */
CREATE TABLE Pedidos (
id SERIAL PRIMARY KEY,
cliente_id INT REFERENCES Clientes(id),
producto_id INT REFERENCES Productos(id)
);

/* Ejemplos de compras */
INSERT INTO Pedidos (cliente_id, producto_id) VALUES
(1, 1), -- Juan compró Laptop
(1, 3), -- Juan compró Auriculares
(1, 2); -- Juan compró Teléfono

/* Consulta solicitada: nombre de usuario + nombre de producto */
SELECT c.nombre AS cliente, p.nombre AS producto
FROM Pedidos ped
INNER JOIN Clientes c ON c.id = ped.cliente_id
INNER JOIN Productos p ON p.id = ped.producto_id
ORDER BY c.nombre, p.nombre;
