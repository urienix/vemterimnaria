const pool = require('./oracle-execute');
const oracledb = require('oracledb');

async function listarPacientes(req, res){
    try {
        let { usuario } = req.user;
        let view_image = '/images/vemterimnaria.png';
        let ruta = 'pacientes';
        let pacientes = await pool.query(
            `select P.ID_PACIENTE, P.NOMBRE, R.NOMBRE AS RAZA, E.NOMBRE AS ESPECIE, D.NOMBRE_COMPLETO AS DUENO, TO_CHAR(FECHA_PRIMERA_CITA, 'YYYY-MM-DD HH24:MI:SS') AS FECHA_PRIMERA_CITA from PACIENTE P INNER JOIN RAZAS R ON P.ID_RAZA = R.ID_RAZA INNER JOIN ESPECIES E ON R.ID_ESPECIE = E.ID_ESPECIE INNER JOIN DUENOS D ON P.ID_DUENO = D.ID_DUENO`
        );
        return res.render('sections/pacientes', {usuario, pacientes, view_image, ruta});
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar listar los pacientes'
        });
    }
}


module.exports = {
    listarPacientes
}