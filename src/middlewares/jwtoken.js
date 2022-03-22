const jwt = require('jsonwebtoken');
const configs = require('../configs/configs');

function createToken(user) {
    return jwt.sign({
        user
    }, configs.SECRET, {
        expiresIn: '1d'
    });
}

function checkSessionView(req, res, next) {
    try {
        const token = req.cookies['session_token'];
        if (!token) {
            return res.redirect('/');
        }
        const decoded = jwt.verify(token, configs.SECRET);
        if (!decoded) {
            return res.redirect('/');
        }
        req.user = decoded.user;
        return next();
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'A ocurrido un error en el servidor'
        });
    }
}

function chechSessionApi(req, res, next) {
    try {
        const token = req.cookies['session_token'];
        if (!token) {
            return res.status(401).send({
                type: 'error',
                title: 'No estas autorizado',
                message: 'No tienes permisos para acceder a esta funcionalidad'
            });
        }
        const decoded = jwt.verify(token, configs.SECRET);
        if (!decoded) {
            return res.status(401).send({
                type: 'error',
                title: 'No estas autorizado',
                message: 'No tienes permisos para acceder a esta funcionalidad'
            });
        }
        req.user = decoded.user;
        return next();
    } catch (error) {
        console.log(error);
        return res.status(500).send({
            type: 'error',
            title: 'Error en el servidor',
            message: 'A ocurrido un error en el servidor'
        });
    }
}

async function checkIfHaveActiveSession(req, res, next) {
    const token = req.cookies['session_token'];
    if (!token) return next();
    let decoded = jwt.verify(token, configs.SECRET);
    let user = decoded.user;
    if (user) {
        return res.redirect('/duenos');
    }else{
        return next();
    }
}

module.exports = {
    createToken,
    checkSessionView,
    chechSessionApi,
    checkIfHaveActiveSession
}