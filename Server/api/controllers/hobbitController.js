const Hobbit = require('../models/hobbit');
const mongoose = require('mongoose');

exports.addHobby = (req, res) => {
    const newHobbit = new Hobbit({
        _id: new mongoose.Types.ObjectId(),
        hobbitName: req.body['name']
    });
    newHobbit.save().then((result) => {
        console.log(result);
    }).catch((err) => {
        console.log(err);
    });
    res.status(201).send(newHobbit);
}

exports.getHobbs = (req, res) => {
    var listaHobbs = [];
    Hobbit.find({}, 'hobbitName', function(req, resp) {
        resp.forEach(element => {
            listaHobbs.push(element['hobbitName']);
        });
        res.status(201).send(listaHobbs);
    });
}