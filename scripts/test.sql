-- Truncado inicial
truncate table staging.gastos;
truncate table public.gastos;
truncate table staging.subcategoria;
truncate table public.subcategoria;
truncate table staging.dia;
truncate table public.dia;

-- Primera prueba: Gasto vacia, no inserta nada en las dimensiones
select count(*) from staging.subcategoria, staging.dia;

-- Inserto 1 gasto
insert into staging.gastos(fvalor, categoria, subcategoria) values ('2021-01-02', 'CAT1', 'SUBCAT1')
select * from public.subcategoria;
select * from public.dia;

-- Inserto otro gasto. No debe modificar lo anterior
insert into staging.gastos(fvalor, categoria, subcategoria) values ('2021-01-03', 'CAT2', 'SUBCAT2')
select * from staging.subcategoria;
select * from staging.dia;

-- Inserto el mismo primer gasto. No debe duplicar
insert into staging.gastos(fvalor, categoria, subcategoria) values ('2021-01-02', 'CAT1', 'SUBCAT1')
select * from public.subcategoria;
select * from public.dia;

