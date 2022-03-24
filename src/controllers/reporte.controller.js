const pool = require('./oracle-execute');

async function mostrarReporte(req, res) {
    try {
        let { usuario } = req.user;
        let { vid_paciente } = req.params;
        let view_image = '/images/dogo.jpg';
        let ruta = 'reporte';
        let reporte = await pool.query(`
        SELECT 
            ROW_NUMBER() OVER (PARTITION BY TO_CHAR(C.FECHA, 'MONTH', 'NLS_DATE_LANGUAGE = spanish') ORDER BY C.FECHA) AS NUMERO,
            TO_CHAR(C.FECHA, 'MONTH', 'NLS_DATE_LANGUAGE = spanish') AS MES, 
            TO_CHAR(C.FECHA, 'DD/MM/YYYY') AS FECHA_ASISTENCIA, 
            D.NOMBRE_COMPLETO AS NOMBRE_DUENO,
            LISTAGG(TD.TELEFONO, ',') WITHIN GROUP (ORDER BY TD.TELEFONO) AS TELEFONOS,
            P.NOMBRE AS NOMBRE_PACIENTE, 
            E.NOMBRE AS ESPECIE, 
            TO_CHAR(C.FECHA_PROGRAMACION, 'DD/MM/YYYY') AS FECHA_PROGRAMACION, 
            M.NOMBRE_COMPLETO AS MEDICO 
            from Citas C INNER JOIN PACIENTE P ON C.ID_PACIENTE = P.ID_PACIENTE 
            INNER JOIN RAZAS R ON R.ID_RAZA = P.ID_RAZA 
            INNER JOIN ESPECIES E ON R.ID_ESPECIE = E.ID_ESPECIE 
            INNER JOIN MEDICOS M ON C.ID_MEDICO = M.ID_MEDICO 
            INNER JOIN DUENOS D ON P.ID_DUENO = D.ID_DUENO
            LEFT JOIN TELEFONOS_DUENO TD ON D.ID_DUENO = TD.ID_DUENO
            GROUP BY C.ID_CITA, C.FECHA, D.NOMBRE_COMPLETO, P.NOMBRE, E.NOMBRE, C.FECHA_PROGRAMACION, M.NOMBRE_COMPLETO
        `);
        return res.render('sections/reporte', {usuario, vid_paciente, view_image, ruta, reporte});
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Ha ocurrido un error',
            message: 'No se ha podido generar el reporte',
        });
    }
}

module.exports = {
    mostrarReporte
}