Create Database Consultorio


--La aplicacion que elegi, es una aplicacion para utilizar en un Consultorio para la asignacion de turnos.

--Esta tabla se crea con el fin de tener coberturas medicas (mediante las cuales los pacientes pagan la consulta), 
--se le crea el IdCobertura, el nombre de la misma, si esta o no activa (ya que puede darse que ya no tengan 
--convenio con una cobertura que antes si tenian) y la fecha de alta.

create table Coberturas
(IdCobertura int identity not null,
Nombre_Cobertura nvarchar (60) not null,
Activo bit not null,
Fecha_Alta_Cobertura datetime not null
Primary key (IdCobertura)
)




--La tabla Usuarios se crea con el fin de brindar un tipo de usuario a los medicos, pacientes y a la administrativa 
--que los gestiona).Habra tres tipos de Usuarios, los del tipo Medico, Tipo paciente y administrativo.
--Se crea tambien pensando, en que posteriormente esta aplicacion pueda vincularse con una pagina web para que los 
--mismos pacientes puedan sacar los turnos.

create table Usuarios
(IdUsuario int identity not null,
Descripcion_Usuario nvarchar (60) not null
Primary key (IdUsuario)
)
alter table Pacientes add IdUsuarioLog int
alter table Turnos add IdUsuarioLog int
alter table Medicos add IdUsuarioLog int
alter table Coberturas add IdUsuarioLog int





--La tabla pacientes se crea con el fin de almacenar los datos de cada paciente que va a atenderse a dicho centro medico.
--Tendra los campos con datos personales, si esta o no activo(normalmente estan activos, pero dado el caso que se de debaja 
--una cobertura,Pasara a estar inactivo, o si en el momento de abonar la cobertura saliera rechazada),
--un Id cobertura, ya que cada Paciente tendra una unica cobertura.
--Un IdUusuario, que normalmente sera el 3, ya que ese es el tipo usuario de los paciente, a menos que alguna de las 
--administrativas tambien sean paciente del centro,en cuyo caso tendrian el Usuario 2. Por ultimo la fecha del primer 
--ingreso del paciente.

create table Pacientes
(IdPaciente int identity not null,
Nombre_Paciente nvarchar (60) not null,
Apellido_Paciente nvarchar (60) not null,
DNI_Paciente int not null,
IdCobertura int not null,
Genero_Paciente nvarchar (60) not null,
Edad_Paciente int not null,
Domicilio_Paciente nvarchar (100) not null,
Telefono_Paciente int not null,
IdUsuario int not null,
Activo bit not null,
Fecha_Alta datetime not null
Primary key (IdPaciente),
Foreign key (IdCobertura) references Coberturas (IdCobertura),
Foreign key (IdUsuario) references Usuarios (IdUsuario)
)



--Esta tabla se crea con el fin de llevar un registro de los medicos, y poder vincularlos a los turnos y pacientes.
--Tendran como campos los datos personales del medico, la especialidad a la que se dedica, el Id Usuario y la fecha 
--desde la cual atiende en el consultorio.

create table Medicos
(IdMedico int identity not null,
Nombre_Medico nvarchar (60) not null,
Apellido_Medico nvarchar (60) not null,
DNI_Medico int not null,
Especialidad nvarchar (60) not null,
Genero_Medico nvarchar (60) not null,
Edad_Medico int not null,
Domicilio_Medico nvarchar (100) not null,
Telefono_Medico int not null,
IdUsuario int not null,
Fecha_Alta datetime not null
Primary key (IdMedico),
Foreign key (IdUsuario) references Usuarios (IdUsuario)
)


--Esta tabla se crea para el almacenamiento y control de los turnos, tendra una fecha con horario determinado, 
--vinculara un unico paciente y un unico medico por turno.

create table Turnos
(IdTurno int identity not null,
Fecha_Hora datetime not null,
IdPaciente int not null,
IdMedico int not null
Primary key (IdTurno),
Foreign key (IdPaciente) references Pacientes (IdPaciente),
Foreign key (IdMedico) references Medicos (IdMedico)
)


--Esta tabla se crea con el fin de conocer cuales son los tipos de persimos, en este caso son solo tres. 
--PERMISO MEDICO, ADMINISTRATIVO Y PACIENTE. 

create table Permisos
(IdPermiso int identity not null,
Descripcion  nvarchar (60) not null,
Primary key (IdPermiso)
)


--En esta tabla se vinculan los IdUsuario con los IdPermiso
--Sabiendo asi que tipo de permiso tiene cada uno de los tipos de usuarios que existen.

create table Usuarios_Permisos
(IdUsuario_Permiso int identity not null,
IdUsuario int not null,
IdPermiso int not null,
Primary key (IdUsuario_Permiso),
Foreign key (IdUsuario) references Usuarios (IdUsuario),
Foreign key (IdPermiso) references Permisos (IdPermiso)
)



--Esta tabla se crea con el fin de aclarar que acciones pueden realizar los distintos Usuarios, y 
--si esas acciones se encuentran o no activas

create table Menu
(IdMenu int identity not null,
Descripcion_Menu nvarchar (60) not null,
Controlador nvarchar (60) not null,
Activo bit not null,
Primary key (IdMenu)
)


--Esta tabla se crea para vincular los Permisos con los menus disponibles, 
--y que en consecuencia se registre que acciones tiene permitidas segun el permiso asignado a los usuarios

create table Menu_Permisos
(IdMenu_Permiso int identity not null,
IdPermiso int not null,
IdMenu int not null,
Primary key (IdMenu_Permiso),
Foreign key (IdMenu) references Menu (IdMenu),
Foreign key (IdPermiso) references Permisos (IdPermiso)
)



--Esta tabla se crea con el objetivo de registrar todas las operaciones de ABM de Medicos, Pacientes y Turnos. 
--Para esto fue necesario asignar un IdUsuarioLog en cada tabla a auditar.

create table Auditoria_General
(IdAuditoria_General int identity not null,
IdUsuario int not null,
Accion nvarchar (max) not null,
Tabla nvarchar (300) not null,
Fecha datetime not null,
IdObjeto int not null,
Objeto nvarchar (max) not null,
Primary key (IdAuditoria_General),
Foreign key (IdUsuario) references Usuarios (IdUsuario)
)


--La tabla de Errores_Control, por ultimo, se crea con el objetivo de almacenar los mensajes de error ante los posibles
--errores que puedan o no generarse en in insert, modificacion y eliminacion de las distintas tablas.

create table Errores_Control
(
NombreObjeto nvarchar (100),
Descripcion_Error nvarchar (500)
)