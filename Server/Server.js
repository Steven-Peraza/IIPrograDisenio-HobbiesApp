require('dotenv').config()
express = require('express')
const app = express()

userRouter = require('./api/Routes/userRouter')
profileRouter = require('./api/routes/profileRouter')
publicationsRouter = require('./api/Routes/publicationRouter')
mongoose = require('mongoose')
    // VARIABLES 
var MongoClient = require('mongodb').MongoClient;
var mongo_uri = "mongodb://admin:admin@theshiredb-shard-00-00-mtwvf.mongodb.net:27017,theshiredb-shard-00-01-mtwvf.mongodb.net:27017,theshiredb-shard-00-02-mtwvf.mongodb.net:27017/test?ssl=true&replicaSet=TheShireDB-shard-0&authSource=admin&retryWrites=true";

const db = mongoose.connect(mongo_uri, { useNewUrlParser: true });

const port = process.env.PORT || 3000;

app.use(express.json());
app.use('/user', userRouter);
app.use('/profiles', profileRouter);
app.use('/publications', publicationsRouter);

app.get('/',(req,res)=>{
    res.send("Server de Hobby Site")
    console.log("conexion entrante")
    console.log("hola"+process.env.APELLIDO)
})

app.listen(port, () => console.info(`REST API running on port ${port}`));