--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 14.0

-- Started on 2021-11-28 21:56:40

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
-- Name: staging; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA staging;


SET default_table_access_method = heap;

--
-- TOC entry 201 (class 1259 OID 16868)
-- Name: dia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dia (
    dia integer NOT NULL,
    mes integer NOT NULL,
    anio integer NOT NULL,
    fecha date NOT NULL,
    dia_key integer NOT NULL
);


--
-- TOC entry 204 (class 1259 OID 16900)
-- Name: dia_dia_key_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dia_dia_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3033 (class 0 OID 0)
-- Dependencies: 204
-- Name: dia_dia_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dia_dia_key_seq OWNED BY public.dia.dia_key;


--
-- TOC entry 210 (class 1259 OID 17192)
-- Name: gastos_fact; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gastos_fact (
    gastos_fact_key integer NOT NULL,
    importe numeric NOT NULL,
    dia_key integer NOT NULL,
    subcategoria_key integer NOT NULL,
    saldo numeric NOT NULL
);


--
-- TOC entry 209 (class 1259 OID 17190)
-- Name: gastos_fact_gastos_fact_key_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gastos_fact_gastos_fact_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3034 (class 0 OID 0)
-- Dependencies: 209
-- Name: gastos_fact_gastos_fact_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gastos_fact_gastos_fact_key_seq OWNED BY public.gastos_fact.gastos_fact_key;


--
-- TOC entry 207 (class 1259 OID 16923)
-- Name: subcategoria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subcategoria (
    subcategoria_key integer NOT NULL,
    subcategoria character(200) NOT NULL,
    categoria character(200) NOT NULL
);


--
-- TOC entry 206 (class 1259 OID 16921)
-- Name: subcategoria_subcategoria_key_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.subcategoria_subcategoria_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3035 (class 0 OID 0)
-- Dependencies: 206
-- Name: subcategoria_subcategoria_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.subcategoria_subcategoria_key_seq OWNED BY public.subcategoria.subcategoria_key;


--
-- TOC entry 203 (class 1259 OID 16881)
-- Name: dia; Type: TABLE; Schema: staging; Owner: -
--

CREATE TABLE staging.dia (
    dia integer NOT NULL,
    mes integer NOT NULL,
    anio integer NOT NULL,
    fecha date NOT NULL
);


--
-- TOC entry 208 (class 1259 OID 17022)
-- Name: gastos_fact; Type: TABLE; Schema: staging; Owner: -
--

CREATE TABLE staging.gastos_fact (
    importe numeric NOT NULL,
    dia_key integer NOT NULL,
    subcategoria_key integer NOT NULL,
    saldo numeric NOT NULL
);


--
-- TOC entry 202 (class 1259 OID 16875)
-- Name: movimientos; Type: TABLE; Schema: staging; Owner: -
--

CREATE TABLE staging.movimientos (
    fvalor date,
    categoria character(100),
    subcategoria character(100),
    descripcion character(2000),
    comentario character(2000),
    imagen character(100),
    importe numeric,
    saldo numeric,
    movimientos_key integer NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 17543)
-- Name: movimientos_movimientos_key_seq; Type: SEQUENCE; Schema: staging; Owner: -
--

CREATE SEQUENCE staging.movimientos_movimientos_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3036 (class 0 OID 0)
-- Dependencies: 211
-- Name: movimientos_movimientos_key_seq; Type: SEQUENCE OWNED BY; Schema: staging; Owner: -
--

ALTER SEQUENCE staging.movimientos_movimientos_key_seq OWNED BY staging.movimientos.movimientos_key;


--
-- TOC entry 205 (class 1259 OID 16910)
-- Name: subcategoria; Type: TABLE; Schema: staging; Owner: -
--

CREATE TABLE staging.subcategoria (
    subcategoria character(200) NOT NULL,
    categoria character(200) NOT NULL
);


--
-- TOC entry 2884 (class 2604 OID 16902)
-- Name: dia dia_key; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dia ALTER COLUMN dia_key SET DEFAULT nextval('public.dia_dia_key_seq'::regclass);


--
-- TOC entry 2887 (class 2604 OID 17195)
-- Name: gastos_fact gastos_fact_key; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gastos_fact ALTER COLUMN gastos_fact_key SET DEFAULT nextval('public.gastos_fact_gastos_fact_key_seq'::regclass);


--
-- TOC entry 2886 (class 2604 OID 16926)
-- Name: subcategoria subcategoria_key; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subcategoria ALTER COLUMN subcategoria_key SET DEFAULT nextval('public.subcategoria_subcategoria_key_seq'::regclass);


--
-- TOC entry 2885 (class 2604 OID 17545)
-- Name: movimientos movimientos_key; Type: DEFAULT; Schema: staging; Owner: -
--

ALTER TABLE ONLY staging.movimientos ALTER COLUMN movimientos_key SET DEFAULT nextval('staging.movimientos_movimientos_key_seq'::regclass);


--
-- TOC entry 2889 (class 2606 OID 16907)
-- Name: dia dia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dia
    ADD CONSTRAINT dia_pkey PRIMARY KEY (dia_key);


--
-- TOC entry 2895 (class 2606 OID 17197)
-- Name: gastos_fact gastos_fact_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gastos_fact
    ADD CONSTRAINT gastos_fact_pkey PRIMARY KEY (gastos_fact_key);


--
-- TOC entry 2893 (class 2606 OID 16928)
-- Name: subcategoria subcategoria_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subcategoria
    ADD CONSTRAINT subcategoria_pkey PRIMARY KEY (subcategoria_key);


--
-- TOC entry 2891 (class 2606 OID 17553)
-- Name: movimientos movimientos_pkey; Type: CONSTRAINT; Schema: staging; Owner: -
--

ALTER TABLE ONLY staging.movimientos
    ADD CONSTRAINT movimientos_pkey PRIMARY KEY (movimientos_key);


--
-- TOC entry 2896 (class 2606 OID 17198)
-- Name: gastos_fact fk_dia; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gastos_fact
    ADD CONSTRAINT fk_dia FOREIGN KEY (dia_key) REFERENCES public.dia(dia_key) NOT VALID;


--
-- TOC entry 2897 (class 2606 OID 17203)
-- Name: gastos_fact fk_subcategoria; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gastos_fact
    ADD CONSTRAINT fk_subcategoria FOREIGN KEY (subcategoria_key) REFERENCES public.subcategoria(subcategoria_key) NOT VALID;


-- Completed on 2021-11-28 21:56:41

--
-- PostgreSQL database dump complete
--

