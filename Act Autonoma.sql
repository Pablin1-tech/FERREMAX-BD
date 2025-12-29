create database Empleados;
use Empleados;
create table Empleados
(
    Cedula VARCHAR(8),
    Nombre VARCHAR(10),
    Departamento VARCHAR(20)
);
select * from empleados;
insert into empleados
values 
('1111111', 'Juan', 'Ventas'),
('2222222', 'Pedro', 'Almacenes'),
('3333333', 'Maria', 'Contabilidad'),
('444444', 'Marco', 'Contabilidad'),
('5555555', 'Susana', 'Ventas'),
('6666666', 'Marcelo', 'Ventas'),
('7777777', 'Ana', 'Direccion General');

alter table empleados
add Jefe VARCHAR(10);

update Empleados
set Jefe = 'Susana'
where Cedula IN ('1111111', '6666666');


update Empleados
set Jefe = 'Marco'
where Cedula = '3333333';

update Empleados
set Jefe = 'Ana'
where Cedula = '444444'
   or Cedula = '5555555';

select * from Empleados;

-- OPCIONAL!!
update Empleados
set Jefe = 'NULL'
where Cedula = '2222222'
   or Cedula = '7777777';

-- FORMA DE CONSULTAR EL NOMBRE DE LOS JEFES DE CADA EMPLEADO
SELECT 
  cedula,
  nombre
from empleados
where Jefe = 'NULL' OR Jefe = 'Marco';

-- FORMA DE CONSULTAR LOS JEFES DE CADA DEPARTAMENTO
SELECT 
  departamento
from empleados
where Jefe = 'Ana';

SELECT DISTINCT  -- EN CASO DE LA JEFA ANA, SE USA EL DISTINCT
                 -- PORQUE ES JEFA DE UN SOLO DEPARTAMENTO, 
                 -- MISMO QUE SE REPITE MAS DE UNA VEZ
    departamento
FROM empleados
WHERE Jefe = 'Susana';

-- ACTIVIDAD AUTONOMA REALIZADA POR PABLO CORTEZ