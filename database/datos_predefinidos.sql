/* INSERCION DE  ESPECIES */
BEGIN
    INSERTAR_ESPECIE('Perro', 'Canes');
    INSERTAR_ESPECIE('Gato', 'Felinos');
    INSERTAR_ESPECIE('Cobaya', 'Cavidos');
    INSERTAR_ESPECIE('Caballo', 'Equidos');
    INSERTAR_ESPECIE('Vaca/Toro', 'Bovino');
END;
/

/* INSERCION DE RAZAS */
BEGIN
    INSERTAR_RAZA('Angora', 5, 10);
    INSERTAR_RAZA('Persa', 5, 10);
    INSERTAR_RAZA('Mestizo', 5, 10);
    INSERTAR_RAZA('Himalayo', 5, 10);
    INSERTAR_RAZA('Pitbull', 4, 12);
    INSERTAR_RAZA('Mestizo', 4, 12);
    INSERTAR_RAZA('Pastor Aleman', 4, 12);
    INSERTAR_RAZA('Pastor Belga', 4, 12);
    INSERTAR_RAZA('Pug', 4, 12);
    INSERTAR_RAZA('Shiba', 4, 12);
END;



select * from RAZAS;

select * from duenos; 

select R.ID_RAZA, E.NOMBRE || ' ' || R.NOMBRE as Razas_animales from RAZAS R INNER JOIN ESPECIES E ON R.ID_ESPECIE = E.ID_ESPECIE;

BEGIN
    INSERTAR_PACIENTE('Pugberto', 9, 1, null, 'https://pbs.twimg.com/media/E7kDdoFVcAEuMjX?format=jpg', SYSDATE);
END;

select * from PACIENTE;

delete from PACIENTE;

/*Ejemplo de estraccion de fecha con hora*/
select P.ID_PACIENTE, P.NOMBRE, R.NOMBRE AS RAZA, E.NOMBRE AS ESPECIE, D.NOMBRE_COMPLETO AS DUENO, TO_CHAR(FECHA_PRIMERA_CITA, 'YYYY-MM-DD HH24:MI:SS') AS FECHA_PRIMERA_CITA from PACIENTE P INNER JOIN RAZAS R ON P.ID_RAZA = R.ID_RAZA INNER JOIN ESPECIES E ON R.ID_ESPECIE = E.ID_ESPECIE INNER JOIN DUENOS D ON P.ID_DUENO = D.ID_DUENO;