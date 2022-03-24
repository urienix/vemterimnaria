const pool = require('./oracle-execute');
const oracledb = require('oracledb');

async function listarMedicos(req, res) {
    try {
        let view_image = '/images/vemterimnaria.png';
        let { usuario } = req.user;
        let ruta = 'medicos';
        let medicos = await pool.query(`SELECT ID_MEDICO, NOMBRE_COMPLETO, TELEFONO_RESIDENCIA, IDENTIFICACION, DIRECCION_RESIDENCIA, ATIENDE_EMERGENCIAS, TO_CHAR(FECHA_INGRESO, 'YYYY-MM-DD') AS INGRESO FROM Medicos`);
        return res.render('sections/medicos', {medicos, view_image, usuario, ruta});
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar listar los médicos'
        });
    }
}

module.exports = {
    listarMedicos
}