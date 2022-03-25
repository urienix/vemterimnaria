/*
    Codificado por: Urienix
    SQL Oracle 11g XE
*/

/* Creando un usuario (Debe ejecutarse desde usuario SYS, usuario adminitrador)
create user cheems identified by Amsiedad;
grant connect to cheems;
grant dba to cheems;
*/

/*
Notas:
    - Cada tabla que contenga un ID debe hacer uso de una secuencia para la incersion
        de la información de registros, esto para simular un AUTO_INCREMENT

    - Cada tabla que contenga ID debe tener un trigger que permita la incersion del
        ID de la secuencia que le pertenece
*/

/* ####################### CREACION DE TABLAS, SECUENCIAS Y TRIGGERS DE AUTO INCREMENT   ######################################## */

/* #################### CONTROLES ########################### */
/* Tabla de usuarios */
CREATE TABLE Usuarios(
    id_usuario number not null,
    usuario VARCHAR2(20) not null,
    nombre_completo VARCHAR2(50) not null,
    telefono VARCHAR2(10),
    direccion_residencia VARCHAR2(80),
    contrasena VARCHAR2(60) not null,
    primary key(id_usuario)
);

CREATE SEQUENCE idusuarios_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

CREATE OR REPLACE TRIGGER idusuarios_trg
    BEFORE INSERT ON Usuarios
    FOR EACH ROW
    BEGIN
        SELECT idusuarios_seq.nextval
        INTO :new.id_usuario
        FROM dual;
    END;


/* Tabla de auditoria */

CREATE TABLE Auditoria(
    id_auditoria number not null,
    tabla_objetivo VARCHAR2(45),
    fecha_ejecucion DATE,
    usuario_ejecutor VARCHAR2(20),
    tipo_transaccion VARCHAR2(15),
    descripcion VARCHAR2(45),
    primary key(id_auditoria)
);
/

CREATE SEQUENCE idauditoria_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;
/

CREATE OR REPLACE TRIGGER idauditoria_trg
    BEFORE INSERT ON Auditoria
    FOR EACH ROW
    BEGIN
        SELECT idauditoria_seq.nextval
        INTO :new.id_auditoria
        FROM dual;
    END;
/

/* #################### TABLAS DE LA BASE DE DATOS ########################### */

/* Tabla Cirugias */

CREATE TABLE Cirugias(
    id_cirugia number not null,
    duracion_estimada_minutos number(3, 0),
    descripcion VARCHAR2(100),
    riesgo varchar2(5),
    nombre varchar2(45),
    necesita_anestesia_general char(1) check (necesita_anestesia_general in (0,1)),
    primary key(id_cirugia)
);

CREATE SEQUENCE idcirugia_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

CREATE OR REPLACE TRIGGER idcirugia_trg
    BEFORE INSERT ON Cirugias
    FOR EACH ROW
    BEGIN
        SELECT idcirugia_seq.nextval
        INTO :new.id_cirugia
        FROM dual;
    END;


/* Tabla Especies */

CREATE TABLE Especies(
    id_especie number not null,
    nombre varchar2(30),
    familia varchar2(40),
    primary key(id_especie)
);

CREATE SEQUENCE idespecie_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

CREATE OR REPLACE TRIGGER idespecie_trg
    BEFORE INSERT ON Especies
    FOR EACH ROW
    BEGIN
        SELECT idespecie_seq.nextval
        INTO :new.id_especie
        FROM dual;
    END;


/* Tabla Medicamentos */

CREATE TABLE Medicamentos(
    id_medicamento number not null,
    nombre varchar2(45),
    cantidad_dosis number(3, 0),
    medida_dosis varchar2(15),
    periodo_dosis_horas number(2, 0),
    primary key(id_medicamento)
);

CREATE SEQUENCE idmedicamento_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

CREATE OR REPLACE TRIGGER idmedicamento_trg
    BEFORE INSERT ON Medicamentos
    FOR EACH ROW
    BEGIN
        SELECT idmedicamento_seq.nextval
        INTO :new.id_medicamento
        FROM dual;
    END;


/* Tabla Enfermedades */

CREATE TABLE Enfermedades(
    id_enfermedad number not null,
    nombre varchar2(40),
    primary key(id_enfermedad)
);

CREATE SEQUENCE idenfermedad_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

CREATE OR REPLACE TRIGGER idenfermedad_trg
    BEFORE INSERT ON Enfermedades
    FOR EACH ROW
    BEGIN
        SELECT idenfermedad_seq.nextval
        INTO :new.id_enfermedad
        FROM dual;
    END;


/* Tabla Especies */

CREATE TABLE Razas(
    id_raza number not null,
    nombre varchar2(40),
    id_especie number,
    longevidad_estimada number(3, 0),
    constraint pk_id_raza
    primary key(id_raza),
    constraint fk_id_especie
    foreign key(id_especie) references Especies(id_especie)
);

CREATE SEQUENCE idrazas_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

CREATE OR REPLACE TRIGGER idrazas_trg
    BEFORE INSERT ON Razas
    FOR EACH ROW
    BEGIN
        SELECT idrazas_seq.nextval
        INTO :new.id_raza
        FROM dual;
    END;


/* Tabla Duenos */

CREATE TABLE Duenos(
    id_dueno number not null,
    nombre_completo varchar2(80),
    identificacion varchar2(15),
    direccion_residencia varchar2(80),
    telefono_residencia varchar2(10),
    primary key(id_dueno)
);

CREATE SEQUENCE idduenos_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

CREATE OR REPLACE TRIGGER idduenos_trg
    BEFORE INSERT ON Duenos
    FOR EACH ROW
    BEGIN
        SELECT idduenos_seq.nextval
        INTO :new.id_dueno
        FROM dual;
    END;


CREATE TABLE Telefonos_dueno(
    id_dueno number not null,
    telefono varchar2(10) not null,
    constraint pk_id_dueno
    primary key(id_dueno, telefono),
    constraint fk_id_dueno_telefono
    foreign key(id_dueno) references Duenos(id_dueno)
);

/* Tabla Medicos */

CREATE TABLE Medicos(
    id_medico number not null,
    nombre_completo varchar2(80),
    telefono_residencia varchar2(10),
    identificacion varchar2(15),
    direccion_residencia varchar2(80),
    atiende_emergencias char(1) check (atiende_emergencias in (0,1)),
    fecha_ingreso date,
    primary key(id_medico)
);

CREATE SEQUENCE idmedicos_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

CREATE OR REPLACE TRIGGER idmedicos_trg
    BEFORE INSERT ON Medicos
    FOR EACH ROW
    BEGIN
        SELECT idmedicos_seq.nextval
        INTO :new.id_medico
        FROM dual;
    END;


CREATE TABLE Telefonos_medico(
    id_medico number not null,
    telefono varchar2(10) not null,
    constraint pk_id_medico
    primary key(id_medico, telefono),
    constraint fk_id_medico
    foreign key(id_medico) references Medicos(id_medico)
);


/* Tabla Turnos */
CREATE TABLE Turnos(
    id_turno number not null,
    hora_inicio DATE,
    hora_final DATE,
    nombre varchar2(15),
    primary key(id_turno)
);

CREATE SEQUENCE idturnos_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

CREATE OR REPLACE TRIGGER idturnos_trg
    BEFORE INSERT ON Turnos
    FOR EACH ROW
    BEGIN
        SELECT idturnos_seq.nextval
        INTO :new.id_turno
        FROM dual;
    END;


/* Tabla Pacientes */

CREATE TABLE Paciente(
    id_paciente number not null,
    nombre varchar2(45),
    id_raza number not null,
    id_dueno number not null,
    id_medico_cabecera number,
    url_foto varchar2(80),
    fecha_primera_cita date,
    constraint pk_id_paciente
    primary key(id_paciente),
    constraint fk_id_raza
    foreign key(id_raza) references Razas(id_raza),
    constraint fk_id_dueno
    foreign key(id_dueno) references Duenos(id_dueno),
    constraint fk_id_medico_cabecera
    foreign key(id_medico_cabecera) references Medicos(id_medico)
);

CREATE SEQUENCE idpaciente_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

CREATE OR REPLACE TRIGGER idpaciente_trg
    BEFORE INSERT ON Paciente
    FOR EACH ROW
    BEGIN
        SELECT idpaciente_seq.nextval
        INTO :new.id_paciente
        FROM dual;
    END;


/* Tabla Citas */

CREATE TABLE Citas(
    id_cita number not null,
    fecha DATE,
    id_paciente number not null,
    descripcion varchar2(120),
    id_cirugia number,
    id_medico number,
    fecha_programacion date,
    constraint pk_id_cita
    primary key(id_cita),
    constraint fk_id_paciente
    foreign key(id_paciente) references Paciente(id_paciente),
    constraint fk_id_cirugia
    foreign key(id_cirugia) references Cirugias(id_cirugia),
    constraint fk_id_medico_cita
    foreign key(id_medico) references Medicos(id_medico)
);

CREATE SEQUENCE idcita_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

CREATE OR REPLACE TRIGGER idcita_trg
    BEFORE INSERT ON Citas
    FOR EACH ROW
    BEGIN
        SELECT idcita_seq.nextval
        INTO :new.id_cita
        FROM dual;
    END;



/* ################## RELACIONES DE MUCHOS A MUCHOS ################## */

/* Enfermedad por raza */
CREATE TABLE Enfermedad_raza(
    id_enfermedad number not null,
    id_raza number not null,
    constraint pk_id_enfermedad_raza
    primary key(id_enfermedad, id_raza),
    constraint fk_id_enfermedad_raza
    foreign key(id_enfermedad) references Enfermedades(id_enfermedad),
    constraint fk_id_raza_enfermedad
    foreign key(id_raza) references Razas(id_raza)
);

/* Enfermedad por medicamento */
CREATE TABLE Enfermedades_medicamentos(
    id_enfermedad number not null,
    id_medicamento number not null,
    constraint pk_id_enfermedad_medicamento
    primary key(id_enfermedad, id_medicamento),
    constraint fk_id_enfermedad_medicamento
    foreign key(id_enfermedad) references Enfermedades(id_enfermedad),
    constraint fk_id_medicamento_enfermedad
    foreign key(id_medicamento) references Medicamentos(id_medicamento)
);

/* Turnos por medico */
CREATE TABLE Turnos_medicos(
    id_medico number not null,
    id_turno number not null,
    fecha Date,
    constraint pk_id_turno_medico
    primary key(id_medico, id_turno),
    constraint fk_id_medico_turno
    foreign key(id_medico) references Medicos(id_medico),
    constraint fk_id_turno_turno
    foreign key(id_turno) references Turnos(id_turno)
);