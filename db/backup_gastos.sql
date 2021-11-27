--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 14.0

-- Started on 2021-10-31 17:06:24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE gastos;
--
-- TOC entry 3038 (class 1262 OID 16822)
-- Name: gastos; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE gastos WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Spain.1252';


ALTER DATABASE gastos OWNER TO postgres;

\connect gastos

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16874)
-- Name: staging; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA staging;


ALTER SCHEMA staging OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 201 (class 1259 OID 16868)
-- Name: dia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dia (
    dia integer NOT NULL,
    mes integer NOT NULL,
    anio integer NOT NULL,
    fecha date NOT NULL,
    dia_key integer NOT NULL
);


ALTER TABLE public.dia OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16900)
-- Name: dia_dia_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dia_dia_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dia_dia_key_seq OWNER TO postgres;

--
-- TOC entry 3039 (class 0 OID 0)
-- Dependencies: 204
-- Name: dia_dia_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dia_dia_key_seq OWNED BY public.dia.dia_key;


--
-- TOC entry 210 (class 1259 OID 17192)
-- Name: gastos_fact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gastos_fact (
    gastos_fact_key integer NOT NULL,
    importe numeric NOT NULL,
    dia_key integer NOT NULL,
    subcategoria_key integer NOT NULL,
    saldo numeric NOT NULL
);


ALTER TABLE public.gastos_fact OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 17190)
-- Name: gastos_fact_gastos_fact_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gastos_fact_gastos_fact_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gastos_fact_gastos_fact_key_seq OWNER TO postgres;

--
-- TOC entry 3040 (class 0 OID 0)
-- Dependencies: 209
-- Name: gastos_fact_gastos_fact_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gastos_fact_gastos_fact_key_seq OWNED BY public.gastos_fact.gastos_fact_key;


--
-- TOC entry 207 (class 1259 OID 16923)
-- Name: subcategoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subcategoria (
    subcategoria_key integer NOT NULL,
    subcategoria character(200) NOT NULL,
    categoria character(200) NOT NULL
);


ALTER TABLE public.subcategoria OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16921)
-- Name: subcategoria_subcategoria_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subcategoria_subcategoria_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subcategoria_subcategoria_key_seq OWNER TO postgres;

--
-- TOC entry 3041 (class 0 OID 0)
-- Dependencies: 206
-- Name: subcategoria_subcategoria_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subcategoria_subcategoria_key_seq OWNED BY public.subcategoria.subcategoria_key;


--
-- TOC entry 203 (class 1259 OID 16881)
-- Name: dia; Type: TABLE; Schema: staging; Owner: postgres
--

CREATE TABLE staging.dia (
    dia integer NOT NULL,
    mes integer NOT NULL,
    anio integer NOT NULL,
    fecha date NOT NULL
);


ALTER TABLE staging.dia OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 17022)
-- Name: gastos_fact; Type: TABLE; Schema: staging; Owner: postgres
--

CREATE TABLE staging.gastos_fact (
    importe numeric NOT NULL,
    dia_key integer NOT NULL,
    subcategoria_key integer NOT NULL,
    saldo numeric NOT NULL
);


ALTER TABLE staging.gastos_fact OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16875)
-- Name: movimientos; Type: TABLE; Schema: staging; Owner: postgres
--

CREATE TABLE staging.movimientos (
    fvalor date,
    categoria character(100),
    subcategoria character(100),
    descripcion character(2000),
    comentario character(2000),
    imagen character(100),
    importe numeric,
    saldo numeric
);


ALTER TABLE staging.movimientos OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16910)
-- Name: subcategoria; Type: TABLE; Schema: staging; Owner: postgres
--

CREATE TABLE staging.subcategoria (
    subcategoria character(200) NOT NULL,
    categoria character(200) NOT NULL
);


ALTER TABLE staging.subcategoria OWNER TO postgres;

--
-- TOC entry 2882 (class 2604 OID 16902)
-- Name: dia dia_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dia ALTER COLUMN dia_key SET DEFAULT nextval('public.dia_dia_key_seq'::regclass);


--
-- TOC entry 2884 (class 2604 OID 17195)
-- Name: gastos_fact gastos_fact_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gastos_fact ALTER COLUMN gastos_fact_key SET DEFAULT nextval('public.gastos_fact_gastos_fact_key_seq'::regclass);


--
-- TOC entry 2883 (class 2604 OID 16926)
-- Name: subcategoria subcategoria_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategoria ALTER COLUMN subcategoria_key SET DEFAULT nextval('public.subcategoria_subcategoria_key_seq'::regclass);


--
-- TOC entry 3023 (class 0 OID 16868)
-- Dependencies: 201
-- Data for Name: dia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dia (dia, mes, anio, fecha, dia_key) FROM stdin;
1	7	2021	2021-07-01	1765
0	0	0	1900-01-01	0
-1	-1	-1	1900-01-01	-1
2	1	2021	2021-01-02	1762
3	1	2021	2021-01-03	1763
1	6	2021	2021-06-01	1764
\.


--
-- TOC entry 3032 (class 0 OID 17192)
-- Dependencies: 210
-- Data for Name: gastos_fact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gastos_fact (gastos_fact_key, importe, dia_key, subcategoria_key, saldo) FROM stdin;
4703	-7000	1764	0	-6500
4704	-6000	1764	0	-5500
4705	-4000	0	162	-3500
4706	-3000	1762	160	-2500
4707	-2000	1763	161	-1500
4708	-1000	1762	160	-500
4709	-8000	1765	164	-7500
\.


--
-- TOC entry 3029 (class 0 OID 16923)
-- Dependencies: 207
-- Data for Name: subcategoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subcategoria (subcategoria_key, subcategoria, categoria) FROM stdin;
163	SUBCAT8                                                                                                                                                                                                 	CAT8                                                                                                                                                                                                    
0	UNKNOWN                                                                                                                                                                                                 	UNKNOWN                                                                                                                                                                                                 
-1	INVALID                                                                                                                                                                                                 	INVALID                                                                                                                                                                                                 
164	SUBCAT8_CAMBIO                                                                                                                                                                                          	CAT8_CAMBIO                                                                                                                                                                                             
160	SUBCAT1                                                                                                                                                                                                 	CAT1                                                                                                                                                                                                    
161	SUBCAT2                                                                                                                                                                                                 	CAT2                                                                                                                                                                                                    
162	SUBCAT4                                                                                                                                                                                                 	CAT4                                                                                                                                                                                                    
\.


--
-- TOC entry 3025 (class 0 OID 16881)
-- Dependencies: 203
-- Data for Name: dia; Type: TABLE DATA; Schema: staging; Owner: postgres
--

COPY staging.dia (dia, mes, anio, fecha) FROM stdin;
1	7	2021	2021-07-01
\.


--
-- TOC entry 3030 (class 0 OID 17022)
-- Dependencies: 208
-- Data for Name: gastos_fact; Type: TABLE DATA; Schema: staging; Owner: postgres
--

COPY staging.gastos_fact (importe, dia_key, subcategoria_key, saldo) FROM stdin;
-8000	1765	164	-7500
\.


--
-- TOC entry 3024 (class 0 OID 16875)
-- Dependencies: 202
-- Data for Name: movimientos; Type: TABLE DATA; Schema: staging; Owner: postgres
--

COPY staging.movimientos (fvalor, categoria, subcategoria, descripcion, comentario, imagen, importe, saldo) FROM stdin;
2021-07-01	CAT8_CAMBIO                                                                                         	SUBCAT8_CAMBIO                                                                                      	\N	\N	\N	-8000	-7500
\.


--
-- TOC entry 3027 (class 0 OID 16910)
-- Dependencies: 205
-- Data for Name: subcategoria; Type: TABLE DATA; Schema: staging; Owner: postgres
--

COPY staging.subcategoria (subcategoria, categoria) FROM stdin;
SUBCAT8_CAMBIO                                                                                                                                                                                          	CAT8_CAMBIO                                                                                                                                                                                             
\.


--
-- TOC entry 3042 (class 0 OID 0)
-- Dependencies: 204
-- Name: dia_dia_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dia_dia_key_seq', 1765, true);


--
-- TOC entry 3043 (class 0 OID 0)
-- Dependencies: 209
-- Name: gastos_fact_gastos_fact_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gastos_fact_gastos_fact_key_seq', 4710, true);


--
-- TOC entry 3044 (class 0 OID 0)
-- Dependencies: 206
-- Name: subcategoria_subcategoria_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subcategoria_subcategoria_key_seq', 164, true);


--
-- TOC entry 2886 (class 2606 OID 16907)
-- Name: dia dia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dia
    ADD CONSTRAINT dia_pkey PRIMARY KEY (dia_key);


--
-- TOC entry 2890 (class 2606 OID 17197)
-- Name: gastos_fact gastos_fact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gastos_fact
    ADD CONSTRAINT gastos_fact_pkey PRIMARY KEY (gastos_fact_key);


--
-- TOC entry 2888 (class 2606 OID 16928)
-- Name: subcategoria subcategoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategoria
    ADD CONSTRAINT subcategoria_pkey PRIMARY KEY (subcategoria_key);


--
-- TOC entry 2891 (class 2606 OID 17198)
-- Name: gastos_fact fk_dia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gastos_fact
    ADD CONSTRAINT fk_dia FOREIGN KEY (dia_key) REFERENCES public.dia(dia_key) NOT VALID;


--
-- TOC entry 2892 (class 2606 OID 17203)
-- Name: gastos_fact fk_subcategoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gastos_fact
    ADD CONSTRAINT fk_subcategoria FOREIGN KEY (subcategoria_key) REFERENCES public.subcategoria(subcategoria_key) NOT VALID;


-- Completed on 2021-10-31 17:06:25

--
-- PostgreSQL database dump complete
--

