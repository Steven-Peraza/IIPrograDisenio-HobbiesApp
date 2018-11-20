'use strict'

const AWS = require('aws-sdk');
const multer = require('multer')
const multerS3 = require('multer-s3')
const fs = require('fs');
const path = require('path');

console.log("Iniciando servicio")
    //configuring the AWS environment
AWS.config.update({
    accessKeyId: process.env.KEY_ID,
    secretAccessKey: process.env.SECRET_ACCESS_KEY
});

var s3 = new AWS.S3();

exports.uploadFile = (filePath) => {
    //configuring parameters
    const params = {
        Bucket: process.env.BUCKET_NAME,
        Body: fs.createReadStream(filePath),
        Key: "folder/" + Date.now() + "_" + path.basename(filePath)
    };
    s3.upload(params, function(err, data) {
        //handle error
        if (err) {
            console.log("Error", err);
        }
        //success
        if (data) {
            console.log("Uploaded in:", data.Location);
        }
    });
}

exports.upload = multer({
    limits: { fieldSize: 25 * 1024 * 1024 },
    storage: multerS3({
      s3: s3,
      bucket: process.env.BUCKET_NAME,
      acl:'public-read',
      metadata: function (req, file, cb) {
        cb(null, {fieldName: file.fieldname});
      },
      key: function (req, file, cb) {
        cb(null, Date.now().toString()+'.jpg')
      }
    })
  })




