create view DimFecha
as
select 
distinct p.FechaEmision,
year(p.FechaEmision) as Año,
month(p.FechaEmision) as Mes,
day(p.FechaEmision) as Dia,
datepart(qq, p.FechaEmision) as Trimestre
from Poliza p

create view DimTPoliza
as
Select * from TipoPoliza

create view DimAsegurado
as
select * from Asegurado

create view FactPolizas
as
select
 p.IdPoliza,
p.IdAsegurado,
p.IdTipoPoliza,
p.FechaEmision,
p.Costo
,count(h.IdPoliza) [Cantidad de Hospitalizaciones]
from 
Poliza p 
inner join Asegurado a
on a.IDAsegurado = p.IdAsegurado
left join Hospitalizacion h
on h.IdPoliza = p.IdPoliza
group by p.IdPoliza, p.FechaEmision, p.IdAsegurado, p.IdTipoPoliza, p.Costo
