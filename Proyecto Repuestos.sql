-- Crear base de datos
DROP DATABASE IF EXISTS AlmacenRepuestos;
CREATE DATABASE AlmacenRepuestos;
USE AlmacenRepuestos;

-- =========================
-- TABLA CLIENTES
-- =========================
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    cedula VARCHAR(10) UNIQUE NOT NULL,
    nombre VARCHAR(50),
    ciudad VARCHAR(50),
    fecha_registro DATE
);

INSERT INTO Clientes (cedula, nombre, ciudad, fecha_registro) VALUES
('0102030401','Carlos Pérez','Quito','2023-01-15'),
('0102030402','María López','Guayaquil','2023-02-10'),
('0102030403','Juan Torres','Cuenca','2023-03-05'),
('0102030404','Ana Gómez','Quito','2023-04-20'),
('0102030405','Luis Ramos','Manta','2023-05-18'),
('0102030406','Pedro Vera','Ambato','2023-06-12'),
('0102030407','Sofía Castillo','Loja','2023-07-01'),
('0102030408','Diego Mora','Quito','2023-08-09'),
('0102030409','Paula Ríos','Ibarra','2023-09-22'),
('0102030410','Andrés Luna','Riobamba','2023-10-30');

-- =========================
-- TABLA REPUESTOS
-- =========================
CREATE TABLE Repuestos (
    id_repuesto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60),
    categoria VARCHAR(40),
    precio DECIMAL(10,2),
    proveedor VARCHAR(50)
);


INSERT INTO Repuestos (nombre, categoria, precio, proveedor) VALUES
('Filtro de aceite','Motor',8.50,'Bosch'),
('Pastillas de freno','Frenos',35.00,'Brembo'),
('Bujía','Motor',6.00,'NGK'),
('Amortiguador','Suspensión',95.00,'KYB'),
('Radiador','Refrigeración',150.00,'Valeo'),
('Batería','Eléctrico',120.00,'Varta'),
('Alternador','Eléctrico',180.00,'Bosch'),
('Aceite 10W40','Lubricantes',28.00,'Shell'),
('Sensor ABS','Frenos',70.00,'Bosch'),
('Embrague','Transmisión',210.00,'Exedy');

-- =========================
-- TABLA INVENTARIO (AUTOREFERENCIA)
-- =========================
CREATE TABLE Inventario (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_repuesto INT,
    stock INT,
    fecha_ingreso DATE,
    supervisor_id INT NULL,
    FOREIGN KEY (id_repuesto) REFERENCES Repuestos(id_repuesto),
    FOREIGN KEY (supervisor_id) REFERENCES Inventario(id_inventario)
);


INSERT INTO Inventario (id_repuesto, stock, fecha_ingreso, supervisor_id) VALUES
(1,50,'2024-01-10',NULL),
(2,20,'2024-01-15',1),
(3,100,'2024-01-20',1),
(4,15,'2024-02-01',2),
(5,30,'2024-02-05',2),
(6,80,'2024-02-10',NULL),
(7,25,'2024-02-15',6),
(8,60,'2024-02-20',6),
(9,18,'2024-03-01',NULL),
(10,12,'2024-03-05',9);


-- =========================
-- CONSULTAS
-- =========================

-- Igualdad entero
SELECT * FROM Clientes WHERE id_cliente = 3;


-- Igualdad cadena
SELECT * FROM Clientes WHERE ciudad = 'Quito';


-- Mayor o igual decimal
SELECT * FROM Repuestos WHERE precio >= 100;


-- Distinto
SELECT * FROM Repuestos WHERE proveedor <> 'Bosch';

-- IN
SELECT * FROM Repuestos WHERE categoria IN ('Motor','Frenos');


-- AND
SELECT * FROM Repuestos WHERE categoria = 'Motor' AND precio > 10;


CREATE VIEW Vista_Repuestos_Motor AS
SELECT nombre, categoria, precio
FROM Repuestos
WHERE categoria = 'Motor' AND precio > 10;

-- OR
SELECT * FROM Clientes
WHERE ciudad = 'Quito' OR ciudad = 'Guayaquil';


-- NOT
SELECT * FROM Repuestos WHERE NOT categoria = 'Motor';


-- INNER JOIN
SELECT r.nombre, i.stock
FROM Repuestos r
JOIN Inventario i ON r.id_repuesto=i.id_repuesto;

-- LEFT JOIN
SELECT r.nombre, i.stock
FROM Repuestos r
LEFT JOIN Inventario i ON r.id_repuesto = i.id_repuesto;


-- RIGHT JOIN
SELECT r.nombre, i.stock
FROM Repuestos r
RIGHT JOIN Inventario i ON r.id_repuesto = i.id_repuesto;


-- Auto referencia
SELECT i1.id_inventario, i2.id_inventario AS supervisor
FROM Inventario i1
LEFT JOIN Inventario i2 ON i1.supervisor_id = i2.id_inventario;


-- ORDER BY
SELECT * FROM Repuestos ORDER BY precio DESC;

-- GROUP BY
SELECT categoria, COUNT(*) AS total
FROM Repuestos
GROUP BY categoria;


-- Campo calculado
SELECT nombre, precio, precio * 1.12 AS precio_con_iva
FROM Repuestos;


-- CONCAT
SELECT nombre, categoria,
CONCAT(nombre,' - ',categoria) AS descripcion
FROM Repuestos;
-- VISTA
CREATE VIEW Vista_Descripcion AS
SELECT nombre, categoria,
CONCAT(nombre,' (',categoria,')') AS descripcion
FROM Repuestos;


-- Subconsulta
SELECT nombre
FROM Repuestos
WHERE id_repuesto = (
    SELECT id_repuesto FROM Inventario WHERE stock = 100
);


-- Fechas con CURDATE
SELECT r.nombre,
DATEDIFF(CURDATE(), i.fecha_ingreso) AS dias_en_almacen
FROM Inventario i
JOIN Repuestos r ON i.id_repuesto = r.id_repuesto;


-- BETWEEN
SELECT * FROM Clientes
WHERE fecha_registro BETWEEN '2023-03-01' AND '2023-06-30';


-- IS NULL / IS NOT NULL
SELECT * FROM Inventario WHERE supervisor_id IS NULL;
SELECT * FROM Inventario WHERE supervisor_id IS NOT NULL;


-- DISTINCT
SELECT DISTINCT categoria FROM Repuestos;

-- CASE
SELECT nombre, precio,
CASE
    WHEN precio > 100 THEN 'Caro'
    WHEN precio BETWEEN 50 AND 100 THEN 'Medio'
    ELSE 'Económico'
END AS clasificacion
FROM Repuestos;


-- UNION
SELECT nombre FROM Repuestos WHERE categoria = 'Motor'
UNION
SELECT nombre FROM Repuestos WHERE categoria = 'Frenos';


-- EXISTS
SELECT nombre
FROM Repuestos r
WHERE EXISTS (
    SELECT 1 FROM Inventario i
    WHERE i.id_repuesto = r.id_repuesto
    AND i.stock > 50
);