--Procedimientos Almacenados


--Se crea un procedimiento almacenado por cada tabla.

--1)ABM_Turnos, para alta, baja y modificacion de los turnos asignados, con control de errores (IdPaciente siempre >0)
--2)ABM_Pacientes, para alta, baja y modificacion de los Pacientes, con control de errores 
--(Nombre y Apellido deben estar completos, y el IdCobertura>0)
--3)ABM_Medicos, para alta, baja y modificacion de los Medicos, con control de errores 
--(Nombre y Especialidad de medico deben estar completas)
--4)ABM_Coberturas, para alta, baja y modificacion de las coberturas, con control de errores 
--(El Nombre de la Cobertura debe estar completo)
--5)ABM_Menu, para alta, baja y modificacion de los Menus, con control de errores 
--(La descripcion debe estar completa, y la cantidad de caracteres <60)
--6)ABM_Menu_Permisos, para alta, baja y modificacion de los Menu_permisos, con control de errores 
--(IdPermisos y IdMenu deben ser >0)
--7)ABM_Permisos, para alta, baja y modificacion de los Permisos existentes, con control de errores 
--(La descripcion debe estar completa, y la cantidad de caracteres debe ser <60)
--8)ABM_Usuarios, para alta, baja y modificacion de los tipos de Usuarios, con control de errores 
--(La descripcion debe estar completa, y la cantidad de caracteres <60)
--9)ABM_Usuarios_Permisos, para alta, baja y modificacion de los Usuarios_Permisos, con control de errores 
--(La descripcion debe estar completa, y la cantidad de caracteres <60)

--Si bien hay varias tablas con la misma descripcion de error, resulta ventajoso que ya se las tenga por separado,
--ya que si en el futuro se quisiera hacer una modificacion ya estan diferenciadas, sera mas sencillo cualquier cambio.

create procedure ABM_Turnos
(
@Accion char (1),
@IdTurno int output,
@Fecha_Hora datetime,
@IdPaciente int,
@IdMedico int,
@IdUsuarioLog int,
@EsCorrecto bit output,
@MensajeError nvarchar (1000) output
)
as
begin
if (@Accion='E')
begin
delete Turnos
where IdTurno = @IdTurno
end

else if (@Accion='M')
begin
begin try
if (@IdPaciente>0)
begin
update Turnos
set Fecha_Hora = @Fecha_Hora, IdPaciente = @IdPaciente , IdMedico= @IdMedico, IdUsuarioLog=@IdUsuarioLog 
where IdTurno = @IdTurno
select @IdTurno= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdTurno=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Turnos')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdTurno=0
set @EsCorrecto=0
end catch
end
else if (@Accion='I')
begin
begin try
if (@IdPaciente>0)
begin

Insert into Turnos (Fecha_Hora, IdPaciente, IdMedico, IdUsuarioLog)
values (@Fecha_Hora, @IdPaciente, @IdMedico, @IdUsuarioLog )
select @IdTurno= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdTurno=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Turnos')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdTurno=0
set @EsCorrecto=0
end catch
end
end


declare @IdTurno int
declare @EsCorrecto bit
declare @MensajeError nvarchar (1000)
execute ABM_Turnos 'I',@IdTurno output,'2020-10-10', 0, 1, 1, @EsCorrecto output, @MensajeError output
select 
@IdTurno IdTurno,
@EsCorrecto EsCorrecto, 
@MensajeError MensajeError

create procedure ABM_Pacientes
(
@Accion char (1),
@IdPaciente int output,
@Nombre_Paciente nvarchar (60),
@Apellido_Paciente nvarchar (60),
@DNI_Paciente int,
@IdCobertura int,
@Genero_Paciente nvarchar (60),
@Edad_Paciente int,
@Domicilio_Paciente nvarchar (100),
@Telefono_Paciente int,
@IdUsuario int,
@Activo bit,
@Fecha_Alta datetime,
@IdUsuarioLog int,
@EsCorrecto bit output,
@MensajeError nvarchar (1000) output
)
as
begin
if (@Accion='E')
begin
delete Pacientes
where IdPaciente = @IdPaciente
end

else if (@Accion='M')
begin
begin try
if (LEN (@Nombre_Paciente)>0 and LEN (@Apellido_Paciente)>0 and (@IdCobertura)>0)
begin
update Pacientes
set Nombre_Paciente = @Nombre_Paciente, Apellido_Paciente = @Apellido_Paciente , DNI_Paciente= @DNI_Paciente, 
IdCobertura=@IdCobertura, Genero_Paciente=@Genero_Paciente, Edad_Paciente=@Edad_Paciente, 
Domicilio_Paciente=@Domicilio_Paciente,Telefono_Paciente=@Telefono_Paciente, IdUsuario=@IdUsuario, 
Activo=@Activo, Fecha_Alta=@Fecha_Alta, IdUsuarioLog=@IdUsuarioLog
where IdPaciente = @IdPaciente
select @IdPaciente= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdPaciente=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Pacientes')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdPaciente=0
set @EsCorrecto=0
end catch
end
else if (@Accion='I')
begin
begin try
if (LEN (@Nombre_Paciente)>0 and LEN (@Apellido_Paciente)>0 and (@IdCobertura)>0)
begin

Insert into Pacientes (Nombre_Paciente, Apellido_Paciente, DNI_Paciente, IdCobertura, Genero_Paciente, 
Edad_Paciente,Domicilio_Paciente,Telefono_Paciente, IdUsuario, Activo, Fecha_Alta, IdUsuarioLog)
values (@Nombre_Paciente, @Apellido_Paciente , @DNI_Paciente, @IdCobertura, @Genero_Paciente, 
@Edad_Paciente,@Domicilio_Paciente,@Telefono_Paciente, @IdUsuario,@Activo, @Fecha_Alta, @IdUsuarioLog)
select @IdPaciente= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdPaciente=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Pacientes')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdPaciente=0
set @EsCorrecto=0
end catch
end
end



declare @IdPaciente int
declare @EsCorrecto bit
declare @MensajeError nvarchar (1000)
execute ABM_Pacientes'I',@IdPaciente output,'', 'D Aleo', 36948613, 2, 'Femenino',29,
'Cullen 5656', 1555236978,3,1,'2020-03-05',1,@EsCorrecto output, @MensajeError output
select 
@IdPaciente IdPaciente,
@EsCorrecto EsCorrecto, 
@MensajeError MensajeError




create procedure ABM_Medicos
(
@Accion char (1),
@IdMedico int output,
@Nombre_Medico nvarchar (60),
@Apellido_Medico nvarchar (60),
@DNI_Medico int,
@Especialidad nvarchar (60),
@Genero_Medico nvarchar (60),
@Edad_Medico int,
@Domicilio_Medico nvarchar (100),
@Telefono_Medico int,
@IdUsuario int,
@Fecha_Alta datetime,
@IdUsuarioLog int,
@MensajeError nvarchar (1000) output,
@EsCorrecto bit output


)
as
begin
if (@Accion='E')
begin
delete Medicos
where IdMedico = @IdMedico
end

else if (@Accion='M')
begin
begin try
if (LEN (@Nombre_Medico)>0 and LEN (@Especialidad)>0 )
begin
update Medicos
set Nombre_Medico = @Nombre_Medico, Apellido_Medico = @Apellido_Medico , DNI_Medico= @DNI_Medico, 
Especialidad=@Especialidad, Genero_Medico=@Genero_Medico, Edad_Medico=@Edad_Medico, Domicilio_Medico=@Domicilio_Medico,
Telefono_Medico=@Telefono_Medico, IdUsuario=@IdUsuario, Fecha_Alta=@Fecha_Alta, IdUsuarioLog=@IdUsuarioLog 
where IdMedico = @IdMedico
select @IdMedico=@@IDENTITY
set @EsCorrecto=1
set @MensajeError=''
end
else 
	begin 
		set @IdMedico=0
		set @EsCorrecto=0
		set @MensajeError=(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Medicos')
		end
end try
begin catch
	select @MensajeError=ERROR_MESSAGE()
	Set @IdMedico=0
	set @EsCorrecto=0
end catch
end
else if (@Accion='I')
begin
begin try
if (LEN (@Nombre_Medico)>0 and LEN (@Especialidad)>0 )
			begin
			Insert into Medicos(Nombre_Medico, Apellido_Medico, DNI_Medico, Especialidad, 
			Genero_Medico, Edad_Medico, Domicilio_Medico, Telefono_Medico, IdUsuario, Fecha_Alta, IdUsuarioLog )
			values (@Nombre_Medico, @Apellido_Medico, @DNI_Medico, @Especialidad, 
			@Genero_Medico, @Edad_Medico, @Domicilio_Medico, @Telefono_Medico, @IdUsuario, @Fecha_Alta, @IdUsuarioLog )
			select @IdMedico=@@IDENTITY
			set @EsCorrecto=1
			set @MensajeError=''
end
else 
	begin 
		set @IdMedico=0
		set @EsCorrecto=0
		set @MensajeError=(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Medicos')
end
end try
begin catch
	select @MensajeError=ERROR_MESSAGE()
	Set @IdMedico=0
	set @EsCorrecto=0
end catch
end
end

declare @IdMedico int
declare @EsCorrecto bit
declare @MensajeError nvarchar (1000)
execute ABM_Medicos 'M', 1, ' ', Jaurez, 34784917, 'Proctologia', 'Masculino', 35, 'sdssd33', 233333, 1, '2020-10-10', 1,
@MensajeError output,@EsCorrecto  output
select 
@IdMedico IdMedico,
@EsCorrecto EsCorrecto, 
@MensajeError MensajeError



create procedure ABM_Coberturas
(
@Accion char (1),
@IdCobertura int output,
@Nombre_Cobertura nvarchar (60),
@Activo bit,
@Fecha_Alta_Cobertura datetime,
@IdUsuarioLog int,
@EsCorrecto bit output,
@MensajeError nvarchar (1000) output
)
as
begin
if (@Accion='E')
begin
delete Coberturas
where IdCobertura = @IdCobertura
end

else if (@Accion='M')
begin
begin try
if (LEN(@Nombre_Cobertura)>0 )
begin
update Coberturas
set Nombre_Cobertura = @Nombre_Cobertura, Activo = @Activo , Fecha_Alta_Cobertura= @Fecha_Alta_Cobertura, 
IdUsuarioLog=@IdUsuarioLog 
where IdCobertura = @IdCobertura
select @IdCobertura= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdCobertura=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Coberturas')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdCobertura=0
set @EsCorrecto=0
end catch
end
else if (@Accion='I')
begin
begin try
if (LEN(@Nombre_Cobertura)>0 )
begin

Insert into Coberturas (Nombre_Cobertura, Activo , Fecha_Alta_Cobertura, IdUsuarioLog)
values (@Nombre_Cobertura, @Activo, @Fecha_Alta_Cobertura, @IdUsuarioLog )
select @IdCobertura= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdCobertura=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Coberturas')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdCobertura=0
set @EsCorrecto=0
end catch
end
end


declare @IdCobertura int
declare @EsCorrecto bit
declare @MensajeError nvarchar (1000)
execute ABM_Coberturas 'I',@IdCobertura output,'',1, '2000-05-23', 1, @EsCorrecto output, @MensajeError output
select 
@IdCobertura IdCobertura,
@EsCorrecto EsCorrecto, 
@MensajeError MensajeError

create procedure ABM_Menu
(
@Accion char (1),
@IdMenu int output,
@Descripcion_Menu nvarchar (60),
@Controlador nvarchar (60),
@Activo bit,
@EsCorrecto bit output,
@MensajeError nvarchar (1000) output
)
as
begin
if (@Accion='E')
begin
delete Menu
where IdMenu = @IdMenu
end

else if (@Accion='M')
begin
begin try
if (LEN(@Descripcion_Menu)>0 and LEN(@Descripcion_Menu)<60)
begin
update Menu
set Descripcion_Menu = @Descripcion_Menu, Controlador = @Controlador , Activo= @Activo
where IdMenu = @IdMenu
select @IdMenu= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdMenu=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Menu')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdMenu=0
set @EsCorrecto=0
end catch
end
else if (@Accion='I')
begin
begin try
if (LEN(@Descripcion_Menu)>0 and LEN(@Descripcion_Menu)<60)
begin

Insert into Menu (Descripcion_Menu , Controlador , Activo)
values (@Descripcion_Menu, @Controlador ,@Activo)
select @IdMenu= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdMenu=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Menu')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdMenu=0
set @EsCorrecto=0
end catch
end
end


declare @IdMenu int
declare @EsCorrecto bit
declare @MensajeError nvarchar (1000)
execute ABM_Menu 'I',@IdMenu output,'','menu',1, @EsCorrecto output, @MensajeError output
select 
@IdMenu IdMenu,
@EsCorrecto EsCorrecto, 
@MensajeError MensajeError



create procedure ABM_Menu_Permisos
(
@Accion char (1),
@IdMenu_Permiso int output ,
@IdPermiso int,
@IdMenu int ,
@EsCorrecto bit output,
@MensajeError nvarchar (1000) output
)
as
begin
if (@Accion='E')
begin
delete Menu_Permisos
where IdMenu_Permiso = @IdMenu_Permiso
end

else if (@Accion='M')
begin
begin try
if ((@IdPermiso)>0 and (@IdMenu)>0)
begin
update Menu_Permisos
set IdPermiso = @IdPermiso, IdMenu = @IdMenu 
where IdMenu_Permiso = @IdMenu_Permiso
select @IdMenu_Permiso= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdMenu_Permiso=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Menu_Permisos')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdMenu_Permiso=0
set @EsCorrecto=0
end catch
end
else if (@Accion='I')
begin
begin try
if ((@IdPermiso)>0 and (@IdMenu)>0)
begin

Insert into Menu_Permisos (IdPermiso, IdMenu )
values (@IdPermiso, @IdMenu )
select @IdMenu_Permiso= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdMenu_Permiso=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Menu_Permisos')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdMenu_Permiso=0
set @EsCorrecto=0
end catch
end
end


declare @IdMenu_Permiso int
declare @EsCorrecto bit
declare @MensajeError nvarchar (1000)
execute ABM_Menu_Permisos 'I',@IdMenu_Permiso output,0,0,@EsCorrecto output, @MensajeError output
select 
@IdMenu_Permiso IdMenu_Permiso,
@EsCorrecto EsCorrecto, 
@MensajeError MensajeError

create procedure ABM_Permisos
(
@Accion char (1),
@IdPermiso int output ,
@Descripcion nvarchar (60),
@EsCorrecto bit output,
@MensajeError nvarchar (1000) output
)
as
begin
if (@Accion='E')
begin
delete Permisos
where IdPermiso = @IdPermiso
end

else if (@Accion='M')
begin
begin try
if (LEN(@Descripcion)>0 and LEN(@Descripcion)<60)
begin
update Permisos
set Descripcion = @Descripcion
where IdPermiso = @IdPermiso
select @IdPermiso= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdPermiso=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Permisos')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdPermiso=0
set @EsCorrecto=0
end catch
end
else if (@Accion='I')
begin
begin try
if (LEN(@Descripcion)>0 and LEN(@Descripcion)<60)
begin

Insert into Permisos (Descripcion)
values (@Descripcion )
select @IdPermiso= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdPermiso=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Permisos')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdPermiso=0
set @EsCorrecto=0
end catch
end
end


declare @IdPermiso int
declare @EsCorrecto bit
declare @MensajeError nvarchar (1000)
execute ABM_Permisos 'I',@IdPermiso output,'', @EsCorrecto output, @MensajeError output
select 
@IdPermiso IdPermiso,
@EsCorrecto EsCorrecto, 
@MensajeError MensajeError


create procedure ABM_Usuarios
(
@Accion char (1),
@IdUsuario int output ,
@Descripcion_Usuario nvarchar (60),
@EsCorrecto bit output,
@MensajeError nvarchar (1000) output
)
as
begin
if (@Accion='E')
begin
delete Usuarios
where IdUsuario = @IdUsuario
end

else if (@Accion='M')
begin
begin try
if (LEN(@Descripcion_Usuario)>0 and LEN(@Descripcion_Usuario)<60)
begin
update Usuarios
set Descripcion_Usuario = @Descripcion_Usuario
where IdUsuario = @IdUsuario
select @IdUsuario= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdUsuario=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Usuarios')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdUsuario=0
set @EsCorrecto=0
end catch
end
else if (@Accion='I')
begin
begin try
if (LEN(@Descripcion_Usuario)>0 and LEN(@Descripcion_Usuario)<60)
begin

Insert into Usuarios(Descripcion_Usuario)
values (@Descripcion_Usuario )
select @IdUsuario= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdUsuario=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Usuarios')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdUsuario=0
set @EsCorrecto=0
end catch
end
end


declare @IdUsuario int
declare @EsCorrecto bit
declare @MensajeError nvarchar (1000)
execute ABM_Usuarios'I',@IdUsuario output,'', @EsCorrecto output, @MensajeError output
select 
@IdUsuario IdUsuario,
@EsCorrecto EsCorrecto, 
@MensajeError MensajeError


create procedure ABM_Usuarios_Permisos
(
@Accion char (1),
@IdUsuario_Permiso int output ,
@IdUsuario int,
@IdPermiso int,
@EsCorrecto bit output,
@MensajeError nvarchar (1000) output
)
as
begin
if (@Accion='E')
begin
delete Usuarios_Permisos
where IdUsuario_Permiso = @IdUsuario_Permiso
end

else if (@Accion='M')
begin
begin try
if ((@IdUsuario)>0 and(@IdPermiso)>0)
begin
update Usuarios_Permisos
set IdUsuario = @IdUsuario, IdPermiso=@IdPermiso
where IdUsuario_Permiso = @IdUsuario_Permiso
select @IdUsuario_Permiso= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdUsuario_Permiso=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Usuarios_Permisos')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdUsuario_Permiso=0
set @EsCorrecto=0
end catch
end
else if (@Accion='I')
begin
begin try
if ((@IdUsuario)>0 and(@IdPermiso)>0)
begin

Insert into Usuarios_Permisos(IdUsuario, IdPermiso)
values (@IdUsuario, @IdPermiso )
select @IdUsuario_Permiso= @@IDENTITY
set @EsCorrecto=1
set @MensajeError =' '
end
else
begin
set @IdUsuario_Permiso=0
set @EsCorrecto=0
set @MensajeError =(select Descripcion_Error from Errores_Control where NombreObjeto = 'ABM_Usuarios_Permisos')
end
end try
begin catch
select @MensajeError = ERROR_MESSAGE()
set @IdUsuario_Permiso=0
set @EsCorrecto=0
end catch
end
end


declare @IdUsuario_Permiso int
declare @EsCorrecto bit
declare @MensajeError nvarchar (1000)
execute ABM_Usuarios_Permisos 'I',@IdUsuario_Permiso output,0,1 ,@EsCorrecto output, @MensajeError output
select 
@IdUsuario_Permiso IdUsuario_Permiso,
@EsCorrecto EsCorrecto, 
@MensajeError MensajeError



















