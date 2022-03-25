/* AUDITANDO DUENOS */
CREATE OR REPLACE TRIGGER auditar_duenos_trg
AFTER INSERT OR UPDATE OR DELETE 
ON DUENOS
FOR EACH ROW
ENABLE
BEGIN
    IF INSERTING THEN
        INSERT INTO AUDITORIA (tabla_objetivo, fecha_ejecucion, usuario_ejecutor, tipo_transaccion, descripcion)
        VALUES ('DUENOS', SYSDATE, SYS_CONTEXT ('USERENV', 'SESSION_USER'), 'INSERCION', 'Se ha insertado un nuevo registro con id: ' || :new.ID_DUENO );
    ELSIF UPDATING THEN
        INSERT INTO AUDITORIA (tabla_objetivo, fecha_ejecucion, usuario_ejecutor, tipo_transaccion, descripcion)
        VALUES ('DUENOS', SYSDATE, SYS_CONTEXT ('USERENV', 'SESSION_USER'), 'ACTUALIZACION', 'Se ha actualizado el registro con id: ' || :new.ID_DUENO );
    ELSIF DELETING THEN
        INSERT INTO AUDITORIA (tabla_objetivo, fecha_ejecucion, usuario_ejecutor, tipo_transaccion, descripcion)
        VALUES ('DUENOS', SYSDATE, SYS_CONTEXT ('USERENV', 'SESSION_USER'), 'ELIMINACION', 'Se ha eliminado el registro con id: ' || :old.ID_DUENO );
    END IF;
END;
/

/* AUDITANDO PACIENTES */
CREATE OR REPLACE TRIGGER auditar_pacientes_trg
AFTER INSERT OR UPDATE OR DELETE 
ON PACIENTE
FOR EACH ROW
ENABLE
BEGIN
    IF INSERTING THEN
        INSERT INTO AUDITORIA (tabla_objetivo, fecha_ejecucion, usuario_ejecutor, tipo_transaccion, descripcion)
        VALUES ('PACIENTE', SYSDATE, SYS_CONTEXT ('USERENV', 'SESSION_USER'), 'INSERCION', 'Se ha insertado un nuevo registro con id: ' || :new.ID_PACIENTE );
    ELSIF UPDATING THEN
        INSERT INTO AUDITORIA (tabla_objetivo, fecha_ejecucion, usuario_ejecutor, tipo_transaccion, descripcion)
        VALUES ('PACIENTE', SYSDATE, SYS_CONTEXT ('USERENV', 'SESSION_USER'), 'ACTUALIZACION', 'Se ha actualizado el registro con id: ' || :new.ID_PACIENTE );
    ELSIF DELETING THEN
        INSERT INTO AUDITORIA (tabla_objetivo, fecha_ejecucion, usuario_ejecutor, tipo_transaccion, descripcion)
        VALUES ('PACIENTE', SYSDATE, SYS_CONTEXT ('USERENV', 'SESSION_USER'), 'ELIMINACION', 'Se ha eliminado el registro con id: ' || :old.ID_PACIENTE );
    END IF;
END;
/


/* AUDITANDO MEDICOS */
CREATE OR REPLACE TRIGGER auditar_medicos_trg
AFTER INSERT OR UPDATE OR DELETE 
ON MEDICOS
FOR EACH ROW
ENABLE
BEGIN
    IF INSERTING THEN
        INSERT INTO AUDITORIA (tabla_objetivo, fecha_ejecucion, usuario_ejecutor, tipo_transaccion, descripcion)
        VALUES ('MEDICOS', SYSDATE, SYS_CONTEXT ('USERENV', 'SESSION_USER'), 'INSERCION', 'Se ha insertado un nuevo registro con id: ' || :new.ID_MEDICO );
    ELSIF UPDATING THEN
        INSERT INTO AUDITORIA (tabla_objetivo, fecha_ejecucion, usuario_ejecutor, tipo_transaccion, descripcion)
        VALUES ('MEDICOS', SYSDATE, SYS_CONTEXT ('USERENV', 'SESSION_USER'), 'ACTUALIZACION', 'Se ha actualizado el registro con id: ' || :new.ID_MEDICO );
    ELSIF DELETING THEN
        INSERT INTO AUDITORIA (tabla_objetivo, fecha_ejecucion, usuario_ejecutor, tipo_transaccion, descripcion)
        VALUES ('MEDICOS', SYSDATE, SYS_CONTEXT ('USERENV', 'SESSION_USER'), 'ELIMINACION', 'Se ha eliminado el registro con id: ' || :old.ID_MEDICO );
    END IF;
END;
/

/* AUDITANDO CITAS */
CREATE OR REPLACE TRIGGER auditar_citas_trg
AFTER INSERT OR UPDATE OR DELETE 
ON CITAS
FOR EACH ROW
ENABLE
BEGIN
    IF INSERTING THEN
        INSERT INTO AUDITORIA (tabla_objetivo, fecha_ejecucion, usuario_ejecutor, tipo_transaccion, descripcion)
        VALUES ('CITAS', SYSDATE, SYS_CONTEXT ('USERENV', 'SESSION_USER'), 'INSERCION', 'Se ha insertado un nuevo registro con id: ' || :new.ID_CITA );
    ELSIF UPDATING THEN
        INSERT INTO AUDITORIA (tabla_objetivo, fecha_ejecucion, usuario_ejecutor, tipo_transaccion, descripcion)
        VALUES ('CITAS', SYSDATE, SYS_CONTEXT ('USERENV', 'SESSION_USER'), 'ACTUALIZACION', 'Se ha actualizado el registro con id: ' || :new.ID_CITA );
    ELSIF DELETING THEN
        INSERT INTO AUDITORIA (tabla_objetivo, fecha_ejecucion, usuario_ejecutor, tipo_transaccion, descripcion)
        VALUES ('CITAS', SYSDATE, SYS_CONTEXT ('USERENV', 'SESSION_USER'), 'ELIMINACION', 'Se ha eliminado el registro con id: ' || :old.ID_CITA );
    END IF;
END;
/

select * from auditoria order by id_auditoria asc;
SELECT * FROM CITAS;