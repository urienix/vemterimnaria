const pool = require('./oracle-execute');
const oracledb = require('oracledb');

async function listarPacientes(req, res){
    try {
        let { usuario } = req.user;
        let view_image = '/images/vemterimnaria.png';
        let ruta = 'pacientes';
        let pacientes = await pool.execute(
            `SELECT * FROM pacientes`
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