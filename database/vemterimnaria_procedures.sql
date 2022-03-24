/*
NOTA: PARA EL SISTEMITA SE HA DECIDIDO QUE UN PROCEDIMIENTO ALMACENADO
SOLO EJECUTE 1 PROCESO, POR LO QUE LAS EXCEPCIONES SERÁN MANEJADAS DESDE EL BACKEND
DEL APLICATIVO.

DE ESTA MANERA AHORRAMOS EL ROLLBACK QUE SE EJECUTARÍA SI UNO DE LOS PROCESOS
LLEGARA A FALLAR
*/

CREATE OR REPLACE PROCEDURE insertar_usuario(
    usuario in VARCHAR2,
    nombre_completo in VARCHAR2,
    telefono in varchar2,
    direccion_residencia in varchar2,
    contrasena in VARCHAR2,
    nuevo_usuario_id out NUMBER
)
AS
BEGIN
    INSERT INTO Usuarios(usuario, nombre_completo, telefono, direccion_residencia, contrasena)
    VALUES(usuario, nombre_completo, telefono, direccion_residencia, contrasena)
    RETURNING id_usuario INTO nuevo_usuario_id;
    COMMIT;
END;
/

/* ################# PROCEDIMIENTOS DE CIRUGIAS ########### */
CREATE OR REPLACE PROCEDURE insertar_cirugia(
    vduracion_estimada_minutos in number,
    vdescripcion in VARCHAR2,
    vriesgo in VARCHAR2,
    vnombre in VARCHAR2,
    vnecesita_anestesia_general in char
)
AS
BEGIN
    INSERT INTO CIRUGIAS(duracion_estimada_minutos, descripcion, riesgo, nombre, necesita_anestesia_general) values (vduracion_estimada_minutos, vdescripcion, vriesgo, vnombre, vnecesita_anestesia_general);
    COMMIT;
END;
/


CREATE OR REPLACE PROCEDURE actualizar_cirugia(
    vid_cirugia in number,
    vduracion_estimada_minutos in number,
    vdescripcion in VARCHAR2,
    vriesgo in VARCHAR2,
    vnombre in VARCHAR2,
    vnecesita_anestesia_general in char
)
AS
BEGIN
    UPDATE CIRUGIAS SET duracion_estimada_minutos = vduracion_estimada_minutos, descripcion = vdescripcion, riesgo = vriesgo, nombre = vnombre, necesita_anestesia_general = vnecesita_anestesia_general WHERE id_cirugia = vid_cirugia;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_cirugia(
    vid_cirugia in number
)
AS
BEGIN
    DELETE FROM CIRUGIAS WHERE id_cirugia = vid_cirugia;
    COMMIT;
END;
/
/*
select * from Cirugias;
EXECUTE insertar_cirugia(8, 'descripcion', 'medio', 'nombre', 1);
EXECUTE eliminar_cirugia(1);
EXECUTE actualizar_cirugia(2, 10, 'descripcion', 'bajo', 'nombre', 0);
*/


/* ################# PROCEDIMIENTOS DE MEDICAMENTOS ########### */
CREATE OR REPLACE PROCEDURE insertar_medicamento(
    vnombre in VARCHAR2,
    vcantidad_dosis in number,
    medida_dosis in VARCHAR2,
    periodo_dosis_horas number
)
AS
BEGIN
    INSERT INTO MEDICAMENTOS(nombre, cantidad_dosis, medida_dosis, periodo_dosis_horas) values (vnombre, vcantidad_dosis, medida_dosis, periodo_dosis_horas);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE actualizar_medicamento(
    vid_medicamento in number,
    vnombre in VARCHAR2,
    vcantidad_dosis in number,
    medida_dosis in VARCHAR2,
    periodo_dosis_horas number
)
AS
BEGIN
    UPDATE MEDICAMENTOS SET nombre = vnombre, cantidad_dosis = vcantidad_dosis, medida_dosis = medida_dosis, periodo_dosis_horas = periodo_dosis_horas WHERE id_medicamento = vid_medicamento;
    COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE eliminar_medicamento(
    vid_medicamento in number
)
AS
BEGIN
    DELETE FROM MEDICAMENTOS WHERE id_medicamento = vid_medicamento;
    COMMIT;
END;
/

/*
select * from Medicamentos;
EXECUTE insertar_medicamento('nombre', 1, 'mg', 10);
EXECUTE eliminar_medicamento(1);
EXECUTE actualizar_medicamento(2, 'nombre', 2, 'ml', 2);
*/

/* ################# PROCEDIMIENTOS DE ESPECIES ########## */

CREATE OR REPLACE PROCEDURE insertar_especie(
    vnombre in VARCHAR2,
    vfamilia in VARCHAR2
)
AS
BEGIN
    INSERT INTO ESPECIES(nombre, familia) values (vnombre, vfamilia);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE actualizar_especie(
    vid_especie in number,
    vnombre in VARCHAR2,
    vfamilia in VARCHAR2
)
AS
BEGIN
    UPDATE ESPECIES SET nombre = vnombre, familia = vfamilia WHERE id_especie = vid_especie;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_especie(
    vid_especie in number
)
AS
BEGIN
    DELETE FROM ESPECIES WHERE id_especie = vid_especie;
    COMMIT;
END;
/


/*
select * from Especies;
EXECUTE insertar_especie('Gato', 'Felino');
EXECUTE eliminar_especie(1);
EXECUTE actualizar_especie(2, 'Perro', 'Canino');
*/


/* ################# PROCEDIMIENTOS DE RAZAS ########### */

CREATE OR REPLACE PROCEDURE insertar_raza(
    vnombre in VARCHAR2,
    vid_especie in number,
    vlongevidad_estimada in number
)
AS
BEGIN
    INSERT INTO RAZAS(nombre, id_especie, longevidad_estimada) values (vnombre, vid_especie, vlongevidad_estimada);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE actualizar_raza(
    vid_raza in number,
    vnombre in VARCHAR2,
    vid_especie in number,
    vlongevidad_estimada in number
)
AS
BEGIN
    UPDATE RAZAS SET nombre = vnombre, id_especie = vid_especie, longevidad_estimada = vlongevidad_estimada WHERE id_raza = vid_raza;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_raza(
    vid_raza in number
)
AS
BEGIN
    DELETE FROM RAZAS WHERE id_raza = vid_raza;
    COMMIT;
END;
/


/*
select * from Razas;
EXECUTE insertar_raza('Angora', 1, 10);
EXECUTE eliminar_raza(1);
EXECUTE actualizar_raza(2, 'Pug', 2, 20);
*/


/* ################# PROCEDIMIENTOS DE DUENOS ########### */
CREATE OR REPLACE PROCEDURE insertar_dueno(
    vnombre_completo in VARCHAR2,
    videntificacion in VARCHAR2,
    vdireccion_residencia in VARCHAR2,
    vtelefono_residencia in VARCHAR2,
    vnuevo_dueno_id out NUMBER
)
AS
BEGIN
    INSERT INTO DUENOS(nombre_completo, identificacion, direccion_residencia, telefono_residencia) values (vnombre_completo, videntificacion, vdireccion_residencia, vtelefono_residencia)
    RETURNING id_dueno INTO vnuevo_dueno_id;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE actualizar_dueno(
    vid_dueno in number,
    vnombre_completo in VARCHAR2,
    videntificacion in VARCHAR2,
    vdireccion_residencia in VARCHAR2,
    vtelefono_residencia in VARCHAR2
)
AS
BEGIN
    UPDATE DUENOS SET nombre_completo = vnombre_completo, identificacion = videntificacion, direccion_residencia = vdireccion_residencia, telefono_residencia = vtelefono_residencia WHERE id_dueno = vid_dueno;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_dueno(
    vid_dueno in number
)
AS
BEGIN
    DELETE FROM TELEFONOS_DUENO WHERE id_dueno = vid_dueno;
    DELETE FROM DUENOS WHERE id_dueno = vid_dueno;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_telefono_dueno(
    vid_dueno in number
)
AS
BEGIN
    DELETE FROM TELEFONOS_DUENO WHERE id_dueno = vid_dueno;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE agregar_telefono_dueno(
    vid_dueno in number,
    vtelefono in VARCHAR2
)
AS
BEGIN
    INSERT INTO TELEFONOS_DUENO(id_dueno, telefono) values (vid_dueno, vtelefono);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_telefono_dueno(
    vid_dueno in number,
    vtelefono in VARCHAR2
)
AS
BEGIN
    DELETE FROM TELEFONOS_DUENO WHERE id_dueno = vid_dueno AND telefono = vtelefono;
END;

/*
select * from Duenos;
EXECUTE insertar_dueno('Juan Perez', '12345678', 'Calle 123', '12345678');
EXECUTE eliminar_dueno(1);
EXECUTE actualizar_dueno(2, 'Juan Perez', '12345678', 'Calle 123', '12345678');
*/


/* ################# PROCEDIMIENTOS DE MEDICOS ########### */
CREATE OR REPLACE PROCEDURE insertar_medico(
    vnombre_completo in VARCHAR2,
    vtelefono_residencia in VARCHAR2,
    videntificacion in VARCHAR2,
    vdireccion_residencia in VARCHAR2,
    vatiende_emergencias in char
)
AS
BEGIN
    INSERT INTO MEDICOS(nombre_completo, telefono_residencia, identificacion, direccion_residencia, atiende_emergencias, fecha_ingreso) values (vnombre_completo, vtelefono_residencia, videntificacion, vdireccion_residencia, vatiende_emergencias, SYSDATE);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE actualizar_medico(
    vid_medico in number,
    vnombre_completo in VARCHAR2,
    vtelefono_residencia in VARCHAR2,
    identificacion in VARCHAR2,
    vdireccion_residencia in VARCHAR2,
    vatiende_emergencias in char
)
AS
BEGIN
    UPDATE MEDICOS SET nombre_completo = vnombre_completo, telefono_residencia = vtelefono_residencia, identificacion = identificacion, direccion_residencia = vdireccion_residencia, atiende_emergencias = vatiende_emergencias WHERE id_medico = vid_medico;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_medico(
    vid_medico in number
)
AS
BEGIN
    DELETE FROM MEDICOS WHERE id_medico = vid_medico;
    COMMIT;
END;
/


/* ################# PROCEDIMIENTOS DE PACIENTES ########### */
CREATE OR REPLACE PROCEDURE insertar_paciente(
    vnombre in varchar2,
    vid_raza in number,
    vid_dueno in number
)
AS
BEGIN
    INSERT INTO PACIENTE(nombre, id_raza, id_dueno, fecha_primera_cita) values (vnombre, vid_raza, vid_dueno, SYSDATE);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE actualizar_paciente(
    vid_paciente in number,
    vnombre in varchar2,
    vid_raza in number,
    vid_dueno in number
)
AS
BEGIN
    UPDATE PACIENTE SET nombre = vnombre, id_raza = vid_raza, id_dueno = vid_dueno WHERE id_paciente = vid_paciente;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_paciente(
    vid_paciente in number
)
AS
BEGIN
    DELETE FROM PACIENTE WHERE id_paciente = vid_paciente;
    COMMIT;
END;
/


/* ################# PROCEDIMIENTOS DE CITAS ########### */
CREATE OR REPLACE PROCEDURE ingresar_cita(
    vfecha in date,
    vid_paciente in number,
    vdescripcion in varchar2,
    vid_cirugia in number,
    vid_medico in number,
    vfecha_programacion in date
)
AS
BEGIN
    INSERT INTO CITAS(fecha, id_paciente, descripcion, id_cirugia, id_medico, fecha_programacion) values (vfecha, vid_paciente, vdescripcion, vid_cirugia, vid_medico, vfecha_programacion);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE actualizar_cita(
    vid_cita in number,
    vfecha in date,
    vid_paciente in number,
    vdescripcion in varchar2,
    vid_cirugia in number,
    vid_medico in number,
    vfecha_programacion in date
)
AS
BEGIN
    UPDATE CITAS SET fecha = vfecha, id_paciente = vid_paciente, descripcion = vdescripcion, id_cirugia = vid_cirugia, id_medico = vid_medico, fecha_programacion = vfecha_programacion WHERE id_cita = vid_cita;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_cita(
    vid_cita in number
)
AS
BEGIN
    DELETE FROM CITAS WHERE id_cita = vid_cita;
    COMMIT;
END;
/

