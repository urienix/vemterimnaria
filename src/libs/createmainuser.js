const pool = require('../controllers/oracle-execute');
const configs = require('../configs/configs');
const { encryptPassword } = require('../others/bcrypt');
const oracledb = require('oracledb');

let createMainUser = async () => {
    try {
        let existUser = await pool.query(`SELECT * FROM Usuarios WHERE usuario = :usuario`, [configs.DB_USER]);
        if (existUser.length > 0) {
            return;
        }
        let user = {
            usuario: configs.MAIN_USER,
            nombre_completo: 'Urienix',
            telefono: '',
            direccion_residencia: '',
            contrasena: await encryptPassword(configs.MAIN_PASSWORD),
            nuevo_usuario_id: { type: oracledb.NUMBER, dir: oracledb.BIND_OUT }
        };
        let result = await pool.procedure(
            'insertar_usuario(:usuario, :nombre_completo, :telefono, :direccion_residencia, :contrasena, :nuevo_usuario_id)',
            user
        );
        console.log('>> Usuario principal creado con éxito');
        return;
    } catch (error) {
        console.log(error);
        return;
    }
}

module.exports = createMainUser;