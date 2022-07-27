USE MASTER
GO
DROP DATABASE dbconcesionario
GO
CREATE DATABASE dbconcesionario
ON PRIMARY
(name='db_concesionario_mdf',
filename='d:\isil\Base de Datos\data\dbconcesionario.mdf',
size=1,
filegrowth=1,
maxsize=2
)
LOG ON
(
name='dbconcesionario_ldf',
filename='d:\isil\Base de Datos\data\dbconcesionario.ldf',
size=1,
filegrowth=1,
maxsize=2
)
GO
USE dbconcesionario
GO
CREATE TABLE COSTO
(
nidcos int not null,
ccosto char(2),
nidpro int,
icosto dec(8,2)
)
CREATE TABLE PRECIO
(
nidpre int not null,
cpreci char(2),
nidpro int,
ipreci dec(8,2)
)
CREATE TABLE VENTA
(
nidven int not null,
ctpdoc char(2),
ndocum int,
nidcon int,
femisi date,
ibruto dec(8,2),
iimpue dec(8,2),
idscto dec(8,2),
itneto dec(8,2)
)
CREATE TABLE DETVENTA
(
niddet int not null,
nidven int,
ctpdoc char(2),
ndocum int,
nidpro int,
qprodu smallint,
ibruto dec(8,2),
iimpue dec(8,2),
idscto dec(8,2),
itneto dec(8,2)
)
CREATE TABLE PRODUCTO
(
nidpro int not null,
cprodu char(4) not null,
dprodu varchar(99)
)
GO
CREATE TABLE CONCESIONARIO
(
nidcon int not null,
cconce char(3) not null,
dconce varchar(99)
)

 --### CREANDO LOS PRIMARYS
ALTER TABLE PRECIO ADD CONSTRAINT PRECIO_PK PRIMARY KEY(nidpre)
ALTER TABLE PRODUCTO ADD CONSTRAINT PRODUCTO_PK PRIMARY KEY(nidpro)
ALTER TABLE VENTA ADD CONSTRAINT VENTA_PK PRIMARY KEY(nidven)
ALTER TABLE DETVENTA ADD CONSTRAINT DETVENTA_PK PRIMARY KEY(niddet)
ALTER TABLE CONCESIONARIO ADD CONSTRAINT CONCESIONARIO_PK PRIMARY KEY(nidcon)
ALTER TABLE COSTO ADD CONSTRAINT COSTO_PK PRIMARY KEY(nidcos)
 
--### CRAENDO EL UNIQUE
ALTER TABLE VENTA ADD CONSTRAINT VENTA_UK UNIQUE(ctpdoc,ndocum)
ALTER TABLE DETVENTA ADD CONSTRAINT DETVENTA_UK UNIQUE(ctpdoc,ndocum,nidpro)
ALTER TABLE PRECIO ADD CONSTRAINT PRECIO_UK UNIQUE(cpreci)
ALTER TABLE COSTO ADD CONSTRAINT COSTO_UK UNIQUE(ccosto)
ALTER TABLE CONCESIONARIO ADD CONSTRAINT CONCESIONARIO_UK UNIQUE(cconce)
ALTER TABLE PRODUCTO ADD CONSTRAINT PRODUCTO_UK UNIQUE(cprodu)
 

--### CREANDO LAS FORANEAS
ALTER TABLE VENTA ADD CONSTRAINT VENTA_FK FOREIGN KEY(nidcon) REFERENCES CONCESIONARIO(nidcon)
ALTER TABLE DETVENTA ADD CONSTRAINT DETVENTA_FK FOREIGN KEY(ctpdoc,ndocum) REFERENCES VENTA(ctpdoc,ndocum)
ALTER TABLE DETVENTA ADD CONSTRAINT DETVENTA_FK1 FOREIGN KEY(nidven) REFERENCES VENTA(nidven)
ALTER TABLE DETVENTA ADD CONSTRAINT DETVENTA_FK2 FOREIGN KEY(nidpro) REFERENCES PRODUCTO(nidpro)
ALTER TABLE PRECIO ADD CONSTRAINT PRECIO_FK FOREIGN KEY(nidpro) REFERENCES PRODUCTO(nidpro)
ALTER TABLE COSTO ADD CONSTRAINT COSTO_FK FOREIGN KEY(nidpro) REFERENCES PRODUCTO(nidpro)

--### CREANDO DEFAULTS
ALTER TABLE VENTA ADD CONSTRAINT VENTA_DF DEFAULT 'FA' FOR ctpdoc
ALTER TABLE VENTA ADD CONSTRAINT VENTA_DF1 DEFAULT 0 FOR ibruto
ALTER TABLE VENTA ADD CONSTRAINT VENTA_DF2 DEFAULT 0  FOR iimpue
ALTER TABLE VENTA ADD CONSTRAINT VENTA_DF3 DEFAULT 0 FOR idscto
ALTER TABLE VENTA ADD CONSTRAINT VENTA_DF4 DEFAULT 0 FOR itneto

ALTER TABLE DETVENTA ADD CONSTRAINT DETVENTA_DF DEFAULT 'FA' FOR ctpdoc
 

 INSERT INTO CONCESIONARIO 
 VALUES (1,'01', 'San Jacinto'),
		(2,'02', 'Santa Raquel'),
		(3,'03','San Benito'),
		(4,'04', 'San Pedro'),
		(5,'05', 'Gaspar')

INSERT INTO PRODUCTO 
VALUES  (1,'1231', 'ACCENT'),
		(2,'1232', 'CRETA'),
		(3,'1233', 'ELANTRA'),
		(4,'1234', 'SANTA FE'),
		(5,'1235', 'HATCHBACK'),
		(6,'1236','TICO'),
		(7,'1237','TOYOTA')

INSERT INTO PRECIO 
VALUES  (1,'01',1, 20000),
		(2,'02',2, 21000),
		(3,'03',3, 32000),
		(4,'04',4, 26000),
		(5,'05',5, 19000)

INSERT INTO COSTO 
VALUES  (1,'01',1, 16000),
		(2,'02',2, 16800),
		(3,'03',3, 24000),
		(4,'04',4, 19000),
		(5,'05',5, 15000)

		delete from venta


INSERT INTO VENTA(nidven, ndocum,nidcon,femisi) VALUES 
(1 ,300001, 1, '2019-10-05'),
(2 ,300002, 2, '2019-12-10'),
(3 ,300003, 3, '2020-04-12'),
(4 ,300004, 4, '2020-05-10'),
(5, 300005, 5, '2020-07-20')

INSERT INTO DETVENTA(niddet,nidven,ndocum,nidpro,qprodu) 
VALUES (1,1, 300001, 1, 12),
(2,1,  300001, 5, 5),
(3,1,  300001, 2, 5),
(4,2,  300002, 3, 5),
(5,2,  300002, 5, 5),
(6,2,  300002, 2, 5),
(7,2 , 300002, 4, 5),
(8,3, 300003, 5, 6),
(9,3,  300003,2, 8),
(10,3 , 300003, 3, 7),
(11,3, 300003, 4, 9),
(12,4, 300004,2, 3),
(13,4, 300004, 3, 7),
(14,5, 300005, 1, 15)

--select * from detventa
UPDATE DETVENTA 
   set ibruto=qprodu*(select ipreci
                         from PRECIO
						 where DETVENTA.nidpro=PRECIO.nidpro),
	   idscto=qprodu*(select ipreci
                         from PRECIO
						 where DETVENTA.nidpro=PRECIO.nidpro)*(CASE
						                                          WHEN DETVENTA.ndocum in (300002,300004) THEN 0.1
																  WHEN DETVENTA.ndocum =300005 THEN 0.05
																  ELSE 0
						                                       END),
	   iimpue=qprodu*(select ipreci
                         from PRECIO
						 where DETVENTA.nidpro=PRECIO.nidpro)*0.18,
	   itneto=qprodu*(select ipreci
                         from PRECIO
						 where DETVENTA.nidpro=PRECIO.nidpro)*1.18-qprodu*(select ipreci
																				 from PRECIO
																				 where DETVENTA.nidpro=PRECIO.nidpro)*(CASE
																														  WHEN DETVENTA.ndocum in (300002,300004) THEN 0.1
																														  WHEN DETVENTA.ndocum =300005 THEN 0.05
																														  ELSE 0
																													   END)


UPDATE VENTA
   set ibruto=(select sum(ibruto)
                   from DETVENTA 
				   where DETVENTA.nidven=VENTA.nidven),
	   iimpue=(select sum(iimpue)
                   from DETVENTA 
				   where DETVENTA.nidven=VENTA.nidven),
	   idscto=(select sum(idscto)
                   from DETVENTA 
				   where DETVENTA.nidven=VENTA.nidven),
	   itneto=(select sum(itneto)
                   from DETVENTA 
				   where DETVENTA.nidven=VENTA.nidven)


--### VENTAS x MES
select ISNULL(format(femisi,'yyyy-MM'),'TOTAL') Año_mes,sum(ibruto) Bruto,sum(iimpue) impuesto,sum(idscto) descuento,sum(itneto) Neto
   from VENTA
   group by  format(femisi,'yyyy-MM') with rollup


--### VENTAS x CONCESIONARIO
select ISNULL(dconce,'TOTAL') Concesionario,sum(ibruto) Bruto,sum(iimpue) impuesto,sum(idscto) descuento,sum(itneto) Neto
   from VENTA v
   inner join CONCESIONARIO c on v.nidcon=c.nidcon
   group by  dconce with rollup

--### VENTAS X MODELO
select ISNULL(dprodu,'TOTAL') Modelo,sum(ibruto) Bruto,sum(iimpue) impuesto,sum(idscto) descuento,sum(itneto) Neto
   from DETVENTA d
   inner join PRODUCTO p on d.nidpro=p.nidpro
   group by dprodu with rollup

 --### UTILIDAD POR MODELO
select ISNULL(dprodu,'TOTAL') Modelo,sum(d.ibruto-qprodu*icosto) Utilidad
    from DETVENTA d
	inner join PRODUCTO p on d.nidpro=p.nidpro
	inner join COSTO c on c.nidpro=p.nidpro
  group by dprodu with rollup

   --### UTILIDAD POR MODELO y CONCESIONARIO
select *
   from (
select dconce,ISNULL(dprodu,'TOTAL') Modelo,sum(d.ibruto-qprodu*icosto) Utilidad
    from DETVENTA d
	inner join VENTA v on v.nidven=d.nidven 
	inner join CONCESIONARIO co on co.nidcon=v.nidcon
	inner join PRODUCTO p on d.nidpro=p.nidpro
	inner join COSTO c on c.nidpro=p.nidpro
  group by dconce,dprodu  ) as tabla1
  PIVOT ( sum(utilidad) for Modelo in ("ACCENT","CRETA","ELANTRA","HATCHBACK","SANTA FE")) as TABLA3

  --### VENTAS x AÑO
select ISNULL(format(femisi,'yyyy'),'TOTAL') Año_mes,sum(ibruto) Bruto,sum(iimpue) impuesto,sum(idscto) descuento,sum(itneto) Neto
   from VENTA
   group by  format(femisi,'yyyy') with rollup

   --### PRODUCTOS CON COSTO Y PRECIO
select dprodu,icosto,ipreci
   from PRODUCTO p
   inner join COSTO c on c.nidpro=p.nidpro
   inner join PRECIO pr on pr.nidpro=p.nidpro
