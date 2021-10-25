-- Truncado inicial
truncate table staging.gastos;
truncate table public.gastos;
truncate table staging.subcategoria;
truncate table public.subcategoria;
truncate table staging.dia;
truncate table public.dia;
insert into public.dia(dia_key, dia, mes, anio, fecha) values(0, 0, 0, 0,' 1900-01-01');
insert into public.dia(dia_key, dia, mes, anio, fecha) values(-1,-1, -1, -1, '1900-01-01');
insert into public.subcategoria(subcategoria_key, subcategoria, categoria) values(0,'UNKNOWN','UNKNOWN');
insert into public.subcategoria(subcategoria_key, subcategoria, categoria) values(-1,'INVALID','INVALID');


-- Primera prueba: Gasto vacia, no inserta nada en las dimensiones
select count(*) from staging.subcategoria, staging.dia;

-- Inserto 1 gasto
insert into staging.gastos(importe, fvalor, categoria, subcategoria) values (1000, '2021-01-02', 'CAT1', 'SUBCAT1')
select * from public.subcategoria;
select * from public.dia;
select * from staging.gastos_fact;

-- Inserto otro gasto. No debe modificar lo anterior
truncate table stating.gastos;
insert into staging.gastos(importe, fvalor, categoria, subcategoria) values (2000, '2021-01-03', 'CAT2', 'SUBCAT2')
select * from staging.subcategoria;
select * from staging.dia;

-- Inserto el mismo primer gasto. No debe duplicar ni las dimensiones ni el gasto
truncate table staging.gastos;
insert into staging.gastos(importe, fvalor, categoria, subcategoria) values (1000, '2021-01-02', 'CAT1', 'SUBCAT1')
select * from public.subcategoria;
select * from public.dia;

-- Inserto gasto con dias nulo e invalido. Deba acabar con dia_key = 0 y -1
truncate table staging.gastos;
insert into staging.gastos(importe, fvalor, categoria, subcategoria) values (4000, NULL, 'CAT4', 'SUBCAT4');
--insert into staging.gastos(importe, fvalor, categoria, subcategoria) values (5000, 'hola', 'CAT5', 'SUBCAT5');
select * from public.subcategoria;
select * from public.dia;

-- Inserto gasto con subcategora o categoria NULL. Debe acabar con subcategoria_key = 0
truncate table staging.gastos;
insert into staging.gastos(importe, fvalor, categoria, subcategoria) values (6000, '2021-06-01', NULL, 'SUBCAT6');
insert into staging.gastos(importe, fvalor, categoria, subcategoria) values (7000, '2021-06-01', 'CAT7', NULL);

