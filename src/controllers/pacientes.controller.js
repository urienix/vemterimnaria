const pool = require('./oracle-execute');
const oracledb = require('oracledb');

async function listarPacientes(req, res){
    try {
        let { usuario } = req.user;
        let view_image = '/images/vemterimnaria.png';
        let ruta = 'pacientes';
        let pacientes = await pool.query(
            `select P.ID_PACIENTE, P.NOMBRE, R.NOMBRE AS RAZA, E.NOMBRE AS ESPECIE, D.NOMBRE_COMPLETO AS DUENO, TO_CHAR(FECHA_PRIMERA_CITA, 'YYYY-MM-DD') AS FECHA_PRIMERA_CITA from PACIENTE P INNER JOIN RAZAS R ON P.ID_RAZA = R.ID_RAZA INNER JOIN ESPECIES E ON R.ID_ESPECIE = E.ID_ESPECIE INNER JOIN DUENOS D ON P.ID_DUENO = D.ID_DUENO`
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

async function nuevoPaciente(req, res){
    try {
        let { usuario } = req.user;
        let view_image = '/images/cheemsluck.jpg';
        let ruta = 'pacientes';
        let razas = (await pool.query(`select R.ID_RAZA, E.NOMBRE || ' ' || R.NOMBRE as Razas_animales from RAZAS R INNER JOIN ESPECIES E ON R.ID_ESPECIE = E.ID_ESPECIE`));
        let duenos = (await pool.query(`select ID_DUENO, NOMBRE_COMPLETO from DUENOS`));
        res.render('forms/nuevo_paciente', {usuario, view_image, ruta, razas, duenos});
    }catch(err){
        console.log(err);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar obtener algunos datos'
        });
    }
}

async function crearPaciente(req, res) {
    try{
        let { vnombre, vid_dueno, vid_raza} = req.body;
        let nuevo_paciente = {
            vnombre,
            vid_raza,
            vid_dueno
        }
        await pool.procedure(`insertar_paciente(:vnombre, :vid_raza, :vid_dueno)`, nuevo_paciente);
        return res.redirect('/pacientes');
    }catch(err){
        console.log(err);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar crear el paciente'
        });
    }
}

async function editarPaciente(req, res) {
    try {
        let { usuario } = req.user;
        let { vid_paciente } = req.params;
        let view_image = '/images/cheemsluck.jpg';
        let ruta = 'pacientes';
        let razas = (await pool.query(`select R.ID_RAZA, E.NOMBRE || ' ' || R.NOMBRE as Razas_animales from RAZAS R INNER JOIN ESPECIES E ON R.ID_ESPECIE = E.ID_ESPECIE`));
        let duenos = (await pool.query(`select ID_DUENO, NOMBRE_COMPLETO from DUENOS`));
        let paciente = (await pool.query(`select * from Paciente where id_paciente = :vid_paciente`, {vid_paciente}))[0];
        res.render('forms/editar_paciente', {usuario, paciente, view_image, ruta, razas, duenos});
    }catch(err){
        console.log(err);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar obtener algunos datos'
        });
    }
}

async function actualizarPaciente(req, res) {
    try {
        let { vid_paciente, vnombre, vid_raza, vid_dueno } = req.body;
        let paciente = {
            vid_paciente,
            vnombre,
            vid_raza,
            vid_dueno
        }
        await pool.procedure(`actualizar_paciente(:vid_paciente, :vnombre, :vid_raza, :vid_dueno)`, paciente);
        return res.redirect('/pacientes');
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar actualizar el paciente'
        });
    }
}

async function eliminarPaciente(req, res) {
    try {
        let { vid_paciente } = req.params;
        await pool.procedure(`eliminar_paciente(:vid_paciente)`, {vid_paciente});
        return res.redirect('/pacientes');
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar eliminar el paciente'
        });
    }
}

module.exports = {
    listarPacientes,
    nuevoPaciente,
    crearPaciente,
    editarPaciente,
    actualizarPaciente,
    eliminarPaciente
}