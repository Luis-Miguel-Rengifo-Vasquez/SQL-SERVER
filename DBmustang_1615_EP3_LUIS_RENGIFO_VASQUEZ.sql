use master
go
--creando la base de datos
drop database dbmustang --borrando base de datos
go
create database dbmustang
on primary --creando el repositorio de datos
(
name="dbmustang_mdf",
filename="d:\isil\Base de Datos\data\dbmustang.mdf",
size=1,
maxsize=5,
filegrowth=1
)
log on --creando el repositorio de logs
(
name="dbmustang_ldf",
filename="d:\isil\Base de Datos\data\dbmustang.ldf",
size=1,
maxsize=5,
filegrowth=1
)
go
use dbmustang
go
--creando las tablas
CREATE TABLE GRUPO
(
nidgru int not null,--not null(no acepta vacios)
cgrupo char(2),
dgrupo varchar(99)
)

CREATE TABLE ARTICULO
(
nidart int not null,
cartic char(4),
dartic varchar(99),
nidgru int
)

CREATE TABLE CLIENTE
(
nidcli int not null,
cclien char(6),
dclien varchar(99)
)

CREATE TABLE VENTA
(
nidven int not null,
ctpdoc char(2),
ndocum int,
nidcli int,
femisi date,
ibruto dec(8,2),
idscto dec(8,2),
iimpue dec(8,2),
itneto dec(8,2)
)

CREATE TABLE DETVENTA
(
niddet int not null,
nidven int not null,
ctpdoc char(2),
ndocum int,
nidart int,
qartic smallint,
ibruto dec(8,2),
idscto dec(8,2),
iimpue dec(8,2),
itneto dec(8,2)
)

--creando los PK
ALTER TABLE GRUPO ADD CONSTRAINT grupo_pk PRIMARY KEY (nidgru)
ALTER TABLE ARTICULO ADD CONSTRAINT articulo_pk PRIMARY KEY (nidart)
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_pk PRIMARY KEY (nidcli)
ALTER TABLE VENTA ADD CONSTRAINT venta_pk PRIMARY KEY (nidven)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_pk PRIMARY KEY (niddet)

--creando UK
ALTER TABLE GRUPO ADD CONSTRAINT grupo_uk UNIQUE (cgrupo)
ALTER TABLE ARTICULO ADD CONSTRAINT articulo_uk UNIQUE (cartic)
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_uk UNIQUE (cclien)
ALTER TABLE VENTA ADD CONSTRAINT venta_uk UNIQUE (ctpdoc,ndocum)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_uk UNIQUE (ctpdoc,ndocum,nidart)

--creando las FK
ALTER TABLE ARTICULO ADD CONSTRAINT articulo_fk FOREIGN KEY (nidgru) REFERENCES GRUPO(nidgru)
ALTER TABLE VENTA ADD CONSTRAINT venta_fk FOREIGN KEY (nidcli) REFERENCES CLIENTE(nidcli)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk1 FOREIGN KEY (nidart) REFERENCES ARTICULO(nidart)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk2 FOREIGN KEY (nidven) REFERENCES VENTA(nidven)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk3 FOREIGN KEY (ctpdoc, ndocum) REFERENCES VENTA(ctpdoc,ndocum)

--INSERTANDO LOS DATOS DEL EJERCICIO

INSERT INTO CLIENTE
--VALUES(1, codigo '102060', nombre_del_cliente 'MINISTERIO DEL INTERIOR')
VALUES(1,'102060','MINISTERIO DEL INTERIOR')

INSERT INTO GRUPO
--VALUES(1, codigo_grupo '10','AUTOS'),
VALUES(1,'10','AUTOS'),
      (2,'20','CAMIONETAS')

INSERT INTO ARTICULO
--VALUES(1,codigo_articulo '1010',descripcion_articulo 'Mustang GT', grupo 1),
VALUES(1,'1010','Mustang GT',1),
      (2,'1020','Mustang GT1',1),
	  (3,'1030','Mustang X0',1),
	  (4,'2010','Ford 1',2),
	  (5,'2020','Ford 34',2),
	  (6,'2030','Ford 101',2)

INSERT INTO VENTA
--VALUES(1, factura 'FA',ndocum 5100001, nidclien 1, fecha_emision'2021-05-01',importe_bruto(suma de detalles) 250000, idscto(%10) 25000, iimpue(%18=IGV) 45000, itneto(ibruto-idscto+iimpue) 270000),
VALUES(1,'FA',5100001,1,'2021-05-01',250000,25000,45000,270000),
      (2,'FA',5100002,1,'2021-07-01',270000,48000,48600,297600),
	  (3,'FA',5100019,1,'2022-09-01',120000,12000,21600,129600),
	  (4,'FA',5100020,1,'2022-10-01',150000,15000,27000,162000)

INSERT INTO DETVENTA
--VALUES(1, factura 1, factura ='FA', ndocum 5100001,cartic 1,qartic 2,importe_bruto 100000, idscto 10000, iimpue(%18) 18000, itneto(ibruto-idscto+iimpue) 108000),
VALUES(1,1,'FA',5100001,1,2,100000,10000,18000,108000),
      (2,1,'FA',5100001,2,3,150000,15000,27000,162000),
	  (3,2,'FA',5100002,5,3,130000,13000,23400,140400),
	  (4,2,'FA',5100002,6,3,140000,14000,25200,151200),
	  (5,3,'FA',5100019,4,2,120000,12000,21600,129600),
	  (6,4,'FA',5100020,3,3,150000,15000,27200,162200)

--select * from grupo
--select * from articulo
--select * from cliente
--select * from detventa
--select ctpdoc, ndocum from venta
--where ndocum=5100001

--QUERYS
--select * 
	--from DETVENTA
	--inner join ARTICULO on ARTICULO.nidart=DETVENTA.nidart

--(a)Qry de ventas por articulo pero solo de autos (5 puntos)
select dartic,ibruto,iimpue,idscto,itneto
	from DETVENTA
	inner join ARTICULO on ARTICULO.nidart=DETVENTA.nidart
	where dartic like 'Mus%'

select * 
	from VENTA
	inner join CLIENTE on VENTA.nidcli=CLIENTE.nidcli

select dclien,ctpdoc,ndocum,ibruto,iimpue,idscto,itneto
	from VENTA
	inner join CLIENTE on VENTA.nidcli=CLIENTE.nidcli

--Alfredo, veo 4 registros cuando una venta por cliente deberia tener solo uno
select dclien, sum(ibruto) bruto,sum(iimpue) impuesto,sum(idscto) descuento,sum(itneto) Neto
	from VENTA
	inner join CLIENTE on VENTA.nidcli=CLIENTE.nidcli
	group by dclien

--(b)query de ventas por grupo
select ISNULL(dgrupo,'TOTAL') Descripcion, sum(ibruto) bruto,sum(iimpue) impuesto,sum(idscto) descuento,sum(itneto) Neto
	from DETVENTA d
	inner join ARTICULO a on a.nidart=d.nidart --a es articulo y d es descuento
	inner join GRUPO g on a.nidgru=g.nidgru
	group by dgrupo with rollup --detalle de todo with rollup

--seleccion(select) *(todos los campos) from(de tabla) as(asignar nombre, asignar variable)
--(c) query del cuadro adjunto
select g.dgrupo as "GRUPO",
	a.cartic + ' ' + a.dartic as "ARTICULO",
	dv.ibruto as "IMPORTE",
	dv.qartic as "CANTIDAD",
	v.ndocum as "FACTURA",
	v.femisi as "FECHA"
from VENTA as v
	inner join DETVENTA dv
		on dv.nidven = v.nidven
	inner join ARTICULO a
		on dv.nidart = a.nidart
	inner join GRUPO g
		on a.nidgru = g.nidgru
order by
	g.dgrupo

--(d)query de ventas por año
select isnull(format(femisi, 'yyyy'), 'TOTAL'), sum(ibruto) bruto, sum(iimpue) impuesto, sum(idscto) Descuento, sum (itneto) Neto
from VENTA
group by format(femisi, 'yyyy') with rollup

--from GRUPO as g
	--inner join (unir interseccion)
	--inner join ARTICULO a
			--on a.nidgru = g.nidgru

select cartic,dartic from ARTICULO

select * from GRUPO
select * from ARTICULO
select * from DETVENTA
select * from VENTA

