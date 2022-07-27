use master
go
drop database dbplanet
go
create database dbplanet
on primary
(
name="dbplanet_mdf",
filename="d:\isil\Base de Datos\data\dbplanet.mdf",
size=1,
maxsize=5,
filegrowth=1
)
log on
(
name="dbplanet_ldf",
filename="d:\isil\Base de Datos\data\dbplanet.ldf",
size=1,
maxsize=5,
filegrowth=1
)
go
use dbplanet
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
CREATE TABLE ARTICULO
(nidart int not null,
cartic varchar(6),
dartic varchar(99),
dcat varchar(99),
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
ALTER TABLE GRUPO ADD CONSTRAINT grupo_pk PRIMARY KEY (nidgru)
ALTER TABLE ARTICULO ADD CONSTRAINT articulo_pk PRIMARY KEY (nidart)
ALTER TABLE PRECIO ADD CONSTRAINT precio_pk PRIMARY KEY (nidpre)
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_pk PRIMARY KEY (nidcli)
ALTER TABLE VENTA ADD CONSTRAINT venta_pk PRIMARY KEY (nidven)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_pk PRIMARY KEY (niddet)
--creando uk
ALTER TABLE COSTO ADD CONSTRAINT costo_uk UNIQUE (ccosto)
ALTER TABLE TIPOC ADD CONSTRAINT tipoc_uk UNIQUE (ctpcli)
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
--nidtip,ctpcli,dtpcli
values(1,'1','MINORISTA'),
	  (2,'2','MAYORISTA')
--delete from CLIENTE
--insertando clientes
INSERT INTO CLIENTE
--VALUES(1, codigo '102060', nombre_del_cliente 'PASARELA',cdocid,tipoclin, tipprod)
values(1,'101010','PASARELA S.A','20100012547',1,1),
      (2,'101011','Casos y Casas S.A','20124578962',2,1),
	  (3,'101012','ELIZABETH CARDAS','20147841101',2,1),
	  (4,'101013','LUIS FONSI','74251523',2,2)
INSERT INTO GRUPO
--VALUES(1, codigo_grupo '10','AUTOS'),
VALUES(1,'01','BELLEZA'),
      (2,'02','SALUD')
INSERT INTO ARTICULO
--VALUES(1,codigo_articulo '101050',descripcion_articulo 'THERMAL A',dcat 'A, grupo 1)
values(1,'101050','THERMAL A','A',1),
      (2,'101051','COOL A','A',1),
	  (3,'101052','TINTA LIPS A','A',1),
	  (4,'101056','THERMAL B','C',1),
      (5,'101057','COOL B','C',1),
	  (6,'101058','TINTA LIPS B','C',1),
	  (7,'101053','VITAMIN 100','B',2),
      (8,'101054','VITAMIN 200','B',2),
	  (9,'101055','COMPLEJO BBB','B',2),
	  (10,'101059','VITAMIN 10','D',2),
	  (11,'101060','VITAMIN 20','D',2),
	  (12,'101061','COMPLEJO B','D',2)   
INSERT INTO PRECIO
--nidpre,cpreci,nidart,ipreci
values(1,'01',1,	105),
      (2,'02',2,	155),
      (3,'03',3,	130),
      (4,'04',4,	110),
      (5,'05',5,	160),
      (6,'06',6,	140),
	  (7,'07',7,	130),
      (8,'08',8,	130),
      (9,'09',9,	130),
      (10,'10',10,	140),
      (11,'11',11,	160),
      (12,'12',12,	160)
INSERT INTO COSTO
--nidcos,ccosto,nidart,icosto
values(1,'01',1,	90),
      (2,'02',2,	80),
      (3,'03',3,	70),
      (4,'04',4,	90),
      (5,'05',5,	80),
      (6,'06',6,	70),
	  (7,'07',7,	60),
      (8,'08',8,	55),
      (9,'09',9,	54),
      (10,'10',10,	60),
      (11,'11',11,	55),
      (12,'12',12,	54)
INSERT INTO VENTA
--nidven,ctpdoc,ndocum,nidcli,femisi,ibruto,iimpue,itneto
values(1,'FA',5100001,1,'2021-05-01',0,0,0),
	  (2,'FA',5100002,2,'2021-09-15',0,0,0),
	  (3,'FA',5100003,3,'2021-05-03',0,0,0),
	  (4,'FA',5100005,2,'2021-10-11',0,0,0),
	  (5,'FA',5100006,4,'2021-10-11',0,0,0),
	  (6,'FA',5100007,1,'2021-05-01',0,0,0),
	  (7,'FA',5100009,3,'2021-09-15',0,0,0),
	  (8,'FA',5100010,1,'2021-05-03',0,0,0),
	  (9,'FA',5100012,4,'2021-10-11',0,0,0),
	  (10,'FA',5100013,1,'2021-10-11',0,0,0),
	  (11,'FA',5100014,2,'2021-05-01',0,0,0),
	  (12,'FA',5100015,3,'2021-09-15',0,0,0),
	  (13,'FA',5100016,1,'2021-05-03',0,0,0),
	  (14,'FA',5100017,2,'2021-10-11',0,0,0),
	  (15,'FA',5100018,4,'2021-10-11',0,0,0)
INSERT INTO DETVENTA
--niddet,nidven,ctpdoc,ndocum,nidart,qartic,ibruto,iimpue,itneto
values(1,1,'FA',5100001,1,100,0,0,0),
	  (2,1,'FA',5100001,7,150,0,0,0),

	  (3,2,'FA',5100002,2,110,0,0,0),
	  (4,2,'FA',5100002,5,80,0,0,0),

	  (5,3,'FA',5100003,3,120,0,0,0),

	  (6,4,'FA',5100005,8,100,0,0,0),
	  (7,4,'FA',5100005,11,15,0,0,0),

      (8,5,'FA',5100006,9,110,0,0,0),

	  (9,6,'FA',5100007,1,90,0,0,0),

	  (10,7,'FA',5100009,6,74,0,0,0),

	  (11,8,'FA',5100010,10,48,0,0,0),

	  (12,9,'FA',5100012,12,58,0,0,0),

	  (13,10,'FA',5100013,4,100,0,0,0),

	  (14,11,'FA',5100014,5,110,0,0,0),

	  (15,12,'FA',5100015,3,120,0,0,0),

	  (16,13,'FA',5100016,7,150,0,0,0),

	  (17,14,'FA',5100017,8,100,0,0,0),

	  (18,15,'FA',5100018,9,110,0,0,0)

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

--BD PLANET
--### 2. Desarrolle el cuadro de ventas adjunto (Gráfico 1) (4 puntos)
select g.dgrupo as GRUPO,a.dartic as ARTICULO,d.qartic as 'CANTIDAD VENDIDA',d.ctpdoc,d.ndocum,c.dclien as CLIENTE
	from Venta v
		inner join DETVENTA d on d.nidven=v.nidven
		inner join ARTICULO a on a.nidart=d.nidart
		inner join GRUPO g on g.nidgru=a.nidgru
		inner join CLIENTE c on c.nidcli=v.nidcli
		order by d.ndocum

--### 3. Desarrolle un query que muestre las ventas por cliente (4 Puntos)
select ISNULL(dclien,'TOTAL') CLIENTE,sum(ibruto) Bruto,sum(iimpue) Impuesto,sum(itneto) Neto
	 from VENTA
		 inner join CLIENTE on CLIENTE.nidcli=VENTA.nidcli
		 group by dclien with rollup

--### 4. Desarrolle un query que muestre las utilidades de la empresa por cliente.(4 puntos)
select ISNULL(dclien,'TOTAL') CLIENTES, sum(d.ibruto-qartic*icosto) as UTILIDADES
	from DETVENTA d
	inner join VENTA v on v.nidven=d.nidven
	inner join CLIENTE cl on cl.nidcli=v.nidcli
	inner join ARTICULO a on a.nidart=d.nidart
	inner join COSTO c on c.nidart=a.nidart
	group by dclien with rollup

--### 5. Desarrolle u query que muestre las ventas por articulo (4 puntos)
select ISNULL(dartic,'TOTAL') ARTICULO, sum(d.ibruto-qartic*icosto) as VENTAS
	from Venta v
		inner join DETVENTA d on d.nidven=v.nidven
		inner join ARTICULO a on a.nidart=d.nidart
		inner join COSTO c on c.nidart=a.nidart
		group by dartic with rollup

--### 6. Desarrolle el cuadro 2 (Grafico 2) 4 puntos
select ISNULL(g.dgrupo,'') GRUPO,dcat as CAT,cartic as CODIGO,dartic as PRODUCTOS,ipreci as 'PRECIO DE VENTAS',c.icosto as COSTO
	from ARTICULO a
		inner join GRUPO g on g.nidgru=a.nidgru
		inner join PRECIO p on p.nidpre=a.nidart
		inner join COSTO c on c.nidart=a.nidart
		order by g.dgrupo

--### 7. Desarrolle un query que muestre las utilidades por categoria ( 4 puntos)
select ISNULL(dcat,'TOTAL') CATEGORIA, sum(d.ibruto-qartic*icosto) as UTILIDADES
	from DETVENTA d
	inner join VENTA v on v.nidven=d.nidven
	inner join CLIENTE cl on cl.nidcli=v.nidcli
	inner join ARTICULO a on a.nidart=d.nidart
	inner join COSTO c on c.nidart=a.nidart
	group by dcat with rollup
