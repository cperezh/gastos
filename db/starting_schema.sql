--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 14.0

-- Started on 2021-11-28 21:56:40


-------------------------------
-- dtm SCHEMA --------------
-------------------------------
DROP SCHEMA dtm CASCADE;

CREATE SCHEMA dtm;

CREATE TABLE dtm.dia (
    dia integer NOT NULL,
    mes integer NOT NULL,
    anio integer NOT NULL,
    fecha date NOT NULL,
    dia_key integer NOT NULL
);

CREATE TABLE dtm.gastos_fact (
    gastos_fact_key integer NOT NULL,
    importe numeric NOT NULL,
    dia_key integer NOT NULL,
    subcategoria_key integer NOT NULL,
    saldo numeric NOT NULL
);

CREATE TABLE dtm.subcategoria (
    subcategoria_key integer NOT NULL,
    subcategoria character(200) NOT NULL,
    categoria character(200) NOT NULL
);

-------------------------------------------------------
-- EDH SCHEMA (Enterprise Data Warehouse) -------------
-------------------------------------------------------
DROP SCHEMA edw CASCADE;

CREATE SCHEMA edw;

CREATE TABLE edw.movimientos (
    movimientos_key integer NOT NULL,
    fvalor date NOT NULL,
	importe numeric NOT NULL,
    saldo numeric NOT NULL,
    subcategoria_key integer NOT NULL,
    descripcion character(2000),
    comentario character(2000)
);

CREATE TABLE edw.subcategoria (
    subcategoria_key integer NOT NULL,
    categoria_key integer NOT NULL,
	subcategoria character(200) NOT NULL
);

CREATE TABLE edw.categoria (
    categoria_key integer NOT NULL,
    categoria character(200) NOT NULL
);

--------------------------------
-- STAGING SCHEMA --------------
--------------------------------
DROP SCHEMA staging CASCADE;

CREATE SCHEMA staging;

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

--------------------------------
-- SECUENCIAS PARA PKs ---------
--------------------------------

CREATE SEQUENCE dtm.dia_dia_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE dtm.dia_dia_key_seq OWNED BY dtm.dia.dia_key;

CREATE SEQUENCE dtm.gastos_fact_gastos_fact_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE dtm.gastos_fact_gastos_fact_key_seq OWNED BY dtm.gastos_fact.gastos_fact_key;

CREATE SEQUENCE dtm.subcategoria_subcategoria_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE dtm.subcategoria_subcategoria_key_seq OWNED BY dtm.subcategoria.subcategoria_key;

CREATE SEQUENCE edw.movimientos_movimientos_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE edw.movimientos_movimientos_key_seq OWNED BY edw.movimientos.movimientos_key;

CREATE SEQUENCE edw.subcategoria_subcategoria_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
ALTER SEQUENCE edw.subcategoria_subcategoria_key_seq OWNED BY edw.subcategoria.subcategoria_key;

CREATE SEQUENCE edw.categoria_categoria_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
ALTER SEQUENCE edw.categoria_categoria_key_seq OWNED BY edw.categoria.categoria_key;

ALTER TABLE ONLY dtm.dia ALTER COLUMN dia_key SET DEFAULT nextval('dtm.dia_dia_key_seq'::regclass);

ALTER TABLE ONLY dtm.gastos_fact ALTER COLUMN gastos_fact_key SET DEFAULT nextval('dtm.gastos_fact_gastos_fact_key_seq'::regclass);

ALTER TABLE ONLY dtm.subcategoria ALTER COLUMN subcategoria_key SET DEFAULT nextval('dtm.subcategoria_subcategoria_key_seq'::regclass);

ALTER TABLE ONLY edw.movimientos ALTER COLUMN movimientos_key SET DEFAULT nextval('edw.movimientos_movimientos_key_seq'::regclass);

ALTER TABLE ONLY edw.subcategoria ALTER COLUMN subcategoria_key SET DEFAULT nextval('edw.subcategoria_subcategoria_key_seq'::regclass);

ALTER TABLE ONLY edw.categoria ALTER COLUMN categoria_key SET DEFAULT nextval('edw.categoria_categoria_key_seq'::regclass);
--------------------------------
----------- PKs ----------------
--------------------------------

ALTER TABLE ONLY dtm.dia
    ADD CONSTRAINT dia_pkey PRIMARY KEY (dia_key);

ALTER TABLE ONLY dtm.gastos_fact
    ADD CONSTRAINT gastos_fact_pkey PRIMARY KEY (gastos_fact_key);

ALTER TABLE ONLY dtm.subcategoria
    ADD CONSTRAINT subcategoria_pkey PRIMARY KEY (subcategoria_key);

ALTER TABLE ONLY edw.movimientos
    ADD CONSTRAINT movimientos_pkey PRIMARY KEY (movimientos_key);

ALTER TABLE ONLY edw.subcategoria
    ADD CONSTRAINT subcategoria_pkey PRIMARY KEY (subcategoria_key);
	
ALTER TABLE ONLY edw.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (categoria_key);
