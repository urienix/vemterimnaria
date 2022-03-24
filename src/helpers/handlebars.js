module.exports = helpers = {
    setActive(route, activationroute){
        return route === activationroute ? 'active' : '';
    },

    setSelected(option, id){
        return option === id ? 'selected' : '';
    }
};