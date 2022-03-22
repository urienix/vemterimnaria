/*
NOTA: PARA EL SISTEMITA SE HA DECIDIDO QUE UN PROCEDIMIENTO ALMACENADO
SOLO EJECUTE 1 PROCESO, POR LO QUE LAS EXCEPCIONES SERÁN MANEJADAS DESDE EL BACKEND
DEL APLICATIVO.

DE ESTA MANERA AHORRAMOS EL ROLLBACK QUE SE EJECUTARÍA SI UNO DE LOS PROCESOS
LLEGARA A FALLAR
*/


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
    vtelefono_residencia in VARCHAR2
)
AS
BEGIN
    INSERT INTO DUENOS(nombre_completo, identificacion, direccion_residencia, telefono_residencia) values (vnombre_completo, videntificacion, vdireccion_residencia, vtelefono_residencia);
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
    DELETE FROM DUENOS WHERE id_dueno = vid_dueno;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE agregar_telefono_dueno(
    vid_dueno in number,
    vtelefono in VARCHAR2
)
AS
BEGIN
    INSERT INTO TELEFONOS_DUENOS(id_dueno, telefono) values (vid_dueno, vtelefono);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_telefono_dueno(
    vid_dueno in number,
    vtelefono in VARCHAR2
)
AS
BEGIN
    DELETE FROM TELEFONOS_DUENOS WHERE id_dueno = vid_dueno AND telefono = vtelefono;
END;

/*
select * from Duenos;
EXECUTE insertar_dueno('Juan Perez', '12345678', 'Calle 123', '12345678');
EXECUTE eliminar_dueno(1);
EXECUTE actualizar_dueno(2, 'Juan Perez', '12345678', 'Calle 123', '12345678');
*/


/* ################# PROCEDIMIENTOS DE MASCOTAS ########### */
