

express = require('express')
controller = require('../Controllers/userController')
const userRouter = express.Router();
userRouter
    .get('/', controller.getAllUsers)
    .post('/',controller.addNewUser)

module.exports = userRouter
