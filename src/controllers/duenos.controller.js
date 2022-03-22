const pool = require('./oracle-execute');
const oracledb = require('oracledb');

async function crearDueno(req, res){
    try {
        let { vnombre_completo, videntificacion, vdireccion_residencia, vtelefono_residencia } = req.body;
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
        if(req.body.vtelefono_dueno){
            let telefonos = req.body.vtelefono_dueno.split(',');
            for (let i = 0; i < 3; i++) {
                const vtelefono = telefonos[i];
                await pool.procedure(
                    `agregar_telefono_dueno(:vid_dueno, :vtelefono)`,
                    {vid_dueno, vtelefono}
                );
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

async function listarDuenos(req, res){
    try {
        let view_image = '/images/vemterimnaria.png';
        let { usuario } = req.user;
        let duenos = (await pool.query(`SELECT * FROM Duenos`));
        return res.render('sections/duenos', {usuario, duenos, view_image});
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar listar los dueños'
        });
    }
}

module.exports = {
    crearDueno,
    listarDuenos
}