require('dotenv').config();

module.exports = {
    PORT: process.env.PORT || 3000,
    DB_HOST: process.env.DB_HOST,
    DB_PORT: process.env.DB_PORT,
    DB_USER: process.env.DB_USER,
    DB_PASSWORD: process.env.DB_PASSWORD,
    DB_INSTANCE: process.env.DB_INSTANCE,
    SECRET: process.env.SECRET,
    MAIN_USER: process.env.MAIN_USER,
    MAIN_PASSWORD: process.env.MAIN_PASSWORD
};