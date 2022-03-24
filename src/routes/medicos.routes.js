let router = require('express').Router();
const { checkSessionView } = require('../middlewares/jwtoken');
const { body, validationResult } = require('express-validator');

const { listarMedicos, crearMedico, editarMedico, actualizarMedico, eliminarMedico } = require('../controllers/medicos.controller');

router
    .get('/', checkSessionView, listarMedicos)

    .get('/nuevo', checkSessionView, (req, res) => {
        let view_image = '/images/cheemsluck.jpg';
        let { usuario } = req.user;
        let ruta = 'medicos';
        return res.render('forms/nuevo_medico', {view_image, usuario, ruta});
    })

    .post('/nuevo', checkSessionView, [
        body('vnombre_completo').not().isEmpty().withMessage('El nombre es requerido'),
        body('vtelefono_residencia').not().isEmpty().withMessage('El teléfono es requerido'),
        body('videntificacion').not().isEmpty().withMessage('La identificación es requerida'),
        body('vdireccion_residencia').not().isEmpty().withMessage('La dirección es requerida'),
        body('vatiende_emergencias').not().isEmpty().isIn(['1', '0']).withMessage('Atender emergencias es requerido')
    ], (req, res, next) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            let { usuario } = req.user;
            let ruta = 'medicos';
            return res.render('forms/nuevo_medico', {errors: errors.array()[0].msg, usuario, ruta});
        }
        return next();
    },  crearMedico)

    .get('/editar/:vid_medico', checkSessionView, editarMedico)

    .post('/editar', checkSessionView, [
        body('vnombre_completo').not().isEmpty().withMessage('El nombre es requerido'),
        body('vtelefono_residencia').not().isEmpty().withMessage('El teléfono es requerido'),
        body('videntificacion').not().isEmpty().withMessage('La identificación es requerida'),
        body('vdireccion_residencia').not().isEmpty().withMessage('La dirección es requerida'),
        body('vatiende_emergencias').not().isEmpty().isIn(['1', '0']).withMessage('Atender emergencias es requerido')
    ], (req, res, next) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            let { usuario } = req.user;
            let ruta = 'medicos';
            return res.render('forms/editar_medico', {error: errors.array()[0].msg, usuario, ruta});
        }
        return next();
    },  actualizarMedico)

    .get('/eliminar/:vid_medico', checkSessionView, eliminarMedico)

module.exports = router;