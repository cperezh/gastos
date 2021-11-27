CREATE TABLE ods.gastos
(
    fvalor character(100) NOT NULL,
    categoria character(100),
	subcategoria character(100),
	descripcion character(2000),
	comentario character(2000),
	imagen character(100),
	importe character(100),
	saldo character(100)
)

CREATE TABLE public.gastos
(
    fvalor date,
    categoria character(100),
	subcategoria character(100),
	descripcion character(2000),
	comentario character(2000),
	imagen character(100),
	importe numeric,
	saldo numeric
)