let router = require('express').Router();
const { checkSessionView } = require('../middlewares/jwtoken');
const { body, validationResult } = require('express-validator');

const { nuevoPaciente, listarPacientes, crearPaciente, eliminarPaciente, editarPaciente, actualizarPaciente } = require('../controllers/pacientes.controller');

router
    .get('/', checkSessionView, listarPacientes)

    .get('/nuevo', checkSessionView, nuevoPaciente)

    .post('/nuevo', checkSessionView, [
        body('vnombre').not().isEmpty().withMessage('El nombre es requerido'),
        body('vid_raza').not().isEmpty().withMessage('La raza es requerida'),
        body('vid_dueno').not().isEmpty().withMessage('El dueño es requerido')
    ], (req, res, next) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.render('forms/nuevo_paciente', {
                error: errors.array()[0].msg
            });
        }
        return next();
    }, crearPaciente)

    .get('/editar/:vid_paciente', checkSessionView, editarPaciente)

    .post('/editar', checkSessionView, [
        body('vnombre').not().isEmpty().withMessage('El nombre es requerido'),
        body('vid_raza').not().isEmpty().withMessage('La raza es requerida'),
        body('vid_dueno').not().isEmpty().withMessage('El dueño es requerido')
    ], (req, res, next) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.render('forms/editar_paciente', {
                error: errors.array()[0].msg
            });
        }
        return next();
    }, actualizarPaciente)

    .get('/eliminar/:vid_paciente', checkSessionView, eliminarPaciente);
    
module.exports = router;