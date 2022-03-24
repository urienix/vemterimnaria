const router = require('express').Router();
const authRoutes = require('./auth.routes');
const duenosRoutes = require('./duenos.routes');
const pacientesRoutes = require('./pacientes.routes');

router.use(authRoutes);
router.use('/duenos', duenosRoutes);
router.use('/pacientes', pacientesRoutes);

router.get('/home', (req, res) => {
    res.send('biemvenido a HOME');
});

module.exports = router;