express = require('express')
const S3 = require('../Services/s3FilesManager')
controller = require('../Controllers/profileController')
const profileRouter = express.Router();
profileRouter
    .post('/getProfile/', controller.getData)
    .post('/editProfile/', controller.editData)

module.exports = profileRouter