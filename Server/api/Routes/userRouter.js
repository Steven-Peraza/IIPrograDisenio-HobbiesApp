express = require('express')
controller = require('../Controllers/userController')
const userRouter = express.Router();
userRouter
    .post('/login/', controller.getAllUsers)
    .post('/signup/', controller.addNewUser)

module.exports = userRouter