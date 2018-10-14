express = require('express')
const app = express()

userRouter = require('./api/Routes/userRouter')
mongoose = require('mongoose')
// VARIABLES 
var MongoClient = require('mongodb').MongoClient;
var mongo_uri = "mongodb://localhost:27017";

const db = mongoose.connect(mongo_uri,{useNewUrlParser:true});

const port = process.env.PORT || 3000;

app.use('/user', userRouter);

app.listen(port, () => console.info(`REST API running on port ${port}`));