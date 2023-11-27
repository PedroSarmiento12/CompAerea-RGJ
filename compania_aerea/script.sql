CREATE DATABASE IF NOT EXISTS compañia_aerea_rgj;
use compañia_aerea_rgj;

create table T_Categoria
(
Codigo tinyint NOT NULL PRIMARY KEY,
Nombre varchar (25) NOT NULL
);

create table T_Personal
(
Id tinyint NOT NULL PRIMARY KEY, 
Nombre varchar (25) NOT NULL,
Apellido1 varchar (25) NOT NULL, 
Apellido2 varchar (25),
CodigoCat tinyint NOT NULL, 
constraint FK_Personal_Categoria
  FOREIGN KEY (CodigoCat) REFERENCES T_Categoria(Codigo)
  );
  
create table T_Telefono_Personal
(
IdPersonal tinyint NOT NULL,
Telefono char(9) NOT NULL,
PRIMARY KEY (IdPersonal,Telefono),
constraint FK_TelefonoP_Personal
  FOREIGN KEY (IdPersonal) REFERENCES T_Personal(Id)
  );

create table T_Avion 
(
Matricula varchar(25) NOT NULL PRIMARY KEY, 
Fabricante varchar (50) NOT NULL, 
Modelo (25) NOT NULL, 
Capacidad tinyint NOT NULL, 
Autonomia varchar (20) NOT NULL
); 
  
create table T_Vuelo
(
Id tinyint NOT NULL PRIMARY KEY, 
Origen varchar (25) NOT NULL,
Destino varchar (25) NOT NULL, 
Fecha date NOT NULL, 
MatriculaAvion varchar (20) NOT NULL, 
constraint FK_Vuelo_Avion
  FOREIGN KEY(MatriculaAvion) REFERENCES T_Avion(Matricula)
  );
  
create table T_Puesto
(
IdTrabajador tinyint NOT NULL, 
IdVuelo tinyint NOT NULL,
PRIMARY KEY (IdTrabajador,IdVuelo),
constraint FK_Puesto_Personal
  FOREIGN KEY(IdTrabajador) REFERENCES T_Personal(Id),
constraint FK_Puesto_Vuelo 
  FOREIGN KEY(IdVuelo) REFERENCES T_Vuelo(Id)
); 

create table T_Pasajero 
(
DNI char(9) NOT NULL PRIMARY KEY,
Nombre varchar(25) NOT NULL,
Apellidos varchar (25) NOT NULL, 
Email varchar(50) NOT NULL
);

create table T_Distribucion
(
DNIPasajero char(9) NOT NULL, 
IdVuelo tinyint NOT NULL,
Asiento tinyint NOT NULL,
Clase varchar(25) NOT NULL, 
PRIMARY KEY(DNIPasajero,IdVuelo),
constraint FK_Distribucion_Pasajero
  FOREIGN KEY(DNIPasajero) REFERENCES T_Pasajero(DNI),
constraint FK_Distribucion_Vuelo
  FOREIGN KEY(IdVuelo) REFERENCES T_Vuelo(Id)
);

create table T_Telefono_Pasajero
(
DNIPasajero char(9) NOT NULL, 
Telefono char (9) NOT NULL,
PRIMARY KEY (DNIPasajero,Telefono),
constraint FK_TelefonoPas_Pasajero
  FOREIGN KEY(DNIPasajero) REFERENCES T_Pasajero(DNI)
  );
-------------------------------------------------
ALTER DATABASE compañia_aerea_rgj CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

ALTER TABLE T_Avion MODIFY Capacidad INT UNSIGNED CHECK(Capacidad<=450);

ALTER TABLE T_Avion MODIFY Autonomia TINYINT UNSIGNED NULL CHECK(Autonomia<48);

ALTER TABLE T_Distribucion MODIFY Asiento TINYINT CHECK(Asiento>0); 

ALTER TABLE T_Distribucion
DROP PRIMARY KEY,
ADD COLUMN IdClase INT NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (DNIPasajero,IdVuelo,IdClase);

ALTER TABLE T_Distribucion ADD COLUMN IdClase INT AUTO_INCREMENT;

ALTER TABLE T_Avion RENAME T_Aeroplano;
  
 
