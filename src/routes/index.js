const router = require('express').Router();
const authRoutes = require('./auth.routes');
const duenosRoutes = require('./duenos.routes');
const pacientesRoutes = require('./pacientes.routes');
const medicosRoutes = require('./medicos.routes');
const reporteRoutes = require('./reporte.routes');

router.use(authRoutes);
router.use('/duenos', duenosRoutes);
router.use('/pacientes', pacientesRoutes);
router.use('/medicos', medicosRoutes);
router.use('/reporte', reporteRoutes);

router.get('/home', (req, res) => {
    res.send('biemvenido a HOME');
});

module.exports = router;