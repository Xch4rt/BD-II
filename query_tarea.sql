--  crear bd repo

create database RepositorioBD

-- crear tablas recaudacion y detalle recaudacion

Use repositoriobd

create table Recaudacion(
	IdRecaudacion int primary key identity(1,1),
	NombreBD nvarchar(25),
	Fecha date,
	Year_ int,
	Mes varchar(15),
	CantidadOrdenes int,
	SubTotal float,
	Descuento float,
	Impuesto float,
	Total float
)

create table Detalle_Recaudacion(
IdRecaudacion int not null,
IdEmpleado int not null,
CantidadOrdenes int,
SubTotal float,
Descuento float,
Impuesto float,
Total float,
)

alter table Detalle_Recaudacion
add primary key (IdRecaudacion, IdEmpleado)

alter table Detalle_Recaudacion
add foreign key (IdRecaudacion) references Recaudacion(IdRecaudacion)


-- procedimiento

select * from Northwind.dbo.Orders where year(OrderDate) = 2022

update Northwind.dbo.Orders set OrderDate = dateadd(month,-2,Orderdate) where month(Northwind.dbo.Orders.OrderDate) = 5 
and year(Northwind.dbo.Orders.OrderDate) = 1998 

update Northwind.dbo.Orders set OrderDate = dateadd(month,-2,Orderdate) where year(Northwind.dbo.Orders.OrderDate) = 2022 


alter  proc ActualizaRecaudacion
as
insert into RepositorioBD.dbo.Recaudacion
select
e.employeeid as IdEmpleado,
count(distinct o.OrderID) as CantidadOrdenes,
sum(od.Quantity * od.UnitPrice) as SubTotal,
sum(od.Quantity * od.UnitPrice * od.Discount) as Descuento,
sum(distinct o.Freight) as Impuesto,
sum(od.Quantity * od.UnitPrice * (1-od.Discount)) + sum(distinct o.Freight) as Total
from Northwind.dbo.Orders o
inner join Northwind.dbo.[Order Details] od
on od.OrderID = o.OrderID,
inner join Northwind.dbo.Employees e,
on e.employeeid = o.employeeid
where month(OrderDate) = month(dateadd(month, -1, getdate()))  and year(orderdate) = year(getdate())
group by year(orderdate), DATENAME(month, orderdate), o.EmployeeID
-- para enviar el detalle
Exec Msdb.dbo.sp_send_dbmail @recipients = 'pab203.guti@gmail.com', @subject = 'Informe de recaudacion mensual', 
@query = 'Execute RepositorioBD.dbo.ActualizaRecaudacion',
@attach_query_result_as_file = 1


exec ActualizaRecaudacion
select * from Recaudacion
