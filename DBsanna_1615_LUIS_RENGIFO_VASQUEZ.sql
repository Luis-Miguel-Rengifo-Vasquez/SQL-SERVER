use master
go
drop database dbsanna
go
create database dbsanna
on primary
(
name="dbsanna_mdf",
filename="d:\isil\Base de Datos\data\dbsanna.mdf",
size=1,
maxsize=5,
filegrowth=1
)
log on
(
name="dbsanna_ldf",
filename="d:\isil\Base de Datos\data\dbsanna.ldf",
size=1,
maxsize=5,
filegrowth=1
)
go
use dbsanna
go
create table SERVICIO
(nidser int not null,
 cservi char(2),
 dservi varchar(99)
 )
create table PRECIO
(nidpre int not null,
 cpreci char(2),
 nidser int,
 ipreci dec(8,2)
 )
 create table COSTO
 (nidcos int not null,
 ccosto char(2),
 nidser int,
 icosto dec(8,2)
 )
 CREATE TABLE SEGURO
(nidseg int not null,
csegur char(2) not null,
dsegur varchar(99),
idscto dec(8,2)
)
go
CREATE TABLE PACIENTE
(nidpac int not null,
cpacie char(6) not null,
dpacie varchar(99),
nidseg int
)
CREATE TABLE MEDICO
(nidmed int not null ,
cmedic char(2) not null,
dmedic varchar(99),
nidesp int
)

CREATE TABLE ESPECIALIDAD
(nidesp int not null,
cespec char(2) not null,
despec varchar(99)
)


CREATE TABLE VENTA
(nidven int not null,
ctpdoc char(2) not null,
ndocum int not null,
nidpac int,
femisi date,
ibruto dec(12,2),
idscto dec(12,2),
iimpue dec(12,2),
itneto dec(12,2),
nidmed int
)
CREATE TABLE DETVENTA
(niddet int not null,
 nidven int not null,
ctpdoc char(2) not null,
ndocum int not null,
nidser int,
qservi smallint,
ibruto dec(12,2),
idscto dec(12,2),
iimpue dec(12,2),
itneto dec(12,2),
)

ALTER TABLE SERVICIO ADD CONSTRAINT servicio_pk  PRIMARY KEY (nidser)
ALTER TABLE PACIENTE ADD CONSTRAINT paciente_pk  PRIMARY KEY (nidpac)
ALTER TABLE MEDICO ADD CONSTRAINT medico_pk  PRIMARY KEY (nidmed)
ALTER TABLE ESPECIALIDAD ADD CONSTRAINT especialidad_pk  PRIMARY KEY (nidesp)
ALTER TABLE SEGURO ADD CONSTRAINT seguro_pk  PRIMARY KEY (nidseg)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_pk  PRIMARY KEY (niddet)
ALTER TABLE VENTA ADD CONSTRAINT venta_pk  PRIMARY KEY (nidven)
ALTER TABLE PRECIO ADD CONSTRAINT precio_pk PRIMARY KEY (nidpre)
ALTER TABLE COSTO ADD CONSTRAINT costo_pk PRIMARY KEY (nidcos)

ALTER TABLE SERVICIO ADD CONSTRAINT servicio_uk  UNIQUE (cservi)
ALTER TABLE PACIENTE ADD CONSTRAINT paciente_uk  UNIQUE (cpacie)
ALTER TABLE MEDICO ADD CONSTRAINT medico_uk  UNIQUE (cmedic)
ALTER TABLE ESPECIALIDAD ADD CONSTRAINT especialidad_uk  UNIQUE (cespec)
ALTER TABLE SEGURO ADD CONSTRAINT seguro_uk  UNIQUE (csegur)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_uk  UNIQUE (ctpdoc,ndocum,nidser)
ALTER TABLE VENTA ADD CONSTRAINT venta_uk  UNIQUE (ctpdoc,ndocum)
ALTER TABLE PRECIO ADD CONSTRAINT precio_uk UNIQUE (cpreci)
ALTER TABLE COSTO ADD CONSTRAINT costo_uk UNIQUE (ccosto)

 ALTER TABLE VENTA ADD CONSTRAINT venta_fk  FOREIGN KEY (nidpac) REFERENCES PACIENTE(nidpac)
 ALTER TABLE VENTA ADD CONSTRAINT venta_fk1  FOREIGN KEY (nidmed) REFERENCES MEDICO(nidmed)
 ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk   FOREIGN KEY (nidser) REFERENCES SERVICIO(nidser)
 ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk1   FOREIGN KEY (nidven) REFERENCES VENTA(nidven)
 ALTER TABLE PACIENTE ADD CONSTRAINT paciente_fk FOREIGN KEY(nidseg) REFERENCES SEGURO(nidseg)
 ALTER TABLE MEDICO ADD CONSTRAINT medico_fk FOREIGN KEY (nidesp) REFERENCES ESPECIALIDAD(nidesp)

 ALTER TABLE VENTA ADD CONSTRAINT venta_dk DEFAULT 1 FOR nidmed
 ALTER TABLE VENTA ADD CONSTRAINT venta_dk1 DEFAULT 0 FOR idscto
 ALTER TABLE DETVENTA ADD CONSTRAINT detventa_dk1 DEFAULT 1 FOR nidser
 ALTER TABLE DETVENTA ADD CONSTRAINT detventa_dk2 DEFAULT 1 FOR qservi

 INSERT INTO SEGURO
 VALUES(1,'01','MAPFRE',.1),
       (2,'02','PACIFICO',.15),
	   (3,'03','RIMAC',.2),
	   (4,'04','SALUD PRIVADA',.14),
	   (5,'05','PPSALUD',.2)

	   
INSERT INTO PRECIO
VALUES(1,'01',1,150)

INSERT INTO COSTO
VALUES(1,'01',1,80)

INSERT INTO ESPECIALIDAD 
VALUES(1,'01','GERIATRIA')

INSERT INTO MEDICO 
VALUES(1,'01','LUIS OTOLAZA',1)

INSERT INTO SERVICIO 
VALUES(1,'01','ATENCION POR GERIATRIA')


INSERT INTO PACIENTE 
VALUES(1,'100001','Carlos Pérez',1),
(2,'100002','Víctor Vélez',2),
(3,'100003','Aldo Pereyra',3),
(4,'100004','Luis Petrovich',4),
(5,'100005','Mauricio Nairn',5),
(6,'100006','Pedro Velarde',null)

INSERT INTO VENTA(nidven,ctpdoc,ndocum,nidpac,femisi)										
VALUES(	1	,	'BV'	,	90000001	,	1	,	'2022-01-01'	),
(	2	,	'BV'	,	90000002	,	1	,	'2022-01-01'	),
(	3	,	'BV'	,	90000003	,	2	,	'2022-01-01'	),
(	4	,	'BV'	,	90000004	,	2	,	'2022-01-01'	),
(	5	,	'BV'	,	90000005	,	2	,	'2022-01-01'	),
(	6	,	'BV'	,	90000006	,	2	,	'2022-01-01'	),
(	7	,	'BV'	,	90000007	,	2	,	'2022-01-01'	),
(	8	,	'BV'	,	90000008	,	3	,	'2022-01-01'	),
(	9	,	'FA'	,	90000001	,	4	,	'2022-01-01'	),
(	10	,	'FA'	,	90000002	,	4	,	'2022-01-01'	),
(	11	,	'BV'	,	90000009	,	5	,	'2022-01-01'	),
(	12	,	'BV'	,	90000010	,	5	,	'2022-01-01'	),
(	13	,	'FA'	,	90000003	,	6	,	'2022-01-01'	),
(	14	,	'FA'	,	90000004	,	6	,	'2022-01-01'	),
(	15	,	'BV'	,	90000011	,	1	,	'2022-02-01'	),
(	16	,	'BV'	,	90000012	,	2	,	'2022-02-01'	),
(	17	,	'FA'	,	90000005	,	4	,	'2022-02-01'	),
(	18	,	'FA'	,	90000006	,	4	,	'2022-02-01'	),
(	19	,	'FA'	,	90000007	,	4	,	'2022-02-01'	),
(	20	,	'FA'	,	90000008	,	4	,	'2022-02-01'	),
(	21	,	'BV'	,	90000013	,	5	,	'2022-02-01'	),
(	22	,	'BV'	,	90000014	,	5	,	'2022-02-01'	),
(	23	,	'BV'	,	90000015	,	5	,	'2022-02-01'	),
(	24	,	'FA'	,	90000009	,	6	,	'2022-02-01'	),
(	25	,	'FA'	,	90000010	,	6	,	'2022-02-01'	),
(	26	,	'FA'	,	90000011	,	6	,	'2022-02-01'	),
(	27	,	'FA'	,	90000012	,	6	,	'2022-02-01'	),
(	28	,	'BV'	,	90000016	,	1	,	'2022-03-01'	),
(	29	,	'BV'	,	90000017	,	3	,	'2022-03-01'	),
(	30	,	'FA'	,	90000013	,	4	,	'2022-03-01'	),
(	31	,	'FA'	,	90000014	,	4	,	'2022-03-01'	),
(	32	,	'FA'	,	90000015	,	4	,	'2022-03-01'	),
(	33	,	'FA'	,	90000016	,	4	,	'2022-03-01'	),
(	34	,	'FA'	,	90000017	,	4	,	'2022-03-01'	),
(	35	,	'FA'	,	90000018	,	4	,	'2022-03-01'	),
(	36	,	'FA'	,	90000019	,	4	,	'2022-03-01'	),
(	37	,	'BV'	,	90000018	,	5	,	'2022-03-01'	),
(	38	,	'BV'	,	90000019	,	5	,	'2022-03-01'	),
(	39	,	'BV'	,	90000020	,	5	,	'2022-03-01'	),
(	40	,	'BV'	,	90000021	,	5	,	'2022-03-01'	),
(	41	,	'BV'	,	90000022	,	5	,	'2022-03-01'	),
(	42	,	'FA'	,	90000020	,	6	,	'2022-03-01'	),
(	43	,	'FA'	,	90000021	,	6	,	'2022-03-01'	),
(	44	,	'FA'	,	90000022	,	6	,	'2022-03-01'	),
(	45	,	'FA'	,	90000023	,	6	,	'2022-03-01'	),
(	46	,	'FA'	,	90000024	,	6	,	'2022-03-01'	),
(	47	,	'FA'	,	90000025	,	6	,	'2022-03-01'	),
(	48	,	'FA'	,	90000026	,	6	,	'2022-03-01'	),
(	49	,	'FA'	,	90000027	,	6	,	'2022-03-01'	),
(	50	,	'FA'	,	90000028	,	6	,	'2022-03-01'	),
(	51	,	'FA'	,	90000029	,	6	,	'2022-03-01'	),
(	52	,	'FA'	,	90000030	,	6	,	'2022-03-01'	),
(	53	,	'FA'	,	90000031	,	6	,	'2022-03-01'	),
(	54	,	'BV'	,	90000023	,	2	,	'2022-04-01'	),
(	55	,	'BV'	,	90000024	,	2	,	'2022-04-01'	),
(	56	,	'FA'	,	90000032	,	4	,	'2022-04-01'	),
(	57	,	'FA'	,	90000033	,	4	,	'2022-04-01'	),
(	58	,	'FA'	,	90000034	,	4	,	'2022-04-01'	),
(	59	,	'FA'	,	90000035	,	4	,	'2022-04-01'	),
(	60	,	'FA'	,	90000036	,	4	,	'2022-04-01'	),
(	61	,	'FA'	,	90000037	,	4	,	'2022-04-01'	),
(	62	,	'FA'	,	90000038	,	4	,	'2022-04-01'	),
(	63	,	'FA'	,	90000039	,	4	,	'2022-04-01'	),
(	64	,	'FA'	,	90000040	,	4	,	'2022-04-01'	),
(	65	,	'BV'	,	90000025	,	5	,	'2022-04-01'	),
(	66	,	'BV'	,	90000026	,	5	,	'2022-04-01'	)


INSERT INTO DETVENTA(niddet,nidven,ctpdoc,ndocum,nidser,qservi)												
VALUES  (	1	,   1	,   'BV'	,   90000001	,	1	,	1	),
		(	2	,	2	,	'BV'	,	90000002	,	1	,	1	),
		(	3	,	3	,	'BV'	,	90000003	,	1	,	1	),
		(	4	,	4	,	'BV'	,	90000004	,	1	,	1	),
		(	5	,	5	,	'BV'	,	90000005	,	1	,	1	),
		(	6	,	6	,	'BV'	,	90000006	,	1	,	1	),
		(	7	,	7	,	'BV'	,	90000007	,	1	,	1	),
		(	8	,	8	,	'BV'	,	90000008	,	1	,	1	),
		(	9	,	9	,	'FA'	,	90000001	,	1	,	1	),
		(	10	,	10	,	'FA'	,	90000002	,	1	,	1	),
		(	11	,	11	,	'BV'	,	90000009	,	1	,	1	),
		(	12	,	12	,	'BV'	,	90000010	,	1	,	1	),
		(	13	,	13	,	'FA'	,	90000003	,	1	,	1	),
		(	14	,	14	,	'FA'	,	90000004	,	1	,	1	),
		(	15	,	15	,	'BV'	,	90000011	,	1	,	1	),
		(	16	,	16	,	'BV'	,	90000012	,	1	,	1	),
		(	17	,	17	,	'FA'	,	90000005	,	1	,	1	),
		(	18	,	18	,	'FA'	,	90000006	,	1	,	1	),
		(	19	,	19	,	'FA'	,	90000007	,	1	,	1	),
		(	20	,	20	,	'FA'	,	90000008	,	1	,	1	),
		(	21	,	21	,	'BV'	,	90000013	,	1	,	1	),
		(	22	,	22	,	'BV'	,	90000014	,	1	,	1	),
		(	23	,	23	,	'BV'	,	90000015	,	1	,	1	),
		(	24	,	24	,	'FA'	,	90000009	,	1	,	1	),
		(	25	,	25	,	'FA'	,	90000010	,	1	,	1	),
		(	26	,	26	,	'FA'	,	90000011	,	1	,	1	),
		(	27	,	27	,	'FA'	,	90000012	,	1	,	1	),
		(	28	,	28	,	'BV'	,	90000016	,	1	,	1	),
		(	29	,	29	,	'BV'	,	90000017	,	1	,	1	),
		(	30	,	30	,	'FA'	,	90000013	,	1	,	1	),
		(	31	,	31	,	'FA'	,	90000014	,	1	,	1	),
		(	32	,	32	,	'FA'	,	90000015	,	1	,	1	),
		(	33	,	33	,	'FA'	,	90000016	,	1	,	1	),
		(	34	,	34	,	'FA'	,	90000017	,	1	,	1	),
		(	35	,	35	,	'FA'	,	90000018	,	1	,	1	),
		(	36	,	36	,	'FA'	,	90000019	,	1	,	1	),
		(	37	,	37	,	'BV'	,	90000018	,	1	,	1	),
		(	38	,	38	,	'BV'	,	90000019	,	1	,	1	),
		(	39	,	39	,	'BV'	,	90000020	,	1	,	1	),
		(	40	,	40	,	'BV'	,	90000021	,	1	,	1	),
		(	41	,	41	,	'BV'	,	90000022	,	1	,	1	),
		(	42	,	42	,	'FA'	,	90000020	,	1	,	1	),
		(	43	,	43	,	'FA'	,	90000021	,	1	,	1	),
		(	44	,	44	,	'FA'	,	90000022	,	1	,	1	),
		(	45	,	45	,	'FA'	,	90000023	,	1	,	1	),
		(	46	,	46	,	'FA'	,	90000024	,	1	,	1	),
		(	47	,	47	,	'FA'	,	90000025	,	1	,	1	),
		(	48	,	48	,	'FA'	,	90000026	,	1	,	1	),
		(	49	,	49	,	'FA'	,	90000027	,	1	,	1	),
		(	50	,	50	,	'FA'	,	90000028	,	1	,	1	),
		(	51	,	51	,	'FA'	,	90000029	,	1	,	1	),
		(	52	,	52	,	'FA'	,	90000030	,	1	,	1	),
		(	53	,	53	,	'FA'	,	90000031	,	1	,	1	),
		(	54	,	54	,	'BV'	,	90000023	,	1	,	1	),
		(	55	,	55	,	'BV'	,	90000024	,	1	,	1	),
		(	56	,	56	,	'FA'	,	90000032	,	1	,	1	),
		(	57	,	57	,	'FA'	,	90000033	,	1	,	1	),
		(	58	,	58	,	'FA'	,	90000034	,	1	,	1	),
		(	59	,	59	,	'FA'	,	90000035	,	1	,	1	),
		(	60	,	60	,	'FA'	,	90000036	,	1	,	1	),
		(	61	,	61	,	'FA'	,	90000037	,	1	,	1	),
		(	62	,	62	,	'FA'	,	90000038	,	1	,	1	),
		(	63	,	63	,	'FA'	,	90000039	,	1	,	1	),
		(	64	,	64	,	'FA'	,	90000040	,	1	,	1	),
		(	65	,	65	,	'BV'	,	90000025	,	1	,	1	),
		(	66	,	66	,	'BV'	,	90000026	,	1	,	1	)


--select *    from DETVENTA

UPDATE DETVENTA
   set ibruto=qservi*(select ipreci  
                        from PRECIO
						where PRECIO.nidser=DETVENTA.nidser),
	   iimpue=qservi*(select ipreci  
                        from PRECIO
						where PRECIO.nidser=DETVENTA.nidser)*0.18,
	   idscto=ISNULL(qservi*(select ipreci  
                        from PRECIO
						where PRECIO.nidser=DETVENTA.nidser)*
						(select s.idscto 
						    from SEGURO s
							inner join PACIENTE p on p.nidseg=s.nidseg
							inner join VENTA v on v.nidpac=p.nidpac
							where v.nidven=DETVENTA.nidven),0),
						 
	   itneto=qservi*(select ipreci  
                        from PRECIO
						where PRECIO.nidser=DETVENTA.nidser)*1.18-ISNULL(qservi*(select ipreci  
                        from PRECIO
						where PRECIO.nidser=DETVENTA.nidser)*
						(select s.idscto 
						    from SEGURO s
							inner join PACIENTE p on p.nidseg=s.nidseg
							inner join VENTA v on v.nidpac=p.nidpac
							where v.nidven=DETVENTA.nidven),0)

update VENTA
   set ibruto=(select SUM(ibruto)
                  from DETVENTA 
				  where DETVENTA.nidven=VENTA.nidven),
	iimpue=(select SUM(iimpue)
                  from DETVENTA 
				  where DETVENTA.nidven=VENTA.nidven),
	idscto=(select SUM(idscto)
                  from DETVENTA 
				  where DETVENTA.nidven=VENTA.nidven),
	itneto=(select SUM(itneto)
                  from DETVENTA 
				  where DETVENTA.nidven=VENTA.nidven)

/* QUERY 1 */
select ISNULL(FORMAT(femisi,'yyyy-MM'),'TOTAL') Mes_Año,SUM(ibruto) Bruto,
                                        SUM(iimpue) Impuesto,
										SUM(idscto) Descuento,
										SUM(itneto) Neto
 from venta
 group by FORMAT(femisi,'yyyy-MM') with rollup

/* QUERY 2 */
select dmedic Medico,SUM(icosto*qservi) costos
   from DETVENTA d
   inner join VENTA v on v.nidven=d.nidven
   inner join MEDICO m on m.nidmed=v.nidmed
   inner join COSTO c on c.nidser=d.nidser
group by dmedic

/* QUERY 3 */
select ISNULL(FORMAT(femisi,'yyyy-MM'),'TOTAL') Mes_Año,SUM(d.ibruto-icosto*qservi) Utilidad
   from DETVENTA d
   inner join VENTA v on v.nidven=d.nidven
   inner join MEDICO m on m.nidmed=v.nidmed
   inner join COSTO c on c.nidser=d.nidser
group by  FORMAT(femisi,'yyyy-MM') with rollup

/*QUERY 4*/
select isnull(dpacie,'TOTAL') Paciente,SUM(d.ibruto-icosto*qservi) Utilidad
   from DETVENTA d
   inner join VENTA v on v.nidven=d.nidven
   inner join PACIENTE p on p.nidpac=v.nidpac
   inner join MEDICO m on m.nidmed=v.nidmed
   inner join COSTO c on c.nidser=d.nidser
group by  dpacie with rollup

/* QUERY5*/
select seguro,dpacie,"01" Enero, "02" Febrero ,"03" marzo,"04" Abril,Total
   from (
select  ISNULL(dsegur,'') seguro,dpacie,format(femisi,'MM') mes, COUNT(*)  Cantidad
   from DETVENTA d
   inner join VENTA v on v.nidven=d.nidven
   inner join PACIENTE p on p.nidpac=v.nidpac
   inner join MEDICO m on m.nidmed=v.nidmed
   inner join COSTO c on c.nidser=d.nidser
   left outer join SEGURO s on s.nidseg=p.nidseg
   group by dsegur,dpacie,format(femisi,'MM')
union
select  ISNULL(dsegur,'') seguro,dpacie,'Total', COUNT(*)  Cantidad
   from DETVENTA d
   inner join VENTA v on v.nidven=d.nidven
   inner join PACIENTE p on p.nidpac=v.nidpac
   inner join MEDICO m on m.nidmed=v.nidmed
   inner join COSTO c on c.nidser=d.nidser
   left outer join SEGURO s on s.nidseg=p.nidseg
   group by dsegur,dpacie 
union 
   select  '' seguro,' TOTAL' dpacie,format(femisi,'MM') mes, COUNT(*)  Cantidad
   from DETVENTA d
   inner join VENTA v on v.nidven=d.nidven
   inner join PACIENTE p on p.nidpac=v.nidpac
   inner join MEDICO m on m.nidmed=v.nidmed
   inner join COSTO c on c.nidser=d.nidser
   left outer join SEGURO s on s.nidseg=p.nidseg
   group by format(femisi,'MM')
union 
   select  '' seguro,' TOTAL' dpacie,'Total', COUNT(*)  Cantidad
   from DETVENTA d
   inner join VENTA v on v.nidven=d.nidven
   inner join PACIENTE p on p.nidpac=v.nidpac
   inner join MEDICO m on m.nidmed=v.nidmed
   inner join COSTO c on c.nidser=d.nidser
   left outer join SEGURO s on s.nidseg=p.nidseg
  
        ) as tabla1
PIVOT(sum(cantidad) for mes in ("01","02","03","04","Total")) as tabla2
order by 2 desc,1 desc
--order by 1 desc,2 desc
 
 
