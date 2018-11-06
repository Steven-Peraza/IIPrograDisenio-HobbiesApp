express = require('express')
    //const S3 = require('../Services/s3FilesManager')
controller = require('../Controllers/profileController')
const profileRouter = express.Router();
//S3.uploadFile("/Users/jafethvasquez/IIPrograDisenio-HobbiesApp/Server/api/Services/File2upload.JPG")
profileRouter
    .post('/getProfile/', controller.getData)
    .post('/editProfile/', controller.editData)
    .post('/addHobby/', controller.addHobby)

module.exports = profileRouter