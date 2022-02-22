let router = require('express').Router();

router.get('/', (req, res) => {
    res.render('sections/duenos');
});

module.exports = router;