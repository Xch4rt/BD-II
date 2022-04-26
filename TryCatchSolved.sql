create login OperadorSQL with password = 'sistemas'

sp_adduser OperadorSQL, OperadorSQL

use Northwind
sp_adduser OperadorSQL, OperadorSQL


sp_altermessage 'with_log', 'True'

sp_addmessage 
50060,
1,
'El registro con ID %d ha sido borrado de la tabla Region por el usuario %s',
'us_English',
'True'

sp_addmessage 50062, 1, 'No existe el registro con ID: %d en la tabla', 'us_English', 'True'

alter procedure DeleteRegion
@IdRegistro int
as 
Declare @Usuario varchar(50)
set @Usuario = USER_NAME()

If exists (select * from Northwind.dbo.Region where RegionID = @IdRegistro)
	begin 
		begin try
			delete from Northwind.dbo.Region where RegionID = @IdRegistro

			Raiserror(50060, 1, 1, @IdRegistro, @usuario)
		end try
		begin catch
			print 'Registro con llave foranea'
		end catch
	end
else 
	begin
		Raiserror(50062, 1, 1, @IdRegistro) 
	end




insert into Region values (9, 'Norte america')
select  * from Region

create table PaisesRegiones(
IdPais int primary key identity (1,1) not null,
NombrePais varchar(50) not null,

RegionID int foreign key references Region(RegionID)
)

insert into PaisesRegiones values ('Canada', 9)
delete from PaisesRegiones
execute DeleteRegion 9