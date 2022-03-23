const pool = require('./oracle-execute');
const oracledb = require('oracledb');

async function crearDueno(req, res){
    try {
        let { vnombre_completo, videntificacion, vdireccion_residencia, vtelefono_residencia, vtelefono_dueno } = req.body;
        let nuevo_dueno = {
            vnombre_completo,
            videntificacion,
            vdireccion_residencia,
            vtelefono_residencia,
            vnuevo_dueno_id: { type: oracledb.NUMBER, dir: oracledb.BIND_OUT }
        };
        let result = await pool.procedure(
            `insertar_dueno(:vnombre_completo, :videntificacion, :vdireccion_residencia, :vtelefono_residencia, :vnuevo_dueno_id)`,
            nuevo_dueno
        );
        let vid_dueno = result.vnuevo_dueno_id;
        if(vtelefono_dueno){
            let telefonos = vtelefono_dueno.split(',');
            for (let i = 0; i < telefonos.length; i++) {
                if (i<3) {
                    const vtelefono = telefonos[i];
                    await pool.procedure(
                        `agregar_telefono_dueno(:vid_dueno, :vtelefono)`,
                        {vid_dueno, vtelefono}
                    );
                }
            }
        }
        return res.redirect('/duenos');
    } catch(error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar crear el dueño'
        });
    }
}

async function actualizarDueno(req, res){
    try{
        let { vid_dueno, vnombre_completo, videntificacion, vdireccion_residencia, vtelefono_residencia, vtelefono_dueno } = req.body;
        let dueno = {
            vid_dueno,
            vnombre_completo,
            videntificacion,
            vdireccion_residencia,
            vtelefono_residencia
        };
        let result = await pool.procedure(
            `actualizar_dueno(:vid_dueno, :vnombre_completo, :videntificacion, :vdireccion_residencia, :vtelefono_residencia)`,
            dueno
        );
        await pool.procedure(
            `eliminar_telefono_dueno(:vid_dueno)`,
            {vid_dueno}
        );
        if(vtelefono_dueno.length > 0){
            let telefonos = vtelefono_dueno.split(',');
            for (let i = 0; i < telefonos.length; i++) {
                if (i<3) {
                    const vtelefono = telefonos[i];
                    await pool.procedure(
                        `agregar_telefono_dueno(:vid_dueno, :vtelefono)`,
                        {vid_dueno, vtelefono}
                    );
                }
            }
        }
        return res.redirect('/duenos');
    }catch(error){
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar actualizar el dueño'
        });
    }
}

async function listarDuenos(req, res){
    try {
        let view_image = '/images/vemterimnaria.png';
        let { usuario } = req.user;
        let duenos = (await pool.query(`SELECT * FROM Duenos`));
        let ruta = 'duenos';
        return res.render('sections/duenos', {usuario, duenos, view_image, ruta});
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar listar los dueños'
        });
    }
}

async function listarDueno(req, res){
    try {
        let view_image = '/images/cheemsluck.jpg'
        let { vid_dueno } = req.params;
        let dueno = (await pool.query(`SELECT * FROM Duenos WHERE id_dueno = :vid_dueno`, {vid_dueno}));
        if (dueno.length > 0) {
            dueno = dueno[0];
        }
        let telefonos = (await pool.query(`SELECT * FROM telefonos_dueno WHERE id_dueno = :vid_dueno`, {vid_dueno}));
        if (telefonos.length > 0) {
            telefonos = telefonos.map(telefono => telefono.TELEFONO).join(',');
        }else{
            telefonos = '';
        }
        return res.render('forms/editar_dueno', {dueno, telefonos, view_image});
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar listar los dueños'
        });
    }
}

async function eliminarDueno(req, res){
    try {
        let { vid_dueno } = req.params;
        let result = await pool.procedure(
            `eliminar_dueno(:vid_dueno)`,
            {vid_dueno}
        );
        return res.redirect('/duenos');
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar eliminar el dueño'
        });
    }
}

module.exports = {
    crearDueno,
    actualizarDueno,
    listarDuenos,
    listarDueno,
    eliminarDueno
}