let router = require('express').Router();
const { checkSessionView } = require('../middlewares/jwtoken');
const { body, validationResult } = require('express-validator');

const { crearDueno, listarDuenos } = require('../controllers/duenos.controller');

router
    .get('/', checkSessionView, listarDuenos)

    .get('/nuevo', checkSessionView, (req, res) => {
        let { usuario } = req.user;
        let view_image = '/images/cheemsluck.jpg';
        res.render('forms/nuevo_dueno', {usuario, view_image});
    })

    .post('/nuevo', checkSessionView, [
        body('vnombre_completo').not().isEmpty().withMessage('El nombre es requerido'),
        body('videntificacion').not().isEmpty().withMessage('La identificacion es requerida'),
        body('vdireccion_residencia').not().isEmpty().withMessage('El direccion de residencia es requerido'),
        body('vtelefono_residencia').not().isEmpty().withMessage('El telefono de residencia es requerido')
    ], (req, res, next) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.render('forms/nuevo_dueno', {
                error: errors.array()[0].msg
            });
        }
        return next();
    }, crearDueno)

module.exports = router;