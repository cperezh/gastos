--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 14.0

-- Started on 2021-11-28 21:56:40


-------------------------------
-- PUBLIC SCHEMA --------------
-------------------------------

CREATE TABLE public.dia (
    dia integer NOT NULL,
    mes integer NOT NULL,
    anio integer NOT NULL,
    fecha date NOT NULL,
    dia_key integer NOT NULL
);

CREATE TABLE public.gastos_fact (
    gastos_fact_key integer NOT NULL,
    importe numeric NOT NULL,
    dia_key integer NOT NULL,
    subcategoria_key integer NOT NULL,
    saldo numeric NOT NULL
);

CREATE TABLE public.subcategoria (
    subcategoria_key integer NOT NULL,
    subcategoria character(200) NOT NULL,
    categoria character(200) NOT NULL
);

--------------------------------
-- STAGING SCHEMA --------------
--------------------------------


CREATE SCHEMA staging;

CREATE TABLE staging.dia (
    dia integer NOT NULL,
    mes integer NOT NULL,
    anio integer NOT NULL,
    fecha date NOT NULL
);

CREATE TABLE staging.subcategoria (
    subcategoria character(200) NOT NULL,
    categoria character(200) NOT NULL
);

CREATE TABLE staging.gastos_fact (
    importe numeric NOT NULL,
    dia_key integer NOT NULL,
    subcategoria_key integer NOT NULL,
    saldo numeric NOT NULL
);

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

--------------------------------
-- SECUENCIAS PARA PKs ---------
--------------------------------

CREATE SEQUENCE public.dia_dia_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.dia_dia_key_seq OWNED BY public.dia.dia_key;

CREATE SEQUENCE public.gastos_fact_gastos_fact_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.gastos_fact_gastos_fact_key_seq OWNED BY public.gastos_fact.gastos_fact_key;

CREATE SEQUENCE public.subcategoria_subcategoria_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.subcategoria_subcategoria_key_seq OWNED BY public.subcategoria.subcategoria_key;

CREATE SEQUENCE staging.movimientos_movimientos_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE staging.movimientos_movimientos_key_seq OWNED BY staging.movimientos.movimientos_key;

ALTER TABLE ONLY public.dia ALTER COLUMN dia_key SET DEFAULT nextval('public.dia_dia_key_seq'::regclass);

ALTER TABLE ONLY public.gastos_fact ALTER COLUMN gastos_fact_key SET DEFAULT nextval('public.gastos_fact_gastos_fact_key_seq'::regclass);

ALTER TABLE ONLY public.subcategoria ALTER COLUMN subcategoria_key SET DEFAULT nextval('public.subcategoria_subcategoria_key_seq'::regclass);

ALTER TABLE ONLY staging.movimientos ALTER COLUMN movimientos_key SET DEFAULT nextval('staging.movimientos_movimientos_key_seq'::regclass);


--------------------------------
----------- PKs ----------------
--------------------------------

ALTER TABLE ONLY public.dia
    ADD CONSTRAINT dia_pkey PRIMARY KEY (dia_key);

ALTER TABLE ONLY public.gastos_fact
    ADD CONSTRAINT gastos_fact_pkey PRIMARY KEY (gastos_fact_key);

ALTER TABLE ONLY public.subcategoria
    ADD CONSTRAINT subcategoria_pkey PRIMARY KEY (subcategoria_key);

ALTER TABLE ONLY staging.movimientos
    ADD CONSTRAINT movimientos_pkey PRIMARY KEY (movimientos_key);

--------------------------------
----------- FKs ----------------
--------------------------------

ALTER TABLE ONLY public.gastos_fact
    ADD CONSTRAINT fk_dia FOREIGN KEY (dia_key) REFERENCES public.dia(dia_key) NOT VALID;

ALTER TABLE ONLY public.gastos_fact
    ADD CONSTRAINT fk_subcategoria FOREIGN KEY (subcategoria_key) REFERENCES public.subcategoria(subcategoria_key) NOT VALID;
