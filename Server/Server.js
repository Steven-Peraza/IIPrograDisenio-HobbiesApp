//require('dotenv').config()
express = require('express')
const app = express()

userRouter = require('./api/Routes/userRouter')
profileRouter = require('./api/routes/profileRouter')
hobbitRouter = require('./api/routes/hobbitRouter')
comusRouter = require('./api/routes/comusRouter')
mongoose = require('mongoose')
    // VARIABLES 
var MongoClient = require('mongodb').MongoClient;
var mongo_uri = "ACM1PT";

const db = mongoose.connect(mongo_uri, { useNewUrlParser: true });

const port = process.env.PORT || 3000;

app.use(express.json());
app.use('/user', userRouter);
app.use('/profiles', profileRouter);
app.use('/hobbit', hobbitRouter);
app.use('/comus', comusRouter);
app.get('/', (req, res) => {
    res.send("Server de Hobby Site")
    console.log("conexion entrante")
        //console.log("hola" + process.env.APELLIDO)
})

app.listen(port, () => console.info(`REST API running on port ${port}`));