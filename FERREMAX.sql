create DATABASE FERREMAX;
use FERREMAX;
-- Tabla de categorias y FK - PK
create table Categorias
(
    Id_Categoria int primary key,
    Nombre_Categoria VARCHAR(50),
    Descripcion VARCHAR(100),
    Rotacion_en_Ventas CHAR(5),
    Ubicacion_Almacen VARCHAR(10)
);
-- NOT NULL
alter table Categorias
MODIFY COLUMN Nombre_Categoria VARCHAR(50) not null;
-- CHECK
alter table Categorias
add constraint rotacion_ventas_val
check (
    Rotacion_en_Ventas in ('ALTA', 'MEDIA', 'BAJA')
);
INSERT INTO Categorias
VALUES
(1,'Cemento','Material para construcción','ALTA','PASILLO 1'),
(2,'Arena','Agregado fino','ALTA','PASILLO 2'),
(3,'Grava','Agregado grueso','MEDIA','PASILLO 2'),
(4,'Hierro','Varillas y estructuras','ALTA','PASILLO 3'),
(5,'Pinturas','Pinturas y esmaltes','MEDIA','PASILLO 4'),
(6,'Electricidad','Material eléctrico','ALTA','PASILLO 5'),
(7,'Plomería','Tuberías y accesorios','MEDIA','PASILLO 6'),
(8,'Herramientas Manuales','Uso manual','ALTA','PASILLO 7'),
(9,'Herramientas Eléctricas','Uso eléctrico','MEDIA','PASILLO 8'),
(10,'Clavos','Elementos de fijación','ALTA','SECCION 1'),
(11,'Tornillos','Fijación metálica','ALTA','SECCION 1'),
(12,'Tuercas','Fijación industrial','MEDIA','SECCION 2'),
(13,'Pegamentos','Adhesivos industriales','BAJA','SECCION 2'),
(14,'Lijas','Material abrasivo','MEDIA','SECCION 3'),
(15,'Seguridad','Equipos de protección','ALTA','SECCION 4'),

(16,'Maderas','Maderas procesadas','MEDIA','PASILLO 1'),
(17,'Techos','Cubiertas','BAJA','PASILLO 3'),
(18,'Cerámica','Pisos y revestimientos','MEDIA','PASILLO 4'),
(19,'Vidrio','Vidrios templados','BAJA','PASILLO 5'),
(20,'Selladores','Siliconas y sellos','MEDIA','SECCION 3'),
(21,'Cables','Conductores eléctricos','ALTA','PASILLO 6'),
(22,'Interruptores','Control eléctrico','MEDIA','PASILLO 7'),
(23,'Iluminación','Luminarias','ALTA','PASILLO 8'),
(24,'Bombas','Bombas de agua','MEDIA','PASILLO 5'),
(25,'Tanques','Almacenamiento','BAJA','PASILLO 6'),
(26,'Accesorios PVC','Conectores','MEDIA','PASILLO 6'),
(27,'Escaleras','Acceso en altura','BAJA','PASILLO 7'),
(28,'Carretillas','Transporte manual','MEDIA','PASILLO 8'),
(29,'Brochas','Aplicadores','ALTA','SECCION 1'),
(30,'Rodillos','Pintura','ALTA','SECCION 1'),
(31,'Guantes','Protección manos','ALTA','SECCION 4'),
(32,'Cascos','Protección cabeza','MEDIA','SECCION 4'),
(33,'Mascarillas','Protección respiratoria','ALTA','SECCION 4'),
(34,'Impermeables','Protección lluvia','BAJA','SECCION 3'),
(35,'Adhesivos Especiales','Uso técnico','BAJA','SECCION 2');


--Tabla de proveedores y FK - PK
create table Proveedor
(
    Id_Proveedor CHAR(13) primary key,
    Nombre_Proveedor VARCHAR(50),
    Tipo_Suministro VARCHAR(50),
    Contacto CHAR(10),
    Correo CHAR(20),
    Tiempo_Entrega CHAR(3)
);
-- NOT NULL
alter table Proveedor
MODIFY COLUMN Nombre_Proveedor VARCHAR(50) not null;
-- CHECK
alter table Proveedor
add constraint tiempo_entrega_val
check (
    Tiempo_Entrega in ('15D', 'MEN', 'SEM', 'ANU')
);
alter table Proveedor
add constraint correo_proveedor_uq
UNIQUE(Correo);
INSERT INTO Proveedor
VALUES
('1790010001001','Holcim Ecuador','MATERIALES DE CONSTRUCCION','0991234567','holcim@ec.com','SEM'),
('1790010001002','Disensa','MATERIALES DE CONSTRUCCION','0982345678','disensa@ec.com','15D'),
('1790010001003','Ferrimax','HERRAMIENTAS','0973456789','ferrimax@ec.com','SEM'),
('1790010001004','Bosch','HERRAMIENTAS','0964567890','bosch@ec.com','MEN'),
('1790010001005','Stanley','HERRAMIENTAS','0955678901','stanley@ec.com','MEN'),
('1790010001006','Pintuco','PINTURAS','0946789012','pintuco@ec.com','15D'),
('1790010001007','Sika','PEGAMENTOS','0937890123','sika@ec.com','SEM'),
('1790010001008','Induma','HIERRO','0928901234','induma@ec.com','MEN'),
('1790010001009','Plastigama','PLOMERIA','0919012345','plastigama@ec.com','SEM'),
('1790010001010','Edesa','PLOMERIA','0900123456','edesa@ec.com','15D'),

('1790010001011','Schneider','ELECTRICIDAD','0991112233','sch@ec.com','MEN'),
('1790010001012','Siemens','ELECTRICIDAD','0982223344','siemens@ec.com','MEN'),
('1790010001013','Truper','HERRAMIENTAS','0973334455','truper@ec.com','SEM'),
('1790010001014','Makita','HERRAMIENTAS','0964445566','makita@ec.com','MEN'),
('1790010001015','3M','SEGURIDAD','0955556677','3m@ec.com','SEM'),
('1790010001016','Eternit','TECHOS','0946667788','eternit@ec.com','MEN'),
('1790010001017','Graiman','CERAMICA','0937778899','graiman@ec.com','15D'),
('1790010001018','FV','SANITARIOS','0928889900','fv@ec.com','MEN'),
('1790010001019','Philips','ILUMINACION','0919990011','philips@ec.com','MEN'),
('1790010001020','General Electric','ILUMINACION','0901100223','ge@ec.com','MEN'),

('1790010001021','Carlos Mena','MADERA','0998887776','cmena@ec.com','SEM'),
('1790010001022','Luis Torres','MADERA','0987776665','ltorres@ec.com','SEM'),
('1790010001023','PVCAndes','PLOMERIA','0976665554','pvc@ec.com','15D'),
('1790010001024','Cablex','ELECTRICIDAD','0965554443','cablex@ec.com','MEN'),
('1790010001025','EscaPro','ESCALERAS','0954443332','esca@ec.com','MEN'),
('1790010001026','Segurimax','SEGURIDAD','0943332221','seguri@ec.com','SEM'),
('1790010001027','Tanquesa','TANQUES','0932221110','tanquesa@ec.com','MEN'),
('1790010001028','Bombas Atlas','BOMBAS','0921110009','atlas@ec.com','MEN'),
('1790010001029','Abrasivos SA','LIJAS','0910009998','abras@ec.com','SEM'),
('1790010001030','Clavex','FIJACIONES','0909998887','clavex@ec.com','SEM'),

('1790010001031','TuercasPro','FIJACIONES','0990001112','tuercas@ec.com','SEM'),
('1790010001032','Sellamax','SELLADORES','0981112223','sellamax@ec.com','15D'),
('1790010001033','Impertec','IMPERMEABLES','0972223334','imper@ec.com','MEN'),
('1790010001034','Rodimex','PINTURA','0963334445','rodimex@ec.com','SEM'),
('1790010001035','BrochasPlus','PINTURA','0954445556','brochas@ec.com','SEM'),
('1790010001036','Luminex','ILUMINACION','0945556667','luminex@ec.com','MEN'),
('1790010001037','Protec','SEGURIDAD','0936667778','protec@ec.com','SEM'),
('1790010001038','ConstruRed','CONSTRUCCION','0927778889','red@ec.com','15D'),
('1790010001039','MegaTools','HERRAMIENTAS','0918889990','mega@ec.com','MEN'),
('1790010001040','Distribuidora Andes','CONSTRUCCION','0907776665','andes@ec.com','ANU');


--Tabla de clientes y FK - PK
create table Clientes
(
    Cedula CHAR(13) primary key,
    Nombre_Cliente VARCHAR(30),
    Razon_Social CHAR(4),
    Contacto CHAR(10),
    Correo CHAR(50),
    Direccion VARCHAR(50),
    Descuento_Asociado CHAR(2)
);
-- CHECHK
alter table Clientes
add constraint razon_social_val
check (
    Razon_Social in ('MINO', 'EMPR', 'MAYO', 'CONT', 'DIST')
);
-- NOT NULL
alter table Clientes
MODIFY COLUMN Nombre_Cliente VARCHAR(30) not null;
-- UNIQUE
alter table Clientes
add constraint correo_cliente_uq
UNIQUE(Correo);
INSERT INTO Clientes
VALUES
('1790010010001','Juan Perez','MAYO','0991111111','juan.perez@correo.com','Av. Amazonas 123','SI'),
('1790010010002','Carlos Mena','DIST','0991111112','carlos.mena@correo.com','Av. Colon 456','SI'),
('1790010010003','Luis Torres','MAYO','0991111113','luis.torres@correo.com','Av. Patria 789','SI'),
('1790010010004','Ana Ruiz','EMPR','0991111114','ana.ruiz@correo.com','Calle 10 Agosto','SI'),
('1790010010005','Maria Lopez','DIST','0991111115','maria.lopez@correo.com','Av. NNUU','SI'),
('1790010010006','Pedro Castro','MAYO','0991111116','pedro.castro@correo.com','Av. Occidental','SI'),
('1790010010007','Jose Mora','CONT','0991111117','jose.mora@correo.com','Av. Moran','SI'),
('1790010010008','Daniel Rios','DIST','0991111118','daniel.rios@correo.com','Av. Eloy Alfaro','SI'),
('1790010010009','Paola Vera','MAYO','0991111119','paola.vera@correo.com','Av. America','SI'),
('1790010010010','Carmen Soto','DIST','0991111120','carmen.soto@correo.com','Av. Mariscal','SI'),

('1790010010011','Miguel Paz','MAYO','0991111121','miguel.paz@correo.com','Av. Shyris','SI'),
('1790010010012','Sofia Luna','DIST','0991111122','sofia.luna@correo.com','Av. Naciones Unidas','SI'),
('1790010010013','Ricardo Leon','MAYO','0991111123','ricardo.leon@correo.com','Av. Republica','SI'),
('1790010010014','Andres Gil','DIST','0991111124','andres.gil@correo.com','Av. La Prensa','SI'),
('1790010010015','Patricia Solis','EMPR','0991111125','patricia.solis@correo.com','Av. Galo Plaza','SI'),
('1790010010016','Diego Navas','MAYO','0991111126','diego.navas@correo.com','Av. Granados','SI'),
('1790010010017','Veronica Cruz','DIST','0991111127','veronica.cruz@correo.com','Av. 6 Diciembre','SI'),
('1790010010018','Marco Ortiz','MAYO','0991111128','marco.ortiz@correo.com','Av. Maldonado','SI'),
('1790010010019','Rosa Paredes','DIST','0991111129','rosa.paredes@correo.com','Av. Simón Bolívar','SI'),
('1790010010020','Fernando Vega','MAYO','0991111130','fernando.vega@correo.com','Av. Occidental','SI'),

('1790010010021','Julio Moya','MINO','0991111131','julio.moya@correo.com','Calle A','NO'),
('1790010010022','Karla Rivas','MINO','0991111132','karla.rivas@correo.com','Calle B','NO'),
('1790010010023','Oscar Lima','CONT','0991111133','oscar.lima@correo.com','Calle C','NO'),
('1790010010024','Nancy Pino','MINO','0991111134','nancy.pino@correo.com','Calle D','NO'),
('1790010010025','Hugo Meza','EMPR','0991111135','hugo.meza@correo.com','Calle E','NO'),
('1790010010026','Daniela Paz','MINO','0991111136','daniela.paz@correo.com','Calle F','NO'),
('1790010010027','Kevin Ruiz','CONT','0991111137','kevin.ruiz@correo.com','Calle G','NO'),
('1790010010028','Lucia Mora','MINO','0991111138','lucia.mora@correo.com','Calle H','NO'),
('1790010010029','Paulo Gil','MINO','0991111139','paulo.gil@correo.com','Calle I','NO'),
('1790010010030','Sandra Leon','EMPR','0991111140','sandra.leon@correo.com','Calle J','NO'),

('1790010010031','Ivan Torres','MINO','0991111141','ivan.torres@correo.com','Calle K','NO'),
('1790010010032','Ruth Solano','MINO','0991111142','ruth.solano@correo.com','Calle L','NO'),
('1790010010033','Alex Herrera','CONT','0991111143','alex.herrera@correo.com','Calle M','NO'),
('1790010010034','Nadia Flores','MINO','0991111144','nadia.flores@correo.com','Calle N','NO'),
('1790010010035','Jorge Silva','EMPR','0991111145','jorge.silva@correo.com','Calle O','NO'),
('1790010010036','Diana Carrillo','MINO','0991111146','diana.carrillo@correo.com','Calle P','NO'),
('1790010010037','Cristian Vaca','MINO','0991111147','cristian.vaca@correo.com','Calle Q','NO'),
('1790010010038','Monica Espinoza','CONT','0991111148','monica.espinoza@correo.com','Calle R','NO'),
('1790010010039','Wilson Tapia','MINO','0991111149','wilson.tapia@correo.com','Calle S','NO'),
('1790010010040','Lorena Aguilar','MINO','0991111150','lorena.aguilar@correo.com','Calle T','NO'),

('1790010010041','Mario Nieto','MINO','0991111151','mario.nieto@correo.com','Calle U','NO'),
('1790010010042','Rocio Diaz','MINO','0991111152','rocio.diaz@correo.com','Calle V','NO'),
('1790010010043','Edgar Cobo','CONT','0991111153','edgar.cobo@correo.com','Calle W','NO'),
('1790010010044','Pamela Vera','MINO','0991111154','pamela.vera@correo.com','Calle X','NO'),
('1790010010045','Fabian Ruiz','MINO','0991111155','fabian.ruiz@correo.com','Calle Y','NO'),
('1790010010046','Adriana Paz','MINO','0991111156','adriana.paz@correo.com','Calle Z','NO'),
('1790010010047','Jonathan Silva','CONT','0991111157','jonathan.silva@correo.com','Calle AA','NO'),
('1790010010048','Valeria Soto','MINO','0991111158','valeria.soto@correo.com','Calle AB','NO'),
('1790010010049','Pablo Moya','MINO','0991111159','pablo.moya@correo.com','Calle AC','NO'),
('1790010010050','Camila Rojas','MINO','0991111160','camila.rojas@correo.com','Calle AD','NO');


-- Tabla de promociones
create table Promocion
(
    Id_Promocion CHAR(3) primary key,
    Nombre_Promocion VARCHAR(30),
    Tipo VARCHAR(20),
    Condicion_Minima VARCHAR(30),
    Porcentaje_Descuento DECIMAL(5,2),
    Fecha_Inicio DATETIME,
    Fecha_Fin DATETIME
);
-- NOT NULL
alter table Promocion
MODIFY COLUMN Nombre_Promocion VARCHAR(30) not null;
INSERT INTO Promocion
VALUES
(001,'Volumen Cemento','POR VOLUMEN','Minimo 10 SACOS',10.00,'2025-01-01','2025-12-12'),
(002,'Promo Herramientas','POR PRODUCTO','Minimo 5 CAJAS',12.00,'2025-02-01','2025-06-30'),
(003,'Temporada Pinturas','POR TEMPORADA','Minimo 8 PAQUETES',15.00,'2025-03-01','2025-09-30'),
(004,'Seguridad Industrial','POR PRODUCTO','Minimo 6 DOCENAS',18.00,'2025-04-01','2025-10-31'),
(005,'Electricidad Mayorista','POR VOLUMEN','Minimo 20 UNIDADES',20.00,'2025-05-01','2025-12-12');


-- Tabla de productos y FK - PK
create table Datos_Producto 
(
    Id_Producto int primary key,
    Nombre_Producto VARCHAR(100),
    Categoria int,
    Id_Proveedor CHAR(13),
    Presentacion CHAR(15),
    Unidades_por_Presentacion int,
    Stock_Presentacion int,
    Precio DECIMAL(15,2)
);
-- FK
alter table Datos_Producto
add CONSTRAINT id_proveedor_fk
Foreign Key (Id_Proveedor) 
REFERENCES Proveedor(Id_Proveedor);
alter table Datos_Producto
add CONSTRAINT categoria_fk
Foreign Key (Categoria) 
REFERENCES Categorias(Id_Categoria);
-- CHECK
alter table Datos_Producto
add CONSTRAINT precio_ck
check (Precio > 0);
-- UNIQUE
alter table Datos_Producto
add constraint nombre_uq
UNIQUE(Nombre_Producto);
-- NOT NULL
alter table Datos_Producto
MODIFY COLUMN Nombre_Producto VARCHAR(100) not null;
INSERT INTO Datos_Producto
VALUES
(1,'Martillo Acero 16oz',1,'1790010001002','UNIDAD',12,50,120.00),
(2,'Destornillador Plano',1,'1790010001011','DOCENA',12,40,85.00),
(3,'Taladro Electrico 800W',2,'1790010001002','CAJA',1,30,950.00),
(4,'Amoladora Industrial',2,'1790010001009','CAJA',1,25,870.00),
(5,'Clavo Acero 2p',16,'1790010001026','CAJA',500,60,75.00),
(6,'Clavo Acero 3p',16,'1790010001026','CAJA',500,55,82.00),
(7,'Tornillo Rosca Fina',3,'1790010001027','CAJA',300,70,110.00),
(8,'Tornillo Rosca Gruesa',3,'1790010001027','CAJA',300,65,115.00),
(9,'Cable THHN 12',24,'1790010001016','ROLLO',100,40,320.00),
(10,'Cable THHN 14',24,'1790010001016','ROLLO',100,45,280.00),

(11,'Interruptor Simple',25,'1790010001039','CAJA',50,35,90.00),
(12,'Interruptor Doble',25,'1790010001039','CAJA',50,30,130.00),
(13,'Tubo PVC 1p',5,'1790010001004','PAQUETE',20,60,140.00),
(14,'Tubo PVC 2p',5,'1790010001004','PAQUETE',15,55,210.00),
(15,'Pintura Latex Blanca',6,'1790010001005','BALDE',1,40,380.00),
(16,'Pintura Latex Azul',6,'1790010001005','BALDE',1,35,395.00),
(17,'Cemento Portland',7,'1790010001001','SACO',1,120,98.00),
(18,'Arena Lavada',7,'1790010001001','SACO',1,100,65.00),
(19,'Casco Seguridad',8,'1790010001006','PAQUETE',10,25,260.00),
(20,'Guantes Industriales',8,'1790010001006','PAQUETE',12,30,180.00),

(21,'Adhesivo Epoxico',10,'1790010001015','PAQUETE',6,40,150.00),
(22,'Silicon Transparente',29,'1790010001033','CAJA',24,45,210.00),
(23,'Lampara LED 18W',11,'1790010001040','CAJA',20,50,220.00),
(24,'Lampara LED 36W',11,'1790010001040','CAJA',20,45,360.00),
(25,'Cerradura Doble',12,'1790010001019','CAJA',10,30,420.00),
(26,'Lija Grano 80',13,'1790010001036','PAQUETE',50,60,95.00),
(27,'Lija Grano 120',13,'1790010001036','PAQUETE',50,55,100.00),
(28,'Aceite Lubricante',14,'1790010001023','CAJA',12,40,260.00),
(29,'Broca Concreto 8mm',26,'1790010001037','PAQUETE',10,50,135.00),
(30,'Broca Concreto 10mm',26,'1790010001037','PAQUETE',10,45,165.00),

(31,'Disco Corte Metal',27,'1790010001036','PAQUETE',10,60,190.00),
(32,'Rodamiento 6204',28,'1790010001025','CAJA',20,35,240.00),
(33,'Madera Triplex',19,'1790010001030','PAQUETE',5,30,520.00),
(34,'Electrodo Soldar',20,'1790010001020','CAJA',5,40,310.00),
(35,'Escalera Aluminio',21,'1790010001031','UNIDAD',1,15,850.00),
(36,'Extractor Aire',22,'1790010001032','CAJA',1,20,780.00),
(37,'Bomba Agua 1HP',23,'1790010001018','CAJA',1,18,1450.00),
(38,'Valvula Esfera 1p',33,'1790010001028','CAJA',20,45,210.00),
(39,'Cinta Aislante',35,'1790010001029','PAQUETE',12,70,75.00),
(40,'Medidor Voltaje',34,'1790010001024','CAJA',1,25,680.00),

(41,'Tuerca Hexagonal',17,'1790010001008','CAJA',400,60,95.00),
(42,'Perno Acero 1p',18,'1790010001009','CAJA',200,55,140.00),
(43,'Malla Electrosoldada',30,'1790010001034','ROLLO',1,20,980.00),
(44,'Andamio Modular',31,'1790010001017','UNIDAD',1,10,3200.00),
(45,'Tanque Agua 500L',32,'1790010001035','UNIDAD',1,12,1750.00),
(46,'Cinta Doble Faz',35,'1790010001029','PAQUETE',12,65,130.00),
(47,'Guantes Nitrilo',15,'1790010001038','PAQUETE',20,50,210.00),
(48,'Chaleco Reflectivo',15,'1790010001038','PAQUETE',10,40,260.00),
(49,'Pintura Esmalte',6,'1790010001013','BALDE',1,30,420.00),
(50,'Sellador Impermeable',29,'1790010001033','BALDE',1,25,510.00);


--Tabla de descuento a clientes frecuentes y FK - PK
create table Descuento_Clientes_Frecuentes
(
    Cedula CHAR(13) primary key,
    Descuento DECIMAL(5,2)
);
-- FK
alter table Descuento_Clientes_Frecuentes
add CONSTRAINT id_cliente_fk
Foreign Key (Cedula) 
REFERENCES Clientes(Cedula);
INSERT INTO Descuento_Clientes_Frecuentes
VALUES
('1790010010001',15.00),
('1790010010002',20.00),
('1790010010003',18.00),
('1790010010004',10.00),
('1790010010005',22.00),
('1790010010006',25.00),
('1790010010007',12.00),
('1790010010008',30.00),
('1790010010009',20.00),
('1790010010010',15.00),
('1790010010011',18.00),
('1790010010012',25.00),
('1790010010013',35.00),
('1790010010014',28.00),
('1790010010015',10.00),
('1790010010016',40.00),
('1790010010017',30.00),
('1790010010018',22.00),
('1790010010019',27.00),
('1790010010020',45.00);


--Tabla de compras y FK - PK
create table Compra
(
    Id_Compra char(10) primary key,
    Id_Proveedor char(13),
    Fecha_Compra DATETIME,
    Metodo_Pago CHAR(5)
);
-- FK
alter table Compra
add CONSTRAINT id_proveedor_2_fk
Foreign Key (Id_Proveedor) 
REFERENCES Proveedor(Id_Proveedor);
-- CHECK
alter table Compra
add constraint metodo_pago_val
check (
    Metodo_Pago in ('CHEQ/', 'EFEC/', 'TRFB/')
);
INSERT INTO Compra 
VALUES
('0000000001','1790010001001','2025-01-10 10:00:00','EFEC/'),
('0000000002','1790010001002','2025-01-15 11:30:00','TRFB/'),
('0000000003','1790010001003','2025-01-20 09:15:00','CHEQ/'),
('0000000004','1790010001004','2025-02-05 14:00:00','EFEC/'),
('0000000005','1790010001005','2025-02-10 16:20:00','TRFB/'),
('0000000006','1790010001006','2025-02-18 08:40:00','CHEQ/'),
('0000000007','1790010001007','2025-03-01 12:10:00','EFEC/'),
('0000000008','1790010001008','2025-03-06 10:50:00','TRFB/'),
('0000000009','1790010001009','2025-03-12 15:30:00','CHEQ/'),
('0000000010','1790010001010','2025-03-18 09:00:00','EFEC/'),

('0000000011','1790010001011','2025-04-02 11:00:00','TRFB/'),
('0000000012','1790010001012','2025-04-08 14:30:00','CHEQ/'),
('0000000013','1790010001013','2025-04-15 10:10:00','EFEC/'),
('0000000014','1790010001014','2025-04-20 16:45:00','TRFB/'),
('0000000015','1790010001015','2025-04-25 09:25:00','CHEQ/'),

('0000000016','1790010001016','2025-05-03 13:10:00','EFEC/'),
('0000000017','1790010001017','2025-05-10 15:40:00','TRFB/'),
('0000000018','1790010001018','2025-05-18 10:35:00','CHEQ/'),
('0000000019','1790010001019','2025-05-25 11:50:00','EFEC/'),
('0000000020','1790010001020','2025-06-01 14:20:00','TRFB/'),

('0000000021','1790010001021','2025-06-08 09:10:00','CHEQ/'),
('0000000022','1790010001022','2025-06-15 16:00:00','EFEC/'),
('0000000023','1790010001023','2025-06-22 10:45:00','TRFB/'),
('0000000024','1790010001024','2025-07-01 12:30:00','CHEQ/'),
('0000000025','1790010001025','2025-07-08 15:15:00','EFEC/'),

('0000000026','1790010001026','2025-07-15 09:00:00','TRFB/'),
('0000000027','1790010001027','2025-07-22 11:40:00','CHEQ/'),
('0000000028','1790010001028','2025-08-01 14:10:00','EFEC/'),
('0000000029','1790010001029','2025-08-08 10:00:00','TRFB/'),
('0000000030','1790010001030','2025-08-15 16:30:00','CHEQ/');


--Tabla de detalles de compra y FK - PK
create table Detalle_Compra
(
    Id_Detalle int primary key,
    Id_Compra char(10),
    Id_Producto int,
    Cantidad_Presentaciones int,
    Costo_Presentacion DECIMAL(15,2)
);
-- FK
alter table Detalle_Compra
add CONSTRAINT id_compra_fk
Foreign Key (Id_Compra) 
REFERENCES Compra(Id_Compra);
alter table Detalle_Compra
add CONSTRAINT id_producto_fk
Foreign Key (Id_Producto) 
REFERENCES Datos_Producto(Id_Producto);
-- CHECK
alter table Detalle_Compra
add CONSTRAINT costo_presentacion_ck
check (Costo_Presentacion > 0);
INSERT INTO Detalle_Compra
VALUES
(1,'0000000001',17,50,95.00),
(2,'0000000001',18,40,60.00),

(3,'0000000002',3,5,900.00),
(4,'0000000002',4,4,820.00),

(5,'0000000003',9,10,300.00),
(6,'0000000003',10,8,260.00),

(7,'0000000004',13,20,130.00),
(8,'0000000004',14,15,190.00),

(9,'0000000005',15,10,360.00),
(10,'0000000005',16,8,370.00),

(11,'0000000006',19,6,240.00),
(12,'0000000006',20,5,165.00),

(13,'0000000007',21,12,140.00),
(14,'0000000007',22,10,195.00),

(15,'0000000008',23,10,210.00),
(16,'0000000008',24,8,340.00),

(17,'0000000009',25,6,390.00),
(18,'0000000009',26,20,85.00),

(19,'0000000010',27,18,90.00),
(20,'0000000010',28,10,240.00),

(21,'0000000011',29,15,125.00),
(22,'0000000011',30,12,155.00),

(23,'0000000012',31,14,180.00),
(24,'0000000012',32,10,225.00),

(25,'0000000013',33,8,480.00),
(26,'0000000013',34,12,290.00),

(27,'0000000014',35,3,820.00),
(28,'0000000014',36,4,740.00),

(29,'0000000015',37,3,1380.00),
(30,'0000000015',38,10,195.00),

(31,'0000000016',39,20,70.00),
(32,'0000000016',40,5,650.00),
(33,'0000000016',41,30,85.00),

(34,'0000000017',42,25,130.00),
(35,'0000000017',43,3,950.00),
(36,'0000000017',44,2,3000.00),

(37,'0000000018',45,2,1650.00),
(38,'0000000018',46,20,120.00),
(39,'0000000018',47,15,195.00),

(40,'0000000019',48,10,240.00),
(41,'0000000019',49,6,400.00),
(42,'0000000019',50,4,480.00),

(43,'0000000020',1,12,110.00),
(44,'0000000020',2,10,80.00),
(45,'0000000020',5,20,70.00),

(46,'0000000021',6,18,75.00),
(47,'0000000021',7,15,105.00),
(48,'0000000021',8,12,110.00),

(49,'0000000022',9,6,300.00),
(50,'0000000022',10,6,260.00),
(51,'0000000022',11,8,85.00),

(52,'0000000023',12,8,120.00),
(53,'0000000023',13,15,130.00),
(54,'0000000023',14,12,190.00),

(55,'0000000024',15,6,360.00),
(56,'0000000024',16,5,370.00),
(57,'0000000024',17,30,95.00),

(58,'0000000025',18,25,60.00),
(59,'0000000025',19,8,240.00),
(60,'0000000025',20,6,165.00),

(61,'0000000026',21,10,140.00),
(62,'0000000026',22,8,195.00),
(63,'0000000026',23,6,210.00),

(64,'0000000027',24,5,340.00),
(65,'0000000027',25,4,390.00),
(66,'0000000027',26,12,85.00),

(67,'0000000028',27,10,90.00),
(68,'0000000028',28,8,240.00),
(69,'0000000028',29,12,125.00),

(70,'0000000029',30,10,155.00),
(71,'0000000029',31,8,180.00),
(72,'0000000029',32,6,225.00),

(73,'0000000030',33,6,480.00),
(74,'0000000030',34,10,290.00),
(75,'0000000030',35,2,820.00);


--Tabla de facturas y FK - PK
create table Factura
(
    Id_Factura int primary key,
    Id_Compra char(10),
    Cedula CHAR(13),
    Fecha_venta DATETIME,
    Forma_Pago CHAR(5),
    Aplica_Promocion CHAR(2),
    Promocion char(3)
);
-- FK
alter table Factura
add CONSTRAINT id_cliente_2_fk
Foreign Key (Cedula) 
REFERENCES Clientes(Cedula);
alter table Factura
add CONSTRAINT id_compra_factura_fk
Foreign Key (Id_Compra) 
REFERENCES Compra(Id_Compra);
alter table Factura
add CONSTRAINT promocion_fk
Foreign Key (Promocion) 
REFERENCES Promocion(Id_Promocion);
-- CHECK
alter table Factura
add constraint forma_pago_val
check (
    Forma_Pago in ('CHEQ/', 'EFEC/', 'TRFB/')
);
INSERT INTO Factura
VALUES
(1,'0000000001','1790010010001','2025-01-12 11:00:00','EFEC/','SI',001),
(2,'0000000002','1790010010002','2025-01-16 12:00:00','TRFB/','SI',001),
(3,'0000000003','1790010010003','2025-01-22 10:00:00','CHEQ/','NO',NULL),
(4,'0000000004','1790010010004','2025-02-06 15:00:00','EFEC/','SI',002),
(5,'0000000005','1790010010005','2025-02-12 17:00:00','TRFB/','SI',002),
(6,'0000000006','1790010010006','2025-02-19 09:30:00','CHEQ/','NO',NULL),
(7,'0000000007','1790010010007','2025-03-02 13:00:00','EFEC/','SI',003),
(8,'0000000008','1790010010008','2025-03-07 11:30:00','TRFB/','NO',NULL),
(9,'0000000009','1790010010009','2025-03-14 16:00:00','CHEQ/','SI',003),
(10,'0000000010','1790010010010','2025-03-19 10:00:00','EFEC/','NO',NULL),

(11,'0000000011','1790010010011','2025-04-03 12:00:00','TRFB/','SI',004),
(12,'0000000012','1790010010012','2025-04-10 15:00:00','CHEQ/','NO',NULL),
(13,'0000000013','1790010010013','2025-04-16 11:00:00','EFEC/','SI',004),
(14,'0000000014','1790010010014','2025-04-21 17:00:00','TRFB/','NO',NULL),
(15,'0000000015','1790010010015','2025-04-26 10:00:00','CHEQ/','SI',005),

(16,'0000000016','1790010010016','2025-05-04 14:00:00','EFEC/','NO',NULL),
(17,'0000000017','1790010010017','2025-05-11 16:30:00','TRFB/','SI',005),
(18,'0000000018','1790010010018','2025-05-19 11:30:00','CHEQ/','NO',NULL),
(19,'0000000019','1790010010019','2025-05-26 12:30:00','EFEC/','NO',NULL),
(20,'0000000020','1790010010020','2025-06-02 15:00:00','TRFB/','SI',001),

(21,'0000000021','1790010010001','2025-06-09 10:30:00','CHEQ/','NO',NULL),
(22,'0000000022','1790010010002','2025-06-16 17:00:00','EFEC/','SI',002),
(23,'0000000023','1790010010003','2025-06-23 11:30:00','TRFB/','NO',NULL),
(24,'0000000024','1790010010004','2025-07-02 13:00:00','CHEQ/','SI',003),
(25,'0000000025','1790010010005','2025-07-09 16:00:00','EFEC/','NO',NULL),

(26,'0000000026','1790010010006','2025-07-16 10:00:00','TRFB/','SI',004),
(27,'0000000027','1790010010007','2025-07-23 12:00:00','CHEQ/','NO',NULL),
(28,'0000000028','1790010010008','2025-08-02 15:00:00','EFEC/','SI',005),
(29,'0000000029','1790010010009','2025-08-09 11:00:00','TRFB/','NO',NULL),
(30,'0000000030','1790010010010','2025-08-16 17:30:00','CHEQ/','SI',001);


--Tabla de detalles de facturas y FK - PK
create table Detalle_Factura
(
    Id_Detalle_Factura int primary key,
    Id_Factura int,
    Id_Producto int,
    Cantidad_Presentaciones int,
    Precio DECIMAL(15,2),
    IVA DECIMAL(15,2)
);
-- FK
alter table Detalle_Factura
add CONSTRAINT id_factura_fk
Foreign Key (Id_Factura) 
REFERENCES Factura(Id_Factura);
alter table Detalle_Factura
add CONSTRAINT id_producto_2_fk
Foreign Key (Id_Producto) 
REFERENCES Datos_Producto(Id_Producto);
-- DEFAULT
alter table Detalle_Factura
MODIFY COLUMN IVA DECIMAL(15,2) default 0.15;
-- CHECK
alter table Detalle_Factura
add CONSTRAINT Precio_2_ck
check (Precio > 0);
INSERT INTO Detalle_Factura
(Id_Detalle_Factura, Id_Factura, Id_Producto, Cantidad_Presentaciones, Precio)
VALUES
(1,1,17,5,95.00),
(2,1,18,4,60.00),

(3,2,3,8,900.00),
(4,2,4,9,820.00),

(5,3,9,10,300.00),
(6,3,10,8,260.00),

(7,4,13,2,130.00),
(8,4,14,15,190.00),

(9,5,15,11,360.00),
(10,5,16,8,370.00),

(11,6,19,3,240.00),
(12,6,20,6,165.00),

(13,7,21,12,140.00),
(14,7,22,1,195.00),

(15,8,23,4,210.00),
(16,8,24,18,340.00),

(17,9,25,6,390.00),
(18,9,26,20,85.00),

(19,10,27,8,90.00),
(20,10,28,10,240.00),

(21,11,29,5,125.00),
(22,11,30,12,155.00),

(23,12,31,4,180.00),
(24,12,32,10,225.00),

(25,13,33,18,480.00),
(26,13,34,2,290.00),

(27,14,35,3,820.00),
(28,14,36,4,740.00),

(29,15,37,7,1380.00),
(30,15,38,8,195.00),

(31,16,39,19,70.00),
(32,16,40,5,650.00),
(33,16,41,21,85.00),

(34,17,42,25,130.00),
(35,17,43,3,950.00),
(36,17,44,2,3000.00),

(37,18,45,2,1650.00),
(38,18,46,16,120.00),
(39,18,47,10,195.00),

(40,19,48,9,240.00),
(41,19,49,6,400.00),
(42,19,50,4,480.00),

(43,20,1,12,110.00),
(44,20,2,10,80.00),
(45,20,5,17,70.00),

(46,21,6,18,75.00),
(47,21,7,15,105.00),
(48,21,8,12,110.00),

(49,22,9,6,300.00),
(50,22,10,6,260.00),
(51,22,11,7,85.00),

(52,23,12,8,120.00),
(53,23,13,13,130.00),
(54,23,14,12,190.00),

(55,24,15,6,360.00),
(56,24,16,5,370.00),
(57,24,17,26,95.00),

(58,25,18,21,60.00),
(59,25,19,8,240.00),
(60,25,20,6,165.00),

(61,26,21,10,140.00),
(62,26,22,8,195.00),
(63,26,23,6,210.00),

(64,27,24,5,340.00),
(65,27,25,4,390.00),
(66,27,26,9,85.00),

(67,28,27,10,90.00),
(68,28,28,8,240.00),
(69,28,29,12,125.00),

(70,29,30,10,155.00),
(71,29,31,8,180.00),
(72,29,32,6,225.00),

(73,30,33,6,480.00),
(74,30,34,10,290.00),
(75,30,35,7,820.00);


-- Extra
show tables;