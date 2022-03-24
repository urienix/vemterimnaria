let router = require('express').Router();
const { checkSessionView } = require('../middlewares/jwtoken');

const { mostrarReporte } = require('../controllers/reporte.controller');

router
    .get('/', checkSessionView, mostrarReporte)

module.exports = router;