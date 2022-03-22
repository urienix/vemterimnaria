let router = require('express').Router();
const { body, validationResult } = require('express-validator');
const { login, logout } = require('../controllers/auth');
const { checkIfHaveActiveSession } = require('../middlewares/jwtoken');

router
    .get('/', checkIfHaveActiveSession, (req, res) => {
        res.render('auth/login');
    })

    .post('/', [
        body('usuario').not().isEmpty().withMessage('El usuario es requerido'),
        body('contrasena').not().isEmpty().withMessage('La contraseña es requerida'),
    ], (req, res, next) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).send({
                type: 'error',
                title: 'Algunos campos son requeridos',
                message: errors.array()[0].msg,
            });
        }
        return next();
    }, login)

    .get('/logout', logout);

module.exports = router;