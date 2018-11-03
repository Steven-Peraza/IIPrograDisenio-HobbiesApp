'use strict'

const AWS = require('aws-sdk');
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
        Bucket: 'hobbysite-sourcesbucket',
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