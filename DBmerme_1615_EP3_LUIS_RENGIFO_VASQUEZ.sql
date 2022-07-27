use master
go
drop database dbmerme
go
create database dbmerme
on primary
(
name="dbmerme_mdf",
filename="d:\isil\Base de Datos\data\dbmerme.mdf",
size=1,
maxsize=5,
filegrowth=1
)
log on
(
name="dbmerme_ldf",
filename="d:\isil\Base de Datos\data\dbmerme.ldf",
size=1,
maxsize=5,
filegrowth=1
)
go
use dbmerme
go
CREATE TABLE GRUPO
(nidgru int not null,
cgrupo char(2),
dgrupo varchar(99)
)
CREATE TABLE TIPOC
(nidtip int not null,
ctpcli char(1),
dtpcli varchar(99)
)
CREATE TABLE PROVINCIA
(nidpro int not null,
cprovi char(2),
dprovi varchar(99)
)
CREATE TABLE ARTICULO
(nidart int not null,
cartic varchar(6),
dartic varchar(99),
qpesos smallint,
nidgru int
)
CREATE TABLE CLIENTE
(nidcli int not null,
cclien char(6),
dclien varchar(99),
cdocid varchar(11),
nidtip int,
nidpro int
)
CREATE TABLE PRECIO
(nidpre int not null,
cpreci char(2),
nidart int,
ipreci dec(8,2)
)
CREATE TABLE COSTO
(nidcos int not null,
ccosto char(2),
nidart int,
icosto dec(8,2)
)
CREATE TABLE VENTA
(nidven int not null,
 ctpdoc char(2),
 ndocum int,
 nidcli int,
 femisi date,
 ibruto dec(8,2),
 iimpue dec(8,2),
 itneto dec(8,2)
 )
 CREATE TABLE DETVENTA
(niddet int not null,
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
ALTER TABLE COSTO ADD CONSTRAINT costo_pk PRIMARY KEY (nidcos)
ALTER TABLE TIPOC ADD CONSTRAINT tipoc_pk PRIMARY KEY (nidtip)
ALTER TABLE PROVINCIA ADD CONSTRAINT provincia_pk PRIMARY KEY (nidpro)
ALTER TABLE GRUPO ADD CONSTRAINT grupo_pk PRIMARY KEY (nidgru)
ALTER TABLE ARTICULO ADD CONSTRAINT articulo_pk PRIMARY KEY (nidart)
ALTER TABLE PRECIO ADD CONSTRAINT precio_pk PRIMARY KEY (nidpre)
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_pk PRIMARY KEY (nidcli)
ALTER TABLE VENTA ADD CONSTRAINT venta_pk PRIMARY KEY (nidven)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_pk PRIMARY KEY (niddet)
--creando uk
ALTER TABLE COSTO ADD CONSTRAINT costo_uk UNIQUE (ccosto)
ALTER TABLE TIPOC ADD CONSTRAINT tipoc_uk UNIQUE (ctpcli)
ALTER TABLE PROVINCIA ADD CONSTRAINT provincia_uk UNIQUE (cprovi)
ALTER TABLE GRUPO ADD CONSTRAINT grupo_uk UNIQUE (cgrupo)
ALTER TABLE ARTICULO ADD CONSTRAINT articulo_uk UNIQUE (cartic)
ALTER TABLE PRECIO ADD CONSTRAINT precio_uk UNIQUE (cpreci)
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_uk UNIQUE (cclien)
ALTER TABLE VENTA ADD CONSTRAINT venta_uk UNIQUE (ctpdoc,ndocum)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_uk UNIQUE (ctpdoc,ndocum,nidart)
--creando fk
ALTER TABLE COSTO ADD CONSTRAINT costo_fk FOREIGN KEY (nidart) REFERENCES ARTICULO(nidart)
ALTER TABLE PRECIO ADD CONSTRAINT precio_fk FOREIGN KEY (nidart) REFERENCES ARTICULO(nidart)
ALTER TABLE ARTICULO ADD CONSTRAINT articulo_fk FOREIGN KEY (nidgru) REFERENCES GRUPO(nidgru)
ALTER TABLE VENTA ADD CONSTRAINT venta_fk FOREIGN KEY (nidcli) REFERENCES CLIENTE(nidcli)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk FOREIGN KEY (nidart) REFERENCES ARTICULO(nidart)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk1 FOREIGN KEY (nidven) REFERENCES VENTA(nidven)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk2 FOREIGN KEY (ctpdoc, ndocum) REFERENCES VENTA(ctpdoc,ndocum)

INSERT INTO TIPOC
values(1,'1','MINORISTA'),
	  (2,'2','MAYORISTA')
insert into PROVINCIA
values(1,'01','LIMA'),
	  (2,'02','PIURA')
--delete from CLIENTE
--insertando clientes
INSERT INTO CLIENTE
--VALUES(1, codigo '102060', nombre_del_cliente 'MINISTERIO DEL INTERIOR')
values(1,'151984','ASTROS, pedro','01548781',1,1),
      (2,'151985','Bellido Luis Alberto','20104050601',2,1),
	  (3,'151986','Caerlos SUarez Vertiz','20518474100',2,1),
	  (4,'151987','Ernesto Sincero Perez','20518479633',2,2),
	  (5,'151988','Francisco Flores Fernandez','01848755',1,2),
	  (6,'151989','Julian Bazo Raez','78451203',1,2)
INSERT INTO GRUPO
--VALUES(1, codigo_grupo '10','AUTOS'),
VALUES(1,'01','SOBRES'),
      (2,'02','PAQUETES')
--VALUES(1,codigo_articulo '1010',descripcion_articulo 'Mustang GT', grupo 1),
INSERT INTO ARTICULO
values(1,'123001','MERMELADA LA PREFERECIDA 100GRS',0,1),
      (2,'123002','MERMELADA LA PREFERECIDA 200GRS',0,1),
	  (3,'123006','MERMELADA LA PREFERECIDA 300GRS',0,1),
	  (4,'123005','MERMELADA LA PREFERECIDA 1KG',0,1),
	  (5,'245001','MERMELADA LA PREFERECIDA 10KG',0,2),
	  (6,'245002','MERMELADA LA PREFERECIDA 20KG',0,2)   
INSERT INTO PRECIO
values(1,'01',1,	3),
      (2,'02',2,	5),
      (3,'03',3,	7),
      (4,'04',4,	26),
      (5,'05',5,	190),
      (6,'06',6,	350)   
INSERT INTO COSTO
values(1,'01',1,	1),
      (2,'02',2,	2),
      (3,'03',3,	5),
      (4,'04',4,	10),
      (5,'05',5,	100),
      (6,'06',6,	200)
INSERT INTO VENTA 
values(1,'FA',9870025,1,'2021-05-01',0,0,0),
	  (2,'FA',9870039,1,'2021-09-15',0,0,0),
	  (3,'FA',9870027,2,'2021-05-03',0,0,0),
	  (4,'FA',9870041,2,'2021-10-11',0,0,0),
	  (5,'FA',9870042,2,'2021-10-11',0,0,0),
	  (6,'FA',9870030,3,'2021-06-6',0,0,0),
	  (7,'FA',9870044,3,'2021-10-12',0,0,0),
	  (8,'FA',9870045,3,'2022-10-13',0,0,0),
	  (9,'FA',9870033,4,'2021-06-09',0,0,0),
	  (10,'FA',9870047,4,'2021-10-15',0,0,0),
	  (11,'FA',9870048,4,'2021-10-15',0,0,0),
	  (12,'FA',9870036,5,'2021-10-11',0,0,0),
	  (13,'FA',9870050,5,'2021-10-15',0,0,0), 
	  (14,'FA',9870038,6,'2021-09-14',0,0,0) 
INSERT INTO DETVENTA
values(1,1,'FA',9870025,1,1,0,0,0),
	  (2,1,'FA',9870025,2,4,0,0,0),
	  (3,1,'FA',9870025,3,5,0,0,0),
	  (4,1,'FA',9870025,4,10,0,0,0),
	  (5,1,'FA',9870025,5,20,0,0,0),
	  (6,1,'FA',9870025,6,5,0,0,0),

	  (7,2,'FA',9870039,1,3,0,0,0),
	  (8,2,'FA',9870039,2,5,0,0,0),
	  (10,2,'FA',9870039,4,10,0,0,0),
	  (11,2,'FA',9870039,5,20,0,0,0),
	  (12,2,'FA',9870039,6,5,0,0,0),

	  (13,3,'FA',9870027,2,6,0,0,0),
	  (14,3,'FA',9870027,4,10,0,0,0),
	  (15,3,'FA',9870027,5,20,0,0,0),
	  (16,3,'FA',9870027,6,5,0,0,0),

	  (17,4,'FA',9870041,1,5,0,0,0),
	  (18,4,'FA',9870041,2,12,0,0,0),
	  (19,4,'FA',9870041,3,5,0,0,0),
	  (20,4,'FA',9870041,4,10,0,0,0),
	  (21,4,'FA',9870041,5,20,0,0,0),
	  (22,4,'FA',9870041,6,5,0,0,0),

	  (23,5,'FA',9870042,1,6,0,0,0),
	  (24,5,'FA',9870042,2,9,0,0,0), 
	  (25,5,'FA',9870042,4,10,0,0,0),
	  (26,5,'FA',9870042,5,20,0,0,0),
	  (27,5,'FA',9870042,6,5,0,0,0),

      (28,6,'FA',9870030,1,7,0,0,0),
	  (29,6,'FA',9870030,2,9,0,0,0),
	  (30,6,'FA',9870030,3,5,0,0,0),
	  (31,6,'FA',9870030,4,10,0,0,0),
	  (32,6,'FA',9870030,5,20,0,0,0),
	  (33,6,'FA',9870030,6,5,0,0,0),

	  (34,7,'FA',9870044,2,10,0,0,0),
	  (35,7,'FA',9870044,3,5,0,0,0),
	  (36,7,'FA',9870044,4,10,0,0,0),
	  (37,7,'FA',9870044,5,20,0,0,0),
	  (38,7,'FA',9870044,6,5,0,0,0),

	  (39,8,'FA',9870045,1,4,0,0,0),
	  (40,8,'FA',9870045,2,11,0,0,0),
	  (41,8,'FA',9870045,4,10,0,0,0),
	  (42,8,'FA',9870045,5,20,0,0,0),
	  (43,8,'FA',9870045,6,5,0,0,0),

	  (44,9,'FA',9870033,1,3,0,0,0),	  
	  (45,9,'FA',9870033,3,3,0,0,0),
	  (46,9,'FA',9870033,4,10,0,0,0),
	  (47,9,'FA',9870033,5,20,0,0,0),
	  (48,9,'FA',9870033,6,5,0,0,0),

	  (49,10,'FA',9870047,1,24,0,0,0),
	  (50,10,'FA',9870047,2,33,0,0,0),
	  (51,10,'FA',9870047,4,10,0,0,0),
	  (52,10,'FA',9870047,5,20,0,0,0),
	  (53,10,'FA',9870047,6,5,0,0,0),

	  (54,11,'FA',9870048,1,5,0,0,0),
	  (55,11,'FA',9870048,2,5,0,0,0),
	  (56,11,'FA',9870048,3,4,0,0,0),
	  (57,11,'FA',9870048,4,10,0,0,0),
	  (58,11,'FA',9870048,5,20,0,0,0),
	  (59,11,'FA',9870048,6,5,0,0,0),

	  (60,12,'FA',9870036,2,4,0,0,0),
	  (61,12,'FA',9870036,3,4,0,0,0),
	  (62,12,'FA',9870036,4,10,0,0,0),
	  (63,12,'FA',9870036,5,20,0,0,0),
	  (64,12,'FA',9870036,6,5,0,0,0),

	  (65,13,'FA',9870050,3,5,0,0,0),
	  (66,13,'FA',9870050,4,10,0,0,0),
	  (67,13,'FA',9870050,5,20,0,0,0),
	  (68,13,'FA',9870050,6,5,0,0,0),
	  
	  (69,14,'FA',9870038,1,2,0,0,0),
	  (70,14,'FA',9870038,2,2,0,0,0),
	  (71,14,'FA',9870038,3,8,0,0,0),
	  (72,14,'FA',9870038,4,10,0,0,0),
	  (73,14,'FA',9870038,5,20,0,0,0),
	  (74,14,'FA',9870038,6,5,0,0,0)

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
--QUERY MERMELADAS
--### 2DO QUERY ADJUNTO
--select * 
	--from Venta v
	--inner join DETVENTA d on d.nidven=v.nidven
	--inner join CLIENTE c on c.nidcli=v.nidcli
select *
	from(
select cclien,dclien,femisi,d.ctpdoc,d.ndocum,cartic,qartic
	from Venta v
	inner join DETVENTA d on d.nidven=v.nidven
	inner join ARTICULO a on a.nidart=d.nidart
	inner join CLIENTE c on c.nidcli=v.nidcli
	) as tabla
PIVOT(sum(qartic) for cartic in ("123001","123002","123006","123005","245001","245002")) as tabla2

--### 3er query(venta por cliente)
select ISNULL(dclien,'TOTAL') Cliente,sum(ibruto) Bruto,sum(iimpue) Impuesto,sum(itneto) Neto
  from VENTA
  inner join CLIENTE on CLIENTE.nidcli=VENTA.nidcli
  group by dclien with rollup

--### 4er query(venta por tipo cliente)
select ISNULL(dtpcli,'TOTAL') Cliente,sum(ibruto) Bruto,sum(iimpue) Impuesto,sum(itneto) Neto
  from VENTA v
  inner join CLIENTE c on c.nidcli=v.nidcli
  inner join TIPOC t on t.nidtip=c.nidtip
  group by dtpcli with rollup

--### 5er query(utilidades por provincias) --UTILIDADES...
select ISNULL(dprovi,'TOTAL') PROVINCIA, sum(d.ibruto-qartic*icosto)
	from DETVENTA d
	inner join VENTA v on v.nidven=d.nidven
	inner join CLIENTE cl on cl.nidcli=v.nidcli
	inner join PROVINCIA p on p.nidpro=cl.nidpro
	inner join ARTICULO a on a.nidart=d.nidart
	inner join COSTO c on c.nidart=a.nidart
group by dprovi with rollup

--### PLUS
select *
	from(
select dprovi,dtpcli, sum(itneto) INGRESO
	from VENTA v
	inner join CLIENTE c on c.nidcli=v.nidcli
	inner join TIPOC t on t.nidtip=c.nidtip
	inner join PROVINCIA p on p.nidpro=c.nidpro
group by dprovi,dtpcli
	) as tabla2
PIVOT(sum(ingreso) for dtpcli in ("MAYORISTA","MINORISTA")) as tabla3
