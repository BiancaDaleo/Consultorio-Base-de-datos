--Consultas


--La Vista de turnos, se utiliza para poder ver dia y horario de los turnos asignados, asi como paciente, especialidad
--y Medico que lo atendera. Tambien dice el Telefono por si hubiera que llamarlo para confirmar el turno, o modificarlo.
--Por ultimo tiene el campo activo para ver si el paciente esta en condiciones administrativas para ser atendido.
--En caso de que al consultar diga que no esta activo, se procedera a llamarlo para informarle.
--Dentro de esta vista podriamos agregarle los parametros que necesitemos, por ejemplo los turnos del dia, 
--o de un periodo determinado

Create View Vw_Turnos
as
select
T.Fecha_Hora,
M.Especialidad,
M.Nombre_Medico,
M.Apellido_Medico,
P.Nombre_Paciente,
P.Apellido_Paciente,
C.Nombre_Cobertura,
P.Telefono_Paciente,
P.Activo

from Turnos T
INNER JOIN Pacientes P
ON P.IdPaciente=T.IdPaciente
INNER JOIN Medicos M
ON M.IdMedico=T.IdMedico
INNER JOIN Coberturas C
ON C.IdCobertura=P.IdCobertura


select * from Vw_Turnos 
select * from Vw_Turnos where Fecha_Hora='2019-12-07 10:20:00.000'
 

 --La Vista de los medicos sirve para consultar el staff medico , con sus especialidades y el tel de contacto
 --Puede consultarte por un medico en especifico, o por la especialidad requerida.
 
Create View Vw_Medicos
as
select

M.Nombre_Medico,
M.Apellido_Medico,
M.Fecha_Alta,
M.Especialidad,
M.Telefono_Medico,
U.Descripcion_Usuario

from Medicos M
INNER JOIN Usuarios U
ON U.IdUsuario=M.IdUsuario



select * from Vw_Medicos
select * from Vw_Medicos where Especialidad = 'Fisiatria'
select * from Vw_Medicos where Nombre_Medico = 'Juan'



--Esta vista sirve para ver el estado de las coberturas de los pacientes que tienen turno asignado.
--Por ejemplo, podria darse que una cobertura deje de tener convenio y por lo tanto con esta vista puede ver
--claramente quien es el paciente y cuando tendra el turno y si la cobertura se dio de baja, que no es lo mismo que
--el paciente este o no activo, que eso ya es extra cobertura.
drop View Vw_Coberturas_Pacientes
Create View Vw_Coberturas_Pacientes
as
select

C.Activo,
C.Nombre_Cobertura,
P.Nombre_Paciente,
P.Apellido_Paciente,
P.Telefono_Paciente,
T.Fecha_Hora

from Pacientes P
INNER JOIN Coberturas C
ON C.IdCobertura= P.IdCobertura
INNER JOIN Turnos T
ON T.IdPaciente=P.IdPaciente

select * from Vw_Coberturas_Pacientes


--La vista de auditoria permite ver la fecha, tabla y accion realizadas.
--Es mas comodo que realizar soolo un selec ya que solo muestra la accion concreta y la tabla afectada.
--puede filtrase por tabla o por accion en caso de ser necesario
Create View Vw_Auditoria
as
select

AG.Fecha,
AG.Accion,
AG.Tabla


from Auditoria_General AG
select * from Vw_Auditoria
select * from Vw_Auditoria where Accion= 'BAJA'

--La vista de Permisos Usuarios permite consultar las acciones que pueden realizar los distintos usuarios
--Puede consultarse uno en especifico o todos.
drop View Vw_Permiso_Usuario
Create View Vw_Permiso_Usuario
as
select


U.Descripcion_Usuario,
M.Descripcion_Menu,
M.Activo

from Usuarios U
INNER JOIN Usuarios_Permisos UP
ON UP.IdUsuario=U.IdUsuario
INNER JOIN Permisos P
ON P.IdPermiso=UP.IdPermiso
INNER JOIN Menu_Permisos MP
ON MP.IdPermiso=P.IdPermiso
INNER JOIN Menu M
ON M.IdMenu=MP.IdMenu


select  * from Vw_Permiso_Usuario
where Descripcion_Usuario = 'SECRETARIA'

select  * from Vw_Permiso_Usuario
where Descripcion_Usuario = 'PACIENTE'