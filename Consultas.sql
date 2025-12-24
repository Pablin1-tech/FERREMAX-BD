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


-- Caso: Consultar los pacientes del plan de medicina frecuente
--       en una lista que incluya:
--       Nombre y cedula del paciente, nombre e ID de la medicina,
--       Descuento
select Cedula_cliente as Cedula, (select nombre from Clientes where cedula = Cedula_cliente) as Cliente, Id_medicamento as ID, (select Nombre from Medicinas where Id = Id_medicamento) as Medicina, descuento from pacientes_permanentes;
select Id_medicamento from Pacientes_permanentes where Via_administracion= 'Oral' AND Descuento > (select Descuento from Pacientes_permanentes where Cedula_cliente='0100000053');

-- Caso: listado de pacientes del plan pacientes permanentes
--       presente el precio final de la medicina junto con el 
--       precio sin descuento

select 
Cedula_cliente as Cedula, (select nombre from Clientes where cedula = Cedula_cliente) as Cliente, 
Id_medicamento as ID, 
(select Nombre from Medicinas where Id = Id_medicamento) as Medicina, 
(SELECT precio from Medicinas where Id = Id_Medicamento) as Precio_original, 
descuento, (SELECT Precio from Medicinas where Id = Id_Medicamento) * descuento as Descontado
from pacientes_permanentes;

SELECT 
    Cedula_cliente AS Cedula,
    (SELECT nombre FROM Clientes WHERE cedula = Cedula_cliente) AS Cliente, 
    Id_medicamento AS ID, 
    (SELECT Nombre FROM Medicinas WHERE Id = Id_medicamento) AS Medicina, 
    (SELECT precio FROM Medicinas WHERE Id = Id_Medicamento) AS Precio_original, 
    descuento,
    (SELECT Precio FROM Medicinas WHERE Id = Id_Medicamento) * descuento AS Descontado,
    (SELECT Precio FROM Medicinas WHERE Id = Id_Medicamento)
      - ((SELECT Precio FROM Medicinas WHERE Id = Id_Medicamento) * descuento)
      AS Precio_final
FROM pacientes_permanentes;

select * from pacientes_permanentes;

-- Caso: Las medicinas comerciales pueden ser reemplazadas
--       por sus correspondientes genericas.
--       Elaborar un listado que compare precios
--       de medicinas comerciales y genericas

select * from medicinas;
select * from clasificacion_medicinas;
SELECT
    clasificacion_medicinas.Medicina_COM AS id_comercial,

    (SELECT nombre
     FROM medicinas
     WHERE id = clasificacion_medicinas.Medicina_COM) AS medicina_comercial,

    (SELECT precio
     FROM medicinas
     WHERE id = clasificacion_medicinas.Medicina_COM) AS precio_comercial,

    clasificacion_medicinas.Medicina_GEN AS id_generica,

    (SELECT nombre
     FROM medicinas
     WHERE id = clasificacion_medicinas.Medicina_GEN) AS medicina_generica,

    (SELECT precio
     FROM medicinas
     WHERE id = clasificacion_medicinas.Medicina_GEN) AS precio_generico
FROM clasificacion_medicinas;

-- Caso JOIN
SELECT
    pp.cedula_cliente AS cedula,
    c.nombre AS cliente,
    m.nombre AS medicamento,
    m.precio AS precio_original,
    pp.descuento,

    (m.precio * pp.descuento / 100) AS valor_descuento,

    (m.precio - (m.precio * pp.descuento / 100)) AS precio_final

FROM pacientes_permanentes pp
JOIN clientes c
    ON pp.cedula_cliente = c.cedula
JOIN medicinas m
    ON pp.id_medicamento = m.id;

SELECT
    cm.medicina_COM AS id_comercial,
    mc.nombre       AS medicina_comercial,
    mc.precio       AS precio_comercial,

    cm.medicina_GEN AS id_generica,
    mg.nombre       AS medicina_generica,
    mg.precio       AS precio_generico
FROM clasificacion_medicinas cm
JOIN medicinas mc
    ON mc.id = cm.medicina_COM
JOIN medicinas mg
    ON mg.id = cm.medicina_GEN;

-- Caso: Crear todas las combinaciones posibles entre la tabla 
--       de clientes y pacientes permanentes
--       Producto Cartesiano

SELECT * FROM
    clientes,
    pacientes_permanentes
WHERE
    clientes.Cedula = pacientes_permanentes.Cedula_cliente;

SELECT * FROM
    Medicinas,
    Pacientes_permanentes
WHERE
    Medicinas.Id = pacientes_permanentes.Id_Medicamento;
SELECT 
    c.Cedula,
    c.Nombre,
    m.Nombre,
    pp.descuento,
    m.Tipo  
from
    clientes c,
    Medicinas m,  
    pacientes_permanentes pp
WHERE
    m.id = pp.Id_medicamento
and c.cedula = pp.Cedula_cliente;

-- JOIN
SELECT 
    c.Cedula,
    c.Nombre,
    m.Nombre,
    pp.descuento,
    m.Tipo  
from 
    pacientes_permanentes pp
JOIN clientes c on c.cedula = pp.Cedula_cliente
JOIN medicinas m ON m.id = pp.Id_medicamento;

SELECT
    mgen.id     AS id_generica,
    mgen.nombre AS medicina_generica,
    mgen.precio AS precio_generico,

    mcom.id     AS id_comercial,
    mcom.nombre AS medicina_comercial,
    mcom.precio AS precio_comercial,

    mcom.precio - mgen.precio as Diferencia

FROM clasificacion_medicinas cm
JOIN medicinas mgen ON mgen.id = cm.medicina_gen
JOIN medicinas mcom ON mcom.id = cm.medicina_com;

-- Caso: Presentar una factura y sus detalles, que incluya:
--       datos de la farmacia, datos del cliente
--       datos de cabecera, medicinas vendidas
--       datos al pie de la factura y forma de pago

-- 1. Carga de datos en factura y detalles usando datos existentes
-- 2. select para cabecera de factura
-- 3. select para detalles de factura
-- 4. select para el pie de factura

SELECT
    /* DATOS DE LA EMPRESA (FARMACIA) */
    de.razonsocial        AS farmacia,
    de.ruc                AS ruc_farmacia,
    de.direccion          AS direccion_farmacia,
    de.telefono           AS telefono_farmacia,
    de.email              AS email_farmacia,

    f.facturanumero,
    f.fecha,

    c.cedula              AS cedula_cliente,
    c.nombre              AS nombre_cliente,
    c.apellido            AS apellido_cliente,
    c.correo               AS email_cliente,

    SUM(fd.cantidad * m.precio)           AS subtotal,
    SUM(fd.cantidad * m.precio) * 0.15    AS IVA,
    SUM(fd.cantidad * m.precio) * 1.15    AS total,

    f.forma_pago         AS metodo_pago

FROM facturas f

JOIN clientes c
    ON c.cedula = f.cedula

JOIN datos_empresa de
    ON de.ruc = '1712312345001'

JOIN facturadetalle fd
    ON fd.facturanumero = f.facturanumero

JOIN medicinas m
    ON m.id = fd.medicamento_id

WHERE f.facturanumero = '0000000001'

GROUP BY
    de.razonsocial,
    de.ruc,
    de.direccion,
    de.telefono,
    de.email,
    f.facturanumero,
    f.fecha,
    c.cedula,
    c.nombre,
    c.apellido,
    c.correo,
    f.forma_pago;

SELECT
fd.facturaNumero        AS numero_factura, 
fd.medicamento_id,
m.nombre                AS medicamento,
fd.cantidad,
fd.precio,
(fd.cantidad * fd.precio) AS subtotal_detalle
FROM facturadetalle fd
JOIN medicinas m
    ON m.id = fd.medicamento_id
WHERE fd.facturaNumero = '0000000001';

CREATE VIEW v_1
AS
SELECT
    mgen.id     AS id_generica,
    mgen.nombre AS medicina_generica,
    mgen.precio AS precio_generico,

    mcom.id     AS id_comercial,
    mcom.nombre AS medicina_comercial,
    mcom.precio AS precio_comercial,

    mcom.precio - mgen.precio as Diferencia

FROM clasificacion_medicinas cm
JOIN medicinas mgen ON mgen.id = cm.medicina_gen
JOIN medicinas mcom ON mcom.id = cm.medicina_com;

select * from v_1;

-- where con 2 ANDs
SELECT
    pp.cedula_cliente AS cedula,
    c.nombre AS cliente,
    m.nombre AS medicamento,
    m.precio AS precio_original,
    pp.descuento,

    (m.precio * pp.descuento / 100) AS valor_descuento,

    (m.precio - (m.precio * pp.descuento / 100)) AS precio_final

FROM pacientes_permanentes pp
JOIN clientes c
    ON pp.cedula_cliente = c.cedula
JOIN medicinas m
    ON pp.id_medicamento = m.id
where precio > 0.50 and precio < 1.20;

-- not
select
  id,
  nombre,
  precio
from medicinas
where not precio > 2;

select count(*) from pacientes_permanentes;

select 
  *
from medicinas
where id not In
(
    select id_medicamento from pacientes_permanentes
);
select * from medicinas;

select 
  *
from medicinas m
join pacientes_permanentes pp on m.id = pp.id_medicamento;

-- left join
select 
  *
from medicinas m
left join pacientes_permanentes pp on m.id = pp.id_medicamento
where pp.id_medicamento is null;
