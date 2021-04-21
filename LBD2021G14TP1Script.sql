-- Año:2021
-- Grupo Nro:14
-- Integrantes:Juan Carlos Rojas, Ivan Alexis Vera
-- Tema:Casa de Deporte (SportZone)
-- Nombre del Esquema:lbd202114sportzone
-- Plataforma (SO + Versión): Windows 10 Pro
-- Motor y Versión: MySQL Server 5.7 (Community Edition)
-- GitHub Repositorio: LBD2021G14
-- GitHub Usuario: JRojas11, IvanFurius



drop database if exists lbd202114sportzone;

create database if not exists lbd202114sportzone;

use lbd202114sportzone;

-- 
-- TABLE: Clientes 
--

CREATE TABLE Clientes(
    IdClientes    INT             NOT NULL,
    DNI           INT             NOT NULL,
    Apellido      VARCHAR(50)     NOT NULL,
    Nombre        VARCHAR(50)     NOT NULL,
    Direccion     VARCHAR(100)    NOT NULL,
    Email         VARCHAR(100),
    PRIMARY KEY (IdClientes)
)ENGINE=INNODB
;



-- 
-- TABLE: Cobros 
--

CREATE TABLE Cobros(
    IdCobros           INT         NOT NULL,
    IdUsuarioCobros    INT         NOT NULL,
    IdUsuario          INT         NOT NULL,
    IdVentas           INT         NOT NULL,
    IdClientes         INT         NOT NULL,
    Estado             CHAR(1)     DEFAULT 'P' NOT NULL
                       CHECK (Estado IN ('P','C','F')),
    fecha              DATETIME    DEFAULT current_timestamp NOT NULL,
    PRIMARY KEY (IdCobros, IdUsuarioCobros, IdUsuario, IdVentas, IdClientes)
)ENGINE=INNODB
;



-- 
-- TABLE: Compras 
--

CREATE TABLE Compras(
    IdCompra            INT             NOT NULL,
    IdProveedores       INT             NOT NULL,
    FechaPedido         DATETIME        NOT NULL,
    FechaLlegada        DATETIME        NOT NULL,
    FechaRealLlegada    DATETIME,
    Estado              CHAR(1)         DEFAULT 'S' NOT NULL
                        CHECK (Estado IN ('S','I', 'C','F')),
    Comentarios         VARCHAR(200),
    PRIMARY KEY (IdCompra, IdProveedores)
)ENGINE=INNODB
;



-- 
-- TABLE: LineaDeCompra 
--

CREATE TABLE LineaDeCompra(
    IdProducto       INT             NOT NULL,
    IdCompra         INT             NOT NULL,
    IdProveedores    INT             NOT NULL,
    PrecioCompra     FLOAT(8, 0)     NOT NULL,
    Cantidad         INT             DEFAULT 10 NOT NULL
                     CHECK (Cantidad IN (10,20,30,40,50,60,70,80,90,100)),
    Comentario       VARCHAR(200),
    PRIMARY KEY (IdProducto, IdCompra, IdProveedores)
)ENGINE=INNODB
;



-- 
-- TABLE: LineaDeVenta 
--

CREATE TABLE LineaDeVenta(
    IdProducto    INT    NOT NULL,
    IdVentas      INT    NOT NULL,
    IdClientes    INT    NOT NULL,
    IdUsuario     INT    NOT NULL,
    Cantidad      INT    DEFAULT 1 NOT NULL
                  CHECK (Cantidad IN (1,2,3,4,5,6,7,8,9,10)),
    PRIMARY KEY (IdProducto, IdVentas, IdClientes, IdUsuario)
)ENGINE=INNODB
;



-- 
-- TABLE: Productos 
--

CREATE TABLE Productos(
    IdProducto     INT             NOT NULL,
    Codigo         INT             NOT NULL,
    Nombre         VARCHAR(50)     NOT NULL,
    Estado         CHAR(1)         DEFAULT 'D' NOT NULL
                   CHECK (Estado IN ('D','N')),
    Talla          VARCHAR(10)     NOT NULL,
    Marca          VARCHAR(30)     NOT NULL,
    PrecioVenta    FLOAT(8, 0)     NOT NULL,
    Foto           BLOB            DEFAULT NULL,
    Cantidad       INT             DEFAULT 1 NOT NULL,
    Comentarios    VARCHAR(200),
    PRIMARY KEY (IdProducto)
)ENGINE=INNODB
;



-- 
-- TABLE: Proveedores 
--

CREATE TABLE Proveedores(
    IdProveedores     INT            NOT NULL,
    CUIT              BIGINT         NOT NULL,
    RazonSocial       VARCHAR(50)    NOT NULL,
    Telefono          VARCHAR(30)    NOT NULL,
    Direccion         VARCHAR(50),
    Estado            CHAR(1)        DEFAULT 'A' NOT NULL
                      CHECK (Estado IN ('A','I')),
    NombreContacto    VARCHAR(50),
    PRIMARY KEY (IdProveedores)
)ENGINE=INNODB
;



-- 
-- TABLE: Usuarios 
--

CREATE TABLE Usuarios(
    IdUsuario    INT             NOT NULL,
    DNI          INT             NOT NULL,
    Cargo        CHAR(1)         NOT NULL
                 CHECK (Cargo IN ('C','V')),
    Apellido     VARCHAR(50)     NOT NULL,
    Nombre       VARCHAR(50)     NOT NULL,
    Direccion    VARCHAR(100)    NOT NULL,
    Telefono     VARCHAR(30)     NOT NULL,
    Estado       CHAR(1)         DEFAULT 'A' NOT NULL
                 CHECK (Estado IN ('A','I')),
    Email        VARCHAR(100),
    PRIMARY KEY (IdUsuario)
)ENGINE=INNODB
;



-- 
-- TABLE: Ventas 
--

CREATE TABLE Ventas(
    IdVentas      INT         NOT NULL,
    IdClientes    INT         NOT NULL,
    IdUsuario     INT         NOT NULL,
    Estado        CHAR(1)     DEFAULT 'A' NOT NULL
                  CHECK (Estado IN ('A', 'B','T')),
    Fecha         DATETIME    DEFAULT current_timestamp NOT NULL,
    PRIMARY KEY (IdVentas, IdClientes, IdUsuario)
)ENGINE=INNODB
;



-- 
-- INDEX: UI_DNI 
--

CREATE UNIQUE INDEX UI_DNI ON Clientes(DNI)
;
-- 
-- INDEX: IX_Apellido 
--

CREATE INDEX IX_Apellido ON Clientes(Apellido)
;
-- 
-- INDEX: IX_fechaCobro 
--

CREATE INDEX IX_fechaCobro ON Cobros(fecha)
;
-- 
-- INDEX: Ref1011 
--

CREATE INDEX Ref1011 ON Cobros(IdUsuarioCobros)
;
-- 
-- INDEX: Ref1222 
--

CREATE INDEX Ref1222 ON Cobros(IdVentas, IdClientes, IdUsuario)
;
-- 
-- INDEX: IX_FechaPedido 
--

CREATE INDEX IX_FechaPedido ON Compras(FechaPedido)
;
-- 
-- INDEX: IX_FechaLlegada 
--

CREATE INDEX IX_FechaLlegada ON Compras(FechaLlegada)
;
-- 
-- INDEX: Ref1819 
--

CREATE INDEX Ref1819 ON Compras(IdProveedores)
;
-- 
-- INDEX: Ref1416 
--

CREATE INDEX Ref1416 ON LineaDeCompra(IdProducto)
;
-- 
-- INDEX: Ref1718 
--

CREATE INDEX Ref1718 ON LineaDeCompra(IdCompra, IdProveedores)
;
-- 
-- INDEX: Ref1414 
--

CREATE INDEX Ref1414 ON LineaDeVenta(IdProducto)
;
-- 
-- INDEX: Ref1223 
--

CREATE INDEX Ref1223 ON LineaDeVenta(IdVentas, IdClientes, IdUsuario)
;
-- 
-- INDEX: UI_Codigo 
--

CREATE UNIQUE INDEX UI_Codigo ON Productos(Codigo)
;
-- 
-- INDEX: IX_Nombre 
--

CREATE INDEX IX_Nombre ON Productos(Nombre)
;
-- 
-- INDEX: UI_CUIT 
--

CREATE UNIQUE INDEX UI_CUIT ON Proveedores(CUIT)
;
-- 
-- INDEX: IX_RazonSocial 
--

CREATE INDEX IX_RazonSocial ON Proveedores(RazonSocial)
;
-- 
-- INDEX: UI_DNI 
--

CREATE UNIQUE INDEX UI_DNI ON Usuarios(DNI)
;
-- 
-- INDEX: IX_Apellido 
--

CREATE INDEX IX_Apellido ON Usuarios(Apellido)
;
-- 
-- INDEX: IX_FechaVenta 
--

CREATE INDEX IX_FechaVenta ON Ventas(Fecha)
;
-- 
-- INDEX: Ref1012 
--

CREATE INDEX Ref1012 ON Ventas(IdUsuario)
;
-- 
-- INDEX: Ref1317 
--

CREATE INDEX Ref1317 ON Ventas(IdClientes)
;
-- 
-- TABLE: Cobros 
--

ALTER TABLE Cobros ADD CONSTRAINT RefUsuarios11 
    FOREIGN KEY (IdUsuarioCobros)
    REFERENCES Usuarios(IdUsuario)
;

ALTER TABLE Cobros ADD CONSTRAINT RefVentas22 
    FOREIGN KEY (IdUsuario, IdVentas, IdClientes)
    REFERENCES Ventas(IdUsuario, IdVentas, IdClientes)
;


-- 
-- TABLE: Compras 
--

ALTER TABLE Compras ADD CONSTRAINT RefProveedores19 
    FOREIGN KEY (IdProveedores)
    REFERENCES Proveedores(IdProveedores)
;


-- 
-- TABLE: LineaDeCompra 
--

ALTER TABLE LineaDeCompra ADD CONSTRAINT RefProductos16 
    FOREIGN KEY (IdProducto)
    REFERENCES Productos(IdProducto)
;

ALTER TABLE LineaDeCompra ADD CONSTRAINT RefCompras18 
    FOREIGN KEY (IdCompra, IdProveedores)
    REFERENCES Compras(IdCompra, IdProveedores)
;


-- 
-- TABLE: LineaDeVenta 
--

ALTER TABLE LineaDeVenta ADD CONSTRAINT RefProductos14 
    FOREIGN KEY (IdProducto)
    REFERENCES Productos(IdProducto)
;

ALTER TABLE LineaDeVenta ADD CONSTRAINT RefVentas23 
    FOREIGN KEY (IdVentas, IdClientes, IdUsuario)
    REFERENCES Ventas(IdVentas, IdClientes, IdUsuario)
;


-- 
-- TABLE: Ventas 
--

ALTER TABLE Ventas ADD CONSTRAINT RefUsuarios12 
    FOREIGN KEY (IdUsuario)
    REFERENCES Usuarios(IdUsuario)
;

ALTER TABLE Ventas ADD CONSTRAINT RefClientes17 
    FOREIGN KEY (IdClientes)
    REFERENCES Clientes(IdClientes)
;


--
-- INSERTs USUARIOS
--

INSERT INTO Usuarios VALUES (101,30000000,'C','Ibiris','Pablo','Italia 154',4236574,'A','pIbiris@gmail.com');
INSERT INTO Usuarios VALUES (102,30000001,'C','Ibiris','Luis','Italia 154',4236574,'A','lIbiris@gmail.com');
INSERT INTO Usuarios VALUES (103,30000002,'C','Paez','Lucas','Santa Fe 751',4785574,'A',NULL);
INSERT INTO Usuarios VALUES (104,30000003,'C','Lencina','Jesus','Corrientes 289',4785239,'A','jLencina@gmail.com');
INSERT INTO Usuarios VALUES (105,30000004,'C','Sotelo','Pablo','La Plata 19',3814562697,'A','pSotelo@gmail.com');
INSERT INTO Usuarios VALUES (106,30000005,'V','Soria','Pedro','Mendoza 541',3813002697,'A','pSoria@gmail.com');
INSERT INTO Usuarios VALUES (107,30000006,'V','Sanchez','Betty','Alberdi 532',3814562486,'A','bSanchez@gmail.com');
INSERT INTO Usuarios VALUES (108,30000007,'V','Diaz','Susana','Santa Fe 1495',3814562470,'A','sDiaz@gmail.com');
INSERT INTO Usuarios VALUES (109,30000008,'V','Mesa','Quemasaplauda','Piedras 147',3814563697,'A','MesaQueMasAplauda@gmail.com');
INSERT INTO Usuarios VALUES (110,30000009,'V','Zinc','Ariel','Ayacucho 1050',3814562520,'A','aZinc@gmail.com');
INSERT INTO Usuarios VALUES (111,30000010,'V','Calcio','Ricardo','Cordoba 237',381595197,'A','rCalcio@gmail.com');
INSERT INTO Usuarios VALUES (112,30000011,'V','Sansone','Marcos','Maipu 215',3814560007,'A','mSansone@gmail.com');
INSERT INTO Usuarios VALUES (113,30000012,'V','Calvo','Marcia','Roca 3250',3814562741,'A','mCalvo@gmail.com');
INSERT INTO Usuarios VALUES (114,30000013,'V','Lopez','Anastasia','Espania 345',3814533397,'I','aLopez@gmail.com');
INSERT INTO Usuarios VALUES (115,30000014,'V','Brito','Ramona','Congreso 258',3814562787,'A','rBrito@gmail.com');
INSERT INTO Usuarios VALUES (116,30000015,'V','Cabral','Florencia','Azurduy 706',3813572697,'A','fCabral@gmail.com');
INSERT INTO Usuarios VALUES (117,30000016,'V','Diaz','Emilio','Brasil 2014',3814577777,'A','eDiaz@gmail.com');
INSERT INTO Usuarios VALUES (118,30000017,'V','Frias','Adrian','La Rioja 23',3814566667,'I','aFrias@gmail.com');
INSERT INTO Usuarios VALUES (119,30000018,'V','Lazarte','Pablo','Salta 199',3814561117,'A','pLazarte@gmail.com');
INSERT INTO Usuarios VALUES (120,30000019,'V','Mazza','Ahilen','Junin 8',3814562000,'A',NULL);


--
-- INSERTs PROVEEDORES
--

INSERT INTO Proveedores VALUES (201,30260000009,'SportX',4302010,'La Paz 321','A', 'Homero Simpson');
INSERT INTO Proveedores VALUES (202,30260000019,'SportXY',4302011,'Santa Fe 196','A', 'Ignacio Perez');
INSERT INTO Proveedores VALUES (203,30260000029,'SportXYZ',4302012,'Cordoba 14','A', 'Roque Corre');
INSERT INTO Proveedores VALUES (204,30260000039,'DeportX',4302013,'Bolivia 269','A', 'Elsa Pito');
INSERT INTO Proveedores VALUES (205,30260000049,'DeportXY',4302014,'Chile 975','A', 'Lucas Cordoba');
INSERT INTO Proveedores VALUES (206,30260000059,'DeportXYZ',4302015,'Mitre 453','A', 'Pedro Cosmefulanito');
INSERT INTO Proveedores VALUES (207,30260000069,'Fitness',4302016,'Don Bosco 21','A', 'Manuel Belgrano');
INSERT INTO Proveedores VALUES (208,30260000079,'Fitness2.0',4302017,'Asuncion 300','A', 'Juan Totti');
INSERT INTO Proveedores VALUES (209,30260000089,'Fitness3.0',4302018,'San Juan 653','A', 'Franco Escamilla');
INSERT INTO Proveedores VALUES (210,30260000099,'Sportive',4302019,'Alberti 46','I', 'Javier Lopez');
INSERT INTO Proveedores VALUES (211,30260000109,'Sportive2.0',4302110,'Peru 164','A', 'Eduardo Rapelli');
INSERT INTO Proveedores VALUES (212,30260000119,'Sportive3.0',4302210,'Ecuador 100','A', 'Rosendo Lomas');
INSERT INTO Proveedores VALUES (213,30260000129,'Sportacous',4302310,'Thames 388','A', 'Alfredo Zarria');
INSERT INTO Proveedores VALUES (214,30260000139,'Sportacous2.0',4302410,'Bulnes 1301','A', 'Juan Manuel de la Raya');
INSERT INTO Proveedores VALUES (215,30260000149,'LocosFit',4302510,'Castelli 705','I', 'Antonio Padua');
INSERT INTO Proveedores VALUES (216,30260000159,'Paco Garcia',4302610,'Azcuenaga 806','A', 'Javier Yerbal');
INSERT INTO Proveedores VALUES (217,30260000169,'Deporting',4302710,'Viamonte 75','I', 'Julio Cortaza');
INSERT INTO Proveedores VALUES (218,30260000179,'Adrenalina',4302810,'Lincoln 96','A', 'Florencio Randazo');
INSERT INTO Proveedores VALUES (219,30260000189,'Adrenalina2.0',4302910,'San Lorenzo 321','A', 'Rodolfo Walsh');
INSERT INTO Proveedores VALUES (220,30260000199,'Adrenalina3.0',4312010,'Leon Gallo 123','I', 'Issac Newton');

--
-- INSERTs PRODUCTOS
--

INSERT INTO Productos VALUES (301,10001,'Zapatilla','D',40,'Adidas',9500,NULL,10,NULL);
INSERT INTO Productos VALUES (302,10002,'Zapatilla','D',41,'Nike',9000,NULL,10,NULL);
INSERT INTO Productos VALUES (303,10003,'Remera','D','XL','Puma',1300,NULL,30,NULL);
INSERT INTO Productos VALUES (304,10004,'Pantalon Corto','D','L','Adidas',2500,NULL,20,NULL);
INSERT INTO Productos VALUES (305,10005,'Zapatilla','D',40,'Adidas',6900,NULL,10,NULL);
INSERT INTO Productos VALUES (306,10006,'Botines','D',38,'Nike',5000,NULL,30,NULL);
INSERT INTO Productos VALUES (307,10007,'Zapatilla','D',36,'Nike',7500,NULL,10,NULL);
INSERT INTO Productos VALUES (308,10008,'Zapatilla','D',42,'Puma',8300,NULL,40,NULL);
INSERT INTO Productos VALUES (309,10009,'Remera','D','L','Puma',3200,NULL,10,NULL);
INSERT INTO Productos VALUES (310,10010,'Remera','D','XL','Adidas',1900,NULL,20,NULL);
INSERT INTO Productos VALUES (311,10011,'Zapatilla','D',35,'Adidas',6400,NULL,10,NULL);
INSERT INTO Productos VALUES (312,10012,'Pantalon Corto','D','M','Nike',2700,NULL,10,NULL);
INSERT INTO Productos VALUES (313,10013,'Pantalon Largo','D','XL','Nike',1900,NULL,30,NULL);
INSERT INTO Productos VALUES (314,10014,'Pantalon Largo','D','XXL','Adidas',1500,NULL,10,NULL);
INSERT INTO Productos VALUES (315,10015,'Zapatilla','D',40,'Puma',8700,NULL,10,NULL);
INSERT INTO Productos VALUES (316,10016,'Zapatilla','D',41,'Nike',9500,NULL,40,NULL);
INSERT INTO Productos VALUES (317,10017,'Botines','D',38,'Adidas',6400,NULL,10,NULL);
INSERT INTO Productos VALUES (318,10018,'Botines','D',40,'Puma',5900,NULL,20,NULL);
INSERT INTO Productos VALUES (319,10019,'Botines','D',42,'Adidas',7200,NULL,10,NULL);
INSERT INTO Productos VALUES (320,10020,'Zapatilla','D',37,'Adidas',8100,NULL,10,NULL);

--
-- INSERTs COMPRAS
--

INSERT INTO Compras VALUES (401,201,'2020-01-10 18:00:00','2020-01-17 18:00:00','2020-01-16 12:00:00','F',NULL);
INSERT INTO Compras VALUES (402,202,'2020-01-20 18:00:00','2020-01-27 18:00:00',NULL,'C','Nunca llego el pedido');
INSERT INTO Compras VALUES (403,203,'2020-02-08 18:00:00','2020-02-15 18:00:00','2020-02-15 18:52:10','F',NULL);
INSERT INTO Compras VALUES (404,204,'2020-02-19 18:00:00','2020-02-26 18:00:00','2020-02-26 11:00:00','F',NULL);
INSERT INTO Compras VALUES (405,205,'2020-03-01 18:00:00','2020-03-08 18:00:00','2020-03-12 17:00:00','C','Llego el pedido en mal estado');
INSERT INTO Compras VALUES (406,206,'2020-03-14 18:00:00','2020-03-21 18:00:00','2020-03-20 18:00:00','F',NULL);
INSERT INTO Compras VALUES (407,207,'2020-04-06 18:00:00','2020-04-13 18:00:00','2020-04-11 17:52:21','F',NULL);
INSERT INTO Compras VALUES (408,208,'2020-04-20 18:00:00','2020-04-27 18:00:00','2020-04-26 17:23:00','F',NULL);
INSERT INTO Compras VALUES (409,209,'2020-05-02 18:00:00','2020-05-09 18:00:00',NULL,'C','Nunca llego el pedido');
INSERT INTO Compras VALUES (410,210,'2020-05-10 18:00:00','2020-05-17 18:00:00','2020-05-20 19:40:18','C','Llego el pedido en mal estado');
INSERT INTO Compras VALUES (411,211,'2020-06-04 18:00:00','2020-06-11 18:00:00',NULL,'C','Nunca llego el pedido');
INSERT INTO Compras VALUES (412,212,'2020-06-16 18:00:00','2020-06-23 18:00:00','2020-06-26 10:30:45','F','Problemas con el transporte, pero se soluciono');
INSERT INTO Compras VALUES (413,213,'2020-07-09 18:00:00','2020-07-16 18:00:00','2020-07-16 17:04:20','F',NULL);
INSERT INTO Compras VALUES (414,214,'2020-07-18 18:00:00','2020-07-25 18:00:00','2020-07-25 10:30:54','F',NULL);
INSERT INTO Compras VALUES (415,215,'2020-09-03 18:00:00','2020-09-10 18:00:00','2020-09-08 12:00:23','F',NULL);
INSERT INTO Compras VALUES (416,216,'2021-03-16 18:00:00','2021-03-23 18:00:00',NULL,'C','Problemas con el transporte, no se soluciono');
INSERT INTO Compras VALUES (417,217,'2021-03-28 18:00:00','2021-04-04 18:00:00','2021-03-08 16:48:50','I','Pedido Incompleto');
INSERT INTO Compras VALUES (418,218,'2021-04-08 18:00:00','2021-04-18 18:00:00',NULL,'S',NULL);
INSERT INTO Compras VALUES (419,219,'2021-04-14 18:00:00','2021-04-21 18:00:00',NULL,'S',NULL);
INSERT INTO Compras VALUES (420,220,'2021-04-20 18:00:00','2021-04-27 18:00:00',NULL,'S',NULL);

--
-- INSERTs LINEAS DE COMPRA
--

INSERT INTO LineaDeCompra VALUES (301,401,201,5000,20,NULL);
INSERT INTO LineaDeCompra VALUES (302,402,202,4500,10,NULL);
INSERT INTO LineaDeCompra VALUES (303,403,203,500,30,NULL);
INSERT INTO LineaDeCompra VALUES (304,404,204,1200,10,NULL);
INSERT INTO LineaDeCompra VALUES (305,405,205,4000,10,NULL);
INSERT INTO LineaDeCompra VALUES (306,406,206,3100,10,NULL);
INSERT INTO LineaDeCompra VALUES (307,407,207,4200,20,NULL);
INSERT INTO LineaDeCompra VALUES (308,408,208,5000,30,NULL);
INSERT INTO LineaDeCompra VALUES (309,409,209,1000,10,NULL);
INSERT INTO LineaDeCompra VALUES (310,410,210,800,20,NULL);
INSERT INTO LineaDeCompra VALUES (311,411,211,4500,20,NULL);
INSERT INTO LineaDeCompra VALUES (312,412,212,1100,10,NULL);
INSERT INTO LineaDeCompra VALUES (313,413,213,850,10,NULL);
INSERT INTO LineaDeCompra VALUES (314,414,214,600,10,NULL);
INSERT INTO LineaDeCompra VALUES (315,415,215,3800,40,NULL);
INSERT INTO LineaDeCompra VALUES (316,416,216,5200,10,NULL);
INSERT INTO LineaDeCompra VALUES (317,417,217,2800,30,NULL);
INSERT INTO LineaDeCompra VALUES (318,418,218,2700,10,NULL);
INSERT INTO LineaDeCompra VALUES (319,419,219,4000,10,NULL);
INSERT INTO LineaDeCompra VALUES (320,420,220,3400,10,NULL);


--
-- INSERTs CLIENTES
--

INSERT INTO Clientes VALUES (501,40000000,'Neta','Mario','La Rioja 147','neta@gmail.com');
INSERT INTO Clientes VALUES (502,40000001,'Tuga','Hector','Jujuy 456','tuga@gmail.com');
INSERT INTO Clientes VALUES (503,40000002,'Ludo','Jacobo','Salta 963','ludo@gmail.com');
INSERT INTO Clientes VALUES (504,40000003,'Chetuda','Monica','Catamarca 753','chetuda@gmail.com');
INSERT INTO Clientes VALUES (505,40000004,'Arada','Julieta','Tucuman 140','Jarada@gmail.com');
INSERT INTO Clientes VALUES (506,40000005,'Vaso','Paul','Eduardo Wilde 100','Pvaso@gmail.com');
INSERT INTO Clientes VALUES (507,40000006,'Noso','Cesar','Delfin Gallo 690','Cnoso@gmail.com');
INSERT INTO Clientes VALUES (508,40000007,'Tambre','Elma','Costa Rica 440','Etambre@gmail.com');
INSERT INTO Clientes VALUES (509,40000008,'Jillas','Jaime','Martin Berho 556','Jjillas@gmail.com');
INSERT INTO Clientes VALUES (510,40000009,'Milon','Fransisco','Sarate 96','Fmilon@gmail.com');
INSERT INTO Clientes VALUES (511,40000010,'Paredes','Armando','Honduras 777','Aparedes@gmail.com');
INSERT INTO Clientes VALUES (512,40000011,'Lazo','Elva','Lola Mora 690','Elazo@gmail.com');
INSERT INTO Clientes VALUES (513,40000012,'Conazo','Mary','Ibatin 410','Mconazo@gmail.com');
INSERT INTO Clientes VALUES (514,40000013,'Horia','Susana','2 de abril 44','Shoria@gmail.com');
INSERT INTO Clientes VALUES (515,40000014,'Galindo','Keca','Colon 569','galindo@gmail.com');
INSERT INTO Clientes VALUES (516,40000015,'Pato','Carlos','9 de julio 897','Cpato@gmail.com');
INSERT INTO Clientes VALUES (517,40000016,'Areas','Luis','Balcarce 360','Lareas@gmail.com');
INSERT INTO Clientes VALUES (518,40000017,'Lopez','Julio','25 de mayo 888','Jlopez@gmail.com');
INSERT INTO Clientes VALUES (519,40000018,'Dias','Lucas','Corrientes 140','Ldias@gmail.com');
INSERT INTO Clientes VALUES (520,40000019,'Moreno','Diego','Entre Rios 475','DMoreno@gmail.com'); 

--
-- INSERTs VENTAS
--

INSERT INTO Ventas VALUES(601,501,106,'T','2020-02-07 10:31:22');
INSERT INTO Ventas VALUES(602,502,107,'T','2020-02-08 17:48:19');
INSERT INTO Ventas VALUES(603,503,108,'T','2020-02-10 09:33:46');
INSERT INTO Ventas VALUES(604,504,109,'T','2020-03-07 10:31:22');
INSERT INTO Ventas VALUES(605,505,110,'B','2020-03-09 18:01:11');
INSERT INTO Ventas VALUES(606,506,111,'T','2020-04-14 09:48:34');
INSERT INTO Ventas VALUES(607,507,112,'T','2020-04-19 11:12:42');
INSERT INTO Ventas VALUES(608,508,113,'T','2020-05-22 12:51:06');
INSERT INTO Ventas VALUES(609,509,114,'B','2020-06-10 15:10:52');
INSERT INTO Ventas VALUES(610,510,115,'T','2020-07-04 16:01:02');
INSERT INTO Ventas VALUES(611,511,116,'T','2020-08-30 11:54:34');
INSERT INTO Ventas VALUES(612,512,117,'T','2020-09-11 13:15:11');
INSERT INTO Ventas VALUES(613,513,118,'B','2020-10-07 10:17:53');
INSERT INTO Ventas VALUES(614,514,119,'B','2020-12-01 10:30:00');
INSERT INTO Ventas VALUES(615,515,120,'T','2021-01-18 11:03:50');
INSERT INTO Ventas VALUES(616,516,106,'T','2021-01-18 18:31:42');
INSERT INTO Ventas VALUES(617,517,107,'T','2021-02-14 08:59:47');
INSERT INTO Ventas VALUES(618,518,108,'T','2021-02-26 10:00:25');
INSERT INTO Ventas VALUES(619,519,109,'A','2021-03-30 16:55:01');
INSERT INTO Ventas VALUES(620,520,110,'A','2021-04-15 19:00:00');

--
-- INSERTs LINEAS DE VENTA
--

INSERT INTO LineaDeVenta VALUES (301,601,501,106,1);
INSERT INTO LineaDeVenta VALUES (302,602,502,107,1);
INSERT INTO LineaDeVenta VALUES (303,603,503,108,2);
INSERT INTO LineaDeVenta VALUES (304,604,504,109,1);
INSERT INTO LineaDeVenta VALUES (305,605,505,110,1);
INSERT INTO LineaDeVenta VALUES (306,606,506,111,1);
INSERT INTO LineaDeVenta VALUES (307,607,507,112,1);
INSERT INTO LineaDeVenta VALUES (308,608,508,113,4);
INSERT INTO LineaDeVenta VALUES (309,609,509,114,1);
INSERT INTO LineaDeVenta VALUES (310,610,510,115,1);
INSERT INTO LineaDeVenta VALUES (311,611,511,116,1);
INSERT INTO LineaDeVenta VALUES (312,612,512,117,3);
INSERT INTO LineaDeVenta VALUES (313,613,513,118,3);
INSERT INTO LineaDeVenta VALUES (314,614,514,119,2);
INSERT INTO LineaDeVenta VALUES (315,615,515,120,1);
INSERT INTO LineaDeVenta VALUES (316,616,516,106,1);
INSERT INTO LineaDeVenta VALUES (317,617,517,107,1);
INSERT INTO LineaDeVenta VALUES (318,618,518,108,4);
INSERT INTO LineaDeVenta VALUES (319,619,519,109,1);
INSERT INTO LineaDeVenta VALUES (320,620,520,110,1);

--
-- INSERTs COBROS
--

INSERT INTO Cobros VALUES(701,101,106,601,501,'F','2020-02-07 10:35:12'); 
INSERT INTO Cobros VALUES(702,102,107,602,502,'F','2020-02-08 17:55:23'); 
INSERT INTO Cobros VALUES(703,103,108,603,503,'F','2020-02-10 09:38:46'); 
INSERT INTO Cobros VALUES(704,104,109,604,504,'F','2020-03-07 10:39:02'); 
INSERT INTO Cobros VALUES(705,105,110,605,505,'F','2020-03-09 18:05:17'); 
INSERT INTO Cobros VALUES(706,101,111,606,506,'F','2020-04-14 09:55:03'); 
INSERT INTO Cobros VALUES(707,102,112,607,507,'F','2020-04-19 11:20:16'); 
INSERT INTO Cobros VALUES(708,103,113,608,508,'C','2020-05-22 13:01:06'); 
INSERT INTO Cobros VALUES(709,104,114,609,509,'C','2020-06-10 15:17:23'); 
INSERT INTO Cobros VALUES(710,105,115,610,510,'F','2020-07-04 16:03:11'); 
INSERT INTO Cobros VALUES(711,101,116,611,511,'F','2020-08-30 11:59:34'); 
INSERT INTO Cobros VALUES(712,102,117,612,512,'F','2020-09-11 13:18:19'); 
INSERT INTO Cobros VALUES(713,103,118,613,513,'F','2020-10-07 10:21:50'); 
INSERT INTO Cobros VALUES(714,104,119,614,514,'F','2020-12-01 10:34:13'); 
INSERT INTO Cobros VALUES(715,105,120,615,515,'C','2021-01-18 11:09:00'); 
INSERT INTO Cobros VALUES(716,101,106,616,516,'F','2021-01-18 18:36:02'); 
INSERT INTO Cobros VALUES(717,102,107,617,517,'F','2021-02-14 09:03:47'); 
INSERT INTO Cobros VALUES(718,103,108,618,518,'C','2021-02-26 10:04:20'); 
INSERT INTO Cobros VALUES(719,104,109,619,519,'F','2021-03-30 16:59:18'); 
INSERT INTO Cobros VALUES(720,105,110,620,520,'F','2021-04-15 19:03:21'); 

