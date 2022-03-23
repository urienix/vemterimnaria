module.exports = helpers = {
    setActive(route, activationroute){
        return route === activationroute ? 'active' : '';
    }
};