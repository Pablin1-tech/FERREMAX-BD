use FERREMAX;
-- Busqueda especifica
select cedula, nombre_cliente from Clientes where razon_social like 'DIST';

-- Busqueda compuesta
select cedula, nombre_cliente from clientes where razon_social like 'MAYO' AND correo like '%correo%';
select id_producto, nombre_producto from datos_producto where precio like '%5%';

-- Busqueda de productos de forma especifica
select id_producto, stock_presentacion from datos_producto where nombre_producto like '%A%' AND categoria like 2;

-- Busqueda de categorias de productos que empiecen con G
select id_categoria, nombre_categoria from Categorias where nombre_categoria like '%g%';

-- Busqueda de proveedores
select id_proveedor, nombre_proveedor from Proveedor where nombre_proveedor like 'Di%';
select nombre_proveedor from proveedor where id_proveedor='1790010001001';

--Busqueda con conectores compuestos
select id_producto, nombre_producto from datos_producto where precio BETWEEN 20 AND 100;


--=================================================================================================================================================--

-- CONSULTAS ADICIONALES APLICADAS AL PROYECTO FINAL

-- 1. Movimientos COMPRA
CREATE OR REPLACE VIEW v_mov_compras_productos AS
SELECT
    c.Fecha_Compra              AS fecha,
    dc.Id_Producto              AS id_producto,
    dp.Nombre_Producto          AS producto,
    c.Id_Compra                 AS documento,
    'COMPRA'                    AS tipo_movimiento,
    dp.Stock_Presentacion       AS stock_actual,
    dc.Cantidad_Presentaciones  AS entrada
FROM Detalle_Compra dc
JOIN Compra c
    ON c.Id_Compra = dc.Id_Compra
JOIN Datos_Producto dp
    ON dp.Id_Producto = dc.Id_Producto
ORDER BY Id_Producto;

select * from v_mov_compras_productos;

-- 2. Movimientos VENTA
CREATE OR REPLACE VIEW v_mov_ventas_productos AS
SELECT
    f.Fecha_venta               AS fecha,
    df.Id_Producto              AS id_producto,
    dp.Nombre_Producto          AS producto,
    f.Id_Factura                AS documento,
    'VENTA'                     AS tipo_movimiento,
    dp.Stock_Presentacion       AS stock_actual,
    df.Cantidad_Presentaciones  AS salida
FROM Detalle_Factura df
JOIN Factura f
    ON f.Id_Factura = df.Id_Factura
JOIN Datos_Producto dp
    ON dp.Id_Producto = df.Id_Producto;

select * from v_mov_ventas_productos;

-- 3. KARDEX completo
SELECT
    fecha,
    id_producto,
    producto,
    tipo_movimiento,
    stock_actual,
    entrada,
    salida,
    stock_actual
      + SUM(
            CASE tipo_movimiento
                WHEN 'COMPRA' THEN entrada
                WHEN 'VENTA'  THEN -salida
            END
        ) OVER (
            PARTITION BY id_producto
            ORDER BY fecha
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS saldo
FROM (
    SELECT
        fecha,
        id_producto,
        producto,
        tipo_movimiento,
        stock_actual,
        entrada,
        0 AS salida
    FROM v_mov_compras_productos

    UNION ALL

    SELECT
        fecha,
        id_producto,
        producto,
        tipo_movimiento,
        stock_actual,
        0 AS entrada,
        salida
    FROM v_mov_ventas_productos
) movimientos
ORDER BY id_producto, fecha;

-- 4. STOCK critico
SELECT
    dp.Id_Producto,
    dp.Nombre_Producto,
    dp.Stock_Presentacion,
    dp.Precio,
    'STOCK CRÍTICO' AS alerta
FROM Datos_Producto dp
WHERE dp.Stock_Presentacion <= 20
ORDER BY dp.Stock_Presentacion ASC;

-- 5. Promociones vigentes
CREATE OR REPLACE VIEW v_promociones_vigentes AS
SELECT
    Id_Promocion,
    Nombre_Promocion,
    Porcentaje_Descuento,
    Fecha_Inicio,
    Fecha_Fin,
    CASE
        WHEN CURDATE() BETWEEN Fecha_Inicio AND Fecha_Fin
        THEN 'PROMOCIÓN ACTIVA'
        ELSE 'PROMOCIÓN EXPIRADA'
    END AS estado
FROM Promocion;

select * from v_promociones_vigentes;

-- 6. Productos que tengan y que no tengan promocion aplicada
SELECT
    dp.Id_Producto,
    dp.Nombre_Producto,
    dp.Precio,

    CASE 
        WHEN pr.Porcentaje_Descuento IS NULL 
        THEN 0
        ELSE pr.Porcentaje_Descuento
    END AS Porcentaje_Descuento,

    dp.Precio
      - (
            dp.Precio *
            CASE 
                WHEN pr.Porcentaje_Descuento IS NULL 
                THEN 0
                ELSE pr.Porcentaje_Descuento
            END / 100
        ) AS precio_final

FROM Datos_Producto dp

LEFT JOIN Detalle_Factura df
    ON df.Id_Producto = dp.Id_Producto

LEFT JOIN Factura f
    ON f.Id_Factura = df.Id_Factura

LEFT JOIN Promocion pr
    ON pr.Id_Promocion = f.Promocion

GROUP BY
    dp.Id_Producto,
    dp.Nombre_Producto,
    dp.Precio,
    pr.Porcentaje_Descuento;


-- 7. Ventas totales por producto
SELECT
    df.Id_Producto,
    dp.Nombre_Producto,
    SUM(df.Cantidad_Presentaciones) AS total_vendido,
    SUM(df.Cantidad_Presentaciones * df.Precio) AS total_ingresos
FROM Detalle_Factura df
JOIN Datos_Producto dp
    ON dp.Id_Producto = df.Id_Producto
GROUP BY
    df.Id_Producto,
    dp.Nombre_Producto
ORDER BY total_ingresos DESC;

-- 8. Detalle de factura (con subtotales calculados)
SELECT
    df.Id_Factura,
    df.Id_Producto,
    dp.Nombre_Producto,
    df.Cantidad_Presentaciones,
    df.Precio,
    (df.Cantidad_Presentaciones * df.Precio) AS subtotal
FROM Detalle_Factura df
JOIN Datos_Producto dp
    ON dp.Id_Producto = df.Id_Producto
ORDER BY df.Id_Factura;

-- 9. Factura completa
SELECT
    f.Id_Factura,
    f.Fecha_venta,
    cl.Nombre_Cliente,
    cl.Correo,
    SUM(df.Cantidad_Presentaciones * df.Precio)               AS subtotal,
    SUM(df.Cantidad_Presentaciones * df.Precio) * 0.15        AS IVA,
    SUM(df.Cantidad_Presentaciones * df.Precio) * 1.15        AS total,
    f.Forma_Pago
FROM Factura f
JOIN Clientes cl
    ON cl.Cedula = f.Cedula
JOIN Detalle_Factura df
    ON df.Id_Factura = f.Id_Factura
WHERE f.Id_Factura = 1
GROUP BY
    f.Id_Factura,
    f.Fecha_venta,
    cl.Nombre_Cliente,
    cl.Correo,
    f.Forma_Pago;

-- 10. Clientes frecuentes con descuento aplicado
SELECT
    cl.Cedula,
    cl.Nombre_Cliente,
    dcf.Descuento,
    CASE
        WHEN dcf.Descuento >= 30 THEN 'CLIENTE PREMIUM'
        WHEN dcf.Descuento >= 15 THEN 'CLIENTE FRECUENTE'
        ELSE 'CLIENTE REGULAR'
    END AS categoria_cliente
FROM Clientes cl
JOIN Descuento_Clientes_Frecuentes dcf
    ON cl.Cedula = dcf.Cedula
ORDER BY dcf.Descuento DESC;

--=================================================================================================================================================--
-- CONSULTAS APLICADAS AL PROYECTO FINAL
-- REALIZADO POR PABLO CORTEZ
-- PROYECTO FINAL
-- NOMBRE PROYECTO: FERREMAX DB