/*
Restaurar bd Northwind, adventure works, neptuno

crear bd llamada Repositorio
	tabla recaudaciones
		IdRecaudacion
		NombreBD
		Mes Evaluado
		Fecha
		Monto Venta
		Impuesto
		Total
		Descuento
	
	Tabla detalleRecaudacionEmpleado
		IdDetalleRecaudacion
		IdRecaudacion
		IdEmpleado
		MontoVenta
		Descuentos
		Impuestos
		Total
		CantidadOrdenes


Enviar la recaudacion via correo electronico
*/

-- Restaurando bd AdventureWorks
restore filelistonly from disk = 'C:\Backups\Adventure.bak'
restore headeronly from disk = 'C:\Backups\Adventure.bak'
restore database Adventure from disk = 'C:\Backups\Adventure.bak' with
move  'AdventureWorks2012_Data' to   'C:\Backups\AdventureWorks2012_Data.mdf',
move  'AdventureWorks2012_log' to   'C:\Backups\AdventureWorks2012_log.ldf',
file = 1,
recovery

-- Restaurando neptuno
restore headeronly from disk ='C:\Backups\Backup_DATABASES.bak'
restore database Neptuno  from disk = 'C:\Backups\Backup_DATABASES.bak'
with
move  'Neptuno_Data' to   'C:\BackupsI\Neptuno.mdf',
move  'Extension_I' to   'C:\BackupsI\Extension_I.ndf',
move  'Extensión_II' to 'C:\BackupsI\Extension_II.ndf',
move 'Neptuno_log' to 'C:\BackupsI\Neptuno_log.ldf',
file = 16, norecovery -- file(2,14,15,16) NO USAR RECOVERY AL 16 SI USAR RECOVERY

select * from Neptuno.dbo.Pedidos

-- creando bd Recaudaciones
create database Repositorio
use Repositorio

-- creacionde tablas
create table Recaudaciones (
IdRecaudacion int identity(1,1) not null primary key,
NombreBD nvarchar(25), 
Fecha date,
Mes int,
Year_ int,
MontoVenta decimal(5,2),
Descuento decimal(5,2),
Impuestos decimal(5,2),
total decimal(5,2),
CantidadOrdenes int
)

create table DetalleRecaudacionEmpleado(
IdDetalleRecaudacion int identity(1,1) not null primary key,
MontoVenta decimal(5,2),
Descuentos decimal(5,2),
Impuestos decimal(5,2),
Total decimal(5,2),
CantidadOrdenes int,

--Fks
IdRecuperacion int Foreign key references Recaudaciones(IdRecaudacion),
IdEmpleado int foreign key references Empleados(IdEmpleado)
)

create table Empleados(
IdEmpleado int identity(1,1) not null primary key,
Nombre nvarchar(25),
Apellido nvarchar(25)
)


select * from Neptuno.
