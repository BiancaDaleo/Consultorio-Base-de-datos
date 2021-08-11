--triggers

--registra las altas de turnos

create trigger tr_Insert_Turnos
on Turnos
for insert
as 
begin

declare @IdObjeto int
declare @IdUsuarioLog int
declare @Objeto nvarchar (MAX)
set @Objeto = (select * from inserted FOR XML AUTO)
set @IdObjeto = (select IdTurno from inserted)
set @IdUsuarioLog = (select IdUsuarioLog from inserted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'NUEVO TURNO', 'Turnos', GETDATE(), @IdObjeto, @Objeto)

end

--registra las bajas en turnos
create trigger tr_delete_Turnos
on Turnos
for delete
as 
begin
declare @IdObjeto int
declare @IdUsuarioLog int
declare @Objeto nvarchar (MAX)
set @Objeto = (select * from deleted FOR XML AUTO)
set @IdObjeto = (select IdTurno from deleted)
set @IdUsuarioLog = (select IdUsuarioLog from deleted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'BAJA', 'Turnos', GETDATE(), @IdObjeto, @Objeto)

end

--Registra las modificaciones en los turnos
create trigger tr_update_Turnos
on Turnos
for update
as 
begin
declare @IdObjeto int
declare @IdUsuarioLog int
declare @Objeto nvarchar (MAX)
set @Objeto = (select * from deleted FOR XML AUTO)
set @IdObjeto = (select IdTurno from deleted)
set @IdUsuarioLog = (select IdUsuarioLog from deleted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'Modificacion - Baja Turno', 'Turnos', GETDATE(), @IdObjeto, @Objeto)

set @Objeto = (select * from inserted FOR XML AUTO)
set @IdObjeto = (select IdTurno from inserted)
set @IdUsuarioLog = (select IdUsuarioLog from inserted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'Modificacion - Nuevo turno', 'Turnos', GETDATE(), @IdObjeto, @Objeto)
end


--registra las altas de Pacientes
create trigger tr_Insert_Pacientes
on Pacientes
for insert
as 
begin
declare @IdObjeto int
declare @IdUsuarioLog int
declare @Objeto nvarchar (MAX)
set @Objeto = (select * from inserted FOR XML AUTO)
set @IdObjeto = (select IdPaciente from inserted)
set @IdUsuarioLog = (select IdUsuarioLog from inserted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'ALTA', 'Pacientes', GETDATE(), @IdObjeto, @Objeto)

end

--registra las bajas de Pacientes
create trigger tr_delete_Pacientes
on Pacientes
for delete
as 
begin
declare @IdObjeto int
declare @IdUsuarioLog int
declare @Objeto nvarchar (MAX)
set @Objeto = (select * from deleted FOR XML AUTO)
set @IdObjeto = (select IdPaciente from deleted)
set @IdUsuarioLog = (select IdUsuarioLog from deleted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'BAJA', 'Pacientes', GETDATE(), @IdObjeto, @Objeto)

end

--Registra las modificaciones en Pacientes
create trigger tr_update_Pacientes
on Pacientes
for update
as 
begin
declare @IdObjeto int
declare @IdUsuarioLog int
declare @Objeto nvarchar (MAX)
set @Objeto = (select * from deleted FOR XML AUTO)
set @IdObjeto = (select IdPaciente from deleted)
set @IdUsuarioLog = (select IdUsuarioLog from deleted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'Modificacion - Baja Paciente', 'Pacientes', GETDATE(), @IdObjeto, @Objeto)

set @Objeto = (select * from inserted FOR XML AUTO)
set @IdObjeto = (select IdPaciente from inserted)
set @IdUsuarioLog = (select IdUsuarioLog from inserted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'Modificacion - ALTA Paciente', 'Pacientes', GETDATE(), @IdObjeto, @Objeto)
end






--registra las altas de Medicos

create trigger tr_Insert_Medicos
on Medicos
for insert
as 
begin

declare @IdObjeto int
declare @IdUsuarioLog int
declare @Objeto nvarchar (MAX)
set @Objeto = (select * from inserted FOR XML AUTO)
set @IdObjeto = (select IdMedico from inserted)
set @IdUsuarioLog = (select IdUsuarioLog from inserted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'NUEVO Medico', 'Medicos', GETDATE(), @IdObjeto, @Objeto)

end





--registra las bajas de Medicos
create trigger tr_delete_Medicos
on Medicos
for delete
as 
begin
declare @IdObjeto int
declare @IdUsuarioLog int
declare @Objeto nvarchar (MAX)
set @Objeto = (select * from deleted FOR XML AUTO)
set @IdObjeto = (select IdMedico from deleted)
set @IdUsuarioLog = (select IdUsuarioLog from deleted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'BAJA', 'Medicos', GETDATE(), @IdObjeto, @Objeto)

end


--Registra las modificaciones en los Medicos
create trigger tr_update_Medicos
on Medicos
for update
as 
begin
declare @IdObjeto int
declare @IdUsuarioLog int
declare @Objeto nvarchar (MAX)
set @Objeto = (select * from deleted FOR XML AUTO)
set @IdObjeto = (select IdMedico from deleted)
set @IdUsuarioLog = (select IdUsuarioLog from deleted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'Modificacion - Baja Medico', 'Medicos', GETDATE(), @IdObjeto, @Objeto)

set @Objeto = (select * from inserted FOR XML AUTO)
set @IdObjeto = (select IdMedico from inserted)
set @IdUsuarioLog = (select IdUsuarioLog from inserted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'Modificacion - Nuevo Medico', 'Medicos', GETDATE(), @IdObjeto, @Objeto)
end



--registra las altas de las Coberturas

create trigger tr_Insert_Coberturas
on Coberturas
for insert
as 
begin

declare @IdObjeto int
declare @IdUsuarioLog int
declare @Objeto nvarchar (MAX)
set @Objeto = (select * from inserted FOR XML AUTO)
set @IdObjeto = (select IdCobertura from inserted)
set @IdUsuarioLog = (select IdUsuarioLog from inserted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'NUEVA Cobertura', 'Coberturas', GETDATE(), @IdObjeto, @Objeto)

end



--registra las bajas en Coberturas
create trigger tr_delete_Coberturas
on Coberturas
for delete
as 
begin
declare @IdObjeto int
declare @IdUsuarioLog int
declare @Objeto nvarchar (MAX)
set @Objeto = (select * from deleted FOR XML AUTO)
set @IdObjeto = (select IdCobertura from deleted)
set @IdUsuarioLog = (select IdUsuarioLog from deleted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'BAJA', 'Cobertura', GETDATE(), @IdObjeto, @Objeto)

end


--Registra las modificaciones en las Coberturas

create trigger tr_update_Coberturas
on Coberturas
for update
as 
begin
declare @IdObjeto int
declare @IdUsuarioLog int
declare @Objeto nvarchar (MAX)
set @Objeto = (select * from deleted FOR XML AUTO)
set @IdObjeto = (select IdCobertura from deleted)
set @IdUsuarioLog = (select IdUsuarioLog from deleted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'Modificacion - Baja Cobertura', 'Coberturas', GETDATE(), @IdObjeto, @Objeto)

set @Objeto = (select * from inserted FOR XML AUTO)
set @IdObjeto = (select IdCobertura from inserted)
set @IdUsuarioLog = (select IdUsuarioLog from inserted)

insert into Auditoria_General (IdUsuario, Accion, Tabla, Fecha, IdObjeto, Objeto)
values (@IdUsuarioLog, 'Modificacion - Nueva Cobertura', 'Coberturas', GETDATE(), @IdObjeto, @Objeto)
end
