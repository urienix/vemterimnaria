module.exports = helpers = {
    setActive(route, activationroute){
        return route === activationroute ? 'active' : '';
    },

    setSelected(option, id){
        return option === id ? 'selected' : '';
    },

    setEmergencies(value){
        return value === '1' ? `
        <a href="#" class="nes-badge">
            <span class="is-success" style="max-width: 50px; margin-left: -20px;">Si</span>
        </a>` : `
        <a href="#" class="nes-badge">
            <span class="is-error" style="max-width: 50px; margin-left: -20px;">No</span>
        </a>`;
    }
};