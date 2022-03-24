let router = require('express').Router();
const { checkSessionView } = require('../middlewares/jwtoken');
const { body, validationResult } = require('express-validator');

const { listarPacientes } = require('../controllers/pacientes.controller');

router
    .get('/', checkSessionView, listarPacientes)

module.exports = router;