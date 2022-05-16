Use Servicio_Autos
go
Create view DimVehiculo
as
Select
v.Id_vehiculo,
c.id_clientes,
c.pNombre,
c.pApellidoc,
v.Marca,
v.Modelo,
v.Placa,
v.No_Chasis
from Vehiculo v
inner join Clientes c
on c.id_clientes = v.id_clientes
------------------------------------------------
Create view DimServicio
as
Select * from Servicio
------------------------------------------------
Create view DimMecanico
as
Select * from mecanico

---------------------------------------------
Alter view DimFecha
as
Select Distinct 
Fecha_Entrada as IdFecha,
year(Fecha_Entrada) as Año,
month(Fecha_Entrada) as Mes,
datename(MONTH, Fecha_Entrada) as NombreMes,
day(Fecha_Entrada) as Día,
datename(WEEKDAY, Fecha_Entrada) as NombreDía,
datepart(QQ, Fecha_Entrada) as Trimestre
from Mantenimiento

Create view HechosMantenimiento
as
----------------------------------------------------------
Select 
----- Llave de las tablas Dimensionales
sm.Id_Servicio_Mantenimiento,
m.fecha_Entrada as IdFecha,
m.Id_Mantenimiento,
sm.id_Mecanico,
sm.id_Servicio,
m.Id_vehiculo,
------------------------------------------------------
sum (sm.costo) as [Total Servicio],
count(sm.Id_Servicio) as [Cantidad Servicios],
dbo.TotalRespuesto(sm.Id_Servicio_Mantenimiento) as [Total Respuesto],
(sum (sm.costo)+ dbo.TotalRespuesto(sm.Id_Servicio_Mantenimiento)) as [Total General] 
 from Servicio_Mantenimiento sm
inner join Mantenimiento m
on m.Id_Mantenimiento = sm.Id_Mantenimiento
Group by 
m.fecha_Entrada,
sm.id_Mecanico,
sm.id_Servicio,
m.Id_vehiculo,
m.Id_Mantenimiento,
sm.Id_Servicio_Mantenimiento



Select * from Repuesto_Servicio
order by id_Servicio_Mantenimiento asc

Create Function TotalRespuesto (@id_ServicioMantenimiento int)
Returns float 
 as begin
Declare @Total float
set @Total =
(Select sum(costo) from Repuesto_Servicio rs where rs.id_Servicio_Mantenimiento =  @id_ServicioMantenimiento)
if (@Total is null)
set @Total = 0

return @Total
end
Select dbo.TotalRespuesto(281)