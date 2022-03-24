module.exports = helpers = {
    setActive(route, activationroute){
        return route === activationroute ? 'active' : '';
    },

    setSelected(option, id){
        return option === id ? 'selected' : '';
    },

    setEmergencies(value){
        return value === '1' ? `
        <span class="nes-badge">
            <span class="is-success" style="max-width: 50px; margin-left: -22px;">Si</span>
        </span>` : `
        <span class="nes-badge">
            <span class="is-error" style="max-width: 50px; margin-left: -22px;">No</span>
        </span>`;
    },

    setChecked(option, value){
        return option === value ? 'checked' : '';
    }
};