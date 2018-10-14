const mongo_uri = 'mongodb://localhost:32768';
const MongoClient = require('mongodb').MongoClient;
const ObjectId = require('mongodb').ObjectId;



exports.login = (req, res) => {
    var gandalf = 'You Shall Not Pass!';
    MongoClient.connect(mongo_uri, { useNewUrlParser: true })
        .then(client => {
            const db = client.db('TheShireDB');
            const collection = db.collection('perfiles');
            collection.find({}).toArray().then(response => res.status(200).json(response)).catch(error => console.error(error));
        });
    res.json({ "respuesta": gandalf });
};


exports.newUser = (req, res) => {
    const id = new ObjectId(req.params.id);
    MongoClient.connect(mongo_uri, { useNewUrlParser: true })
        .then(client => {
            const db = client.db('TheShireDB');
            const collection = db.collection('perfiles');
            collection.findOne({ _id: id }).then(response => res.status(200).json(response)).catch(error => console.error(error));
        });
    res.json();
};