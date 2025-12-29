-- 1. Condicion de igualdad sobre atributo entero
SELECT 
    dp.Id_Producto,
    dp.Nombre_Producto,
    dp.Stock_Presentacion,
    dp.Precio
FROM Datos_Producto dp
WHERE dp.Id_Producto = 17;

-- 2. Condicion de igualdad sobre un atributo de tipo cadena
SELECT 
    c.Id_Categoria,
    c.Nombre_Categoria,
    c.Rotacion_en_Ventas,
    c.Ubicacion_Almacen
FROM Categorias c
WHERE c.Rotacion_en_Ventas = 'ALTA';

-- 3. Condicion mayor o igual sobre atributo decimal
SELECT 
    dp.Id_Producto,
    dp.Nombre_Producto,
    dp.Precio,
    dp.Stock_Presentacion
FROM Datos_Producto dp
WHERE dp.Precio >= 500.00
ORDER BY dp.Precio DESC;

-- 4. Condicion distinto sobre atributo cadena
SELECT 
    p.Id_Proveedor,
    p.Nombre_Proveedor,
    p.Tipo_Suministro
FROM Proveedor p
WHERE p.Tipo_Suministro <> 'HERRAMIENTAS';

-- 5. Condicion IN sobre atributo tipo cadena
SELECT 
    cl.Cedula,
    cl.Nombre_Cliente,
    cl.Razon_Social,
    cl.Descuento_Asociado
FROM Clientes cl
WHERE cl.Razon_Social IN ('MAYO','DIST','EMPR');

-- 6. Dos condiciones unidas con AND
SELECT 
    dp.Nombre_Producto,
    dp.Stock_Presentacion,
    dp.Precio
FROM Datos_Producto dp
WHERE dp.Stock_Presentacion > 30
  AND dp.Precio < 300.00;

-- 7. Dos condiciones con AND, proyeccion de 3 columnas y vista
CREATE VIEW Vista_Productos_Stock_Precio AS
SELECT 
    dp.Id_Producto,
    dp.Nombre_Producto,
    dp.Precio
FROM Datos_Producto dp
WHERE dp.Stock_Presentacion >= 40
  AND dp.Precio BETWEEN 100 AND 400;

select * from Vista_Productos_Stock_Precio;

-- 8. Dos condiciones unidas con OR
SELECT 
    f.Id_Factura,
    f.Forma_Pago,
    f.Aplica_Promocion
FROM Factura f
WHERE f.Forma_Pago = 'EFEC/'
   OR f.Aplica_Promocion = 'SI';

-- 9. Uso de operador NOT
SELECT 
    c.Nombre_Categoria,
    c.Rotacion_en_Ventas
FROM Categorias c
WHERE NOT c.Rotacion_en_Ventas = 'BAJA';

-- 10. JOIN con clave foránea
SELECT 
    dp.Nombre_Producto,
    p.Nombre_Proveedor,
    dp.Precio
FROM Datos_Producto dp
INNER JOIN Proveedor p
    ON dp.Id_Proveedor = p.Id_Proveedor;

-- 11. JOIN, 3 columnas, vista creada
CREATE VIEW Vista_Factura_Cliente AS
SELECT 
    f.Id_Factura,
    cl.Nombre_Cliente,
    f.Fecha_venta
FROM Factura f
INNER JOIN Clientes cl
    ON f.Cedula = cl.Cedula;

select * from Vista_Factura_Cliente;

-- 12. LEFT JOIN
SELECT 
    cl.Nombre_Cliente,
    f.Id_Factura,
    f.Fecha_venta
FROM Clientes cl
LEFT JOIN Factura f
    ON cl.Cedula = f.Cedula;

-- 13. RIGHT JOIN
SELECT 
    f.Id_Factura,
    cl.Nombre_Cliente,
    f.Forma_Pago
FROM Clientes cl
RIGHT JOIN Factura f
    ON cl.Cedula = f.Cedula;

-- 14. LEFT JOIN, autorreferencia
SELECT 
    c1.Nombre_Categoria AS Categoria_1,
    c2.Nombre_Categoria AS Categoria_Misma_Ubicacion
FROM Categorias c1
LEFT JOIN Categorias c2
    ON c1.Ubicacion_Almacen = c2.Ubicacion_Almacen
   AND c1.Id_Categoria <> c2.Id_Categoria;

-- 15. ORDER BY descendente
SELECT 
    Nombre_Producto,
    Precio
FROM Datos_Producto
ORDER BY Precio DESC;

-- 16. ORDER BY ascendente y descendente
SELECT 
    Nombre_Producto,
    Stock_Presentacion,
    Precio
FROM Datos_Producto
ORDER BY Stock_Presentacion ASC, Precio DESC;

-- 17. GROUP BY, COUNT
SELECT 
    Categoria,
    COUNT(*) AS Total_Productos
FROM Datos_Producto
GROUP BY Categoria;

-- 18. Proyeccion con columna calculada
SELECT 
    df.Id_Factura,
    df.Cantidad_Presentaciones,
    df.Precio,
    (df.Cantidad_Presentaciones * df.Precio) AS Subtotal
FROM Detalle_Factura df;

-- 19. CONCAT
SELECT 
    cl.Cedula,
    CONCAT(cl.Nombre_Cliente, ' - ', cl.Razon_Social) AS Cliente_Descripcion,
    cl.Correo
FROM Clientes cl;

-- 20. CONCAT, vista creada
CREATE VIEW Vista_Clientes_Descripcion AS
SELECT 
    Cedula,
    CONCAT(Nombre_Cliente, ' (', Razon_Social, ')') AS Cliente,
    Direccion
FROM Clientes;

select * from Vista_Clientes_Descripcion;

--21. Subconsulta con clave foranea
SELECT 
    Nombre_Producto,
    Precio
FROM Datos_Producto
WHERE Id_Producto IN (
    SELECT Id_Producto
    FROM Detalle_Factura
    WHERE Cantidad_Presentaciones > 20
);

-- 22. Fecha, CURDATE
SELECT 
    f.Id_Factura,
    f.Fecha_venta,
    DATEDIFF(CURDATE(), f.Fecha_venta) AS Dias_Transcurridos
FROM Factura f;

-- 23. Fecha, BETWEEN
SELECT 
    Id_Compra,
    Fecha_Compra,
    Metodo_Pago
FROM Compra
WHERE Fecha_Compra BETWEEN '2025-03-01' AND '2025-05-31';

-- 24. IS NULL/IS NOT NULL
SELECT 
    Id_Factura,
    Aplica_Promocion,
    Promocion
FROM Factura
WHERE Promocion IS NULL
   OR Promocion IS NOT NULL;

-- 25. DISTINCT
SELECT DISTINCT
    Tipo_Suministro
FROM Proveedor;

-- 26. CASE, WHEN, THEN, ELSE
SELECT 
    Nombre_Producto,
    Precio,
    CASE
        WHEN Precio >= 1000 THEN 'PRODUCTO CARO'
        WHEN Precio BETWEEN 300 AND 999 THEN 'PRODUCTO MEDIO'
        ELSE 'PRODUCTO ECONOMICO'
    END AS Clasificacion_Precio
FROM Datos_Producto;

-- 27. UNION
SELECT 
    cl.Cedula              AS Identificador,
    cl.Nombre_Cliente      AS Nombre,
    'CLIENTE'              AS Tipo_Entidad,
    COUNT(f.Id_Factura)    AS Total_Operaciones,
    MAX(f.Fecha_venta)     AS Ultima_Fecha
FROM Clientes cl
INNER JOIN Factura f
    ON cl.Cedula = f.Cedula
GROUP BY 
    cl.Cedula,
    cl.Nombre_Cliente

UNION

SELECT 
    p.Id_Proveedor         AS Identificador,
    p.Nombre_Proveedor     AS Nombre,
    'PROVEEDOR'            AS Tipo_Entidad,
    COUNT(c.Id_Compra)     AS Total_Operaciones,
    MAX(c.Fecha_Compra)    AS Ultima_Fecha
FROM Proveedor p
INNER JOIN Compra c
    ON p.Id_Proveedor = c.Id_Proveedor
GROUP BY 
    p.Id_Proveedor,
    p.Nombre_Proveedor
ORDER BY 
    Tipo_Entidad ASC,
    Total_Operaciones DESC;

-- 28. EXISTS, subconsulta
SELECT 
    cl.Nombre_Cliente,
    cl.Cedula
FROM Clientes cl
WHERE EXISTS (
    SELECT 1
    FROM Factura f
    WHERE f.Cedula = cl.Cedula
      AND f.Aplica_Promocion = 'SI'
);


--===============================================================================================--
-- REALIZADO POR PABLO CORTEZ
-- PROYECTO FINAL
-- BASE DE DATOS
-- NOMBRE PROYECTO: FERREMAX DB