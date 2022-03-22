const express = require('express');
const path = require('path');
const exphbs = require('express-handlebars');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const helpers = require('./helpers/handlebars');
const createMainUser = require('./libs/createmainuser');

require('dotenv').config();
const app = express();

// Settings
app.set('port', process.env.PORT || 4000);
app.set('views', path.join(__dirname, 'views'));

app.engine('.hbs', exphbs.engine({
    defaultLayout: 'main',
    layoutsDir: path.join(app.get('views'), 'layouts'),
    partialsDir: path.join(app.get('views'), 'partials'),
    extname: '.hbs',
    helpers
}));
app.set('view engine', '.hbs');

// middlewares
app.use(bodyParser.urlencoded({extended: true }));
app.use(cookieParser());

// Routes
app.use(require('./routes/index'));

// Public
app.use(express.static(path.join(__dirname, 'public')));

createMainUser();
//error response
/*
app.use(function(req, res, next) {
    res.status(404).render('404');
});
*/


// Starting
app.listen(app.get('port'), () => {
    console.log('Server is on port', app.get('port'));
});

