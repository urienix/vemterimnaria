let router = require('express').Router();
const { checkSessionView } = require('../middlewares/jwtoken');
const { body, validationResult } = require('express-validator');

const { listarMedicos } = require('../controllers/medicos.controller');

router
    .get('/', checkSessionView, listarMedicos)

    .get('/nuevo', checkSessionView, (req, res) => {
        let view_image = '/images/cheemsluck.jpg';
        let { usuario } = req.user;
        let ruta = 'medicos';
        return res.render('forms/nuevo_medico', {view_image, usuario, ruta});
    })

module.exports = router;