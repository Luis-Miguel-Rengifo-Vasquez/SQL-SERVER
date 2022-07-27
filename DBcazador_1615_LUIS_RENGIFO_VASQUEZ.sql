use master
go
drop database dbcazador
go
create database dbcazador
on primary
(
name="dbcazador_mdf",
filename="d:\isil\Base de Datos\data\dbcazador.mdf",
size=1,
maxsize=5,
filegrowth=1
)
log on
(
name="dbcazador_ldf",
filename="d:\isil\Base de Datos\data\dbcazador.ldf",
size=1,
maxsize=5,
filegrowth=1
)
go
use dbcazador
go
create table SERVICIO
(
nidser int not null,
cservi char(2),
dservi varchar(99)
)
create table PRECIO
(
nidpre int not null,
cpreci char(2),
nidser int,
ipreci dec(8,2)
 )
 create table COSTO
(
nidcos int not null,
ccosto char(2),
nidser int,
icosto dec(8,2)
)
 CREATE TABLE PAGO
(
nidpag int not null,
cpago char(2) not null,
dpago varchar(99),
idscto dec(8,2)
)
go
CREATE TABLE CLIENTE
(
nidclien int not null,
cclien char(6) not null,
dclien varchar(99),
nidpag int,
cdocid varchar(99)
)
CREATE TABLE CHEF
(
nidchef int not null ,
cchef char(2) not null,
dchef varchar(99),
cdocid varchar(11),
nidesp int
)

CREATE TABLE ESPECIALIDAD
(
nidesp int not null,
cespec char(2) not null,
despec varchar(99)
)

CREATE TABLE VENTA
(
nidven int not null,
ctpdoc char(2) not null,
ndocum int not null,
nidclien int,
femisi date,
ibruto dec(12,2),
idscto dec(12,2),
iimpue dec(12,2),
itneto dec(12,2),
nidchef int
)
CREATE TABLE DETVENTA
(
niddet int not null,
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
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_pk  PRIMARY KEY (nidclien)
ALTER TABLE CHEF ADD CONSTRAINT chef_pk  PRIMARY KEY (nidchef)
ALTER TABLE ESPECIALIDAD ADD CONSTRAINT especialidad_pk  PRIMARY KEY (nidesp)
ALTER TABLE PAGO ADD CONSTRAINT pago_pk  PRIMARY KEY (nidpag)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_pk  PRIMARY KEY (niddet)
ALTER TABLE VENTA ADD CONSTRAINT venta_pk  PRIMARY KEY (nidven)
ALTER TABLE PRECIO ADD CONSTRAINT precio_pk PRIMARY KEY (nidpre)
ALTER TABLE COSTO ADD CONSTRAINT costo_pk PRIMARY KEY (nidcos)

ALTER TABLE SERVICIO ADD CONSTRAINT servicio_uk  UNIQUE (cservi)
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_uk  UNIQUE (cclien)
ALTER TABLE CHEF ADD CONSTRAINT chef_uk  UNIQUE (cchef)
ALTER TABLE ESPECIALIDAD ADD CONSTRAINT especialidad_uk  UNIQUE (cespec)
ALTER TABLE PAGO ADD CONSTRAINT pago_uk  UNIQUE (cpago)
ALTER TABLE DETVENTA ADD CONSTRAINT detventa_uk  UNIQUE (ctpdoc,ndocum,nidser)
ALTER TABLE VENTA ADD CONSTRAINT venta_uk  UNIQUE (ctpdoc,ndocum)
ALTER TABLE PRECIO ADD CONSTRAINT precio_uk UNIQUE (cpreci)
ALTER TABLE COSTO ADD CONSTRAINT costo_uk UNIQUE (ccosto)

 ALTER TABLE VENTA ADD CONSTRAINT venta_fk  FOREIGN KEY (nidclien) REFERENCES CLIENTE(nidclien)
 ALTER TABLE VENTA ADD CONSTRAINT venta_fk1  FOREIGN KEY (nidchef) REFERENCES CHEF(nidchef)
 ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk   FOREIGN KEY (nidser) REFERENCES SERVICIO(nidser)
 ALTER TABLE DETVENTA ADD CONSTRAINT detventa_fk1   FOREIGN KEY (nidven) REFERENCES VENTA(nidven)
 ALTER TABLE CLIENTE ADD CONSTRAINT cliente_fk FOREIGN KEY(nidpag) REFERENCES PAGO(nidpag)
 ALTER TABLE CHEF ADD CONSTRAINT chef_fk FOREIGN KEY (nidesp) REFERENCES ESPECIALIDAD(nidesp)

 ALTER TABLE VENTA ADD CONSTRAINT venta_dk DEFAULT 1 FOR nidchef
 ALTER TABLE VENTA ADD CONSTRAINT venta_dk1 DEFAULT 0 FOR idscto
 ALTER TABLE DETVENTA ADD CONSTRAINT detventa_dk1 DEFAULT 1 FOR nidser
 ALTER TABLE DETVENTA ADD CONSTRAINT detventa_dk2 DEFAULT 1 FOR qservi

 INSERT INTO PAGO
 VALUES(1,'01','VIZA',.50),
       (2,'02','DINNERZ',.45),
	   (3,'03','BASTERCARD',.30),
	   (4,'04','DINERS',null)
	   
INSERT INTO PRECIO
VALUES(1,'01',1,120),
	  (2,'02',2,135)

INSERT INTO COSTO
VALUES(1,'01',1,40),
	  (2,'02',2,45)

INSERT INTO ESPECIALIDAD
VALUES(1,'01','CARNES Y PARRILLAS'),
	  (2,'02','PASTAS Y PIZZAS')

INSERT INTO CHEF
VALUES(1,'01','KAREN GAMBA','77232343',1),
	  (2,'02','LORENA VILDOSOLA','23436509',2)

INSERT INTO SERVICIO
VALUES(1,'01','MES DE LAS CARNES Y PARRILLAS'),
	  (2,'02','MES DE LAS PASTAS Y PIZZAS')

INSERT INTO CLIENTE
VALUES(1,'100001','LIONEL MESSI',1,'ARG000254'),
(2,'100002','CRISTIANO RONALDO',2,'POR000300'),
(3,'100003','NEYMAR',3,'BRA000100'),
(4,'100004','SERGIO RAMOS',4,'ESP000200'),
(5,'100005','LUIS SUAREZ',1,'URU000501'),
(6,'100006','PAOLO GUERRERO',2,'PER000305'),
(7,'100007','PAUL POGBA',1,'FRA000115'),
(8,'100008','ALFREDO PARDON',null,'1067755681')

INSERT INTO VENTA(nidven,ctpdoc,ndocum,nidclien,femisi, nidchef)	
VALUES

--##ENERO###--

(	1	,	'BV'	,	21000001	,	1	,	'2022-01-01'	,1),
(	2	,	'BV'	,	21000002	,	1	,	'2022-01-01'	,1),
(	3	,	'BV'	,	21000003	,	1	,	'2022-01-01'	,1),
(	4	,	'BV'	,	21000004	,	2	,	'2022-01-01'	,1),
(	5	,	'BV'	,	21000005	,	2	,	'2022-01-01'	,1),
(	6	,	'BV'	,	21000006	,	2	,	'2022-01-01'	,1),
(	7	,	'BV'	,	21000007	,	2	,	'2022-01-01'	,1),
(	8	,	'BV'	,	21000008	,	2	,	'2022-01-01'	,1),
(	9	,	'BV'	,	21000009	,	3	,	'2022-01-01'	,1),
(	10	,	'BV'	,	21000010	,	3	,	'2022-01-01'	,1),
(	11	,	'BV'	,	21000011	,	3	,	'2022-01-01'	,1),
(	12	,	'BV'	,	21000012	,	3	,	'2022-01-01'	,1),
(	13	,	'BV'	,	21000013	,	3	,	'2022-01-01'	,1),
(	14	,	'BV'	,	21000014	,	3	,	'2022-01-01'	,1),
(	15	,	'BV'	,	21000015	,	4	,	'2022-01-01'	,1),
(	16	,	'BV'	,	21000016	,	4	,	'2022-01-01'	,1),
(	17	,	'BV'	,	21000017	,	5	,	'2022-01-01'	,1),
(	18	,	'BV'	,	21000018	,	5	,	'2022-01-01'	,1),
(	19	,	'BV'	,	21000019	,	6	,	'2022-01-01'	,1),
(	20	,	'BV'	,	21000020	,	6	,	'2022-01-01'	,1),
(	21	,	'BV'	,	21000021	,	7	,	'2022-01-01'	,1),
(	22	,	'BV'	,	21000022	,	7	,	'2022-01-01'	,1),
(	23	,	'BV'	,	21000023	,	7	,	'2022-01-01'	,1),
(	24	,	'BV'	,	21000024	,	7	,	'2022-01-01'	,1),
(	25	,	'FA'	,	21000001	,	8	,	'2022-01-01'	,1),
(	26	,	'FA'	,	21000002	,	8	,	'2022-01-01'	,1),
(	27	,	'FA'	,	21000003	,	8	,	'2022-01-01'	,1),
(	28	,	'FA'	,	21000004	,	8	,	'2022-01-01'	,1),
(	29	,	'FA'	,	21000005	,	8	,	'2022-01-01'	,1),

--##FEBRERO##--

(	30	,	'BV'	,	21000025	,	1	,	'2022-02-01'	,2),
(	31	,	'BV'	,	21000026	,	1	,	'2022-02-01'	,2),
(	32	,	'BV'	,	21000027	,	1	,	'2022-02-01'	,2),
(	33	,	'BV'	,	21000028	,	1	,	'2022-02-01'	,2),
(	34	,	'BV'	,	21000029	,	1	,	'2022-02-01'	,2),
(	35	,	'BV'	,	21000030	,	1	,	'2022-02-01'	,2),
(	36	,	'BV'	,	21000031	,	1	,	'2022-02-01'	,2),
(	37	,	'BV'	,	21000032	,	1	,	'2022-02-01'	,2),
(	38	,	'BV'	,	21000033	,	1	,	'2022-02-01'	,2),
(	39	,	'BV'	,	21000034	,	1	,	'2022-02-01'	,2),
(	40	,	'BV'	,	21000035	,	1	,	'2022-02-01'	,2),
(	41	,	'BV'	,	21000036	,	1	,	'2022-02-01'	,2),
(	42	,	'BV'	,	21000037	,	2	,	'2022-02-01'	,2),
(	43	,	'BV'	,	21000038	,	3	,	'2022-02-01'	,2),
(	44	,	'BV'	,	21000039	,	3	,	'2022-02-01'	,2),
(	45	,	'BV'	,	21000040	,	3	,	'2022-02-01'	,2),
(	46	,	'BV'	,	21000041	,	3	,	'2022-02-01'	,2),
(	47	,	'BV'	,	21000042	,	3	,	'2022-02-01'	,2),
(	48	,	'BV'	,	21000043	,	4	,	'2022-02-01'	,2),
(	49	,	'BV'	,	21000044	,	4	,	'2022-02-01'	,2),
(	50	,	'BV'	,	21000045	,	4	,	'2022-02-01'	,2),
(	51	,	'BV'	,	21000046	,	4	,	'2022-02-01'	,2),
(	52	,	'BV'	,	21000047	,	5	,	'2022-02-01'	,2),
(	53	,	'BV'	,	21000048	,	5	,	'2022-02-01'	,2),
(	54	,	'BV'	,	21000049	,	5	,	'2022-02-01'	,2),
(	55	,	'BV'	,	21000050	,	6	,	'2022-02-01'	,2),
(	56	,	'BV'	,	21000051	,	6	,	'2022-02-01'	,2),
(	57	,	'BV'	,	21000052	,	6	,	'2022-02-01'	,2),
(	58	,	'BV'	,	21000053	,	6	,	'2022-02-01'	,2),
(	59	,	'BV'	,	21000054	,	7	,	'2022-02-01'	,2),
(	60	,	'BV'	,	21000055	,	7	,	'2022-02-01'	,2),
(	61	,	'BV'	,	21000056	,	7	,	'2022-02-01'	,2),
(	62	,	'BV'	,	21000057	,	7	,	'2022-02-01'	,2),
(	63	,	'FA'	,	21000006	,	8	,	'2022-02-01'	,2),
(	64	,	'FA'	,	21000007	,	8	,	'2022-02-01'	,2),
(	65	,	'FA'	,	21000008	,	8	,	'2022-02-01'	,2),
(	66	,	'FA'	,	21000009	,	8	,	'2022-02-01'	,2),
(	67	,	'FA'	,	21000010	,	8	,	'2022-02-01'	,2),
(	68	,	'FA'	,	21000011	,	8	,	'2022-02-01'	,2),
(	69	,	'FA'	,	21000012	,	8	,	'2022-02-01'	,2),
(	70	,	'FA'	,	21000013	,	8	,	'2022-02-01'	,2),
(	71	,	'FA'	,	21000014	,	8	,	'2022-02-01'	,2),
(	72	,	'FA'	,	21000015	,	8	,	'2022-02-01'	,2),
(	73	,	'FA'	,	21000016	,	8	,	'2022-02-01'	,2),

--##MARZO##--

(	74	,	'BV'	,	21000058	,	1	,	'2022-03-01'	,1),
(	75	,	'BV'	,	21000059	,	2	,	'2022-03-01'	,1),
(	76	,	'BV'	,	21000060	,	2	,	'2022-03-01'	,1),
(	77	,	'BV'	,	21000061	,	2	,	'2022-03-01'	,1),
(	78	,	'BV'	,	21000062	,	2	,	'2022-03-01'	,1),
(	79	,	'BV'	,	21000063	,	2	,	'2022-03-01'	,1),
(	80	,	'BV'	,	21000064	,	2	,	'2022-03-01'	,1),
(	81	,	'BV'	,	21000065	,	2	,	'2022-03-01'	,1),
(	82	,	'BV'	,	21000066	,	2	,	'2022-03-01'	,1),
(	83	,	'BV'	,	21000067	,	3	,	'2022-03-01'	,1),
(	84	,	'BV'	,	21000068	,	3	,	'2022-03-01'	,1),
(	85	,	'BV'	,	21000069	,	3	,	'2022-03-01'	,1),
(	86	,	'BV'	,	21000070	,	3	,	'2022-03-01'	,1),
(	87	,	'BV'	,	21000071	,	3	,	'2022-03-01'	,1),
(	88	,	'BV'	,	21000072	,	3	,	'2022-03-01'	,1),
(	89	,	'BV'	,	21000073	,	4	,	'2022-03-01'	,1),
(	90	,	'BV'	,	21000074	,	4	,	'2022-03-01'	,1),
(	91	,	'BV'	,	21000075	,	4	,	'2022-03-01'	,1),
(	92	,	'BV'	,	21000076	,	4	,	'2022-03-01'	,1),
(	93	,	'BV'	,	21000077	,	4	,	'2022-03-01'	,1),
(	94	,	'BV'	,	21000078	,	4	,	'2022-03-01'	,1),
(	95	,	'BV'	,	21000079	,	4	,	'2022-03-01'	,1),
(	96	,	'BV'	,	21000080	,	5	,	'2022-03-01'	,1),
(	97	,	'BV'	,	21000081	,	5	,	'2022-03-01'	,1),
(	98	,	'BV'	,	21000082	,	5	,	'2022-03-01'	,1),
(	99	,	'BV'	,	21000083	,	5	,	'2022-03-01'	,1),
(	100	,	'BV'	,	21000084	,	5	,	'2022-03-01'	,1),
(	101	,	'BV'	,	21000085	,	6	,	'2022-03-01'	,1),
(	102	,	'BV'	,	21000086	,	6	,	'2022-03-01'	,1),
(	103	,	'BV'	,	21000087	,	6	,	'2022-03-01'	,1),
(	104	,	'BV'	,	21000088	,	6	,	'2022-03-01'	,1),
(	105	,	'BV'	,	21000089	,	6	,	'2022-03-01'	,1),
(	106	,	'BV'	,	21000090	,	6	,	'2022-03-01'	,1),
(	107	,	'BV'	,	21000091	,	6	,	'2022-03-01'	,1),
(	108	,	'BV'	,	21000092	,	6	,	'2022-03-01'	,1),
(	109	,	'BV'	,	21000093	,	6	,	'2022-03-01'	,1),
(	110	,	'BV'	,	21000094	,	6	,	'2022-03-01'	,1),
(	111	,	'BV'	,	21000095	,	6	,	'2022-03-01'	,1),
(	112	,	'BV'	,	21000096	,	6	,	'2022-03-01'	,1),
(	113	,	'BV'	,	21000097	,	7	,	'2022-03-01'	,1),
(	114	,	'BV'	,	21000098	,	7	,	'2022-03-01'	,1),
(	115	,	'BV'	,	21000099	,	7	,	'2022-03-01'	,1),
(	116	,	'BV'	,	21000100	,	7	,	'2022-03-01'	,1),
(	117	,	'BV'	,	21000101	,	7	,	'2022-03-01'	,1),
(	118	,	'FA'	,	21000017	,	8	,	'2022-03-01'	,1),
(	119	,	'FA'	,	21000018	,	8	,	'2022-03-01'	,1),
(	120	,	'FA'	,	21000019	,	8	,	'2022-03-01'	,1),
(	121	,	'FA'	,	21000020	,	8	,	'2022-03-01'	,1),
(	122	,	'FA'	,	21000021	,	8	,	'2022-03-01'	,1),
(	123	,	'FA'	,	21000022	,	8	,	'2022-03-01'	,1),
(	124	,	'FA'	,	21000023	,	8	,	'2022-03-01'	,1),

--##ABRIL##--

(	125	,	'BV'	,	21000102	,	1	,	'2022-04-01'	,2),
(	126	,	'BV'	,	21000103	,	1	,	'2022-04-01'	,2),
(	127	,	'BV'	,	21000104	,	1	,	'2022-04-01'	,2),
(	128	,	'BV'	,	21000105	,	1	,	'2022-04-01'	,2),
(	129	,	'BV'	,	21000106	,	1	,	'2022-04-01'	,2),
(	130	,	'BV'	,	21000107	,	2	,	'2022-04-01'	,2),
(	131	,	'BV'	,	21000108	,	2	,	'2022-04-01'	,2),
(	132	,	'BV'	,	21000109	,	3	,	'2022-04-01'	,2),
(	133	,	'BV'	,	21000110	,	3	,	'2022-04-01'	,2),
(	134	,	'BV'	,	21000111	,	3	,	'2022-04-01'	,2),
(	135	,	'BV'	,	21000112	,	3	,	'2022-04-01'	,2),
(	136	,	'BV'	,	21000113	,	3	,	'2022-04-01'	,2),
(	137	,	'BV'	,	21000114	,	3	,	'2022-04-01'	,2),
(	138	,	'BV'	,	21000115	,	4	,	'2022-04-01'	,2),
(	139	,	'BV'	,	21000116	,	4	,	'2022-04-01'	,2),
(	140	,	'BV'	,	21000117	,	4	,	'2022-04-01'	,2),
(	141	,	'BV'	,	21000118	,	4	,	'2022-04-01'	,2),
(	142	,	'BV'	,	21000119	,	4	,	'2022-04-01'	,2),
(	143	,	'BV'	,	21000120	,	4	,	'2022-04-01'	,2),
(	144	,	'BV'	,	21000121	,	4	,	'2022-04-01'	,2),
(	145	,	'BV'	,	21000122	,	4	,	'2022-04-01'	,2),
(	146	,	'BV'	,	21000123	,	4	,	'2022-04-01'	,2),
(	147	,	'BV'	,	21000124	,	5	,	'2022-04-01'	,2),
(	148	,	'BV'	,	21000125	,	5	,	'2022-04-01'	,2),
(	149	,	'BV'	,	21000126	,	7	,	'2022-04-01'	,2),
(	150	,	'BV'	,	21000127	,	7	,	'2022-04-01'	,2),
(	151	,	'BV'	,	21000128	,	7	,	'2022-04-01'	,2),
(	152	,	'BV'	,	21000129	,	7	,	'2022-04-01'	,2),
(	153	,	'BV'	,	21000130	,	7	,	'2022-04-01'	,2),
(	154	,	'BV'	,	21000131	,	7	,	'2022-04-01'	,2),
(	155	,	'FA'	,	21000024	,	8	,	'2022-04-01'	,2),
(	156	,	'FA'	,	21000025	,	8	,	'2022-04-01'	,2),
(	157	,	'FA'	,	21000026	,	8	,	'2022-04-01'	,2),
(	158	,	'FA'	,	21000027	,	8	,	'2022-04-01'	,2),
(	159	,	'FA'	,	21000028	,	8	,	'2022-04-01'	,2)

INSERT INTO DETVENTA(niddet,nidven,ctpdoc,ndocum,nidser,qservi)		
VALUES

--##ENERO##--

(	1	,   1,	 'BV'	,	21000001	,	1	,	1	),
(	2	,   2,   'BV'	,	21000002	,	1	,	1	),
(	3	,   3,   'BV'	,	21000003	,	1	,	1	),
(	4	,   4,	 'BV'	,	21000004	,	1	,	1	),
(	5	,   5,   'BV'	,	21000005	,	1	,	1	),
(	6	,	6,   'BV'	,	21000006	,	1	,	1	),
(	7	,	7,   'BV'	,	21000007	,	1	,	1	),
(	8	,	8,   'BV'	,	21000008	,	1	,	1	),
(	9	,	9,   'BV' 	,	21000009	,	1	,	1	),
(	10	,	10,  'BV'	,	21000010	,	1	,	1	),
(	11	,	11,  'BV'	,	21000011	,	1	,	1	),
(	12	,	12,  'BV'	,	21000012	,	1	,	1	),
(	13	,	13,  'BV'	,	21000013	,	1	,	1	),
(	14	,	14,  'BV'	,	21000014	,	1	,	1	),
(	15	,	15,  'BV'	,	21000015	,	1	,	1	),
(	16	,	16,  'BV'	,	21000016	,	1	,	1	),
(	17	,	17,  'BV'	,	21000017	,	1	,	1	),
(	18	,	18,  'BV'	,	21000018	,	1	,	1	),
(	19	,	19,  'BV'	,	21000019	,	1	,	1	),
(	20	,	20,  'BV'	,	21000020	,	1	,	1	),
(	21	,	21,  'BV'	,	21000021	,	1	,	1	),
(	22	,	22,  'BV'	,	21000022	,	1	,	1	),
(	23	,	23,  'BV'	,	21000023	,	1	,	1	),
(	24	,	24,  'BV'	,	21000024	,	1	,	1	),
(	25	,	25,  'FA'	,	21000001	,	1	,	1	),
(	26	,	26,  'FA'	,	21000002	,	1	,	1	),
(	27	,	27,  'FA'	,	21000003	,	1	,	1	),
(	28	,	28,  'FA'	,	21000004	,	1	,	1	),
(	29	,	29,  'FA'	,	21000005	,	1	,	1	),

--##FEBRERO##--

(	30	,	30,  'BV'	,	21000025	,	2	,	1	),
(	31	,	31,  'BV'	,	21000026	,	2	,	1	),
(	32	,	32,  'BV'	,	21000027	,	2	,	1	),
(	33	,	33,  'BV'	,	21000028	,	2	,	1	),
(	34	,	34,  'BV'	,	21000029	,	2	,	1	),
(	35	,	35,  'BV'	,	21000030	,	2	,	1	),
(	36	,	36,  'BV'	,	21000031	,	2	,	1	),
(	37	,	37,  'BV'	,	21000032	,	2	,	1	),
(	38	,	38,  'BV'	,	21000033	,	2	,	1	),
(	39	,	39,  'BV'	,	21000034	,	2	,	1	),
(	40	,	40,  'BV'	,	21000035	,	2	,	1	),
(	41	,	41,  'BV'	,	21000036	,	2	,	1	),
(	42	,	42,  'BV'	,	21000037	,	2	,	1	),
(	43	,	43,  'BV'	,	21000038	,	2	,	1	),
(	44	,	44,  'BV'	,	21000039	,	2	,	1	),
(	45	,	45,  'BV'	,	21000040	,	2	,	1	),
(	46	,	46,  'BV'	,	21000041	,	2	,	1	),
(	47	,	47,  'BV'	,	21000042	,	2	,	1	),
(	48	,	48,  'BV' 	,	21000043	,	2	,	1	),
(	49	,	49,  'BV'	,	21000044	,	2	,	1	),
(	50	,	50,  'BV'	,	21000045	,	2	,	1	),
(	51	,	51,  'BV'	,	21000046	,	2	,	1	),
(	52	,	52,  'BV'	,	21000047	,	2	,	1	),
(	53	,	53,  'BV'	,	21000048	,	2	,	1	),
(	54	,	54,  'BV'	,	21000049	,	2	,	1	),
(	55	,	55,  'BV'	,	21000050	,	2	,	1	),
(	56	,	56,  'BV'	,	21000051	,	2	,	1	),
(	57	,	57,  'BV'	,	21000052	,	2	,	1	),
(	58	,	58,  'BV'	,	21000053	,	2	,	1	),
(	59	,	59,  'BV'	,	21000054	,	2	,	1	),
(	60	,	60,  'BV'	,	21000055	,	2	,	1	),
(	61	,	61,  'BV'	,	21000056	,	2	,	1	),
(	62	,	62,  'BV'	,	21000057	,	2	,	1	),
(	63	,	63,  'FA'	,	21000006	,	2	,	1	),
(	64	,	64,  'FA'	,	21000007	,	2	,	1	),
(	65	,	65,  'FA'	,	21000008	,	2	,	1	),
(	66	,	66,  'FA'	,	21000009	,	2	,	1	),
(	67	,	67,  'FA'	,	21000010	,	2	,	1	),
(	68	,	68,  'FA'	,	21000011	,	2	,	1	),
(	69	,	69,  'FA'	,	21000012	,	2	,	1	),
(	70	,	70,  'FA'	,	21000013	,	2	,	1	),
(	71	,	71,  'FA'	,	21000014	,	2	,	1	),
(	72	,	72,  'FA'	,	21000015	,	2	,	1	),
(	73	,	73,  'FA'	,	21000016	,	2	,	1	),

--##MARZO##--

(	74	,	74,  'BV'	,	21000058	,	1	,	1	),
(	75	,	75,  'BV'	,	21000059	,	1	,	1	),
(	76	,	76,  'BV'	,	21000060	,	1	,	1	),
(	77	,	77,  'BV'	,	21000061	,	1	,	1	),
(	78	,	78,  'BV'	,	21000062	,	1	,	1	),
(	79	,	79,  'BV'	,	21000063	,	1	,	1	),
(	80	,	80,  'BV'	,	21000064	,	1	,	1	),
(	81	,	81,  'BV'	,	21000065	,	1	,	1	),
(	82	,	82,  'BV'	,	21000066	,	1	,	1	),
(	83	,	83,  'BV'	,	21000067	,	1	,	1	),
(	84	,	84,  'BV'	,	21000068	,	1	,	1	),
(	85	,	85,  'BV'	,	21000069	,	1	,	1	),
(	86	,	86,  'BV'	,	21000070	,	1	,	1	),
(	87	,	87,  'BV'	,	21000071	,	1	,	1	),
(	88	,	88,  'BV'	,	21000072	,	1	,	1	),
(	89	,	89,  'BV'	,	21000073	,	1	,	1	),
(	90	,	90,  'BV'	,	21000074	,	1	,	1	),
(	91	,	91,  'BV'	,	21000075	,	1	,	1	),
(	92	,	92,  'BV'	,	21000076	,	1	,	1	),
(	93	,	93,  'BV'	,	21000077	,	1	,	1	),
(	94	,	94,  'BV'	,	21000078	,	1	,	1	),
(	95	,	95,  'BV'	,	21000079	,	1	,	1	),
(	96	,	96,  'BV'	,	21000080	,	1	,	1	),
(	97	,	97,  'BV'	,	21000081	,	1	,	1	),
(	98	,	98,  'BV'	,	21000082	,	1	,	1	),
(	99	,	99,  'BV'	,	21000083	,	1	,	1	),
(	100	,	100, 'BV'	,	21000084	,	1	,	1	),
(	101	,	101, 'BV'	,	21000085	,	1	,	1	),
(	102	,	102, 'BV'	,	21000086	,	1	,	1	),
(	103	,	103, 'BV'	,	21000087	,	1	,	1	),
(	104	,	104, 'BV'	,	21000088	,	1	,	1	),
(	105	,	105, 'BV'	,	21000089	,	1	,	1	),
(	106	,	106, 'BV'	,	21000090	,	1	,	1	),
(	107	,	107, 'BV'	,	21000091	,	1	,	1	),
(	108	,	108, 'BV'	,	21000092	,	1	,	1	),
(	109	,	109, 'BV'	,	21000093	,	1	,	1	),
(	110	,	110, 'BV'	,	21000094	,	1	,	1	),
(	111	,	111, 'BV'	,	21000095	,	1	,	1	),
(	112	,	112, 'BV'	,	21000096	,	1	,	1	),
(	113	,	113, 'BV'	,	21000097	,	1	,	1	),
(	114	,	114, 'BV'	,	21000098	,	1	,	1	),
(	115	,	115, 'BV'	,	21000099	,	1	,	1	),
(	116	,	116, 'BV'	,	21000100	,	1	,	1	),
(	117	,	117, 'BV'	,	21000101	,	1	,	1	),
(	118	,	118, 'FA'	,	21000017	,	1	,	1	),
(	119	,	119, 'FA'	,	21000018	,	1	,	1	),
(	120	,	120, 'FA'	,	21000019	,	1	,	1	),
(	121	,	121, 'FA'	,	21000020	,	1	,	1	),
(	122	,	122, 'FA'	,	21000021	,	1	,	1	),
(	123	,	123, 'FA'	,	21000022	,	1	,	1	),
(	124	,	124, 'FA'	,	21000023	,	1	,	1	),

--##ABRIL##--

(	125	,	125, 'BV'	,	21000102	,	2	,	1	),
(	126	,	126, 'BV'	,	21000103	,	2	,	1	),
(	127	,	127, 'BV'	,	21000104	,	2	,	1	),
(	128	,	128, 'BV'	,	21000105	,	2	,	1	),
(	129	,	129, 'BV'	,	21000106	,	2	,	1	),
(	130	,	130, 'BV'	,	21000107	,	2	,	1	),
(	131	,	131, 'BV'	,	21000108	,	2	,	1	),
(	132	,	132, 'BV'	,	21000109	,	2	,	1	),
(	133	,	133, 'BV'	,	21000110	,	2	,	1	),
(	134	,	134, 'BV'	,	21000111	,	2	,	1	),
(	135	,	135, 'BV'	,	21000112	,	2	,	1	),
(	136	,	136, 'BV'	,	21000113	,	2	,	1	),
(	137	,	137, 'BV'	,	21000114    ,	2	,	1	),
(	138	,	138, 'BV'	,	21000115	,	2	,	1	),
(	139	,	139, 'BV'	,	21000116	,	2	,	1	),
(	140	,	140, 'BV'	,	21000117	,	2	,	1	),
(	141	,	141, 'BV'	,	21000118	,	2	,	1	),
(	142	,	142, 'BV'	,	21000119	,	2	,	1	),
(	143	,	143, 'BV'	,	21000120	,	2	,	1	),
(	144	,	144, 'BV'	,	21000121	,	2	,	1	),
(	145	,	145, 'BV'	,	21000122	,	2	,	1	),
(	146	,	146, 'BV'	,	21000123	,	2	,	1	),
(	147	,	147, 'BV'	,	21000124	,	2	,	1	),
(	148	,	148, 'BV'	,	21000125	,	2	,	1	),
(	149	,	149, 'BV'	,	21000126	,	2	,	1	),
(	150	,	150, 'BV'	,	21000127	,	2	,	1	),
(	151	,	151, 'BV'	,	21000128	,	2	,	1	),
(	152	,	152, 'BV'	,	21000129	,	2	,	1	),
(	153	,	153, 'BV'	,	21000130	,	2	,	1	),
(	154	,	154, 'BV'	,	21000131	,	2	,	1	),
(	155	,	155, 'FA'	,	21000024	,	2	,	1	),
(	156	,	156, 'FA'	,	21000025	,	2	,	1	),
(	157	,	157, 'FA'	,	21000026	,	2	,	1	),
(	158	,	158, 'FA'	,	21000027	,	2	,	1	),
(	159	,	159, 'FA'	,	21000028	,	2	,	1	)

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
						(select pg.idscto 
						    from Pago pg
							inner join CLIENTE c on c.nidpag=pg.nidpag
							inner join VENTA v on v.nidclien=c.nidclien
							where v.nidven=DETVENTA.nidven),0),
						 
	   itneto=qservi*(select ipreci  
                        from PRECIO
						where PRECIO.nidser=DETVENTA.nidser)*1.18-ISNULL(qservi*(select ipreci  
                        from PRECIO
						where PRECIO.nidser=DETVENTA.nidser)*
						(select pg.idscto 
						    from PAGO pg
							inner join CLIENTE c on c.nidpag=pg.nidpag
							inner join VENTA v on v.nidclien=c.nidclien
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

--##QRY 1 VENTAS x DOCUMENTO
select ISNULL(v.ctpdoc,'TOTAL') DOCUMENTO, sum(v.ibruto) bruto,sum(v.iimpue) impuesto,sum(v.idscto) descuento,sum(v.itneto) Neto
	from VENTA v
	inner join DETVENTA d 
		on d.nidven=v.nidven
	inner join COSTO c 
		on c.nidser=d.nidser
	group by v.ctpdoc with rollup

--##QRY 2 VENTA x MES
select ISNULL(format(femisi,'yyyy-MM'),'TOTAL') Año_mes,sum(ibruto) Bruto,sum(iimpue) impuesto,sum(idscto) descuento,sum(itneto) Neto
   from VENTA
   group by  format(femisi,'yyyy-MM') with rollup

--##QRY 3 UTILIDAD x CHEF x MES
select *
	from(
		select dchef as CHEF, ISNULL(format(femisi,'yyyy-MM'),'TOTAL') Año_mes, sum(d.ibruto-qservi*icosto) as UTILIDADES
	   from VENTA v
	   inner join DETVENTA d 
			on d.nidven=v.nidven
	   inner join CHEF ch 
			on ch.nidchef=v.nidchef
	   inner join SERVICIO s 
			on s.nidser=d.nidser
	   inner join COSTO c 
			on c.nidser=s.nidser
	   group by dchef,format(femisi,'yyyy-MM')
union
		select 'TOTAL', ISNULL(format(femisi,'yyyy-MM'),'TOTAL') Año_mes, sum(d.ibruto-qservi*icosto) as UTILIDADES
	   from VENTA v
	   inner join DETVENTA d 
			on d.nidven=v.nidven
	   inner join CHEF ch 
			on ch.nidchef=v.nidchef
	   inner join SERVICIO s 
			on s.nidser=d.nidser
	   inner join COSTO c 
			on c.nidser=s.nidser
	   group by format(femisi,'yyyy-MM')
union
		select dchef as CHEF, 'TOTAL', sum(d.ibruto-qservi*icosto) as UTILIDADES
	   from VENTA v
	   inner join DETVENTA d 
			on d.nidven=v.nidven
	   inner join CHEF ch 
			on ch.nidchef=v.nidchef
	   inner join SERVICIO s 
			on s.nidser=d.nidser
	   inner join COSTO c 
			on c.nidser=s.nidser
	   group by dchef
union
		select 'TOTAL', 'TOTAL', sum(d.ibruto-qservi*icosto) as UTILIDADES
	   from VENTA v
	   inner join DETVENTA d 
			on d.nidven=v.nidven
	   inner join CHEF ch 
			on ch.nidchef=v.nidchef
	   inner join SERVICIO s 
			on s.nidser=d.nidser
	   inner join COSTO c 
			on c.nidser=s.nidser
	   group by dchef,format(femisi,'yyyy-MM')
	) as tabla1
PIVOT(sum(UTILIDADES) for CHEF in ("KAREN GAMBA", "LORENA VILDOSOLA","TOTAL")) as TABLA2

--##QRY 4 UTILIDAD x ESPECIALIDAD
select ISNULL(despec,'TOTAL') ESPECIALIDAD, sum(d.ibruto-qservi*icosto) as UTILIDADES
	from DETVENTA d
	inner join VENTA v 
		on v.nidven=d.nidven
	inner join CHEF ch 
		on ch.nidchef=v.nidchef
	inner join ESPECIALIDAD e 
		on e.nidesp=ch.nidesp
	inner join SERVICIO s 
		on s.nidser=d.nidser
	inner join COSTO c 
		on c.nidser=s.nidser
	group by despec with rollup

--##QRY 5 UTILIDAD x CLIENTE
select *
	from(
		select ISNULL(dclien,'TOTAL') CLIENTE, despec as ESPECIALIDAD ,sum(d.ibruto-qservi*icosto) as UTILIDADES
			from DETVENTA d
			inner join VENTA v 
				on v.nidven=d.nidven
			inner join CLIENTE cl 
				on cl.nidclien=v.nidclien
			inner join CHEF ch 
				on ch.nidchef=v.nidchef
			inner join SERVICIO s 
				on s.nidser=d.nidser
			inner join COSTO c 
				on c.nidser=s.nidser
			left outer join ESPECIALIDAD e 
				on e.nidesp=ch.nidesp
			group by dclien, despec
union
		select 'TOTAL', despec as ESPECIALIDAD ,sum(d.ibruto-qservi*icosto) as UTILIDADES
			from DETVENTA d
			inner join VENTA v 
				on v.nidven=d.nidven
			inner join CLIENTE cl 
				on cl.nidclien=v.nidclien
			inner join CHEF ch 
				on ch.nidchef=v.nidchef
			inner join SERVICIO s 
				on s.nidser=d.nidser
			inner join COSTO c 
				on c.nidser=s.nidser
			left outer join ESPECIALIDAD e 
				on e.nidesp=ch.nidesp
			group by despec
union
		select ISNULL(dclien,'TOTAL') CLIENTE,'TOTAL',sum(d.ibruto-qservi*icosto) as UTILIDADES
			from DETVENTA d
			inner join VENTA v 
				on v.nidven=d.nidven
			inner join CLIENTE cl 
				on cl.nidclien=v.nidclien
			inner join CHEF ch 
				on ch.nidchef=v.nidchef
			inner join SERVICIO s 
				on s.nidser=d.nidser
			inner join COSTO c 
				on c.nidser=s.nidser
			left outer join ESPECIALIDAD e 
				on e.nidesp=ch.nidesp
			group by dclien
union
		select 'TOTAL','TOTAL',sum(d.ibruto-qservi*icosto) as UTILIDADES
			from DETVENTA d
			inner join VENTA v 
				on v.nidven=d.nidven
			inner join CLIENTE cl 
				on cl.nidclien=v.nidclien
			inner join CHEF ch 
				on ch.nidchef=v.nidchef
			inner join SERVICIO s 
				on s.nidser=d.nidser
			inner join COSTO c 
				on c.nidser=s.nidser
			left outer join ESPECIALIDAD e 
				on e.nidesp=ch.nidesp
			group by dclien
	) as tabla1
PIVOT(sum(UTILIDADES) for ESPECIALIDAD in ("CARNES Y PARRILLAS", "PASTAS Y PIZZAS","TOTAL")) as TABLA2

