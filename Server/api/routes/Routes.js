'use strict';
module.exports = function(app) {

    var shireServer = require('../controllers/Controller');

    app.get("/", (req, res) => { res.send("Api de la aplicacion de hobbies") });

    app.route("/login")
        .get(shireServer.login);

    app.route("/newUser");

    app.route("/showDataU");

    app.route("/editDataU");
}