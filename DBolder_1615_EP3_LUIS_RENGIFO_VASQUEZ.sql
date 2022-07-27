use master
go
drop database dbolder
go
create database dbolder
on primary
(
name="dbolder_mdf",
filename="d:\isil\Base de Datos\data\dbolder.mdf",
size=1,
maxsize=5,
filegrowth=1
)
log on
(
name="dbolder_ldf",
filename="d:\isil\Base de Datos\data\dbolder.ldf",
size=1,
maxsize=5,
filegrowth=1
)
go
use dbolder
go
CREATE TABLE GRUPO
(
nidgru int not null,
cgrupo char(2),
dgrupo varchar(99)
)
CREATE TABLE ARTICULO
(
nidart int not null,
cartic varchar(6),
dartic varchar(99),
nidgru int
)
CREATE TABLE CLIENTE
(
nidcli int not null,
cclien char(6),
dclien varchar(99)
)
CREATE TABLE PRECIO
(
nidpre int not null,
cpreci char(2),
nidart int,
ipreci dec(8,2)
)
CREATE TABLE VENTA
(
nidven int not null,
ctpdoc char(2),
ndocum int,
nidcli int,
femisi date,
ibruto dec(8,2),
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
iimpue dec(8,2),
itneto dec(8,2)
)
--creando los primary key
ALTER TABLE GRUPO ADD CONSTRAINT grupo_pk PRIMARY KEY (nidgru)
ALTER TABLE ARTICULO ADD CONSTRAINT articulo_pk PRIMARY KEY (nidart)
ALTER TABLE PRECIO ADD CONSTRAINT precio_pk PRIMARY KEY (nidpre)
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_pk PRIMARY KEY (nidcli)
ALTER TABLE VENTA ADD CONSTRAINT venta_pk PRIMARY KEY (nidven)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_pk PRIMARY KEY (niddet)
--creando uk
ALTER TABLE GRUPO ADD CONSTRAINT grupo_uk UNIQUE (cgrupo)
ALTER TABLE ARTICULO ADD CONSTRAINT articulo_uk UNIQUE (cartic)
ALTER TABLE PRECIO ADD CONSTRAINT precio_uk UNIQUE (cpreci)
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_uk UNIQUE (cclien)
ALTER TABLE VENTA ADD CONSTRAINT venta_uk UNIQUE (ctpdoc,ndocum)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_uk UNIQUE (ctpdoc,ndocum,nidart)
--creando fk
ALTER TABLE ARTICULO ADD CONSTRAINT articulo_fk FOREIGN KEY (nidgru) REFERENCES GRUPO(nidgru)
ALTER TABLE VENTA ADD CONSTRAINT venta_fk FOREIGN KEY (nidcli) REFERENCES CLIENTE(nidcli)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk FOREIGN KEY (nidart) REFERENCES ARTICULO(nidart)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk1 FOREIGN KEY (nidven) REFERENCES VENTA(nidven)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk2 FOREIGN KEY (ctpdoc, ndocum) REFERENCES VENTA(ctpdoc,ndocum)

--delete from CLIENTE
--insertando clientes
INSERT INTO CLIENTE
--VALUES(1, codigo '102060', nombre_del_cliente 'MINISTERIO DEL INTERIOR')
VALUES(1,'102060','MARTINEZ SALVADOR PEDRO'),
	  (2,'102061','PEREZ GUTIERREZ JUAN'),
	  (3,'102062','PAREDES SOLDEVILLA MARIANA'),
	  (4,'102063','BURGA NORIEGA ARTURO'),
	  (5,'102064','CIUDAD LANDORF MONICA'),
	  (6,'102065','PODESTA CARRE SILVANA'),
	  (7,'102066','MANSILLA PEREZ GISELLA'),
	  (8,'102067','VILDOSOLA AMPUERO LORENA')


INSERT INTO GRUPO
--VALUES(1, codigo_grupo '10','AUTOS'),
VALUES(1,'01','ESTATUA'),
      (2,'02','PINTURA'),
	  (3,'03','MUEBLE')

INSERT INTO ARTICULO
--VALUES(1,codigo_articulo '1010',descripcion_articulo 'Mustang GT', grupo 1),
VALUES(1,'159878','LAMPARA DE MARMOL',1),
      (2,'514512','LA PIETAT ESCULTURA',1),
	  (3,'161541','LA BUENA RISA',2),
	  (4,'151412','LA OTRA CARA',2),
	  (5,'141283','LA DESPENSA',2),
	  (6,'131154','ESCRITORIO DE LUIS XV',3),
	  (7,'121025','CARA BONITA',2),
      (8,'110896','LA MONALISA',2),
	  (9,'100767','EL ANGEL',3),
	  (10,'90638','SAN GABRIEL',2),
	  (11,'80509','LA NOCHE',2),
	  (12,'70380','LAMPARA DE LUIS XVI',3),
	  (13,'60251','CORTINA DE LUIS XVI',3),
	  (14,'50122','PASAMANOS',3)

INSERT INTO PRECIO
VALUES(1,'01',1,	1000),
      (2,'02',2,	2400),
      (3,'03',3,	1800),
      (4,'04',4,	1600),
      (5,'05',5,	1500),
      (6,'06',6,	2000),
      (7,'07',7,	1900),
      (8,'08',8,	4000),
      (9,'09',9,	6500),
     (10,'10',10,	1500),
     (11,'11',11,	800	),
     (12,'12',12,	1700),
     (13,'13',13,	1600),
     (14,'14',14,	400	)

INSERT INTO VENTA
--VALUES(1, factura 'FA',ndocum 5100001, nidclien 1, fecha_emision'2021-05-01',importe_bruto(suma de detalles) 250000, idscto(%10) 25000, iimpue(%18=IGV) 45000, itneto(ibruto-idscto+iimpue) 270000),
VALUES(1,'FA',1234,1,'2021-05-15',0,0,0),
      (2,'FA',1235,2,'2021-06-19',0,0,0),
	  (3,'FA',1236,3,'2021-05-15',0,0,0),
	  (4,'FA',1237,4,'2021-12-15',0,0,0),
	  (5,'FA',1238,5,'2022-05-5',0,0,0),
	  (6,'FA',1239,6,'2022-05-6',0,0,0),
	  (7,'FA',1240,7,'2022-09-6',0,0,0),
	  (8,'FA',1241,8,'2022-10-15',0,0,0)

INSERT INTO DETVENTA
--VALUES(1, factura 1, factura ='FA', ndocum 5100001,cartic 1,qartic 2,importe_bruto 100000, idscto 10000, iimpue(%18) 18000, itneto(ibruto-idscto+iimpue) 108000),
VALUES(1,1,'FA',1234,1,1,0,0,0),
      (2,1,'FA',1234,2,1,0,0,0),
	  (3,2,'FA',1235,3,1,0,0,0),
	  (4,2,'FA',1235,4,1,0,0,0),
      (5,3,'FA',1236,5,1,0,0,0),
	  (6,4,'FA',1237,6,1,0,0,0),
	  (7,5,'FA',1238,7,1,0,0,0),
      (8,5,'FA',1238,8,2,0,0,0),
	  (9,6,'FA',1239,9,1,0,0,0),
	  (10,7,'FA',1240,10,1,0,0,0),
      (11,7,'FA',1240,11,1,0,0,0),
	  (12,8,'FA',1241,12,3,0,0,0),
	  (13,8,'FA',1241,13,3,0,0,0),
      (14,8,'FA',1241,14,1,0,0,0)

--uniendo dos tabla, tabla venta con cliente
select *
	from VENTA
	inner join CLIENTE on CLIENTE.nidcli=VENTA.nidcli
--ibruto = qartic x precio unitario
--select * from DETVENTA

--solo funciona cuando se tiene el precio del articulo y la cantidad
update DETVENTA
	set ibruto = qartic*(select ipreci
							from PRECIO
							where PRECIO.nidart=DETVENTA.nidart),

		iimpue = qartic*(select ipreci
							from PRECIO
							where PRECIO.nidart=DETVENTA.nidart)*0.18,

		itneto = qartic*(select ipreci
							from PRECIO
							where PRECIO.nidart=DETVENTA.nidart)*1.18
							--where PRECIO.nidart=DETVENTA.nidart)*(1(cantidad)+0.18)
--sum suma
update VENTA
	set ibruto = (select sum(ibruto)
						from DETVENTA
						where DETVENTA.nidven = VENTA.nidven),

		iimpue = (select sum(iimpue)
						from DETVENTA
						where DETVENTA.nidven = VENTA.nidven),

		itneto = (select sum(itneto)
						from DETVENTA
						where DETVENTA.nidven = VENTA.nidven)
 --### 1er query
select ISNULL(format(femisi,'yyyy-MM'),'TOTAL') Mes,sum(ibruto) Bruto,sum(iimpue) Impuesto,sum(itneto) Neto
  from VENTA
  group by format(femisi,'yyyy-MM') with rollup
  
--### 2do query
select ISNULL(dgrupo,'TOTAL') Grupo,sum(ibruto) Bruto,sum(iimpue) Impuesto,sum(itneto) Neto
   from DETVENTA d
   inner join ARTICULO a on d.nidart=a.nidart
   inner join GRUPO g on g.nidgru=a.nidgru
   group by dgrupo with rollup

--### 3er query
select ISNULL(dclien,'TOTAL') Cliente,sum(ibruto) Bruto,sum(iimpue) Impuesto,sum(itneto) Neto
  from VENTA
  inner join CLIENTE on CLIENTE.nidcli=VENTA.nidcli
  group by dclien with rollup

--### 4tpo query
select d.ctpdoc,FORMAT(d.ndocum,'####') Numero,dclien,format(femisi,'dd/MM/yyyy') Fecha,cartic,dartic,dgrupo,ipreci,qartic,d.ibruto,d.iimpue,d.itneto
   from DETVENTA d
   inner join VENTA v on v.nidven=d.nidven
   inner join CLIENTE c on c.nidcli=v.nidcli
   inner join ARTICULO a on d.nidart=a.nidart
   inner join PRECIO p on p.nidart=a.nidart
   inner join GRUPO g on g.nidgru=a.nidgru
union  
select 'TOTAL','','','','','','',0,0,sum(d.ibruto),sum(d.iimpue),sum(d.itneto)
   from DETVENTA d

--### modificando 4tpo query
select d.ctpdoc,FORMAT(d.ndocum,'####') Numero,dclien,format(femisi,'dd/MM/yyyy') Fecha,cartic,dartic,dgrupo,format(p.ipreci,'0') PU,format(d.qartic,'0') Cantidad,d.ibruto,d.iimpue,d.itneto
   from DETVENTA d
   inner join VENTA v on v.nidven=d.nidven
   inner join CLIENTE c on c.nidcli=v.nidcli
   inner join ARTICULO a on d.nidart=a.nidart
   inner join PRECIO p on p.nidart=a.nidart
   inner join GRUPO g on g.nidgru=a.nidgru
union  
select 'TOTAL','','','','','','','','',sum(d.ibruto),sum(d.iimpue),sum(d.itneto)
   from DETVENTA d
   