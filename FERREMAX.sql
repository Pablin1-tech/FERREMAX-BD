create DATABASE FERREMAX;
use FERREMAX;
-- Tabla de productos y FK - PK
create table Datos_Producto 
(
    Id_Producto int primary key,
    Nombre_Producto VARCHAR(100),
    Categoria int,
    Id_Proveedor int,
    Presentacion CHAR(15),
    Unidades_por_Presentacion int,
    Stock_Presentacion int,
    Precio DECIMAL(15,2)
);
alter table Datos_Producto
add CONSTRAINT id_proveedor_fk
Foreign Key (Id_Proveedor) 
REFERENCES Proveedor(Id_Proveedor);
alter table Datos_Producto
add CONSTRAINT categoria_fk
Foreign Key (Categoria) 
REFERENCES Categorias(Id_Categoria);
alter table Datos_Producto
add CONSTRAINT precio_ck
check (Precio > 0);
alter table Datos_Producto
add constraint nombre_uq
UNIQUE(Nombre_Producto);
alter table Datos_Producto
MODIFY COLUMN Nombre_Producto VARCHAR(100) not null;














-- Tabla de categorias y FK - PK
create table Categorias
(
    Id_Categoria int primary key,
    Nombre_Categoria VARCHAR(50),
    Descripcion VARCHAR(100),
    Rotacion_en_Ventas CHAR(5),
    Ubicacion_Almacen VARCHAR(10)
);
alter table Categorias
MODIFY COLUMN Nombre_Categoria VARCHAR(50) not null;















--Tabla de proveedores y FK - PK
create table Proveedor
(
    Id_Proveedor int primary key,
    Nombre_Proveedor VARCHAR(50),
    Tipo_Suministro VARCHAR(50),
    Contacto CHAR(10),
    Correo CHAR(20),
    Tiempo_Entrega CHAR(3)
);
alter table Proveedor
MODIFY COLUMN Nombre_Proveedor VARCHAR(50) not null;














--Tabla de clientes y FK - PK
create table Clientes
(
    Id_Cliente CHAR(13) primary key,
    Nombre_Cliente VARCHAR(30),
    Razon_Social CHAR(4),
    Contacto CHAR(10),
    Correo CHAR(20),
    Direccion VARCHAR(50),
    Descuento_Asociado CHAR(2)
);
alter table Clientes
add constraint razon_social_val
check (
    Razon_Social in ('MINO', 'EMPR', 'MAYO', 'CONT', 'DIST')
);
alter table Clientes
MODIFY COLUMN Nombre_Cliente VARCHAR(30) not null;
alter table Clientes
add constraint correo_cliente_uq
UNIQUE(Correo);
















--Tabla de descuento a clientes frecuentes y FK - PK
create table Descuento_Clientes_Frecuentes
(
    Id_Cliente CHAR(13) primary key,
    Descuento DECIMAL(5,2)
);
alter table Descuento_Clientes_Frecuentes
add CONSTRAINT id_cliente_fk
Foreign Key (Id_Cliente) 
REFERENCES Clientes(Id_Cliente);















--Tabla de compras y FK - PK
create table Compra
(
    Id_Compra int primary key,
    Id_Proveedor int,
    Fecha_Compra DATETIME,
    Metodo_Pago CHAR(5),
    Total DECIMAL(15,2)
);
alter table Compra
add CONSTRAINT id_proveedor_2_fk
Foreign Key (Id_Proveedor) 
REFERENCES Proveedor(Id_Proveedor);















--Tabla de detalles de compra y FK - PK
create table Detalle_Compra
(
    Id_Detalle int primary key,
    Id_Compra int,
    Id_Producto int,
    Cantidad_Presentaciones int,
    Costo_Presentacion DECIMAL(15,2),
    Subtotal DECIMAL(15,2),
    IVA DECIMAL(15,2)
);
alter table Detalle_Compra
add CONSTRAINT id_compra_fk
Foreign Key (Id_Compra) 
REFERENCES Compra(Id_Compra);
alter table Detalle_Compra
add CONSTRAINT id_producto_fk
Foreign Key (Id_Producto) 
REFERENCES Datos_Producto(Id_Producto);
alter table Detalle_Compra
MODIFY COLUMN IVA DECIMAL(15,2) default 0.15;


















--Tabla de facturas y FK - PK
create table Factura
(
    Id_Factura int primary key,
    Id_Compra int,
    Id_Cliente CHAR(13),
    Fecha_venta DATETIME,
    Forma_Pago CHAR(5),
    Total DECIMAL(15,2),
    Aplica_Promocion CHAR(2),
    Promocion int
);
alter table Factura
add CONSTRAINT id_cliente_2_fk
Foreign Key (Id_Cliente) 
REFERENCES Clientes(Id_Cliente);
alter table Factura
add CONSTRAINT id_compra_factura_fk
Foreign Key (Id_Compra) 
REFERENCES Compra(Id_Compra);
alter table Factura
add CONSTRAINT promocion_fk
Foreign Key (Promocion) 
REFERENCES Promocion(Id_Promocion);


















--Tabla de detalles de facturas y FK - PK
create table Detalle_Factura
(
    Id_Detalle_Factura int primary key,
    Id_Factura int,
    Id_Producto int,
    Cantidad_Presentaciones int,
    Precio DECIMAL(15,2),
    Subtotal DECIMAL(15,2)
);
alter table Detalle_Factura
add CONSTRAINT id_factura_fk
Foreign Key (Id_Factura) 
REFERENCES Factura(Id_Factura);
alter table Detalle_Factura
add CONSTRAINT id_producto_2_fk
Foreign Key (Id_Producto) 
REFERENCES Datos_Producto(Id_Producto);



















-- Tabla de promociones
create table Promocion
(
    Id_Promocion int primary key,
    Nombre_Promocion VARCHAR(30),
    Tipo VARCHAR(20),
    Condicion_Minima VARCHAR(30),
    Porcentaje_Descuento DECIMAL(5,2),
    Fecha_Inicio DATETIME,
    Fecha_Fin DATETIME
);
alter table Promocion
MODIFY COLUMN Nombre_Promocion VARCHAR(30) not null;


















-- Extra