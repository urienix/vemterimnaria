const router = require('express').Router();
const authRoutes = require('./auth.routes');
const duenosRoutes = require('./duenos.routes');

router.use(authRoutes);
router.use('/duenos', duenosRoutes);

module.exports = router;