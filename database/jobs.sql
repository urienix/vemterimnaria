
/*
NOTAS:
    en start_date puede ponerse una hora fija, por ejemplo:
    
    start_date => to_date('2022-02-25 00:01:00', 'YYYY-MM-DD HH24:MI:SS')
    
*/
BEGIN
    SYS.DBMS_SCHEDULER.CREATE_JOB(
        job_name => 'actualizar_fecha_jb',
        job_type => 'PLSQL_BLOCK',
        job_action => 'BEGIN
        DELETE FROM CONTROL_SISTEMA;
        INSERT INTO CONTROL_SISTEMA VALUES(1, sysdate);
        END;
        ',
        start_date => sysdate,
        repeat_interval => 'FREQ=DAILY;INTERVAL=1',
        auto_drop => false,
        end_date => null,
        enabled => true,
        comments => 'Tarea programada que va a actualizar la fecha actual en sistema'
    );
END;

/* ELIMINAR JOB */
BEGIN
    DBMS_SCHEDULER.DROP_JOB(
        job_name => '"CHEEMS"."ACTUALIZAR_FECHA_JB"',
        defer => false,
        force => false
    );
END;


/* EJECUTAR JOB */
BEGIN
    DBMS_SCHEDULER.RUN_JOB(job_name => '"CHEEMS"."ACTUALIZAR_FECHA_JB"', USE_CURRENT_SESSION => FALSE);
END;


/* QUERYS DE VERIFICACION */
select ID_FECHA_ACTUAL, TO_CHAR(FECHA_ACTUAL, 'DD-MM-YYYY HH:MI:SS') AS FECHA_ACTUAL from CONTROL_SISTEMA;

select TO_CHAR(sysdate, 'DD-MM-YYYY HH24:MI:SS') from dual;



