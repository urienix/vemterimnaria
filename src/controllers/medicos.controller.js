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

async function crearMedico(req, res) {
    try {
        let { vnombre_completo, vtelefono_residencia, videntificacion, vdireccion_residencia, vatiende_emergencias } = req.body;
        await pool.procedure('insertar_medico(:vnombre_completo, :vtelefono_residencia, :videntificacion, :vdireccion_residencia, :vatiende_emergencias)', [vnombre_completo, vtelefono_residencia, videntificacion, vdireccion_residencia, vatiende_emergencias]);
        return res.redirect('/medicos');
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar crear el médico'
        });
    }
}

async function editarMedico(req, res){
    try {
        let { vid_medico } = req.params;
        let view_image = '/images/cheemsluck.jpg';
        let { usuario } = req.user;
        let ruta = 'medicos';
        let medico = (await pool.query(`SELECT ID_MEDICO, NOMBRE_COMPLETO, TELEFONO_RESIDENCIA, IDENTIFICACION, DIRECCION_RESIDENCIA, ATIENDE_EMERGENCIAS, TO_CHAR(FECHA_INGRESO, 'YYYY-MM-DD') AS INGRESO FROM Medicos WHERE ID_MEDICO = :vid_medico`, [vid_medico]))[0];
        return res.render('forms/editar_medico', {medico, view_image, usuario, ruta});
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar editar el médico'
        });
    }
}

async function actualizarMedico(req, res) {
    try {
        let { vid_medico, vnombre_completo, vtelefono_residencia, videntificacion, vdireccion_residencia, vatiende_emergencias } = req.body;
        await pool.procedure('actualizar_medico(:vid_medico, :vnombre_completo, :vtelefono_residencia, :videntificacion, :vdireccion_residencia, :vatiende_emergencias)', [vid_medico, vnombre_completo, vtelefono_residencia, videntificacion, vdireccion_residencia, vatiende_emergencias]);
        return res.redirect('/medicos');
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar actualizar el médico'
        });
    }
}


async function eliminarMedico(req, res) {
    try {
        let { vid_medico } = req.params;
        await pool.procedure('eliminar_medico(:vid_medico)', [vid_medico]);
        return res.redirect('/medicos');
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar eliminar el médico'
        });
    }
}

module.exports = {
    listarMedicos,
    crearMedico,
    editarMedico,
    actualizarMedico,
    eliminarMedico
}