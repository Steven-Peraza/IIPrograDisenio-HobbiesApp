express = require('express')
const app = express()

userRouter = require('./api/Routes/userRouter')
mongoose = require('mongoose')
    // VARIABLES 
var MongoClient = require('mongodb').MongoClient;
var mongo_uri = "mongodb://admin:admin@theshiredb-shard-00-00-mtwvf.mongodb.net:27017,theshiredb-shard-00-01-mtwvf.mongodb.net:27017,theshiredb-shard-00-02-mtwvf.mongodb.net:27017/test?ssl=true&replicaSet=TheShireDB-shard-0&authSource=admin&retryWrites=true";

const db = mongoose.connect(mongo_uri, { useNewUrlParser: true });

const port = process.env.PORT || 3000;

app.use(express.json());
app.use('/user', userRouter);

app.listen(port, () => console.info(`REST API running on port ${port}`));