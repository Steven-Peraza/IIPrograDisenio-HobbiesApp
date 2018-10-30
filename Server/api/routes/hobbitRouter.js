express = require('express')
controller = require('../Controllers/hobbitController')
const hobbitRouter = express.Router();
hobbitRouter
    .post('/newHobbit/', controller.addHobby)
    .get('/getHobbit/', controller.getHobbs)

module.exports = hobbitRouter