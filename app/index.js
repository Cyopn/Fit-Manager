'use strict'
var express = require('express');
var path = require('path');
var app = module.exports = express();
app.engine('.html', require('ejs').__express);
app.set('views', path.join(__dirname, 'views'));
app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'html');

app.get('/', function (req, res) {
    res.render('index');
});

app.get("/admin", function (req, res) {
res.render('admin');
})

app.get('/signin', function (req, res) {
    res.render('signin');
});

app.get("/dashboard", function (req, res) {
    res.render('dashboard');
})

if (!module.parent) {
    app.listen(4000);
    console.log(`Aplicacion corriendo en http://localhost:4000`);
}
