--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-07-24 23:12:22

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 237 (class 1255 OID 17992)
-- Name: actualizar_estado_recordatorio(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actualizar_estado_recordatorio() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW."fechaLimite" < CURRENT_DATE AND NEW.estado = 'Activo' THEN
    NEW.estado := 'Vencido';
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.actualizar_estado_recordatorio() OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 17994)
-- Name: set_estado_activo(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_estado_activo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.estado IS NULL THEN
    NEW.estado := 'Activo';
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_estado_activo() OWNER TO postgres;

--
-- TOC entry 236 (class 1255 OID 17985)
-- Name: set_fecha_registro(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_fecha_registro() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW."fechaRegistro" IS NULL THEN
    NEW."fechaRegistro" := CURRENT_DATE;
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_fecha_registro() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 17597)
-- Name: Apunte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Apunte" (
    "idApunte" integer NOT NULL,
    "idUsuMat" bigint NOT NULL,
    fecha date NOT NULL,
    titulo text NOT NULL,
    resumen text
);


ALTER TABLE public."Apunte" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17602)
-- Name: Apunte_idApunte_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Apunte_idApunte_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Apunte_idApunte_seq" OWNER TO postgres;

--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 218
-- Name: Apunte_idApunte_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Apunte_idApunte_seq" OWNED BY public."Apunte"."idApunte";


--
-- TOC entry 219 (class 1259 OID 17603)
-- Name: Contenido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Contenido" (
    "idContenido" integer NOT NULL,
    "idTema" bigint NOT NULL,
    texto text NOT NULL
);


ALTER TABLE public."Contenido" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17608)
-- Name: Contenido_idContenido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Contenido_idContenido_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Contenido_idContenido_seq" OWNER TO postgres;

--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 220
-- Name: Contenido_idContenido_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Contenido_idContenido_seq" OWNED BY public."Contenido"."idContenido";


--
-- TOC entry 221 (class 1259 OID 17609)
-- Name: Materia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Materia" (
    "idMateria" integer NOT NULL,
    "nombreMateria" text NOT NULL,
    "cursoParalelo" text NOT NULL,
    "nombreDocente" text NOT NULL,
    horario text NOT NULL,
    estado text NOT NULL,
    "fechaRegistro" date NOT NULL,
    clave text,
    "imagenUrl" text
);


ALTER TABLE public."Materia" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17614)
-- Name: Materia_idMateria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Materia_idMateria_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Materia_idMateria_seq" OWNER TO postgres;

--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 222
-- Name: Materia_idMateria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Materia_idMateria_seq" OWNED BY public."Materia"."idMateria";


--
-- TOC entry 223 (class 1259 OID 17615)
-- Name: Recordatorio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Recordatorio" (
    "idRecordatorio" integer NOT NULL,
    "idUsuario" bigint NOT NULL,
    "fechaLimite" date NOT NULL,
    titulo text NOT NULL,
    descripcion text,
    estado text NOT NULL,
    "fechaRegistro" date NOT NULL,
    hora text NOT NULL
);


ALTER TABLE public."Recordatorio" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17620)
-- Name: Recordatorio_idRecordatorio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Recordatorio_idRecordatorio_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Recordatorio_idRecordatorio_seq" OWNER TO postgres;

--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 224
-- Name: Recordatorio_idRecordatorio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Recordatorio_idRecordatorio_seq" OWNED BY public."Recordatorio"."idRecordatorio";


--
-- TOC entry 225 (class 1259 OID 17621)
-- Name: Tema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tema" (
    "idTema" integer NOT NULL,
    "idApunte" bigint NOT NULL,
    "idTemaPadre" bigint,
    nombre text NOT NULL
);


ALTER TABLE public."Tema" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17626)
-- Name: Tema_idTema_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Tema_idTema_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Tema_idTema_seq" OWNER TO postgres;

--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 226
-- Name: Tema_idTema_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Tema_idTema_seq" OWNED BY public."Tema"."idTema";


--
-- TOC entry 227 (class 1259 OID 17633)
-- Name: Usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Usuario" (
    "idUsuario" integer NOT NULL,
    nombre text NOT NULL,
    apellido text NOT NULL,
    correo text NOT NULL,
    contrasena text NOT NULL,
    estado text NOT NULL,
    "fechaRegistro" date NOT NULL
);


ALTER TABLE public."Usuario" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17638)
-- Name: UsuarioMateria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UsuarioMateria" (
    "idUsuMat" integer NOT NULL,
    "idUsuario" bigint NOT NULL,
    "idMateria" bigint NOT NULL,
    estado text NOT NULL,
    "fechaRegistro" date NOT NULL
);


ALTER TABLE public."UsuarioMateria" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17643)
-- Name: UsuarioMateria_idUsuMat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UsuarioMateria_idUsuMat_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UsuarioMateria_idUsuMat_seq" OWNER TO postgres;

--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 229
-- Name: UsuarioMateria_idUsuMat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UsuarioMateria_idUsuMat_seq" OWNED BY public."UsuarioMateria"."idUsuMat";


--
-- TOC entry 230 (class 1259 OID 17644)
-- Name: Usuario_idUsuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Usuario_idUsuario_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Usuario_idUsuario_seq" OWNER TO postgres;

--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 230
-- Name: Usuario_idUsuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Usuario_idUsuario_seq" OWNED BY public."Usuario"."idUsuario";


--
-- TOC entry 233 (class 1259 OID 17967)
-- Name: apuntes_por_materia; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.apuntes_por_materia AS
 SELECT a."idApunte",
    a."idUsuMat",
    u.nombre AS nombre_usuario,
    u.apellido AS apellido_usuario,
    m."nombreMateria",
    m."cursoParalelo",
    a.fecha,
    a.titulo,
    a.resumen
   FROM (((public."Apunte" a
     JOIN public."UsuarioMateria" um ON ((a."idUsuMat" = um."idUsuMat")))
     JOIN public."Usuario" u ON ((um."idUsuario" = u."idUsuario")))
     JOIN public."Materia" m ON ((um."idMateria" = m."idMateria")))
  ORDER BY u.nombre, u.apellido;


ALTER VIEW public.apuntes_por_materia OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17981)
-- Name: contenidos_por_tema; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.contenidos_por_tema AS
 SELECT c."idContenido",
    c."idTema",
    t.nombre AS nombre_tema,
    t."idTemaPadre",
    c.texto
   FROM (public."Contenido" c
     JOIN public."Tema" t ON ((c."idTema" = t."idTema")))
  ORDER BY t."idTemaPadre" NULLS FIRST, t."idTema", c."idContenido";


ALTER VIEW public.contenidos_por_tema OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17962)
-- Name: materias_inscritas_por_usuario; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.materias_inscritas_por_usuario AS
 SELECT um."idUsuMat",
    um."idUsuario",
    u.nombre AS nombre_usuario,
    u.apellido AS apellido_usuario,
    um."idMateria",
    m."nombreMateria",
    m."cursoParalelo",
    um.estado,
    um."fechaRegistro"
   FROM ((public."UsuarioMateria" um
     JOIN public."Usuario" u ON ((um."idUsuario" = u."idUsuario")))
     JOIN public."Materia" m ON ((um."idMateria" = m."idMateria")))
  ORDER BY u.nombre, u.apellido;


ALTER VIEW public.materias_inscritas_por_usuario OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17958)
-- Name: recordatorios_por_usuario; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.recordatorios_por_usuario AS
 SELECT r."idRecordatorio",
    r."idUsuario",
    u.nombre,
    u.apellido,
    r."fechaLimite",
    r.titulo,
    r.descripcion,
    r.estado,
    r."fechaRegistro",
    r.hora
   FROM (public."Recordatorio" r
     JOIN public."Usuario" u ON ((r."idUsuario" = u."idUsuario")));


ALTER VIEW public.recordatorios_por_usuario OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17972)
-- Name: temas_por_apunte; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.temas_por_apunte AS
 SELECT t."idTema",
    t."idApunte",
    a.titulo AS titulo_apunte,
    t."idTemaPadre",
    t.nombre
   FROM (public."Tema" t
     JOIN public."Apunte" a ON ((t."idApunte" = a."idApunte")))
  ORDER BY a.titulo, t."idTemaPadre" NULLS FIRST, t."idTema";


ALTER VIEW public.temas_por_apunte OWNER TO postgres;

--
-- TOC entry 4795 (class 2604 OID 17658)
-- Name: Apunte idApunte; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Apunte" ALTER COLUMN "idApunte" SET DEFAULT nextval('public."Apunte_idApunte_seq"'::regclass);


--
-- TOC entry 4796 (class 2604 OID 17659)
-- Name: Contenido idContenido; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contenido" ALTER COLUMN "idContenido" SET DEFAULT nextval('public."Contenido_idContenido_seq"'::regclass);


--
-- TOC entry 4797 (class 2604 OID 17660)
-- Name: Materia idMateria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Materia" ALTER COLUMN "idMateria" SET DEFAULT nextval('public."Materia_idMateria_seq"'::regclass);


--
-- TOC entry 4798 (class 2604 OID 17661)
-- Name: Recordatorio idRecordatorio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Recordatorio" ALTER COLUMN "idRecordatorio" SET DEFAULT nextval('public."Recordatorio_idRecordatorio_seq"'::regclass);


--
-- TOC entry 4799 (class 2604 OID 17662)
-- Name: Tema idTema; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tema" ALTER COLUMN "idTema" SET DEFAULT nextval('public."Tema_idTema_seq"'::regclass);


--
-- TOC entry 4800 (class 2604 OID 17664)
-- Name: Usuario idUsuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario" ALTER COLUMN "idUsuario" SET DEFAULT nextval('public."Usuario_idUsuario_seq"'::regclass);


--
-- TOC entry 4801 (class 2604 OID 17665)
-- Name: UsuarioMateria idUsuMat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UsuarioMateria" ALTER COLUMN "idUsuMat" SET DEFAULT nextval('public."UsuarioMateria_idUsuMat_seq"'::regclass);


--
-- TOC entry 4982 (class 0 OID 17597)
-- Dependencies: 217
-- Data for Name: Apunte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Apunte" ("idApunte", "idUsuMat", fecha, titulo, resumen) FROM stdin;
1	1	2025-07-22	Fundamento de Base de Datos	
6	1	2025-07-22	Funciones	
7	7	2025-07-22	Apunte de ejemplo	
8	2	2025-07-22	Direcciones IP y Subnetting	
10	9	2025-07-22	Apunte 1	
13	11	2025-07-23	Apunte 1	
12	11	2025-07-23	Apunte 2	Una base de datos es una colección organizada de datos, típicamente almacenada electrónicamente en un sistema informático, que permite un acceso eficiente y seguro a la información. Funciona como un sistema para almacenar, recuperar y manipular datos, utilizando un sistema de gestión de bases de datos (DBMS). Las bases de datos son fundamentales para la gestión de la información en diversas aplicaciones, desde pequeñas empresas hasta grandes organizaciones.
\.


--
-- TOC entry 4984 (class 0 OID 17603)
-- Dependencies: 219
-- Data for Name: Contenido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Contenido" ("idContenido", "idTema", texto) FROM stdin;
8	13	contenido de ejemplo
9	14	contenido 2
10	15	contenido 3
11	18	Dirección de 32 bits (ejemplo: 192.168.0.1)
12	19	Dirección de 128 bits para reemplazar IPv4 (ejemplo: 2001:0db8::1)
13	20	Permite dividir redes grandes en subredes más pequeñas (ejemplo: 255.255.255.0)
14	21	Representación de subredes con barra diagonal (ejemplo: 192.168.1.0/24)
1	6	Una tabla representa una relación.
18	28	Contenido 2
17	28	Contenidoasdasdasdsadad<SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSaaaa\nasdsdasd
19	36	Contenido
2	7	Una fila (tupla) representa un registro.
3	8	Una columna (atributo) representa una propiedad del registro.
4	5	En bases de datos, una clave primaria identifica de forma única cada registro en una tabla, mientras que una clave secundaria es una columna o conjunto de columnas que hacen referencia a la clave primaria de otra tabla
5	9	Identifica de forma única cada fila.
6	10	Establece relaciones entre tablas.
\.


--
-- TOC entry 4986 (class 0 OID 17609)
-- Dependencies: 221
-- Data for Name: Materia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Materia" ("idMateria", "nombreMateria", "cursoParalelo", "nombreDocente", horario, estado, "fechaRegistro", clave, "imagenUrl") FROM stdin;
1	Administración de Bases de Datos	Quinto 'A'	Milton Valarezo	Lunes 07:30 - 09:30 / Jueves 07:30 - 09:30	Activo	2025-06-05	abd123	abd.jpg
2	Ingeniería de Software I	Quinto 'A'	Patricio Orellana	Lunes 09:30 - 11:30 / Jueves 09:30 - 11:30	Activo	2025-06-05	is123	is.jpg
3	Plataformas de Hardware	Quinto 'A'	Johnny Novillo	Lunes 11:30 - 13:30 / Miércoles 09:30 - 11:30	Activo	2025-06-05	ph123	ph.avif
4	Tecnologías Web	Quinto 'A'	Milton Valarezo	Martes 07:30 - 10:30	Activo	2025-06-05	tw123	tw.avif
5	Fundamentos de Redes	Quinto 'A'	Oscar Cardenas	Lunes 11:30 - 13:30 / Miércoles 09:30 - 11:30	Activo	2025-06-05	fr123	fr.jpg
\.


--
-- TOC entry 4988 (class 0 OID 17615)
-- Dependencies: 223
-- Data for Name: Recordatorio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Recordatorio" ("idRecordatorio", "idUsuario", "fechaLimite", titulo, descripcion, estado, "fechaRegistro", hora) FROM stdin;
1	1	2025-07-22	Proyecto BD	Presentar proyecto de BD\n	Activo	2025-07-22	07:30
2	1	2025-07-22	Proyecto TW		Activo	2025-07-22	07:30
3	1	2025-07-16	Prueba  BD		Vencido	2025-07-22	09:30
4	1	2025-07-10	Prueba TW		Vencido	2025-07-22	08:40
5	3	2025-07-24	Recordatorio de ejemplo	Descripción de ejemplo	Activo	2025-07-22	12:40
\.


--
-- TOC entry 4990 (class 0 OID 17621)
-- Dependencies: 225
-- Data for Name: Tema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Tema" ("idTema", "idApunte", "idTemaPadre", nombre) FROM stdin;
2	1	\N	Normalización
3	1	\N	Lenguaje SQL
4	1	1	Tablas, Filas y Columnas
5	1	1	Claves Primarias y Secundarias
6	1	4	Tabla
7	1	4	Fila
8	1	4	Columna
9	1	5	Primarias
10	1	5	Secundarias
13	7	\N	Tema padre de ejemplo
14	7	13	subtema de ejemplo
15	7	14	subtema 2 de ejemplo
16	8	\N	Direcciones IP
17	8	\N	Subnetting
18	8	16	IPv4
19	8	16	IPv6
20	8	17	Máscara de subred
21	8	17	CIDR
23	10	\N	Tema 2
24	10	\N	Tema 3
28	12	\N	Tema 1
29	12	\N	Tema 2
30	12	\N	Tema 3
31	12	28	Subtema 1
32	12	28	Subtema 2
33	12	28	Subtema 3
34	12	31	Sub-Subtema 1
35	12	31	Sub-Subtema 2
1	1	\N	Modelo Relacional
36	1	1	Subtitulo 1
\.


--
-- TOC entry 4992 (class 0 OID 17633)
-- Dependencies: 227
-- Data for Name: Usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Usuario" ("idUsuario", nombre, apellido, correo, contrasena, estado, "fechaRegistro") FROM stdin;
1	Alex Ariel	Niola Toro	niolatoro@hotmail.com	Ados123@	Activo	2025-07-22
2	Jimmy Fernando	Carchipulla Camacho	jimmycarchipulla4523@gmail.com	Jimmy123@	Activo	2025-07-22
3	Anthony	Murillo	murillo@hotmail.com	Murillo123@	Activo	2025-07-22
7	Mauricio	Perez	mauricio@hotmail.com	Mauricio123@	Activo	2025-07-22
8	Andy	Aguirre	andyaguirre12@gmail.com	Andyaguirre1.	Activo	2025-07-23
9	Juan	Perez	juan@hotmail.com	Juan123@	Activo	2025-07-25
\.


--
-- TOC entry 4993 (class 0 OID 17638)
-- Dependencies: 228
-- Data for Name: UsuarioMateria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UsuarioMateria" ("idUsuMat", "idUsuario", "idMateria", estado, "fechaRegistro") FROM stdin;
1	1	1	Activo	2025-07-22
2	1	5	Activo	2025-07-22
3	1	2	Activo	2025-07-22
4	1	3	Activo	2025-07-22
7	3	1	Activo	2025-07-22
8	1	4	Activo	2025-07-22
9	7	1	Activo	2025-07-22
11	8	1	Activo	2025-07-23
\.


--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 218
-- Name: Apunte_idApunte_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Apunte_idApunte_seq"', 13, true);


--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 220
-- Name: Contenido_idContenido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Contenido_idContenido_seq"', 19, true);


--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 222
-- Name: Materia_idMateria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Materia_idMateria_seq"', 5, true);


--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 224
-- Name: Recordatorio_idRecordatorio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Recordatorio_idRecordatorio_seq"', 8, true);


--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 226
-- Name: Tema_idTema_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Tema_idTema_seq"', 36, true);


--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 229
-- Name: UsuarioMateria_idUsuMat_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UsuarioMateria_idUsuMat_seq"', 11, true);


--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 230
-- Name: Usuario_idUsuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Usuario_idUsuario_seq"', 9, true);


--
-- TOC entry 4803 (class 2606 OID 17667)
-- Name: Apunte Apunte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Apunte"
    ADD CONSTRAINT "Apunte_pkey" PRIMARY KEY ("idApunte");


--
-- TOC entry 4805 (class 2606 OID 17669)
-- Name: Contenido Contenido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contenido"
    ADD CONSTRAINT "Contenido_pkey" PRIMARY KEY ("idContenido");


--
-- TOC entry 4807 (class 2606 OID 17671)
-- Name: Materia Materia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Materia"
    ADD CONSTRAINT "Materia_pkey" PRIMARY KEY ("idMateria");


--
-- TOC entry 4809 (class 2606 OID 17673)
-- Name: Recordatorio Recordatorio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Recordatorio"
    ADD CONSTRAINT "Recordatorio_pkey" PRIMARY KEY ("idRecordatorio");


--
-- TOC entry 4811 (class 2606 OID 17675)
-- Name: Tema Tema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tema"
    ADD CONSTRAINT "Tema_pkey" PRIMARY KEY ("idTema");


--
-- TOC entry 4817 (class 2606 OID 17679)
-- Name: UsuarioMateria UsuarioMateria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UsuarioMateria"
    ADD CONSTRAINT "UsuarioMateria_pkey" PRIMARY KEY ("idUsuMat");


--
-- TOC entry 4813 (class 2606 OID 17681)
-- Name: Usuario Usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_pkey" PRIMARY KEY ("idUsuario");


--
-- TOC entry 4815 (class 2606 OID 17723)
-- Name: Usuario correo_unico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT correo_unico UNIQUE (correo);


--
-- TOC entry 4825 (class 2620 OID 17993)
-- Name: Recordatorio trg_actualizar_estado_recordatorio; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_actualizar_estado_recordatorio BEFORE INSERT OR UPDATE ON public."Recordatorio" FOR EACH ROW EXECUTE FUNCTION public.actualizar_estado_recordatorio();


--
-- TOC entry 4826 (class 2620 OID 17997)
-- Name: Recordatorio trg_estado_recordatorio; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_estado_recordatorio BEFORE INSERT ON public."Recordatorio" FOR EACH ROW EXECUTE FUNCTION public.set_estado_activo();


--
-- TOC entry 4828 (class 2620 OID 17995)
-- Name: Usuario trg_estado_usuario; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_estado_usuario BEFORE INSERT ON public."Usuario" FOR EACH ROW EXECUTE FUNCTION public.set_estado_activo();


--
-- TOC entry 4830 (class 2620 OID 17996)
-- Name: UsuarioMateria trg_estado_usuariomateria; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_estado_usuariomateria BEFORE INSERT ON public."UsuarioMateria" FOR EACH ROW EXECUTE FUNCTION public.set_estado_activo();


--
-- TOC entry 4827 (class 2620 OID 17989)
-- Name: Recordatorio trg_set_fecha_registro_recordatorio; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_set_fecha_registro_recordatorio BEFORE INSERT ON public."Recordatorio" FOR EACH ROW EXECUTE FUNCTION public.set_fecha_registro();


--
-- TOC entry 4829 (class 2620 OID 17986)
-- Name: Usuario trg_set_fecha_registro_usuario; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_set_fecha_registro_usuario BEFORE INSERT ON public."Usuario" FOR EACH ROW EXECUTE FUNCTION public.set_fecha_registro();


--
-- TOC entry 4831 (class 2620 OID 17987)
-- Name: UsuarioMateria trg_set_fecha_registro_usuariomateria; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_set_fecha_registro_usuariomateria BEFORE INSERT ON public."UsuarioMateria" FOR EACH ROW EXECUTE FUNCTION public.set_fecha_registro();


--
-- TOC entry 4821 (class 2606 OID 17933)
-- Name: Tema Apunte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tema"
    ADD CONSTRAINT "Apunte_fkey" FOREIGN KEY ("idApunte") REFERENCES public."Apunte"("idApunte") ON DELETE CASCADE;


--
-- TOC entry 4822 (class 2606 OID 17953)
-- Name: Tema TemaPadre_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tema"
    ADD CONSTRAINT "TemaPadre_fkey" FOREIGN KEY ("idTemaPadre") REFERENCES public."Tema"("idTema") ON DELETE CASCADE;


--
-- TOC entry 4819 (class 2606 OID 17928)
-- Name: Contenido Tema_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contenido"
    ADD CONSTRAINT "Tema_fkey" FOREIGN KEY ("idTema") REFERENCES public."Tema"("idTema") ON DELETE CASCADE;


--
-- TOC entry 4820 (class 2606 OID 17948)
-- Name: Recordatorio Usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Recordatorio"
    ADD CONSTRAINT "Usuario_fkey" FOREIGN KEY ("idUsuario") REFERENCES public."Usuario"("idUsuario") ON DELETE CASCADE;


--
-- TOC entry 4823 (class 2606 OID 17707)
-- Name: UsuarioMateria idMateria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UsuarioMateria"
    ADD CONSTRAINT "idMateria" FOREIGN KEY ("idMateria") REFERENCES public."Materia"("idMateria") NOT VALID;


--
-- TOC entry 4818 (class 2606 OID 17938)
-- Name: Apunte idUsuMat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Apunte"
    ADD CONSTRAINT "idUsuMat" FOREIGN KEY ("idUsuMat") REFERENCES public."UsuarioMateria"("idUsuMat") ON DELETE CASCADE;


--
-- TOC entry 4824 (class 2606 OID 17943)
-- Name: UsuarioMateria idUsuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UsuarioMateria"
    ADD CONSTRAINT "idUsuario" FOREIGN KEY ("idUsuario") REFERENCES public."Usuario"("idUsuario") ON DELETE CASCADE;


-- Completed on 2025-07-24 23:12:22

--
-- PostgreSQL database dump complete
--

