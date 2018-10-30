express = require('express')
//const S3 = require('../Services/s3FilesManager')
controller = require('../Controllers/publicationsController')
const publicationsRouter = express.Router();
//S3.uploadFile("/Users/jafethvasquez/IIPrograDisenio-HobbiesApp/Server/api/Services/File2upload.JPG")
publicationsRouter
    .post('/create/', controller.addNewPublication)
    .get('/getByHobby/:hobby/', controller.getPublicationsByHobby)

module.exports = publicationsRouter