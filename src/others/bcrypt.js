const bcrypt = require('bcrypt');

let encryptPassword = async (password) => {
    const salts = await bcrypt.genSalt(13);
    return await bcrypt.hash(password, salts);
};

let comparePassword = async (password, hash) => {
    return await bcrypt.compare(password, hash);
};

module.exports = {
    encryptPassword,
    comparePassword
};