-- TALLER N° 2: 
-- Elaborar una consulta sQL para obtener una lista de registros con:

-- 1. Condición de igualdad aplicada a un atributo de tipo entero
SELECT *
FROM Datos_Producto
WHERE Categoria = 6;

-- 2. Condicion de igualdad aplicada a un atributo de tipo cadena de caracteres
SELECT *
FROM Clientes
WHERE Razon_Social = 'MAYO';

-- 3. Condicion de mayor/igual que aplicada a un atributo de tipo decimal
SELECT Id_Producto, Nombre_Producto, Precio
FROM Datos_Producto
WHERE Precio >= 150.00;

-- 4. Condicion de distinto aplicada a un atributo de tipo cadena de caracteres
SELECT *
FROM Proveedor
WHERE Nombre_Proveedor <> 'Disensa';

-- 5. Condicion de pertenencia a una lista de valores (IN) aplicada a
--    un atributo de tipo cadena de caracteres
SELECT *
FROM Categorias
WHERE Rotacion_en_Ventas IN ('ALTA', 'BAJA');

-- 6. Dos condiciones a su eleccion, unidas con el operador AND
SELECT Nombre_Producto, Stock_Presentacion, Precio
FROM Datos_Producto
WHERE Stock_Presentacion > 45
  AND Precio < 800;

-- 7. Dos condiciones similares a la anterior, proyecta en tres columnas
--    y crear una vista para contenerla
CREATE VIEW V1 as
SELECT 
    dp.Id_Producto,
    dp.Nombre_Producto,
    dp.Precio,
    dp.Stock_Presentacion,
    c.Nombre_Categoria AS categoria
FROM Datos_Producto dp
JOIN Categorias c ON dp.Categoria = c.Id_Categoria
WHERE dp.Precio > 150
  AND dp.Stock_Presentacion > 40;

SELECT * from V1;

-- 8. Dos condiciones a su eleccion, unidas con el operador OR
SELECT Cedula, Nombre_Cliente, Direccion, Contacto
FROM Clientes
WHERE Razon_Social = 'CONT'
   OR Descuento_Asociado = 'SI';

-- 9. Una condicion a su eleccion y el operador NOT
SELECT dp.Id_Producto, dp.Nombre_Producto, c.Nombre_Categoria AS Categoria
FROM Datos_Producto dp
JOIN Categorias c ON dp.Categoria = c.Id_Categoria
WHERE NOT dp.Categoria = 6;

SELECT
  Id_Producto,
  Nombre_Producto,
  Precio
from Datos_Producto
where not Precio > 150;

-- 10. Operacion JOIN en base a dos tablas que dispongan de FKs
SELECT 
    f.Id_Factura,
    f.Fecha_Venta,
    f.Forma_Pago,
    c.Nombre_Cliente AS Cliente,
    c.Contacto
FROM Factura f
JOIN Clientes c ON f.Cedula = c.Cedula;

-- 11. Operacion JOIN proyectada en tres columnas y 
--     con una vista para contenerlas
CREATE VIEW V2 AS
SELECT 
    f.Id_Factura,
    c.Nombre_Cliente AS Cliente,
    c.Contacto,
    c.Correo,
    f.Fecha_Venta
FROM Factura f
JOIN Clientes c ON f.Cedula = c.Cedula;

SELECT * from V2;

-- 12. Operacion LEFT JOIN en base de dos tablas que dispongan 
--     de la restriccion de FKs
SELECT 
    *
FROM Clientes c
LEFT JOIN Factura f ON c.Cedula = f.Cedula;

-- 13. Operacion RIGHT JOIN en base de dos tablas que dispongan
--     de la restriccion de FKs
SELECT 
    f.Id_Factura,
    f.Fecha_Venta,
    c.Nombre_Cliente
FROM Clientes c
RIGHT JOIN Factura f ON c.Cedula = f.Cedula;

-- 14. Operacion LEFT JOIN en base a una tabla con auto referencias
SELECT 
    c1.Id_Categoria,
    c1.Nombre_Categoria AS categoria_principal,
    c1.Rotacion_en_Ventas,
    c2.Nombre_Categoria AS categoria_misma_rotacion
FROM Categorias c1
LEFT JOIN Categorias c2
    ON c1.Rotacion_en_Ventas = c2.Rotacion_en_Ventas
   AND c1.Id_Categoria <> c2.Id_Categoria;

-- 15. Ordenamiento sobre un atributo de forma descendente
SELECT Nombre_Proveedor, Tipo_Suministro, Contacto
FROM Proveedor
ORDER BY Nombre_Proveedor DESC;

-- 16. Ordenamiento sobre dos atributos,
--     primero ascendente y segundo descendente
SELECT Nombre_Producto, Categoria, Precio
FROM Datos_Producto
ORDER BY Categoria ASC, Precio DESC;

-- 17. Agrupamiento sobre un atributo que no posee restriccion de unicidad
--     y una operacion de conteo
SELECT 
    p.Nombre_Proveedor AS Proveedor,
    COUNT(dp.Id_Producto) AS Total_productos
FROM Datos_Producto dp
JOIN Proveedor p ON dp.Id_Proveedor = p.Id_Proveedor
GROUP BY p.Nombre_Proveedor;

-- 18. Proyeccion con tres columnas, una calculada con operadores matematicos
SELECT 
    Id_Factura,
    Id_Producto,
    Cantidad_Presentaciones,
    Precio,
    (Cantidad_Presentaciones * Precio) AS subtotal
FROM Detalle_Factura;

-- 19. Proyeccion de tres columnas, una calculada con contenacion de caracteres
SELECT 
    CONCAT(Nombre_Cliente, ' - ', Direccion, ' - ') AS Info_cliente,
    Contacto,
    Correo
FROM Clientes;

-- 20. Proyeccion de tres columnas, una con concatenacion de caracteres
--     y con una vista creada para contenerla
CREATE VIEW V3 AS
SELECT 
    CONCAT(Nombre_Cliente, ' (', Direccion, ')') AS cliente,
    Contacto,
    Correo
FROM Clientes;

SELECT * from V3;

-- 21. Subconsulta basada en FKs que retorne cierto valor
SELECT 
    dp.Nombre_Producto,
    dp.Precio,
    pr.Nombre_Proveedor AS proveedor
FROM Datos_Producto dp
JOIN Proveedor pr 
    ON dp.Id_Proveedor = pr.Id_Proveedor
WHERE dp.Id_Proveedor = (
    SELECT Id_Proveedor
    FROM Proveedor
    WHERE Nombre_Proveedor = 'Disensa'
);

-- TALLER N2 REALIZADO POR PABLO CORTEZ