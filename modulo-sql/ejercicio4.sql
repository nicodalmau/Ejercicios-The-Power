/* ===============================================================
Ejercicio 4 — SQL (PostgreSQL)
Nivel: Experto
=============================================================== */

/* --- Reset previo --- */
DROP TABLE IF EXISTS Pedidos;

/* --- 1) Crear tabla Pedidos --- */
CREATE TABLE Pedidos (
id SERIAL PRIMARY KEY,
id_usuario INT REFERENCES Clientes(id), -- usamos Clientes como "Usuarios"
id_producto INT REFERENCES Productos(id)
);

/* --- 2) Insertar al menos 3 registros --- */
INSERT INTO Pedidos (id_usuario, id_producto) VALUES
(1, 1), -- Juan compró Laptop
(1, 2), -- Juan compró Teléfono
(1, 3); -- Juan compró Auriculares

/* --- 3) Consulta con LEFT JOIN y COALESCE --- */
/* Mostrar todos los usuarios y los productos que han comprado,
incluidos los que no han hecho pedidos */
SELECT c.nombre AS usuario,
COALESCE(p.nombre, 'Ningún producto') AS producto
FROM Clientes c
LEFT JOIN Pedidos pd ON c.id = pd.id_usuario
LEFT JOIN Productos p ON pd.id_producto = p.id
ORDER BY c.nombre;

/* --- 4) Consulta con LEFT JOIN --- */
/* Mostrar usuarios que han hecho pedidos y también los que no */
SELECT c.nombre AS usuario,
p.nombre AS producto
FROM Clientes c
LEFT JOIN Pedidos pd ON c.id = pd.id_usuario
LEFT JOIN Productos p ON pd.id_producto = p.id
ORDER BY c.nombre;

/* --- 5) Agregar columna "cantidad" a Pedidos --- */
ALTER TABLE Pedidos
ADD COLUMN cantidad INT;

/* Actualizar registros existentes con valor (ejemplo = 1) */
UPDATE Pedidos
SET cantidad = 1;

/* Ahora Pedidos tiene: id, id_usuario, id_producto, cantidad */
