Los usuarios que han recibido permisos para crear tablas, pueden crear tablas en los
Esquemas de su propiedad.   VERDADERO
```
use Northwind

create login Pablo1 with password = '123' 

sp_adduser Pablo1, Pablo1
create schema schema1 authorization dbo

grant create table to Pablo1

create table Northwind.Pablo1.PabloPrueba1(id int)
```


Los usuarios al ser creados tienen por defecto el rol public. VERDADERO


No se pueden dar permisos al rol public. FALSO

Los usuarios con With grant Option no pueden heredar permisos a usuarios con rol
db_datareader.

Un inicio de sesión puede tener más de un usuario siempre y cuando tenga un nombre
distinto en la misma base de datos.

El rol de Servidor Datawriter solo permite permisos de escritura y actualizado. FALSO

El propietario de esquema puede transferir sus objetos a otro esquema que no es de su
propiedad.

Únicamente el propietario del esquema podrá crear objetos en dicho esquema.

El rol de BD db_BackupOperator no puede utilizar dispositivos de almacenamiento.


El rol db_ddladmin le permite al usuario crear vistas con objetos a los que no tiene
permiso de acceso.


El rol db_owner no puede crear backup de la base de datos.

Se puede denegar el permiso de selección a un objeto que es propiedad del usuario.

Cuando se agrega un objeto a un esquema que es propiedad del usuario, este puede
borrarlo omodificarlo

Db_SecurityAdmin puede denegar y conceder accesos a todos los usuarios de la base de
datos

Db_Securityadmin puede crear usuarios y asignarlos a cuentas de acceso.

Securityadmin puede cambiar los permisos de propiedad de un esquema

Bulkadmin puede administrar la función Insert Data

Securityadmin puede ingresar a todas las bases de datos


Securityadmin puede borrar esquemas y crear nuevos esquemas


Los usuarios con rol de propietario de BD no pueden visualizar los dispositivos de
almacenamiento.
