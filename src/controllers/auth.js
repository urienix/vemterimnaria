const pool = require('./oracle-execute');
const configs = require('../configs/configs');
const { comparePassword } = require('../others/bcrypt');
const { createToken } = require('../middlewares/jwtoken');

let login = async (req, res) => {
    try {
        let { usuario, contrasena } = req.body;
        let result = await pool.query(`SELECT * FROM Usuarios WHERE usuario = :usuario`, [usuario]);
        if (result.length === 0) {
            return res.render('auth/login', {
                error: 'Usuario o contraseña incorrecto',
            });
        }
        let match = await comparePassword(contrasena, result[0].CONTRASENA);
        if (!match) {
            return res.render('auth/login', {
                error: 'Usuario o contraseña incorrecto',
            });
        }
        let user = {
            usuario: result[0].USUARIO,
            id_usuario: result[0].ID_USUARIO
        };
        let token = createToken(user);
        res.cookie('session_token', token, {
            maxAge: 1000 * 60 * 60 * 24,
        });
        res.redirect('/duenos');
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'Ocurrió un error al intentar iniciar sesión'
        });
    }
}

let logout = (req, res) => {
    res.clearCookie('session_token');
    res.redirect('/');
}

module.exports = {
    login,
    logout
}