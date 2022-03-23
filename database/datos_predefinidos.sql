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
END;

select * from RAZAS;

select R.ID_RAZA, E.NOMBRE || ' ' || R.NOMBRE as Razas_animales from RAZAS R INNER JOIN ESPECIES E ON R.ID_ESPECIE = E.ID_ESPECIE;