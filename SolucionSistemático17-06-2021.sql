Insert into DimRepuestos(id_Repuesto,No_Repuesto,Titulo,
                         Descripcion,Marca,Modelo, Precio, Cantidad)
						 
Select * from Servicios_Autos.dbo.Repuesto
Select * from Servicios_Autos.dbo.Repuesto_Servicio
update DimRepuestos set FechaInicio = '2021-06-17'
update DimRepuestos set FechaFinal = '9999-12-31'

Select * from HechosMantenimiento


drop table DimRepuestos
Create table DimRepuestos(
IdDImRepuesto int identity(1,1) primary key,
[id_Repuesto] [int] NOT NULL,   
	[No_Repuesto] [int] NOT NULL,
	[Titulo] [nvarchar](80) NOT NULL,
	[Descripcion] [nvarchar](80) NOT NULL,
	[Marca] [nvarchar](100) NOT NULL,
	[Modelo] [nvarchar](70) NOT NULL,
	[Precio] [float] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[FechaInicio] [date] NULL,
	[FechaFinal] [date] NULL
)

go

drop table HechosRepuestos
delete from DimRepuestos
Create Table HechosRepuestos(
[idDimServicios] [int] Foreign key references  DimServicio(idDimServicio)  null,
	[idDimMecanico] [int] Foreign key references  DimMecanico(idDimMecanico) NULL,
	[idDimRepuesto] [int] Foreign key references DimRepuestos(idDimRepuesto)   NULL,
	[idDimFecha] [int] Foreign key references DimFecha(IdDimFecha) NULL,
	[Cantidad] [int] NULL,
	[Monto ] [float] NULL,
	[Comision] [Float] Null,
	[Impuesto] [float] NULL,
	[Total] [float] NULL

)

select *from HechosRepuestos



Merge dbo.HechosRepuestos Destino
Using

(Select 
----- Llave de las tablas Dimensionales

--sm.Id_Servicio_Mantenimiento,
Rs.Id_Repuesto_Servicio,
sm.Id_Servicio_Mantenimiento,
Dr.IdDImRepuesto,
Dm.IdDimMecanico,
Ds.IdDimServicio,
Df.IdDimFecha,

------------------------------------------------------
(Rs.Cantidad) As Cantidad_repuesto,
(Rs.Costo * Rs.Cantidad) As Monto,
(Rs.Costo * Rs.Cantidad *0.05) as Comision,
(Rs.Costo * Rs.Cantidad*0.15) as [Impuestos],
((Rs.Costo * Rs.Cantidad)+(Rs.Costo * Rs.Cantidad*0.05)
+(Rs.Costo * Rs.Cantidad*0.15)) as [Total]
 
 from  Servicios_Autos.dbo.Repuesto_Servicio Rs 
 inner join 
 Servicios_Autos.dbo.Servicio_Mantenimiento sm
 on Rs.id_Servicio_Mantenimiento= sm.Id_Servicio_Mantenimiento
inner join Servicios_Autos.dbo.Mantenimiento m
on m.Id_Mantenimiento = sm.Id_Mantenimiento
inner join DimRepuestos Dr
on Dr.id_Repuesto= Rs.Id_Repuesto
inner join DimMecanico Dm
on Dm.id_Mecanico= Sm.id_Mecanico
inner join DimServicio Ds
on Ds.id_Servicio= sm.Id_Servicio
inner join DimFecha Df
on Df.IdFecha=m.fecha_Entrada
where
ds.FechaFinal='9999/12/31' AND 
dm.FechaFinal='9999/12/31' AND 
Dr.FechaFinal='9999/12/31' 

--Group by 

--rs.Id_Repuesto_Servicio,
--Dr.IdDImRepuesto,
--Dm.IdDimMecanico,
--Ds.IdDimServicio,
--Df.IdDimFecha,
) Origen
on 
Origen.IdDimServicio = Destino.IdDimServicios and
Origen.IddimMecanico = Destino.IdDimMecanico and
Origen.IDdimRepuesto = Destino.IDdimrepuesto and
Origen.IddimFecha= Destino.IdDimFecha
WHEN MATCHED AND
(Origen.[Cantidad_repuesto] <> Destino.[Cantidad] Or
Origen.[Monto] <> Destino.[Monto ] or
Origen.[Comision] <> Destino.[Comision] or
Origen.[Impuestos] <> Destino.[Impuesto] or
Origen.[Total] <> Destino.[Total])
--Cantidad_repuesto	Total Repuesto	Impuestos	Total
Then
update set 
 Destino.[Cantidad]=Origen.[Cantidad_repuesto],
 Destino.[Monto ] = Origen.[Monto],
 Destino.[Comision] = Origen.[Comision],
 Destino.[Impuesto] = Origen.[Impuestos],
 Destino.[Total] = Origen.[Total] 
 
 WHEN NOT MATCHED THEN 
            INSERT
	(IdDimServicios, IdDimMecanico, IdDimrepuesto, IdDimFecha,
	 Cantidad	,[Monto ],comision	,Impuesto	,Total)
	 Values
	 (Origen.IdDimServicio, Origen.IdDimMecanico, Origen.IdDimrepuesto,
	 Origen.IdDimFecha,
	  Origen.[Cantidad_repuesto],Origen.[Monto] ,Origen.[Comision], 
	  Origen.[Impuestos], Origen.[Total]);







	  Select *from HechosRepuestos

	  select *from DimVehiculo