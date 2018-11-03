express = require('express')
controller = require('../Controllers/comusController')
const comusRouter = express.Router();
comusRouter
    .post('/newComu/', controller.addComu)
    .post('/getComuUser/', controller.getComusByUser)
    .post('/getComus/', controller.getComusByHobby)
    .post('/joinComu/', controller.joinComu)

module.exports = comusRouter