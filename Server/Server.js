const express = require('express')
const app = express()

var MongoClient = require('mongodb').MongoClient;
var mongo_uri = "mongodb://localhost:27017";

let db;
let collection;
const port = 3000;

MongoClient.connect(mongo_uri, { useNewUrlParser: true })
    .then(client => {
        const db = client.db('theShireDB');
        const collection = db.collection('perfiles');
        app.locals.collection = collection;
        app.listen(port, () => console.info(`REST API running on port ${port}`));
    }).catch(error => console.error(error));


app.get('/perfiles', (req, res) => {
    const collection = req.app.locals.collection;
    collection.find({}).toArray().then(response => res.status(200).json(response)).catch(error => console.error(error));
});

app.get('/:id', (req, res) => {
    const collection = req.app.locals.collection;
    const id = new ObjectId(req.params.id);
    collection.findOne({ _id: id }).then(response => res.status(200).json(response)).catch(error => console.error(error));
});