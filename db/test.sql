-- Truncado inicial
truncate table staging.movimientos;
truncate table staging.subcategoria;
truncate table staging.dia;
truncate table staging.gastos_fact;
truncate table public.gastos_fact;
delete from public.subcategoria;
delete from public.dia;
insert into public.dia(dia_key, dia, mes, anio, fecha) values(0, 0, 0, 0,' 1900-01-01');
insert into public.dia(dia_key, dia, mes, anio, fecha) values(-1,-1, -1, -1, '1900-01-01');
insert into public.subcategoria(subcategoria_key, subcategoria, categoria) values(0,'UNKNOWN','UNKNOWN');
insert into public.subcategoria(subcategoria_key, subcategoria, categoria) values(-1,'INVALID','INVALID');


-- Primera prueba: Gasto vacia, no inserta nada en las dimensiones
select count(*) from staging.subcategoria, staging.dia, staging.gastos_fact;

-- Inserto 1 gasto
-- Inserto otro gasto. debe insertar nuevo gasto y nuevas dimensaiones
-- Inserto gasto con mismas dimensiones. No debe duplicar las dimensiones
-- Inserto gasto con dias nulo e invalido. Deba acabar con dia_key = 0 y -1
-- Inserto gasto con subcategora o categoria NULL. Debe acabar con subcategoria_key = 0
insert into staging.movimientos(importe, saldo, fvalor, categoria, subcategoria) values (-1000, -500, '2021-01-02', 'CAT1', 'SUBCAT1');
insert into staging.movimientos(importe, saldo, fvalor, categoria, subcategoria) values (-2000, -1500, '2021-01-03', 'CAT2', 'SUBCAT2');
insert into staging.movimientos(importe, saldo, fvalor, categoria, subcategoria) values (-3000, -2500, '2021-01-02', 'CAT1', 'SUBCAT1');
insert into staging.movimientos(importe, saldo, fvalor, categoria, subcategoria) values (-4000, -3500, NULL, 'CAT4', 'SUBCAT4');
insert into staging.movimientos(importe, saldo, fvalor, categoria, subcategoria) values (-6000, -5500, '2021-06-01', NULL, 'SUBCAT6');
insert into staging.movimientos(importe, saldo, fvalor, categoria, subcategoria) values (-7000, -6500, '2021-06-01', 'CAT7', NULL);

select * from staging.movimientos;
select * from public.subcategoria;
select * from public.dia;
select * from public.gastos_fact;
select * from staging.gastos_fact;

-- Lanzo otra vez la ETL para ver que no duplica
-- Vacio staging.movimientos para ver que no borra
truncate table staging.movimientos
select * from public.subcategoria;
select * from public.dia;
select * from public.gastos_fact

-- Inserto un gasto nuevo, con nuevas dimensiones
truncate table staging.movimientos
insert into staging.movimientos(importe, saldo, fvalor, categoria, subcategoria) values (-8000, -7500, '2021-07-01', 'CAT8', 'SUBCAT8');
select * from public.subcategoria;
select * from public.dia;
select * from public.gastos_fact

-- Cambio un movimiento de categoria
truncate table staging.movimientos
insert into staging.movimientos(importe, saldo, fvalor, categoria, subcategoria) values (-8000, -7500, '2021-07-01', 'CAT8_CAMBIO', 'SUBCAT8_CAMBIO');
select * from public.subcategoria;
select * from public.dia;
select * from public.gastos_fact

