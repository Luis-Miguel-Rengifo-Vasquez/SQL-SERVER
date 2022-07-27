use master
go
drop database dbmolino
go
create database dbmolino
on primary
(
name="dbmolino_mdf",
filename="d:\isil\Base de Datos\data\dbmolino.mdf",
size=1,
maxsize=5,
filegrowth=1
)
log on
(
name="dbmolino_ldf",
filename="d:\isil\Base de Datos\data\dbmolino.ldf",
size=1,
maxsize=5,
filegrowth=1
)
go
use dbmolino
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
dclien varchar(99),
cdocid varchar(99)
)
CREATE TABLE COSTO
(
nidcos int not null,
ccosto char(2),
nidart int,
icosto dec(8,2)
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
idscto dec(8,2),
iimpue dec(8,2),
itneto dec(8,2),
nidvend int not null
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
CREATE TABLE VENDEDOR
(
nidvend int not null,
cvend char(6),
dvend varchar(99),
nidtpvend int 
)
CREATE TABLE TIPOVEND
(
nidtpvend int not null,
ctpvend char(1),
dtpvend varchar(99)
)
--creando los primary key
ALTER TABLE COSTO ADD CONSTRAINT costo_pk PRIMARY KEY (nidcos)
ALTER TABLE PRECIO ADD CONSTRAINT precio_pk PRIMARY KEY (nidpre)
ALTER TABLE GRUPO ADD CONSTRAINT grupo_pk PRIMARY KEY (nidgru)
ALTER TABLE ARTICULO ADD CONSTRAINT articulo_pk PRIMARY KEY (nidart)
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_pk PRIMARY KEY (nidcli)
ALTER TABLE VENTA ADD CONSTRAINT venta_pk PRIMARY KEY (nidven)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_pk PRIMARY KEY (niddet)
ALTER TABLE VENDEDOR ADD CONSTRAINT vendedor_pk PRIMARY KEY (nidvend)
ALTER TABLE TIPOVEND ADD CONSTRAINT tipovendedor_pk PRIMARY KEY (nidtpvend)
--creando uk
ALTER TABLE COSTO ADD CONSTRAINT costo_uk UNIQUE (ccosto)
ALTER TABLE PRECIO ADD CONSTRAINT precio_uk UNIQUE (cpreci)
ALTER TABLE GRUPO ADD CONSTRAINT grupo_uk UNIQUE (cgrupo)
ALTER TABLE ARTICULO ADD CONSTRAINT articulo_uk UNIQUE (cartic)
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_uk UNIQUE (cclien)
ALTER TABLE VENTA ADD CONSTRAINT venta_uk UNIQUE (ctpdoc,ndocum)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_uk UNIQUE (ctpdoc,ndocum,nidart)
ALTER TABLE VENDEDOR ADD CONSTRAINT vendedor_uk UNIQUE (cvend)
ALTER TABLE TIPOVEND ADD CONSTRAINT tipovendedor_uk UNIQUE (ctpvend)
--creando fk
ALTER TABLE COSTO ADD CONSTRAINT costo_fk FOREIGN KEY (nidart) REFERENCES ARTICULO(nidart)
ALTER TABLE PRECIO ADD CONSTRAINT precio_fk FOREIGN KEY(nidart) REFERENCES ARTICULO(nidart)
ALTER TABLE ARTICULO ADD CONSTRAINT articulo_fk FOREIGN KEY (nidgru) REFERENCES GRUPO(nidgru)
ALTER TABLE VENTA ADD CONSTRAINT venta_fk FOREIGN KEY (nidcli) REFERENCES CLIENTE(nidcli)
ALTER TABLE VENTA ADD CONSTRAINT venta_fk1 FOREIGN KEY (nidvend) REFERENCES VENDEDOR(nidvend)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk FOREIGN KEY (nidart) REFERENCES ARTICULO(nidart)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk1 FOREIGN KEY (nidven) REFERENCES VENTA(nidven)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk2 FOREIGN KEY (ctpdoc, ndocum) REFERENCES VENTA(ctpdoc,ndocum)
ALTER TABLE VENDEDOR ADD CONSTRAINT vendedor_fk FOREIGN KEY (nidtpvend) REFERENCES TIPOVEND(nidtpvend)

--delete from CLIENTE
--insertando clientes
INSERT INTO CLIENTE
--nidcli,cclien,dclien
VALUES(1,'5050','DOÑA PEPA','201058544875'),
	  (2,'5051','MOLINOS S.A','20101010101')

INSERT INTO GRUPO
--VALUES(1, codigo_grupo '01',dgrupo 'FIDEOS'),
VALUES(1,'01','FIDEOS'),
      (2,'02','HARINAS PANADERAS'),
	  (3,'03','HARINAS SIN GLUTTEN'),
	  (4,'04','HARINAS DE ARROZ')

INSERT INTO ARTICULO
--VALUES(1,codigo_articulo '3010',descripcion_articulo, grupo 1),
VALUES(1,'3010','FIDEOS CORTOS',1),
      (2,'3011','FIDEOS LARGOS',1),
	  (3,'3012','FIDEOS PASTA',1),
	  (4,'4010','HARINA 1KG',2),
	  (5,'4011','HARINA 10KG',2),
	  (6,'4012','HARINA PASTELERA',2),
	  (7,'5010','HARINA 1KG',3),
      (8,'5011','HARINA 10KG',3),
	  (9,'5012','HARINA GALLETERA',3),
	  (10,'6010','HARINA 1KG',4),
	  (11,'6011','HARINA 10KG',4)

INSERT INTO COSTO
--nidcos,ccosto,nidart,icosto
values(1,'01',1,26),
      (2,'02',2,81.25),
      (3,'03',3,75),
      (4,'04',4,36),
      (5,'05',5,52),
      (6,'06',6,52.5),
	  (7,'07',7,69.23),
      (8,'08',8,52),
      (9,'09',9,56.25),
      (10,'10',10,48),
      (11,'11',11,40)

INSERT INTO PRECIO
--nidpre,cpreci,nidpro,ipreci
VALUES(1,'01',1,40),
      (2,'02',2,125),
      (3,'03',3,115.38),
      (4,'04',4,60),
      (5,'05',5,86.67),
      (6,'06',6,87.5),
	  (7,'07',7,115.38),
      (8,'08',8,86.67),
      (9,'09',9,93.75),
      (10,'10',10,80),
      (11,'11',11,66.67)

INSERT INTO TIPOVEND
--nidtpvend,ctpvend,dtpvend
VALUES(1,1,'VENDEDOR MIXTO'),
	  (2,2,'VENDEDOR HARINAS'),
	  (3,3,'VENDEDOR FIDEOS')

INSERT INTO VENDEDOR
--nidvend,cvend,dvend,nidgrupo,tpvendedor,nidtpvend
VALUES(1,051487,'ARTUR BUENAVENTE GONZALES',1),
      (2,051436,'PEDRO GONZALES TERCIO',2),
	  (3,055874,'LUIS ALONSO GONZALES',3)

INSERT INTO VENTA
--VALUES(1, factura 'FA',ndocum 5100001, nidclien 1, fecha_emision'2021-05-01',importe_bruto(suma de detalles) 49000, idscto(0.05 o 0.25) 2450, iimpue(%18=IGV) 8820, itneto(ibruto-idscto+iimpue) 270000),nidvend,
VALUES(1,'FA',5100001,1,'2021-05-15',0,0,0,0,1),
      (2,'FA',5100002,1,'2021-06-19',0,0,0,0,1),
	  (3,'FA',5100003,2,'2021-05-15',0,0,0,0,3),
	  (4,'FA',5100004,2,'2021-12-15',0,0,0,0,2),
	  (5,'FA',5100005,2,'2022-05-5',0,0,0,0,3)

INSERT INTO DETVENTA
--VALUES(1, factura 1, factura ='FA', ndocum 5100001,cartic 1,qartic 2,importe_bruto 100000, idscto 10000, iimpue(%18) 18000, itneto(ibruto-idscto+iimpue) 108000),
--niddet,nidven,ctpdoc,ndocum,nidart,qartic,ibruto,idscto(0.05 o 0.25),iimpue(ibruto)*0.18,itneto(ibruto+iimpue)*idscto si existe
VALUES(1,1,'FA',5100001,1,250,0,0,0,0),
      (2,2,'FA',5100002,2,120,0,0,0,0),
	  (3,2,'FA',5100002,3,130,0,0,0,0),
	  (4,1,'FA',5100001,4,200,0,0,0,0),
      (5,3,'FA',5100003,5,150,0,0,0,0),
	  (6,3,'FA',5100003,6,160,0,0,0,0),
	  (7,1,'FA',5100001,7,130,0,0,0,0),
      (8,4,'FA',5100004,8,150,0,0,0,0),
	  (9,4,'FA',5100004,9,160,0,0,0,0),
	  (10,1,'FA',5100001,10,150,0,0,0,0),
	  (11,5,'FA',5100005,11,150,0,0,0,0)

UPDATE DETVENTA 
   set ibruto=qartic*(select ipreci
                         from PRECIO
						 where DETVENTA.nidart=PRECIO.nidart),
	   idscto=qartic*(select ipreci
                         from PRECIO
						 where DETVENTA.nidart=PRECIO.nidart)*(CASE
						                                          WHEN DETVENTA.ndocum in (5000001,5000002) THEN 0.05
																  ELSE 0.25
						                                       END),
	   iimpue=qartic*(select ipreci
                         from PRECIO
						 where DETVENTA.nidart=PRECIO.nidart)*0.18,
	   itneto=qartic*(select ipreci
                         from PRECIO
						 where DETVENTA.nidart=PRECIO.nidart)*1.18-qartic*(select ipreci
																				 from PRECIO
																				 where DETVENTA.nidart=PRECIO.nidart)*(CASE
																														  WHEN DETVENTA.ndocum in (300002,300004) THEN 0.1
																														  WHEN DETVENTA.ndocum =300005 THEN 0.05
																														  ELSE 0
																													   END)

UPDATE VENTA
   set ibruto=(select sum(ibruto)
                   from DETVENTA 
				   where DETVENTA.nidven=VENTA.nidven),
	   idscto=(select sum(idscto)
                   from DETVENTA 
				   where DETVENTA.nidven=VENTA.nidven),
	   iimpue=(select sum(iimpue)
                   from DETVENTA 
				   where DETVENTA.nidven=VENTA.nidven),
	   itneto=(select sum(itneto)
                   from DETVENTA 
				   where DETVENTA.nidven=VENTA.nidven)

--### 2do query utilidades por vendedor
--select SUM((d.ibruto-c.icosto*d.qartic)*(case d.idsto when 0 then 1 else d.idsto end)) as "UTILIDAD", 
select SUM((d.ibruto-c.icosto*d.qartic)) as "UTILIDAD", 
	   ISNULL(vd.dvend,'TOTAL') as "VENDEDOR"
	from VENDEDOR vd
	inner join VENTA v on v.nidvend=vd.nidvend
	inner join DETVENTA d on d.nidven=v.nidven
	inner join COSTO c on c.nidart=d.nidart
	group by vd.dvend with rollup

--### 3er Utilidades por documento
--select SUM((d.ibruto-c.icosto*d.qartic)*(case d.idsto when 0 then 1 else d.idsto end)) as "UTILIDAD", 
select SUM((d.ibruto-c.icosto*d.qartic)) as "UTILIDAD", 
	   ISNULL(CAST(v.ndocum as varchar(8)),'TOTAL') as "DOCUMENTO"
	from VENTA v
	inner join DETVENTA d on d.nidven=v.nidven
	inner join COSTO c on c.nidart=d.nidart
	group by v.ndocum with rollup

--### 4to query del cuadro adjunto
select g.dgrupo as "GRUPO",
	a.cartic + ' ' + a.dartic as "ARTICULO",
	dv.ibruto as "IMPORTE",
	dv.qartic as "CANTIDAD",
	v.ndocum as "NRO DOCUMENTO",
	vd.cvend as "VENDEDOR"
from VENTA as v
	inner join VENDEDOR vd
		on vd.nidvend = v.nidvend
	inner join DETVENTA dv
		on dv.nidven = v.nidven
	inner join ARTICULO a
		on dv.nidart = a.nidart
	inner join GRUPO g
		on a.nidgru = g.nidgru
order by
	g.dgrupo

--### 5to query venta por cliente
select ISNULL(dclien,'TOTAL') Cliente,sum(ibruto) Bruto,sum(iimpue) Impuesto,sum(itneto) Neto
  from VENTA
  inner join CLIENTE on CLIENTE.nidcli=VENTA.nidcli
  group by dclien with rollup

--### 6to utilidades por grupo
select *
	from(
	select cgrupo + ' ' + dgrupo as "GRUPO",cartic,itneto
	from DETVENTA d
		inner join ARTICULO a on a.nidart=d.nidart
		inner join GRUPO g on g.nidgru=a.nidgru
	) as TABLA1
PIVOT(sum(itneto) for cartic in ("3010","3011","3012","4010","4011","4012","5010","5011","5012","6010","6011")) as TABLA2
